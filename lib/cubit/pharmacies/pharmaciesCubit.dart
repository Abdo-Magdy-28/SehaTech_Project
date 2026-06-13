import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/pharmacies/pharmaciesStates.dart';
import 'package:grad_project/models/pharmacies.dart';
import 'package:grad_project/services/pharmacies/pharmaciesService.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  final PharmacyService pharmacyService;
  List<Pharmacy> _allPharmacies = [];

  PharmacyCubit(this.pharmacyService) : super(PharmacyInitial());

  Future<void> fetchPharmacies({int page = 1}) async {
    emit(PharmacyLoading());
    try {
      final pharmacies = await pharmacyService.getPharmacies(page: page);
      _allPharmacies = pharmacies;
      emit(PharmacyLoaded(pharmacies: pharmacies));
    } catch (e) {
      emit(PharmacyError(e.toString()));
    }
  }

  Future<void> searchPharmacies(String query) async {
    if (query.isEmpty) {
      emit(PharmacyLoaded(pharmacies: _allPharmacies));
      return;
    }

    emit(PharmacyLoading());
    try {
      final results = await pharmacyService.searchPharmacies(query);
      if (results.isEmpty) {
        emit(const PharmacySearchEmpty());
      } else {
        emit(PharmacyLoaded(pharmacies: results, isSearching: true));
      }
    } catch (e) {
      emit(PharmacyError(e.toString()));
    }
  }

  Future<void> fetchNearbyPharmacies({
    required double lat,
    required double lng,
  }) async {
    emit(PharmacyLoading());
    try {
      final pharmacies = await pharmacyService.getNearbyPharmacies(
        lat: lat,
        lng: lng,
      );
      _allPharmacies = pharmacies;
      emit(PharmacyLoaded(pharmacies: pharmacies));
    } catch (e) {
      emit(PharmacyError(e.toString()));
    }
  }

  void resetToAll() {
    emit(PharmacyLoaded(pharmacies: _allPharmacies));
  }
}
