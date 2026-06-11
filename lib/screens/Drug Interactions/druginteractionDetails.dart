import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Drug%20To%20Drug%20Interaction/drugToDrugCubit.dart';
import 'package:grad_project/cubit/Drug%20To%20Drug%20Interaction/drugToDrugStates.dart';

const Color _kBlue = Color(0xFF1655FA);

class DrugInteractionDetailScreen extends StatefulWidget {
  final DrugInteractionState state;

  const DrugInteractionDetailScreen({super.key, required this.state});

  @override
  State<DrugInteractionDetailScreen> createState() =>
      _DrugInteractionDetailScreenState();
}

class _DrugInteractionDetailScreenState
    extends State<DrugInteractionDetailScreen> {
  bool _showEnglish = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No bottom nav bar — full-screen detail view
      backgroundColor: _kBlue,
      body: BlocBuilder<DrugInteractionCubit, DrugInteractionState>(
        builder: (context, liveState) {
          // Use liveState so we get updates when explanation finishes loading
          final currentState =
              liveState is DrugInteractionFound ||
                  liveState is DrugInteractionNone
              ? liveState
              : widget.state;

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Back arrow — centered ─────────────────────────────
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),

                // ── Language Toggle with centred icon ─────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _showEnglish = true),
                              child: Column(
                                children: [
                                  Text(
                                    'English',
                                    style: TextStyle(
                                      color: _showEnglish
                                          ? Colors.white
                                          : Colors.white54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 2,
                                    color: _showEnglish
                                        ? Colors.white
                                        : Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 64),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _showEnglish = false),
                              child: Column(
                                children: [
                                  Text(
                                    'العربية',
                                    style: TextStyle(
                                      color: !_showEnglish
                                          ? Colors.white
                                          : Colors.white54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 2,
                                    color: !_showEnglish
                                        ? Colors.white
                                        : Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Centred icon circle
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: _kBlue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          currentState is DrugInteractionNone
                              ? Icons.check_circle_outline
                              : Icons.info_outline,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ── Scrollable Content ────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _buildContent(currentState),
                  ),
                ),

                // ── Bottom Button ─────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: _kBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.search, size: 18),
                      label: const Text(
                        'Check Interactions',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── Content Builder ───────────────────────────────────────────────────────

  Widget _buildContent(DrugInteractionState state) {
    if (state is DrugInteractionNone) {
      return _buildTextContent(
        title: _showEnglish
            ? 'Great News! No Drug Interactions Detected'
            : 'أخبار رائعة! لم يتم اكتشاف أي تفاعلات دوائية',
        body: _showEnglish
            ? 'We analyzed the medications you entered and found no known clinically '
                  'significant interactions between them. Based on the current medical database, '
                  'these medications can generally be used together safely.\n\n'
                  'Please note that individual factors such as dosage, medical history, and '
                  'existing health conditions may still affect treatment safety. Always follow '
                  "your healthcare provider's recommendations for personalized guidance."
            : 'لقد حللنا الأدوية التي أدخلتها ولم نجد أي تفاعلات سريرية معروفة بينها. '
                  'بناءً على قاعدة البيانات الطبية الحالية، يمكن عمومًا استخدام هذه الأدوية معًا بأمان.\n\n'
                  'يرجى ملاحظة أن العوامل الفردية مثل الجرعة والتاريخ الطبي والحالات الصحية '
                  'القائمة قد تؤثر على سلامة العلاج. اتبع دائمًا توصيات مقدم الرعاية الصحية للحصول على إرشادات شخصية.',
      );
    }

    if (state is DrugInteractionFound) {
      if (state.explanationLoading) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 48),
          child: Center(child: CircularProgressIndicator(color: Colors.white)),
        );
      }

      final explanation = state.explanation;
      if (explanation != null) {
        return _buildTextContent(
          title: _showEnglish
              ? 'Potential Drug Interaction Detected'
              : 'تم اكتشاف تفاعل دوائي محتمل',
          body: _showEnglish ? explanation.english : explanation.arabic,
        );
      }

      // Fallback: raw interactions list (explanation not yet returned)
      return _buildTextContent(
        title: 'Potential Drug Interaction Detected',
        body: state.interactions.join('\n\n'),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildTextContent({required String title, required String body}) {
    final isRtl = !_showEnglish;
    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            body,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 14,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
