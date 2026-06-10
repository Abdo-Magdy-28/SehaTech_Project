// ── health_matrix_cubit.dart ──────────────────────────────────────────────────

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/profile/Health%20Matrix/healthmatrixstates.dart';
import 'package:grad_project/models/healthmatrixmodel.dart';
import 'package:grad_project/services/profile/healthmatrixservice.dart';

class HealthMatrixCubit extends Cubit<HealthMatrixState> {
  final HealthMatrixService _service;
  final String userId;
  final String token;

  HealthMatrixCubit({
    required this.userId,
    required this.token,
    HealthMatrixService? service,
  }) : _service = service ?? HealthMatrixService(),
       super(const HealthMatrixInitial());

  // ── Load (GET) ───────────────────────────────────────────────────────────────

  Future<void> loadHealthMatrix() async {
    emit(const HealthMatrixLoading());
    try {
      final data = await _service.getHealthMatrix(userId: userId, token: token);
      emit(HealthMatrixLoaded(data));
    } on HealthMatrixException catch (e) {
      if (e.statusCode == 404) {
        emit(const HealthMatrixNotFound());
      } else if (e.statusCode == 401) {
        emit(const HealthMatrixUnauthorized());
      } else {
        emit(HealthMatrixError(e.message));
      }
    } catch (e) {
      emit(HealthMatrixError(_friendlyError(e)));
    }
  }

  // ── Create (POST) ────────────────────────────────────────────────────────────

  Future<void> createHealthMatrix(HealthMatrixModel data) async {
    emit(const HealthMatrixLoading());
    try {
      final saved = await _service.createHealthMatrix(
        userId: userId,
        token: token,
        data: data,
      );
      emit(HealthMatrixSaved(saved));
    } on HealthMatrixException catch (e) {
      emit(HealthMatrixError(e.message));
    } catch (e) {
      emit(HealthMatrixError(_friendlyError(e)));
    }
  }

  // ── Update (PATCH) ───────────────────────────────────────────────────────────

  Future<void> updateHealthMatrix(HealthMatrixModel data) async {
    emit(const HealthMatrixLoading());
    try {
      final saved = await _service.updateHealthMatrix(
        userId: userId,
        token: token,
        data: data,
      );
      emit(HealthMatrixSaved(saved));
    } on HealthMatrixException catch (e) {
      emit(HealthMatrixError(e.message));
    } catch (e) {
      emit(HealthMatrixError(_friendlyError(e)));
    }
  }

  // ── Convenience: add / remove allergy locally then patch ────────────────────

  Future<void> addAllergy(String substance, {String? severity}) async {
    final current = _currentData;
    if (current == null) return;

    final optimistic = current.copyWith(
      allergies: [
        ...current.allergies,
        AllergyModel(substance: substance, severity: severity),
      ],
    );
    emit(HealthMatrixLoaded(optimistic));

    try {
      final saved = await _service.updateHealthMatrix(
        userId: userId,
        token: token,
        data: optimistic,
      );
      emit(HealthMatrixSaved(saved));
    } on HealthMatrixException catch (e) {
      emit(HealthMatrixLoaded(current)); // rollback
      emit(HealthMatrixError(e.message));
    } catch (e) {
      emit(HealthMatrixLoaded(current)); // rollback
      emit(HealthMatrixError(_friendlyError(e)));
    }
  }

  Future<void> removeAllergyAt(int index) async {
    final current = _currentData;
    if (current == null) return;
    if (index < 0 || index >= current.allergies.length) return; // bounds guard

    final list = List<AllergyModel>.from(current.allergies)..removeAt(index);
    final optimistic = current.copyWith(allergies: list);
    emit(HealthMatrixLoaded(optimistic));

    try {
      final saved = await _service.updateHealthMatrix(
        userId: userId,
        token: token,
        data: optimistic,
      );
      emit(HealthMatrixSaved(saved));
    } on HealthMatrixException catch (e) {
      emit(HealthMatrixLoaded(current)); // rollback
      emit(HealthMatrixError(e.message));
    } catch (e) {
      emit(HealthMatrixLoaded(current)); // rollback
      emit(HealthMatrixError(_friendlyError(e)));
    }
  }

  Future<void> addDisease(String name) async {
    final current = _currentData;
    if (current == null) return;

    final optimistic = current.copyWith(
      chronicDiseases: [...current.chronicDiseases, name],
    );
    emit(HealthMatrixLoaded(optimistic));

    try {
      final saved = await _service.updateHealthMatrix(
        userId: userId,
        token: token,
        data: optimistic,
      );
      emit(HealthMatrixSaved(saved));
    } on HealthMatrixException catch (e) {
      emit(HealthMatrixLoaded(current)); // rollback
      emit(HealthMatrixError(e.message));
    } catch (e) {
      emit(HealthMatrixLoaded(current)); // rollback
      emit(HealthMatrixError(_friendlyError(e)));
    }
  }

  Future<void> removeDiseaseAt(int index) async {
    final current = _currentData;
    if (current == null) return;
    if (index < 0 || index >= current.chronicDiseases.length)
      return; // bounds guard

    final list = List<String>.from(current.chronicDiseases)..removeAt(index);
    final optimistic = current.copyWith(chronicDiseases: list);
    emit(HealthMatrixLoaded(optimistic));

    try {
      final saved = await _service.updateHealthMatrix(
        userId: userId,
        token: token,
        data: optimistic,
      );
      emit(HealthMatrixSaved(saved));
    } on HealthMatrixException catch (e) {
      emit(HealthMatrixLoaded(current)); // rollback
      emit(HealthMatrixError(e.message));
    } catch (e) {
      emit(HealthMatrixLoaded(current)); // rollback
      emit(HealthMatrixError(_friendlyError(e)));
    }
  }

  Future<void> changeBloodType(String bloodType) async {
    final current = _currentData;
    if (current == null) return;
    if (current.bloodType == bloodType) return; // no-op guard

    final optimistic = current.copyWith(bloodType: bloodType);
    emit(HealthMatrixLoaded(optimistic));

    try {
      final saved = await _service.updateHealthMatrix(
        userId: userId,
        token: token,
        data: optimistic,
      );
      emit(HealthMatrixSaved(saved));
    } on HealthMatrixException catch (e) {
      emit(HealthMatrixLoaded(current)); // rollback
      emit(HealthMatrixError(e.message));
    } catch (e) {
      emit(HealthMatrixLoaded(current)); // rollback
      emit(HealthMatrixError(_friendlyError(e)));
    }
  }

  // ── Internal helpers ─────────────────────────────────────────────────────────

  HealthMatrixModel? get _currentData {
    final s = state;
    if (s is HealthMatrixLoaded) return s.data;
    if (s is HealthMatrixSaved) return s.data;
    return null;
  }

  String _friendlyError(Object e) {
    final msg = e.toString();
    if (e is SocketException ||
        msg.contains('SocketException') ||
        msg.contains('Failed host lookup')) {
      return 'No internet connection. Please check your network and try again.';
    }
    if (msg.contains('TimeoutException') || msg.contains('timed out')) {
      return 'Request timed out. Please try again.';
    }
    if (msg.contains('ClientException')) {
      return 'Network error. Please check your connection and try again.';
    }
    return 'Something went wrong. Please try again.';
  }
}
