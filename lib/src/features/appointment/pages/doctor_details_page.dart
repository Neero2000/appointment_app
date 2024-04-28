import '../../../config/index.dart';

class DoctorDetailsArgs {
  final DoctorModel doctor;
  const DoctorDetailsArgs({required this.doctor});
}

class DoctorDetailsPage extends StatelessWidget {
  static const String routeName = '/doctor_details_page';
  const DoctorDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final DoctorDetailsArgs args =
        ModalRoute.of(context)?.settings.arguments as DoctorDetailsArgs;
    return Scaffold(
      appBar: const CustomAppBar(
        appTitle: 'Doctor Details',
        icon: FontAwesomeIcons.arrowLeft,
        actions: [],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AboutDoctor(
              doctor: args.doctor,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Button(
                width: double.infinity,
                title: 'Prendre rendez-vous',
                onPressed: () {
                  // Add your logic for handling the button press here
                  Navigator.of(context).pushNamed(BookingPage.routeName);
                },
                disable: false, // Provide a valid value for 'disable' parameter
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutDoctor extends StatelessWidget {
  final DoctorModel doctor;
  const AboutDoctor({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              doctor.assetPath,
              width: 130.0,
              height: 130.0,
              fit: BoxFit.cover,
            ),
          ),
          Config.spaceMedium,
          Text(
            doctor.name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            doctor.speciality,
            style: const TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Config.spaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInfoCard(
                  'assets/doc1.png', 'Patients ${doctor.patientNumber}'),
              _buildInfoCard(
                  'assets/doc2.png', 'Experience +${doctor.experience}'),
              _buildInfoCard('assets/doc3.png',
                  'Notation +${doctor.notation.toStringAsFixed(1)}'),
            ],
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '    heures de travail',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '     ${doctor.startDate}-${doctor.endDate}, ${doctor.startTime}-${doctor.endTime}',
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String imagePath, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Image.asset(imagePath, width: 80, height: 80),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
