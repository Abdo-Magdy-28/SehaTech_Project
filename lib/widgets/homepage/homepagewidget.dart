import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Reminder/DailyReminder.dart';
import 'package:grad_project/cubit/doctors/popular/popular_states.dart';
import 'package:grad_project/cubit/doctors/popular/popularcubit.dart';
import 'package:grad_project/cubit/language/locale_cubit.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/Reminders/DailyReminder.dart';
import 'package:grad_project/models/medicineremindercardmodel.dart';
import 'package:grad_project/screens/Doctors/alldoctors.dart';
import 'package:grad_project/screens/chatbotScreen.dart';
import 'package:grad_project/widgets/Medicines/EmptyUpcoming.dart';
import 'package:grad_project/widgets/Medicines/MedicineReminderCard.dart';
import 'package:grad_project/widgets/Medicines/UpcomingReminder.dart';
import 'package:grad_project/widgets/categorysrow.dart';
import 'package:grad_project/widgets/chatbotslider.dart';
import 'package:grad_project/widgets/customappbar.dart';
import 'package:grad_project/widgets/doctors/doctor_card.dart';
import 'package:grad_project/widgets/doctors/doctor_details.dart';
import 'package:grad_project/widgets/hearttopic.dart';
import 'package:grad_project/widgets/homepage/DrugtoDrugwidget.dart';
import 'package:grad_project/widgets/homepage/home_carouselcard.dart';
import 'package:grad_project/widgets/homepage/medication_management_grid.dart';
import 'package:grad_project/widgets/prevent_diseases.dart';
import 'package:grad_project/widgets/weakcalender.dart';
import 'package:grad_project/widgets/weaklystreak.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Homepagewidget extends StatefulWidget {
  const Homepagewidget({super.key});

  @override
  State<Homepagewidget> createState() => _HomepagewidgetState();
}

