import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grad_project/cubit/map/map_cubit.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/pharmacies.dart';
import 'package:grad_project/services/Map/MapService.dart';
import 'package:grad_project/widgets/hosptials/hospital_card.dart';
import 'package:grad_project/widgets/maphospitalcard.dart';
import 'package:grad_project/widgets/mappharmacycard.dart';
import 'package:grad_project/widgets/mapscreen/blurred_appbar.dart';
import 'package:grad_project/widgets/mapscreen/circlemap.dart';
import 'package:grad_project/widgets/mapscreen/searchbar.dart';
import 'package:grad_project/screens/Hospitals/hospitaldetails.dart';
import 'package:grad_project/screens/pharmacies/pharmacydetails.dart';
import 'package:geolocator/geolocator.dart';

class Mapscreen extends StatelessWidget {
  final double? targetLat;
  final double? targetLng;
  final String? targetName;

  const Mapscreen({super.key, this.targetLat, this.targetLng, this.targetName});

  Future<bool> _checkAndRequestLocation(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (context.mounted) {
        await _showLocationDialog(
          context,
          title: S.of(context).locationRequired,
          message: S.of(context).locationServiceDisabled,
          onConfirm: () async => await Geolocator.openLocationSettings(),
        );
      }
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (context.mounted) {
          await _showLocationDialog(
            context,
            title: S.of(context).locationRequired,
            message: S.of(context).locationRequiredMessage,
            onConfirm: null,
          );
        }
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        await _showLocationDialog(
          context,
          title: S.of(context).locationRequired,
          message: S.of(context).locationPermissionPermanentlyDenied,
          onConfirm: () async => await Geolocator.openAppSettings(),
        );
      }
      return false;
    }

    return true;
  }

  Future<void> _showLocationDialog(
    BuildContext context, {
    required String title,
    required String message,
    required Future<void> Function()? onConfirm,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.location_off, color: Color(0xff2260FF)),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 16),
            ),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'Cairo', fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              S.of(context).cancel,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          if (onConfirm != null)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2260FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await onConfirm();
              },
              child: Text(
                S.of(context).openSettings,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = MapCubit(MapService());
        if (targetLat != null && targetLng != null) {
          cubit.setExternalTarget(LatLng(targetLat!, targetLng!));
        }
        cubit.initLocation();
        return cubit;
      },
      child: _LocationGate(
        checkLocation: _checkAndRequestLocation,
        child: _MapView(
          targetLat: targetLat,
          targetLng: targetLng,
          targetName: targetName,
        ),
      ),
    );
  }
}

class _LocationGate extends StatefulWidget {
  final Future<bool> Function(BuildContext) checkLocation;
  final Widget child;

  const _LocationGate({required this.checkLocation, required this.child});

  @override
  State<_LocationGate> createState() => _LocationGateState();
}

class _LocationGateState extends State<_LocationGate> {
  bool _isChecking = true;
  bool _locationGranted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  Future<void> _check() async {
    final granted = await widget.checkLocation(context);
    if (mounted) {
      setState(() {
        _locationGranted = granted;
        _isChecking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!_locationGranted) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_disabled,
                  size: 80,
                  color: Color(0xff2260FF),
                ),
                const SizedBox(height: 24),
                Text(
                  S.of(context).locationUnavailable,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  S.of(context).locationUnavailableMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Cairo',
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2260FF),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: Text(
                    S.of(context).tryagain,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  onPressed: () => setState(() {
                    _isChecking = true;
                    _check();
                  }),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return widget.child;
  }
}

class _MapView extends StatefulWidget {
  final double? targetLat;
  final double? targetLng;
  final String? targetName;

  const _MapView({this.targetLat, this.targetLng, this.targetName});

  @override
  State<_MapView> createState() => _MapViewState();
}

class _MapViewState extends State<_MapView> {
  bool modalshowed = false;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: BlocBuilder<MapCubit, MapState>(
          builder: (context, state) {
            if (state.currentLocation == null) {
              return const Center(child: CircularProgressIndicator());
            }

            LatLng? extraMarker;
            if (widget.targetLat != null && widget.targetLng != null) {
              extraMarker = LatLng(widget.targetLat!, widget.targetLng!);
            }

            return Stack(
              children: [
                CircleMap(
                  currentLocation: state.currentLocation!,
                  extraMarker: extraMarker,
                  extraMarkerLabel: widget.targetName,
                  markers: _buildMarkers(context, state),
                  onMapCreated: (controller) => _mapController = controller,
                  radius: state.searchRadiusMeters,
                ),
                Positioned(top: 0, left: 0, right: 0, child: blurred_appbar()),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 90,
                  left: 16,
                  right: 16,
                  child: searchbar(context),
                ),
                Positioned(
                  right: 16,
                  top: MediaQuery.of(context).padding.top + 170,
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xff2260FF),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.layers, color: Colors.white),
                      onPressed: () {
                        setState(() => modalshowed = true);
                        showModalBottomSheet(
                          context: context,
                          barrierColor: Colors.transparent,
                          builder: (sheetContext) => BlocProvider.value(
                            value: context.read<MapCubit>(),
                            child: _NearbySheet(devheight: devheight),
                          ),
                        ).then((_) => setState(() => modalshowed = false));
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: modalshowed
                      ? MediaQuery.of(context).padding.bottom + 360
                      : 110,
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xff2260FF),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.my_location, color: Colors.white),
                      onPressed: () async {
                        await context.read<MapCubit>().recenterToUser();
                        final userLoc = context
                            .read<MapCubit>()
                            .state
                            .userLocation;
                        if (userLoc != null && _mapController != null) {
                          _mapController!.animateCamera(
                            CameraUpdate.newLatLngZoom(userLoc, 15),
                          );
                        }
                      },
                    ),
                  ),
                ),
                if (state.locationStatus == LocationStatus.denied ||
                    state.locationStatus == LocationStatus.error)
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 140,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        state.locationStatus == LocationStatus.denied
                            ? S.of(context).locationPermissionDenied
                            : S.of(context).somethingWentWrong,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Set<Marker> _buildMarkers(BuildContext context, MapState state) {
    final markers = <Marker>{};
    final locale = Localizations.localeOf(context).languageCode;

    if (state.userLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('user'),
          position: state.userLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(title: 'You'),
        ),
      );
    }

    if (state.selectedCategory == NearbyCategory.hospitals) {
      final devheight = MediaQuery.of(context).size.height;
      for (final h in state.hospitals) {
        markers.add(
          Marker(
            markerId: MarkerId('hospital_${h.id}'),
            position: LatLng(h.latitude, h.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
            infoWindow: InfoWindow(title: h.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      Hospitaldetails(hospital: h, devheight: devheight),
                ),
              );
            },
          ),
        );
      }
    } else {
      for (final p in state.pharmacies) {
        if (p.latitude == null || p.longitude == null) continue;
        final displayName = locale == 'ar' ? p.nameAr : p.name;
        markers.add(
          Marker(
            markerId: MarkerId('pharmacy_${p.id}'),
            position: LatLng(p.latitude!, p.longitude!),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
            infoWindow: InfoWindow(title: displayName),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PharmacyDetails(
                    name: displayName,
                    rate: p.rating,
                    isopen24: p.is24Hours,
                    devheight: MediaQuery.of(context).size.height,
                    latitude: p.latitude!,
                    longitude: p.longitude!,
                  ),
                ),
              );
            },
          ),
        );
      }
    }

    return markers;
  }
}

