import '../../../config/index.dart';

class AdminHomePage extends StatefulWidget {
  static const String path = '/admin_home';
  const AdminHomePage({super.key});
  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            const NoAppointmentCard(),
          ],
        ),
      ),
    );
  }
}