class _HomepagewidgetState extends State<Homepagewidget> {
  int _index = 0;
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

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
              BlocBuilder<DoctorCubit, DoctorState>(
                builder: (context, state) {
                  if (state is DoctorLoading) {
                    // Skeleton shimmer while loading
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Skeletonizer(
                            child: Doctorcard(
                              doctorimage: Image.asset('assets/images/Pic.png'),
                              job: "Loading...",
                              hospital: "Loading...",
                              name: "Loading...",
                              rate: 0,
                              begindate: "--:--",
                              enddate: "--:--",
                              profile: "",
                            ),
                          );
                        },
                        childCount: 5, // show 5 skeletons
                      ),
                    );
                  } else if (state is DoctorLoaded) {
                    // Real doctors list
                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final doctor = state.doctors[index];
                        return Doctorcard(
                          doctorimage: Image.network(doctor.image),
                          job: doctor.job,
                          hospital: doctor.hospital,
                          name: doctor.name,
                          rate: doctor.rate,
                          begindate: doctor.beginDate,
                          enddate: doctor.endDate,
                          profile: doctor.profile ?? "",
                        );
                      }, childCount: state.doctors.length),
                    );
                  } else if (state is DoctorError) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text("Error: ${state.message}")),
                    );
                  } else {
                    return SliverToBoxAdapter(
                      child: Center(child: Text("No data")),
                    );
                  }
                },
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
                child: BlocBuilder<DailyScheduleCubit, DailyScheduleState>(
                  builder: (context, state) {
                    final cubit = context.read<DailyScheduleCubit>();
                    if (state is DailyScheduleLoading) {
                      return Skeletonizer(
                        child: UpcomingReminder(
                          medicine: DailyMedications(
                            reminderId: "",
                            medicationName: "Loading...",
                            genericName: "",
                            form: "",
                            strength: "",
                            instructions: "",
                            color: "",
                            status: "",
                            dosage: "-",
                            time: "--:--",
                          ),
                        ),
                      );
                    } else if (state is DailyScheduleLoaded) {
                      final pending = cubit.getUpcomingForToday(
                        state.medications,
                      );
                      if (_index >= pending.length) _index = 0;
                      if (pending.isNotEmpty) {
                        return UpcomingReminder(medicine: pending.first);
                      } else {
                        return EmptyUpcoming(
                          medicine: DailyMedications(
                            reminderId: "",
                            medicationName: S
                                .of(context)
                                .Nowupcomingreminderstoday,
                            genericName: "",
                            form: "",
                            strength: "",
                            instructions: "",
                            color: "",
                            status: "",
                            dosage: "-",
                            time: "--:--",
                          ),
                        );
                      }
                    } else if (state is DailyScheduleError) {
                      return Center(
                        child: Text(
                          "Error: ${state.message}",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(child: DrugInteractionCheckerCard()),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(child: Weaklystreak()),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(
                child: WeekScheduleWidget(
                  onDateSelected: (selectedDate) {
                    context.read<DailyScheduleCubit>().loadSchedule(
                      selectedDate,
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              BlocBuilder<DailyScheduleCubit, DailyScheduleState>(
                builder: (context, state) {
                  if (state is DailyScheduleLoading) {
                    return SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state is DailyScheduleError) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text("Error loading medications")),
                    );
                  }

                  if (state is DailyScheduleLoaded) {
                    final meds = state.medications;

                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final med = meds[index];
                        return Medicineremindercard(
                          image: Image.asset("assets/images/Shape10.png"),
                          condition: med.status,
                          name: med.medicationName,
                          quatity: med.dosage,
                          scheduletime: "",
                          time: med.time,
                        );
                      }, childCount: meds.length),
                    );
                  }

                  return SliverToBoxAdapter(child: SizedBox());
                },
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
                  name: 'English',
                  selected: locale.languageCode == 'en',
                ),
                _LangOption(
                  code: 'ar',
                  name: 'العربية',
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

class UpcomingSection extends StatefulWidget {
  const UpcomingSection({super.key});

  @override
  State<UpcomingSection> createState() => _UpcomingSectionState();
}

class _UpcomingSectionState extends State<UpcomingSection> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return BlocBuilder<DailyScheduleCubit, DailyScheduleState>(
      builder: (context, state) {
        if (state is DailyScheduleLoading) {
          return Skeletonizer(
            child: UpcomingReminder(
              medicine: DailyMedications(
                reminderId: "",
                medicationName: "Loading...",
                genericName: "",
                form: "",
                strength: "",
                instructions: "",
                color: "",
                status: "",
                dosage: "-",
                time: "--:--",
              ),
            ),
          );
        }

        if (state is DailyScheduleLoaded) {
          final cubit = context.read<DailyScheduleCubit>();
          final pending = cubit.getUpcomingForToday(state.medications);

          // reset index if it's out of range (e.g. day changed)
          if (_index >= pending.length) _index = 0;

          if (pending.isNotEmpty) {
            return Column(
              children: [
                UpcomingReminder(medicine: pending[_index]),
                TextButton(
                  onPressed: pending.length > _index + 1
                      ? () => setState(() => _index++)
                      : null,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: devwidth * 0.02),
                      Icon(Icons.alarm, color: Color(0xfff9783c), size: 25),
                      SizedBox(width: devwidth * 0.008),
                      Text(
                        S.of(context).RemindLater,
                        style: TextStyle(
                          color: Color(0xfff9783c),
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return EmptyUpcoming(
            medicine: DailyMedications(
              reminderId: "",
              medicationName: S.of(context).Nowupcomingreminderstoday,
              genericName: "",
              form: "",
              strength: "",
              instructions: "",
              color: "",
              status: "",
              dosage: "-",
              time: "--:--",
            ),
          );
        }

        if (state is DailyScheduleError) {
          return Center(
            child: Text(
              "Error: ${state.message}",
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}

class _LangOption extends StatelessWidget {
  final String code, name;
  final bool selected;

  const _LangOption({
    required this.code,
    required this.name,
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
        title: Center(
          child: Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),

        trailing: selected
            ? const Icon(Icons.check, color: Color(0xFF2563EB), size: 20)
            : null,
      ),
    );
  }
}
