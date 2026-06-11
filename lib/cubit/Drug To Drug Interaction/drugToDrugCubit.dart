import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Drug%20To%20Drug%20Interaction/drugToDrugStates.dart';
import 'package:grad_project/services/drugToDrugService.dart';

class DrugInteractionCubit extends Cubit<DrugInteractionState> {
  final DrugInteractionService _service;

  DrugInteractionCubit({DrugInteractionService? service})
    : _service = service ?? DrugInteractionService(),
      super(const DrugInteractionInitial());

  // Debounce timers for each field.
  Timer? _debounce1;
  Timer? _debounce2;

  // Currently selected drug names (confirmed from suggestions or typed).
  String _drug1 = '';
  String _drug2 = '';

  String get drug1 => _drug1;
  String get drug2 => _drug2;

  // ── Autocomplete ─────────────────────────────────────────────────────────

  void onDrug1Changed(String value) {
    _drug1 = value;
    _debounce1?.cancel();
    if (value.trim().isEmpty) {
      emit(const DrugInteractionInitial());
      return;
    }
    _debounce1 = Timer(const Duration(milliseconds: 350), () {
      _fetchSuggestions(1, value);
    });
  }

  void onDrug2Changed(String value) {
    _drug2 = value;
    _debounce2?.cancel();
    if (value.trim().isEmpty) {
      emit(const DrugInteractionInitial());
      return;
    }
    _debounce2 = Timer(const Duration(milliseconds: 350), () {
      _fetchSuggestions(2, value);
    });
  }

  Future<void> _fetchSuggestions(int fieldIndex, String query) async {
    print('🔵 fetchSuggestions called: field=$fieldIndex query=$query');
    emit(DrugAutocompleteSuggestionsLoading(fieldIndex));
    print('🟡 emitted loading');
    try {
      final suggestions = await _service.autocomplete(query);
      print('🟢 got suggestions: ${suggestions.length}');
      emit(
        DrugAutocompleteSuggestionsLoaded(
          fieldIndex: fieldIndex,
          suggestions: suggestions,
        ),
      );
    } catch (e) {
      print('🔴 error: $e');
      emit(
        DrugAutocompleteSuggestionsLoaded(
          fieldIndex: fieldIndex,
          suggestions: [],
        ),
      );
    }
  }

  void selectSuggestion(int fieldIndex, String value) {
    if (fieldIndex == 1) {
      _drug1 = value;
    } else {
      _drug2 = value;
    }
    // Dismiss suggestions and go back to idle.
    emit(const DrugInteractionInitial());
  }

  // ── Check Interactions ────────────────────────────────────────────────────

  Future<void> checkInteractions() async {
    if (_drug1.trim().isEmpty || _drug2.trim().isEmpty) return;

    emit(const DrugInteractionLoading());

    try {
      final interactions = await _service.checkInteractions(
        _drug1.trim(),
        _drug2.trim(),
      );

      if (interactions.isEmpty) {
        emit(DrugInteractionNone(drug1: _drug1, drug2: _drug2));
      } else {
        emit(
          DrugInteractionFound(
            drug1: _drug1,
            drug2: _drug2,
            interactions: interactions,
          ),
        );
        // Automatically fetch the bilingual explanation.
        await _fetchExplanation(interactions);
      }
    } on Exception catch (e) {
      final msg = e.toString();
      // Treat 404-like errors as "not found in database".
      if (msg.contains('404') || msg.contains('not found')) {
        emit(const DrugInteractionNotFound());
      } else {
        emit(DrugInteractionError(msg));
      }
    }
  }

  Future<void> _fetchExplanation(List<String> interactions) async {
    final current = state;
    if (current is! DrugInteractionFound) return;

    emit(current.copyWith(explanationLoading: true));

    try {
      final explanation = await _service.explainInteractions(
        drug1: _drug1,
        drug2: _drug2,
        interactionsText: interactions.join('\n'),
      );

      final updated = state;
      if (updated is DrugInteractionFound) {
        emit(
          updated.copyWith(explanation: explanation, explanationLoading: false),
        );
      }
    } catch (_) {
      final updated = state;
      if (updated is DrugInteractionFound) {
        emit(updated.copyWith(explanationLoading: false));
      }
    }
  }

  // ── Reset ─────────────────────────────────────────────────────────────────

  void reset() {
    _drug1 = '';
    _drug2 = '';
    _debounce1?.cancel();
    _debounce2?.cancel();
    emit(const DrugInteractionInitial());
  }

  @override
  Future<void> close() {
    _debounce1?.cancel();
    _debounce2?.cancel();
    return super.close();
  }
}
