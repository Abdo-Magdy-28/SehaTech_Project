import 'package:flutter/material.dart';
import 'package:grad_project/models/prescription_model.dart';
import 'package:grad_project/screens/prescriptions/reminder_screen.dart';
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

  final List<Prescription> _actualPrescriptions = const [
    Prescription(
      medicineName: 'Amoxiciling 250gm',
      description: 'Antibiotic For Bacterial Infections',
      capsuleCount: '12 Capsules',
      dateRange: '12 - 9 Feb , 2026',
      status: PrescriptionStatus.active,
    ),
    Prescription(
      medicineName: 'Lisonopril 100gm',
      description: 'Antibiotic For Bacterial Infections',
      capsuleCount: '12 Capsules',
      dateRange: '10 - 1 Mar , 2026',
      status: PrescriptionStatus.upcoming,
    ),
    Prescription(
      medicineName: 'Metformin 500gm',
      description: 'Antibiotic For Bacterial Infections',
      capsuleCount: '24 Capsules',
      dateRange: '20- 9 Feb , 2026',
      status: PrescriptionStatus.expired,
    ),
    Prescription(
      medicineName: 'Lisonopril 100gm',
      description: 'Antibiotic For Bacterial Infections',
      capsuleCount: '12 Capsules',
      dateRange: '10 - 1 Mar , 2026',
      status: PrescriptionStatus.upcoming,
    ),
    Prescription(
      medicineName: 'Metformin 500gm',
      description: 'Antibiotic For Bacterial Infections',
      capsuleCount: '24 Capsules',
      dateRange: '20- 9 Feb , 2026',
      status: PrescriptionStatus.expired,
    ),
  ];

  final List<Prescription> _historyPrescriptions = const [
    Prescription(
      medicineName: 'Amoxiciling 250gm',
      description: 'Antibiotic For Bacterial Infections',
      capsuleCount: '12 Capsules',
      dateRange: '12 - 9 Feb , 2026',
      status: PrescriptionStatus.expired,
      isHistory: true,
    ),
    Prescription(
      medicineName: 'Lisonopril 100gm',
      description: 'Antibiotic For Bacterial Infections',
      capsuleCount: '12 Capsules',
      dateRange: '10 - 9 Jan , 2026',
      status: PrescriptionStatus.expired,
      isHistory: true,
    ),
    Prescription(
      medicineName: 'Metformin 500gm',
      description: 'Antibiotic For Bacterial Infections',
      capsuleCount: '24 Capsules',
      dateRange: '20- 9 Feb , 2026',
      status: PrescriptionStatus.expired,
      isHistory: true,
    ),
    Prescription(
      medicineName: 'Metformin 500gm',
      description: 'Antibiotic For Bacterial Infections',
      capsuleCount: '24 Capsules',
      dateRange: '20- 9 Feb , 2026',
      status: PrescriptionStatus.expired,
      isHistory: true,
    ),
    Prescription(
      medicineName: 'Amoxiciling 250gm',
      description: 'Antibiotic For Bacterial Infections',
      capsuleCount: '12 Capsules',
      dateRange: '12 - 9 Feb , 2026',
      status: PrescriptionStatus.expired,
      isHistory: true,
    ),
  ];

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

  List<Prescription> _filtered(List<Prescription> list) {
    if (_searchQuery.isEmpty) return list;
    return list
        .where(
          (p) =>
              p.medicineName.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  void _showMoreOptions(BuildContext context, Prescription prescription) {
    final devwidth = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(devwidth * 0.06),
        ),
      ),
      builder: (_) => _MoreOptionsSheet(prescription: prescription),
    );
  }

  @override
  Widget build(BuildContext context) {
    final devwidth = MediaQuery.of(context).size.width;
    final devheight = MediaQuery.of(context).size.height;

    final filteredActual = _filtered(_actualPrescriptions);
    final filteredHistory = _filtered(_historyPrescriptions);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Prescriptions",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          PrescriptionsSearchBar(
            controller: _searchController,
            onChanged: (v) => setState(() => _searchQuery = v),
          ),

          // Tab bar
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
              tabs: const [
                Tab(text: 'Actual'),
                Tab(text: 'History'),
              ],
            ),
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // ── Actual Tab ──────────────────────────────
                _buildActualTab(filteredActual, devwidth, devheight),

                // ── History Tab ─────────────────────────────
                _buildHistoryTab(filteredHistory, devwidth),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Actual Tab
  Widget _buildActualTab(
    List<Prescription> list,
    double devwidth,
    double devheight,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: devwidth * 0.04,
            vertical: devheight * 0.012,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Perceptions',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  fontSize: devwidth * 0.045,
                  color: const Color(0xFF111111),
                ),
              ),
              // Add button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ReminderScreen(medicineName: '', medicineSize: ''),
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
        // List
        Expanded(child: _buildList(list, devwidth)),
      ],
    );
  }

  // ── History Tab ──────────────────────────────────────────
  Widget _buildHistoryTab(List<Prescription> list, double devwidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: devwidth * 0.04,
            vertical: devwidth * 0.03,
          ),
          child: Text(
            'History Perceptions',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
              fontSize: devwidth * 0.045,
              color: const Color(0xFF111111),
            ),
          ),
        ),
        Expanded(child: _buildList(list, devwidth)),
      ],
    );
  }

  // ── Shared list builder ──────────────────────────────────
  Widget _buildList(List<Prescription> list, double devwidth) {
    if (list.isEmpty) {
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
              'No prescriptions found',
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
    return ListView.builder(
      padding: EdgeInsets.only(bottom: devwidth * 0.04),
      itemCount: list.length,
      itemBuilder: (ctx, i) => PrescriptionCard(
        prescription: list[i],
        onMorePressed: () => _showMoreOptions(ctx, list[i]),
      ),
    );
  }
}

// ── More Options Bottom Sheet ────────────────────────────────
class _MoreOptionsSheet extends StatelessWidget {
  final Prescription prescription;
  const _MoreOptionsSheet({required this.prescription});

  @override
  Widget build(BuildContext context) {
    final devwidth = MediaQuery.of(context).size.width;
    final devheight = MediaQuery.of(context).size.height;

    return Padding(
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
            prescription.medicineName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: devwidth * 0.045,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: devheight * 0.02),
          _OptionTile(
            icon: Icons.edit_outlined,
            label: 'Edit',
            color: const Color(0xFF2260FF),
            onTap: () => Navigator.pop(context),
          ),
          _OptionTile(
            icon: Icons.share_outlined,
            label: 'Share',
            color: const Color(0xFF059669),
            onTap: () => Navigator.pop(context),
          ),
          _OptionTile(
            icon: Icons.delete_outline,
            label: 'Delete',
            color: Colors.red,
            onTap: () => Navigator.pop(context),
          ),
          SizedBox(height: devheight * 0.01),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _OptionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final devwidth = MediaQuery.of(context).size.width;
    return ListTile(
      leading: Icon(icon, color: color, size: devwidth * 0.06),
      title: Text(
        label,
        style: TextStyle(
          fontSize: devwidth * 0.04,
          fontFamily: 'Cairo',
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
