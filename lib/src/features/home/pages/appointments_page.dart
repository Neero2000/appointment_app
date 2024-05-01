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
    "started",
    "pending",
    "completed",
  ];

  final List<AppointmentModel> _appointments = [];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _fetchAppointments();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future _fetchAppointments() async {
    final QuerySnapshot querySnapshot = await firebaseFirestoreUtils.getAppointments(userId: firebaseAuthUtils.uid);
    final List<AppointmentModel> appointments = querySnapshot.docs.map((doc) => doc.data()).map((data) => AppointmentModel.fromJson(jsonDecode(data.toString()))).toList();
    setState(() {
      _appointments.addAll(appointments);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My appointments',
        addBackButton: false,
        bottom: _Tabs(tabController: _tabController),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 25),
          SizedBox(height: 25),
          // Expanded(
          //     child: ListView.builder(
          //         itemCount: filteredSchedules.length,
          //         itemBuilder: ((context, index) {
          //           var schedule = filteredSchedules[index];
          //           bool isLastElement = filteredSchedules.length + 1 == index;
          //           return Card(
          //             shape: RoundedRectangleBorder(
          //               side: const BorderSide(
          //                 color: Colors.grey,
          //               ),
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //             margin: !isLastElement ? const EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
          //             child: Padding(
          //               padding: const EdgeInsets.all(15),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.stretch,
          //                 children: [
          //                   Row(
          //                     children: [
          //                       CircleAvatar(
          //                         backgroundImage: AssetImage(schedule['doctor_profile']),
          //                       ),
          //                       const SizedBox(
          //                         width: 10,
          //                       ),
          //                       Column(
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           Text(
          //                             schedule['doctor_name'],
          //                             style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          //                           ),
          //                           const SizedBox(
          //                             height: 5,
          //                           ),
          //                           Text(
          //                             schedule['category'],
          //                             style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),
          //                           )
          //                         ],
          //                       )
          //                     ],
          //                   ),
          //                   const SizedBox(
          //                     height: 15,
          //                   ),
          //                   //schedule Card
          //                   const ScheduleCard(),
          //                   const SizedBox(
          //                     height: 15,
          //                   ),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       Expanded(
          //                         child: OutlinedButton(
          //                           onPressed: () {},
          //                           child: const Text(
          //                             'Cancel',
          //                             style: TextStyle(color: Colors.black),
          //                           ),
          //                         ),
          //                       ),
          //                       const SizedBox(
          //                         width: 20,
          //                       ),
          //                       Expanded(
          //                         child: OutlinedButton(
          //                           style: OutlinedButton.styleFrom(
          //                             backgroundColor: AppTheme.primaryColor,
          //                           ),
          //                           onPressed: () {},
          //                           child: const Text(
          //                             'Reschedule',
          //                             style: TextStyle(color: Colors.white),
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           );
          //         })))
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
    return Container(
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
          Tab(text: 'Active'),
          Tab(text: 'Pending'),
          Tab(text: 'Completed'),
        ],
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4A5D71),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.calendarAlt, // Use FontAwesome icon
            color: Colors.white,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Friday, 3/3/2024',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            FontAwesomeIcons.clock, // Use FontAwesome icon
            color: Colors.white,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              '2:00 PM',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
