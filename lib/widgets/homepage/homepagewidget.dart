import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/language/locale_cubit.dart';
import 'package:grad_project/models/medicineremindercardmodel.dart';
import 'package:grad_project/screens/alldoctors.dart';
import 'package:grad_project/screens/chatbotScreen.dart';
import 'package:grad_project/widgets/categorysrow.dart';
import 'package:grad_project/widgets/chatbotslider.dart';
import 'package:grad_project/widgets/customappbar.dart';
import 'package:grad_project/widgets/doctors/doctor_card.dart';
import 'package:grad_project/widgets/doctors/doctor_details.dart';
import 'package:grad_project/widgets/hearttopic.dart';
import 'package:grad_project/widgets/homepage/home_carouselcard.dart';
import 'package:grad_project/widgets/homepage/medication_management_grid.dart';
import 'package:grad_project/widgets/Medicines/MedicineReminderCard.dart';
import 'package:grad_project/widgets/Medicines/UpcomingReminder.dart';
import 'package:grad_project/widgets/prevent_diseases.dart';
import 'package:grad_project/widgets/weakcalender.dart';
import 'package:grad_project/widgets/weaklystreak.dart';
import 'package:grad_project/generated/l10n.dart';

class Homepagewidget extends StatefulWidget {
  const Homepagewidget({super.key});

  @override
  State<Homepagewidget> createState() => _HomepagewidgetState();
}

class _HomepagewidgetState extends State<Homepagewidget> {
  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Center(
        child: SizedBox(
          width: devwidth * 0.9,
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.02)),
              SliverToBoxAdapter(child: Customappbar()),
              SliverToBoxAdapter(
                child: SizedBox(width: devwidth, child: Divider(thickness: 1)),
              ),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () => _showLanguageSheet(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.language, size: 20),
                      const SizedBox(width: 6),
                      BlocBuilder<LocaleCubit, Locale>(
                        builder: (context, locale) => Text(
                          locale.languageCode == 'en' ? 'English' : 'عربية',
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down, size: 18),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.01)),

              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatBotScreen()),
                  ),
                  child: chatbotslider(devheight: devheight),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(child: categorysrow()),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.030)),
              SliverToBoxAdapter(
                child: home_crouselcard(
                  devwidth: devwidth,
                  devheight: devheight,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).findDoctors,
                      style: TextStyle(
                        color: Color(0xff33384B),
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Alldoctors()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          S.of(context).seeAll,
                          style: TextStyle(
                            color: Color(0xff2E6FF3),
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorDetails(
                            name: S.of(context).youssefAli,
                            begindate: S.of(context).startTime,
                            enddate: S.of(context).endTime,
                            hospital: S.of(context).elDemerdashHospital,
                            job: S.of(context).neurologist,
                            rate: 4.5,
                          ),
                        ),
                      );
                    },
                    child: Doctorcard(
                      devheight: devheight,
                      doctorimage: Image.asset('assets/images/Pic.png'),
                      job: S.of(context).neurologist,
                      hospital: S.of(context).elDemerdashHospital,
                      name: S.of(context).youssefAli,
                      rate: 4.5,
                      begindate: S.of(context).startTime,
                      enddate: S.of(context).endTime,
                    ),
                  );
                }, childCount: 5),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(
                child: Text(
                  S.of(context).medicationManagement,
                  style: TextStyle(
                    color: Color(0xff33384B),
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.02)),
              SliverToBoxAdapter(
                child: MedicationManagementGrid(
                  devheight: devheight,
                  devwidth: devwidth,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(
                child: UpcomingReminder(
                  medicine: MedicineReminderCardModel(
                    medicineName: S.of(context).belladonna30,
                    dosage: S.of(context).dosage,
                    reminderTime: S.of(context).reminderTime,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(child: Weaklystreak()),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(child: WeekScheduleWidget()),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Medicineremindercard(
                    image: Image.asset("assets/images/Shape10.png"),
                    condition: S.of(context).missed,
                    name: S.of(context).belladonna30,
                    quatity: S.of(context).drops,
                    scheduletime: S.of(context).everyTwoHours,
                    time: S.of(context).reminderTime,
                  );
                }, childCount: 3),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).importantTopics,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color(0xff33384B),
                      ),
                    ),
                    Text(
                      S.of(context).seeAll,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xff2E6FF3),
                      ),
                    ),
                  ],
                ),
              ),

              SliverToBoxAdapter(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: SizedBox(
                    height: 170,
                    child: ListView(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(right: 20, bottom: 15, top: 15),
                      children: [hearttopic(), prevent_diseases()],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showLanguageSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Select language',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 14),
                _LangOption(
                  code: 'en',
                  flag: '🇬🇧',
                  name: 'English',
                  native: 'English',
                  selected: locale.languageCode == 'en',
                ),
                _LangOption(
                  code: 'ar',
                  flag: '🇸🇦',
                  name: 'Arabic',
                  native: 'عربية',
                  selected: locale.languageCode == 'ar',
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

class _LangOption extends StatelessWidget {
  final String code, flag, name, native;
  final bool selected;

  const _LangOption({
    required this.code,
    required this.flag,
    required this.name,
    required this.native,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFEFF6FF) : Colors.transparent,
        border: Border.all(
          color: selected ? const Color(0xFFBFDBFE) : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () {
          context.read<LocaleCubit>().setLocale(code);
          Navigator.pop(context);
        },
        leading: Text(flag, style: const TextStyle(fontSize: 28)),
        title: Text(
          name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(native, style: const TextStyle(fontSize: 13)),
        trailing: selected
            ? const Icon(Icons.check, color: Color(0xFF2563EB), size: 20)
            : null,
      ),
    );
  }
}
