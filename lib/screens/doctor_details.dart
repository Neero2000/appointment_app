import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart'; // Assuming Button widget is defined in this file
import 'package:flutter_application_1/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/custom_appbar.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({Key? key}) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Doctor Details',
        icon: FontAwesomeIcons.arrowLeft,
        actions: [],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const AboutDoctor(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Button(
                width: double.infinity,
                title: 'Prendre rendez-vous',
                onPressed: () {
                  // Add your logic for handling the button press here
                  Navigator.of(context).pushNamed('booking_page');
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
  const AboutDoctor({Key? key});

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              'assets/doctor2.jpg',
              width: 130.0,
              height: 130.0,
              fit: BoxFit.cover,
            ),
          ),
          Config.spaceMedium,
          const Text(
            'Dr Aymen Azzouz',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Cardiologist',
            style: TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Config.spaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInfoCard('assets/doc1.png', 'Patients'),
              _buildInfoCard('assets/doc2.png', 'Experience +10'),
              _buildInfoCard('assets/doc3.png', 'Notation +5'),
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '     Monday-Friday, 08.00 AM-18.00 pM',
              style: TextStyle(
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