class _NearbySheet extends StatelessWidget {
  final double devheight;

  const _NearbySheet({required this.devheight});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildTabButton(
                            context,
                            label: S.of(context).hospitals,
                            icon: Icons.local_hospital,
                            category: NearbyCategory.hospitals,
                            isSelected:
                                state.selectedCategory ==
                                NearbyCategory.hospitals,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildTabButton(
                            context,
                            label: S.of(context).pharmacies,
                            icon: Icons.medical_services,
                            category: NearbyCategory.pharmacies,
                            isSelected:
                                state.selectedCategory ==
                                NearbyCategory.pharmacies,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 340,
                    height: 272,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xffDADADA)),
                      color: Colors.white,
                    ),
                    child: state.nearbyStatus == NearbyStatus.loading
                        ? const Center(child: CircularProgressIndicator())
                        : state.nearbyStatus == NearbyStatus.error
                        ? Center(
                            child: Text(
                              S.of(context).somethingWentWrong,
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${S.of(context).nearest} '
                                      '${state.selectedCategory == NearbyCategory.hospitals ? S.of(context).hospitals : S.of(context).pharmacies}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child:
                                    state.selectedCategory ==
                                        NearbyCategory.hospitals
                                    ? _buildHospitalList(context, state)
                                    : _buildPharmacyList(
                                        context,
                                        state,
                                        locale,
                                      ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHospitalList(BuildContext context, MapState state) {
    if (state.hospitals.isEmpty) {
      return Center(child: Text(S.of(context).sorrynoresultfound));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: state.hospitals.length,
      itemBuilder: (context, index) {
        final h = state.hospitals[index];
        return Maphospitalcard(devheight: devheight, rate: 4.5, name: h.name);
      },
    );
  }

  Widget _buildPharmacyList(
    BuildContext context,
    MapState state,
    String locale,
  ) {
    if (state.pharmacies.isEmpty) {
      return Center(child: Text(S.of(context).sorrynoresultfound));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: state.pharmacies.length,
      itemBuilder: (context, index) {
        final Pharmacy p = state.pharmacies[index];
        final displayName = locale == 'ar' ? p.nameAr : p.name;
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PharmacyDetails(
                name: displayName,
                rate: p.rating,
                isopen24: p.is24Hours,
                devheight: devheight,
                latitude: p.latitude ?? 0,
                longitude: p.longitude ?? 0,
              ),
            ),
          ),
          child: Mappharmacycard(
            name: displayName,
            devheight: devheight,
            rate: p.rating,
          ),
        );
      },
    );
  }

  Widget _buildTabButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required NearbyCategory category,
    required bool isSelected,
  }) {
    return ElevatedButton.icon(
      onPressed: () => context.read<MapCubit>().selectCategory(category),
      icon: Icon(
        icon,
        color: isSelected ? Colors.white : const Color(0xff2260FF),
        size: 16,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xff2260FF),
          fontFamily: 'Cairo',
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, 29),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        backgroundColor: isSelected ? const Color(0xff2260FF) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: isSelected ? 4 : 0,
      ),
    );
  }
}
