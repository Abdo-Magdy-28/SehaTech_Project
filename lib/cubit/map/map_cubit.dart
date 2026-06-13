import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grad_project/models/hospitals.dart';
import 'package:grad_project/models/pharmacies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grad_project/services/Map/MapService.dart';

enum NearbyCategory { hospitals, pharmacies }

enum LocationStatus { initial, loading, success, denied, error }

enum NearbyStatus { initial, loading, success, error }

class MapState extends Equatable {
  final LocationStatus locationStatus;
  final LatLng? userLocation;
  final LatLng? currentLocation;

  final NearbyCategory selectedCategory;
  final NearbyStatus nearbyStatus;
  final List<Hospital> hospitals;
  final List<Pharmacy> pharmacies;
  final String? errorMessage;

  const MapState({
    this.locationStatus = LocationStatus.initial,
    this.userLocation,
    this.currentLocation,
    this.selectedCategory = NearbyCategory.pharmacies,
    this.nearbyStatus = NearbyStatus.initial,
    this.hospitals = const [],
    this.pharmacies = const [],
    this.errorMessage,
  });

  MapState copyWith({
    LocationStatus? locationStatus,
    LatLng? userLocation,
    LatLng? currentLocation,
    NearbyCategory? selectedCategory,
    NearbyStatus? nearbyStatus,
    List<Hospital>? hospitals,
    List<Pharmacy>? pharmacies,
    String? errorMessage,
  }) {
    return MapState(
      locationStatus: locationStatus ?? this.locationStatus,
      userLocation: userLocation ?? this.userLocation,
      currentLocation: currentLocation ?? this.currentLocation,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      nearbyStatus: nearbyStatus ?? this.nearbyStatus,
      hospitals: hospitals ?? this.hospitals,
      pharmacies: pharmacies ?? this.pharmacies,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    locationStatus,
    userLocation,
    currentLocation,
    selectedCategory,
    nearbyStatus,
    hospitals,
    pharmacies,
    errorMessage,
  ];
}

class MapCubit extends Cubit<MapState> {
  final MapService _service;

  MapCubit(this._service) : super(const MapState());

  Future<void> initLocation() async {
    emit(state.copyWith(locationStatus: LocationStatus.loading));
    try {
      final pos = await _service.getCurrentPosition();
      final loc = LatLng(pos.latitude, pos.longitude);
      emit(
        state.copyWith(
          locationStatus: LocationStatus.success,
          userLocation: loc,
          currentLocation: state.currentLocation ?? loc,
        ),
      );
      fetchNearby(state.selectedCategory);
    } on LocationPermissionDeniedException {
      emit(
        state.copyWith(
          locationStatus: LocationStatus.denied,
          currentLocation:
              state.currentLocation ?? const LatLng(30.0444, 31.2357),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          locationStatus: LocationStatus.error,
          errorMessage: e.toString(),
          currentLocation:
              state.currentLocation ?? const LatLng(30.0444, 31.2357),
        ),
      );
    }
  }

  void setExternalTarget(LatLng location) {
    emit(state.copyWith(currentLocation: location));
  }

  Future<void> recenterToUser() async {
    if (state.userLocation != null) {
      emit(state.copyWith(currentLocation: state.userLocation));
    } else {
      await initLocation();
    }
  }

  void selectCategory(NearbyCategory category) {
    emit(state.copyWith(selectedCategory: category));
    fetchNearby(category);
  }

  Future<void> fetchNearby(NearbyCategory category) async {
    final loc = state.userLocation;
    if (loc == null) return;

    emit(state.copyWith(nearbyStatus: NearbyStatus.loading));
    try {
      if (category == NearbyCategory.hospitals) {
        final hospitals = await _service.getNearbyHospitals(
          lat: loc.latitude,
          lng: loc.longitude,
        );
        emit(
          state.copyWith(
            nearbyStatus: NearbyStatus.success,
            hospitals: hospitals,
          ),
        );
      } else {
        final pharmacies = await _service.getNearbyPharmacies(
          lat: loc.latitude,
          lng: loc.longitude,
        );
        emit(
          state.copyWith(
            nearbyStatus: NearbyStatus.success,
            pharmacies: pharmacies,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          nearbyStatus: NearbyStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

extension MapStateRadius on MapState {
  double get searchRadiusMeters => 20000;
}
