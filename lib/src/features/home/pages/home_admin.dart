import '../../../config/index.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adding padding here
        child: Column(
          children: [
            Config.spaceBig,
            Config.spaceBig, // Add Config.spaceSmall here
            const NoAppointmentCard(),
          ],
        ),
      ),
    );
  }
}
