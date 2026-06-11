import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Drug%20To%20Drug%20Interaction/drugToDrugCubit.dart';
import 'package:grad_project/cubit/Drug%20To%20Drug%20Interaction/drugToDrugStates.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/screens/Drug%20Interactions/druginteractionDetails.dart';

class DrugInteractionScreen extends StatefulWidget {
  const DrugInteractionScreen({super.key});

  @override
  State<DrugInteractionScreen> createState() => _DrugInteractionScreenState();
}

class _DrugInteractionScreenState extends State<DrugInteractionScreen> {
  final TextEditingController _drug1Controller = TextEditingController();
  final TextEditingController _drug2Controller = TextEditingController();

  static const Color kBlue = Color(0xFF1655FA);

  bool _dialogOpen = false;

  void _showResultDialog(BuildContext context, DrugInteractionState state) {
    if (_dialogOpen) return;
    _dialogOpen = true;

    final cubit = context.read<DrugInteractionCubit>();

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      barrierDismissible: false,
      builder: (dialogCtx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _ResultCard(state: state, cubit: cubit),
            Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(dialogCtx),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: kBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ).whenComplete(() => _dialogOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).drugInteractionChecker,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade300),
        ),
      ),
      body: BlocConsumer<DrugInteractionCubit, DrugInteractionState>(
        listenWhen: (prev, curr) {
          final isTerminal =
              curr is DrugInteractionFound ||
              curr is DrugInteractionNone ||
              curr is DrugInteractionNotFound ||
              curr is DrugInteractionError;
          final wasLoading = prev is DrugInteractionLoading;
          return isTerminal && wasLoading;
        },
        listener: (context, state) => _showResultDialog(context, state),
        builder: (context, state) {
          return Column(
            children: [
              // ── Top white section: image ──────────────────────────
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Image.asset(
                  'assets/images/Drugtodrug/image 1338.png',
                  fit: BoxFit.contain,
                ),
              ),

              // ── Blue section fills remaining space ────────────────
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: kBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Scrollable content
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // ── Medication 1 ──────────────────────
                              Text(
                                S.of(context).medicine1,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildSearchField(
                                context: context,
                                controller: _drug1Controller,
                                fieldIndex: 1,
                              ),
                              if (state is DrugAutocompleteSuggestionsLoaded &&
                                  state.fieldIndex == 1)
                                _buildSuggestionsList(
                                  context,
                                  state.suggestions,
                                  1,
                                ),
                              if (state is DrugAutocompleteSuggestionsLoading &&
                                  state.fieldIndex == 1)
                                _buildSuggestionsLoading(),

                              const SizedBox(height: 20),

                              // ── Medication 2 ──────────────────────
                              Text(
                                S.of(context).medicine2,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildSearchField(
                                context: context,
                                controller: _drug2Controller,
                                fieldIndex: 2,
                              ),
                              if (state is DrugAutocompleteSuggestionsLoaded &&
                                  state.fieldIndex == 2)
                                _buildSuggestionsList(
                                  context,
                                  state.suggestions,
                                  2,
                                ),
                              if (state is DrugAutocompleteSuggestionsLoading &&
                                  state.fieldIndex == 2)
                                _buildSuggestionsLoading(),

                              const SizedBox(height: 70),

                              // ── Check Interactions button ──────────
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: OutlinedButton.icon(
                                  onPressed: state is DrugInteractionLoading
                                      ? null
                                      : () => context
                                            .read<DrugInteractionCubit>()
                                            .checkInteractions(),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.transparent,
                                    disabledForegroundColor: Colors.white
                                        .withOpacity(0.5),
                                    side: BorderSide(
                                      color: state is DrugInteractionLoading
                                          ? Colors.white.withOpacity(0.4)
                                          : Colors.white,
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  icon: state is DrugInteractionLoading
                                      ? const SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Icon(Icons.search),
                                  label: Text(
                                    S.of(context).cheakInteractions,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ── Pinned disclaimer pill ─────────────────────
                      SafeArea(
                        top: false,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                          child: _DisclaimerPill(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchField({
    required BuildContext context,
    required TextEditingController controller,
    required int fieldIndex,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        onChanged: (value) {
          if (fieldIndex == 1) {
            context.read<DrugInteractionCubit>().onDrug1Changed(value);
          } else {
            context.read<DrugInteractionCubit>().onDrug2Changed(value);
          }
        },
        decoration: InputDecoration(
          hintText: '${S.of(context).search}...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionsList(
    BuildContext context,
    List<String> suggestions,
    int fieldIndex,
  ) {
    if (suggestions.isEmpty) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      constraints: const BoxConstraints(maxHeight: 200),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: suggestions.length,
        separatorBuilder: (_, __) =>
            Divider(height: 1, color: Colors.grey.shade200),
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFFE8EEFF),
              child: Icon(Icons.medication, color: Color(0xFF1655FA), size: 20),
            ),
            title: Text(
              suggestion,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            subtitle: Text(
              S.of(context).pain,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
            onTap: () {
              if (fieldIndex == 1) {
                _drug1Controller.text = suggestion;
              } else {
                _drug2Controller.text = suggestion;
              }
              context.read<DrugInteractionCubit>().selectSuggestion(
                fieldIndex,
                suggestion,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSuggestionsLoading() {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Color(0xFF1655FA),
          ),
        ),
      ),
    );
  }
}

// ── Reusable disclaimer pill ──────────────────────────────────────────────────

class _DisclaimerPill extends StatelessWidget {
  const _DisclaimerPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.white.withOpacity(0.85),
            size: 14,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              S.of(context).drugInteractionDisclaimer,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Result Card Widget ────────────────────────────────────────────────────────

class _ResultCard extends StatelessWidget {
  final DrugInteractionState state;
  final DrugInteractionCubit cubit;

  const _ResultCard({required this.state, required this.cubit});

  static const Color kBlue = Color(0xFF1655FA);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      decoration: BoxDecoration(
        color: kBlue,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon circle
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(_icon(), color: _iconColor(), size: 34),
          ),

          const SizedBox(height: 18),

          // Title
          Text(
            _title(context),
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
            _subtitle(context),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.82),
              fontSize: 13,
              height: 1.55,
            ),
          ),

          const SizedBox(height: 20),

          // ── Disclaimer pill ──────────────────────────────────────
          const _DisclaimerPill(),

          const SizedBox(height: 16),

          // ── Show All Details button ──────────────────────────────
          if (state is DrugInteractionFound || state is DrugInteractionNone)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: cubit,
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
                child: Text(
                  S.of(context).showAllDetails,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  IconData _icon() {
    if (state is DrugInteractionNotFound) return Icons.cancel;
    if (state is DrugInteractionNone) return Icons.check_circle;
    if (state is DrugInteractionFound) return Icons.info_outline;
    return Icons.error_outline;
  }

  Color _iconColor() {
    if (state is DrugInteractionNotFound) return Colors.red;
    if (state is DrugInteractionNone) return Colors.green;
    if (state is DrugInteractionFound) return kBlue;
    return Colors.orange;
  }

  String _title(BuildContext context) {
    if (state is DrugInteractionNotFound)
      return S.of(context).drugInfoUnavailable;
    if (state is DrugInteractionNone) return S.of(context).noInteractionsFound;
    if (state is DrugInteractionFound) return S.of(context).interactionFound;
    if (state is DrugInteractionError) return S.of(context).somethingWentWrong;
    return '';
  }

  String _subtitle(BuildContext context) {
    if (state is DrugInteractionNotFound)
      return S.of(context).drugInfoUnavailableSubtitle;
    if (state is DrugInteractionNone)
      return S.of(context).noInteractionsSubtitle;
    if (state is DrugInteractionFound)
      return S.of(context).interactionFoundSubtitle;
    if (state is DrugInteractionError)
      return (state as DrugInteractionError).message;
    return '';
  }
}
