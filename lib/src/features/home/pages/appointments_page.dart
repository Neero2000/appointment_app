import '../../../config/index.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});
  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> with SingleTickerProviderStateMixin {
  final FirebaseFirestoreUtils firebaseFirestoreUtils = FirebaseFirestoreUtils.instance;
  final FirebaseAuthUtils firebaseAuthUtils = FirebaseAuthUtils.instance;

  late TabController _tabController;
  final List<String> _statuses = [
    "pending",
    "completed",
    "canceled",
  ];

  final List<AppointmentModel> _appointments = [];
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _fetchAppointments();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _isLoading = true;
    _isError = false;
    super.dispose();
  }

  Future _fetchAppointments() async {
    final List<AppointmentModel> appointments = await firebaseFirestoreUtils.getAppointments(userId: firebaseAuthUtils.uid);
    if (mounted) {
      setState(() {
        _appointments.clear();
        _appointments.addAll(appointments);
        _isLoading = false;
      });
    }
  }

  void _refresh() {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    _fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My appointments',
        addBackButton: false,
        bottom: _Tabs(tabController: _tabController),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const BouncingScrollPhysics(),
        children: [
          ..._statuses.map(
            (status) => _TabBarView(
              appointments: _appointments.where((appointment) => appointment.status == status).toList(),
              isError: _isError,
              isLoading: _isLoading,
              refresh: _refresh,
            ),
          ),
        ],
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  final TabController tabController;
  const _Tabs({required this.tabController});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TabBar(
            controller: tabController,
            physics: const BouncingScrollPhysics(),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: AppTheme.primaryColor,
            ),
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[500],
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
            tabs: const [
              Tab(text: 'Pending'),
              Tab(text: 'Completed'),
              Tab(text: 'Canceled'),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _TabBarView extends StatelessWidget {
  final List<AppointmentModel> appointments;
  final bool isError;
  final bool isLoading;
  final VoidCallback refresh;
  const _TabBarView({
    required this.appointments,
    required this.isError,
    required this.isLoading,
    required this.refresh,
  });
  @override
  Widget build(BuildContext context) {
    if (isError) {
      return ErrorRefreshItem(
        errorText: "Error loading appointments. Please try again later.",
        refresh: refresh,
      );
    }
    if (isLoading) {
      return const AppointmentsLoading();
    }
    if (appointments.isEmpty) {
      return AppointmentsEmpty(
        refresh: refresh,
      );
    }
    return ListView.separated(
      itemCount: appointments.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      itemBuilder: (context, index) {
        return AppointmentCard(
          appointment: appointments[index],
          refresh: refresh,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
    );
  }
}
