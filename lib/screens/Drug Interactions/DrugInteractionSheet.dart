import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Drug%20To%20Drug%20Interaction/drugToDrugCubit.dart';
import 'package:grad_project/cubit/Drug%20To%20Drug%20Interaction/drugToDrugStates.dart';
import 'package:grad_project/screens/Drug%20Interactions/druginteractionDetails.dart';

const Color kBlue = Color(0xFF1655FA);

/// Call this after [DrugInteractionCubit.checkInteractions()] emits a result.
/// It shows itself as a modal bottom sheet and handles all result states.
void showDrugInteractionResultSheet(
  BuildContext context,
  DrugInteractionState state,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => BlocProvider.value(
      value: context.read<DrugInteractionCubit>(),
      child: _DrugInteractionResultSheet(state: state),
    ),
  );
}

class _DrugInteractionResultSheet extends StatelessWidget {
  final DrugInteractionState state;
  const _DrugInteractionResultSheet({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kBlue,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Icon circle
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: _buildIcon(),
          ),

          const SizedBox(height: 20),

          // Title
          Text(
            _title(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),

          const SizedBox(height: 10),

          // Subtitle
          Text(
            _subtitle(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.80),
              fontSize: 13,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          // Buttons
          ..._buildButtons(context),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  Widget _buildIcon() {
    if (state is DrugInteractionNotFound) {
      return const Icon(Icons.cancel, color: Colors.red, size: 36);
    }
    if (state is DrugInteractionNone) {
      return const Icon(Icons.check_circle, color: Colors.green, size: 36);
    }
    if (state is DrugInteractionFound) {
      return const Icon(Icons.info_outline, color: kBlue, size: 36);
    }
    if (state is DrugInteractionError) {
      return const Icon(Icons.error_outline, color: Colors.orange, size: 36);
    }
    return const Icon(Icons.help_outline, color: Colors.grey, size: 36);
  }

  String _title() {
    if (state is DrugInteractionNotFound) return 'Drug Information Unavailable';
    if (state is DrugInteractionNone) return 'There is No Interactions';
    if (state is DrugInteractionFound)
      return '1 Potential Drug Interaction Found';
    if (state is DrugInteractionError) return 'Something Went Wrong';
    return '';
  }

  String _subtitle() {
    if (state is DrugInteractionNotFound) {
      return 'No interaction data was found for this medication. '
          'The drug may be unavailable in our current database or entered incorrectly.';
    }
    if (state is DrugInteractionNone) {
      return 'No known clinically significant interactions were detected '
          'between these two medications.';
    }
    if (state is DrugInteractionFound) {
      return 'This combination may affect treatment safety or increase the risk '
          'of side effects. Please review the interaction details below and '
          'consult your healthcare provider if necessary.';
    }
    if (state is DrugInteractionError) {
      return (state as DrugInteractionError).message;
    }
    return '';
  }

  List<Widget> _buildButtons(BuildContext context) {
    final buttons = <Widget>[];

    // "Show All Details" — only when there are interactions or no-interaction result
    if (state is DrugInteractionFound || state is DrugInteractionNone) {
      buttons.add(
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // close sheet first
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<DrugInteractionCubit>(),
                    child: DrugInteractionDetailScreen(state: state),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: kBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Show All Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ),
      );
      buttons.add(const SizedBox(height: 12));
    }

    // "Check Interactions" (retry / start over)
    buttons.add(
      SizedBox(
        width: double.infinity,
        height: 48,
        child: OutlinedButton.icon(
          onPressed: () => Navigator.pop(context),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          icon: const Icon(Icons.search, size: 18),
          label: const Text(
            'Check Interactions',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
    );

    return buttons;
  }
}
