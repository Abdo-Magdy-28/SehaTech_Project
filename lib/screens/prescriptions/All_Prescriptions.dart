import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Reminder/AllReminders.dart';
import 'package:grad_project/cubit/Reminder/ReminderCubit.dart';
import 'package:grad_project/cubit/prescription%20history/OcrHistoryCubit.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/Reminders/AllReminder.dart';
import 'package:grad_project/models/Reminders/OcrHistory.dart';
import 'package:grad_project/screens/prescriptions/UpdateRemiderScreen.dart';
import 'package:grad_project/screens/prescriptions/reminder_screen.dart';
import 'package:grad_project/services/prescription%20History/OcrHistoryService.dart';
import 'package:grad_project/widgets/prescriptions/ActualCards.dart';
import 'package:grad_project/widgets/prescriptions/prescriptioncard.dart';
import 'package:grad_project/widgets/prescriptions/prescriptionsearchbar.dart';

class AllPrescriptions extends StatefulWidget {
  const AllPrescriptions({super.key});

  @override
  State<AllPrescriptions> createState() => _AllPrescriptionsState();
}

class _AllPrescriptionsState extends State<AllPrescriptions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  void _showDeleteOption(
    BuildContext context,
    OcrHistoryModel ocr, [
    OcrHistoryCubit? cubit,
  ]) {
    final devwidth = MediaQuery.of(context).size.width;
    final devheight = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(devwidth * 0.06),
        ),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: devwidth * 0.05,
          vertical: devheight * 0.025,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: devwidth * 0.1,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: devheight * 0.02),
            Text(
              ocr.tradeName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: devwidth * 0.045,
                fontFamily: 'Cairo',
              ),
            ),
            SizedBox(height: devheight * 0.02),
            ListTile(
              leading: Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: devwidth * 0.06,
              ),
              title: Text(
                'Delete',
                style: TextStyle(
                  fontSize: devwidth * 0.04,
                  fontFamily: 'Cairo',
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                cubit?.deleteScan(ocr.id);
              },
            ),
            SizedBox(height: devheight * 0.01),
          ],
        ),
      ),
    );
  }

  void _showActualOptions(
    BuildContext context,
    AllReminderModel reminder,
    AllRemindersCubit cubit,
  ) {
    final devwidth = MediaQuery.of(context).size.width;
    final devheight = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(devwidth * 0.06),
        ),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: devwidth * 0.05,
          vertical: devheight * 0.025,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: devwidth * 0.1,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: devheight * 0.02),
            Text(
              reminder.medicationName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: devwidth * 0.045,
                fontFamily: 'Cairo',
              ),
            ),
            SizedBox(height: devheight * 0.02),

            // Edit
            ListTile(
              leading: Icon(
                Icons.edit_outlined,
                color: const Color(0xFF2260FF),
                size: devwidth * 0.06,
              ),
              title: Text(
                'Edit',
                style: TextStyle(
                  fontSize: devwidth * 0.04,
                  fontFamily: 'Cairo',
                  color: const Color(0xFF2260FF),
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => ReminderCubit(),
                      child: UpdateReminderScreen(reminder: reminder),
                    ),
                  ),
                ).then((_) => cubit.loadReminders()); // refresh after edit
              },
            ),

            // Delete
            ListTile(
              leading: Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: devwidth * 0.06,
              ),
              title: Text(
                'Delete',
                style: TextStyle(
                  fontSize: devwidth * 0.04,
                  fontFamily: 'Cairo',
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                cubit.deleteReminder(reminder.id, reminder);
                Navigator.pop(context);
              },
            ),

            SizedBox(height: devheight * 0.01),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<OcrHistoryModel> _filtered(List<OcrHistoryModel> list) {
    if (_searchQuery.isEmpty) return list;
    return list
        .where(
          (p) => p.tradeName.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final devwidth = MediaQuery.of(context).size.width;
    final devheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).perscriptions,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey),
        ),
      ),
      body: Column(
        children: [
          PrescriptionsSearchBar(
            controller: _searchController,
            onChanged: (v) => setState(() => _searchQuery = v),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: devwidth * 0.04),
            child: TabBar(
              controller: _tabController,
              labelStyle: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: devwidth * 0.04,
              ),
              unselectedLabelStyle: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w400,
                fontSize: devwidth * 0.04,
              ),
              labelColor: const Color(0xFF2260FF),
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xFF2260FF),
              indicatorWeight: 2.5,
              tabs: [
                Tab(text: S.of(context).actual),
                Tab(text: S.of(context).history),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildActualTab(devwidth, devheight),
                _buildHistoryTab(devwidth),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Actual Tab ───────────────────────────────────────────
  Widget _buildActualTab(double devwidth, double devheight) {
    return BlocProvider(
      create: (context) => AllRemindersCubit()..loadReminders(),
      child: BlocBuilder<AllRemindersCubit, AllRemindersState>(
        builder: (context, state) {
          if (state is AllRemindersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AllRemindersLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: devwidth * 0.04,
                    vertical: devheight * 0.012,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).allperscriptions,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          fontSize: devwidth * 0.045,
                          color: const Color(0xFF111111),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => ReminderCubit(),
                                child: ReminderScreen(
                                  medicineName: '',
                                  medicineSize: '',
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: devwidth * 0.08,
                          height: devwidth * 0.08,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1.5),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: devwidth * 0.05,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _buildReminderList(
                    state.reminders,
                    devwidth,
                    context.read<AllRemindersCubit>(),
                  ),
                ),
              ],
            );
          } else if (state is AllRemindersError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildReminderList(
    List<AllReminderModel> list,
    double devwidth,
    AllRemindersCubit cubit,
  ) {
    if (list.isEmpty) return _emptyState(devwidth);
    return ListView.builder(
      padding: EdgeInsets.only(bottom: devwidth * 0.04),
      itemCount: list.length,
      itemBuilder: (ctx, i) => ActualCard(
        reminder: list[i],
        onMorePressed: () => _showActualOptions(ctx, list[i], cubit),
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////
  // ── History Tab ──────────────────────────────────────────-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Widget _buildHistoryTab(double devwidth) {
    return BlocProvider(
      create: (context) => OcrHistoryCubit(OcrHistoryService())..loadHistory(),
      child: BlocBuilder<OcrHistoryCubit, OcrState>(
        builder: (context, state) {
          if (state is OcrLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OcrLoaded) {
            final filtered = _filtered(state.scans);
            return _buildList(
              filtered,
              devwidth,
              context.read<OcrHistoryCubit>(),
            );
          } else if (state is OcrError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  // ── Shared list builder (both tabs use OcrHistoryCard) ───
  Widget _buildList(
    List<OcrHistoryModel> list,
    double devwidth, [
    OcrHistoryCubit? cubit,
  ]) {
    if (list.isEmpty) return _emptyState(devwidth);
    return ListView.builder(
      padding: EdgeInsets.only(bottom: devwidth * 0.04),
      itemCount: list.length,
      itemBuilder: (ctx, i) => OcrHistoryCard(
        ocr: list[i],
        onMorePressed: () => _showDeleteOption(ctx, list[i], cubit),
      ),
    );
  }

  Widget _emptyState(double devwidth) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.medication_outlined,
            size: devwidth * 0.2,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: devwidth * 0.04),
          Text(
            S.of(context).noperscriptionsfound,
            style: TextStyle(
              color: Colors.grey,
              fontSize: devwidth * 0.04,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}
