import 'package:equatable/equatable.dart';
import 'package:grad_project/services/drugToDrugService.dart';

abstract class DrugInteractionState extends Equatable {
  const DrugInteractionState();

  @override
  List<Object?> get props => [];
}

/// Initial / idle state — both search fields are empty.
class DrugInteractionInitial extends DrugInteractionState {
  const DrugInteractionInitial();
}

/// User is typing in one of the drug fields; suggestions are loading.
class DrugAutocompleteSuggestionsLoading extends DrugInteractionState {
  final int fieldIndex; // 1 or 2
  const DrugAutocompleteSuggestionsLoading(this.fieldIndex);

  @override
  List<Object?> get props => [fieldIndex];
}

/// Autocomplete suggestions are ready for a field.
class DrugAutocompleteSuggestionsLoaded extends DrugInteractionState {
  final int fieldIndex;
  final List<String> suggestions;

  const DrugAutocompleteSuggestionsLoaded({
    required this.fieldIndex,
    required this.suggestions,
  });

  @override
  List<Object?> get props => [fieldIndex, suggestions];
}

/// The "Check Interactions" button was pressed; waiting for the API.
class DrugInteractionLoading extends DrugInteractionState {
  const DrugInteractionLoading();
}

/// API returned 0 interactions → safe combination.
class DrugInteractionNone extends DrugInteractionState {
  final String drug1;
  final String drug2;

  const DrugInteractionNone({required this.drug1, required this.drug2});

  @override
  List<Object?> get props => [drug1, drug2];
}

/// API returned ≥1 interaction(s). Contains raw list and optional explanation.
class DrugInteractionFound extends DrugInteractionState {
  final String drug1;
  final String drug2;
  final List<String> interactions;
  final InteractionExplanation? explanation;
  final bool explanationLoading;

  const DrugInteractionFound({
    required this.drug1,
    required this.drug2,
    required this.interactions,
    this.explanation,
    this.explanationLoading = false,
  });

  DrugInteractionFound copyWith({
    InteractionExplanation? explanation,
    bool? explanationLoading,
  }) => DrugInteractionFound(
    drug1: drug1,
    drug2: drug2,
    interactions: interactions,
    explanation: explanation ?? this.explanation,
    explanationLoading: explanationLoading ?? this.explanationLoading,
  );

  @override
  List<Object?> get props => [
    drug1,
    drug2,
    interactions,
    explanation,
    explanationLoading,
  ];
}

/// The drug name was not found in the database or entered incorrectly.
class DrugInteractionNotFound extends DrugInteractionState {
  const DrugInteractionNotFound();
}

/// A network / server error occurred.
class DrugInteractionError extends DrugInteractionState {
  final String message;
  const DrugInteractionError(this.message);

  @override
  List<Object?> get props => [message];
}
