import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/components/appointment_card.dart';
import 'package:flutter_application_1/components/doctor_card.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.bell,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'No new notifications',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> medCat = [
    {
      "icon": 'assets/a.png',
      "Categories": "General",
    },
    {
      "icon": 'assets/b.png',
      "Categories": "Cardiology",
    },
    {
      "icon": 'assets/c.png',
      "Categories": "Immunology",
    },
    {
      "icon": 'assets/d.png',
      "Categories": "Pulmonologist",
    },
    {
      "icon": 'assets/e.png',
      "Categories": "Ophthalmology",
    },
    {
      "icon": 'assets/f.png',
      "Categories": "Dentistry",
    },
  ];

  late String userFirstName;

  @override
  void initState() {
    super.initState();
    getUserFirstName();
  }

  void getUserFirstName() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        String email = user.email!;
        userFirstName =
            email.split('@')[0]; // Extracting the first part of the email
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      userFirstName ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationPage(),
                          ),
                        );
                      },
                      child: const Icon(
                        CupertinoIcons.bell,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: medCat.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: GestureDetector(
                          onTap: () {
                            // Add your onTap logic here
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                medCat[index]['icon'],
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                medCat[index]['Categories'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Text(
                  'Rendez-vous aujourd\'hui',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                const AppointmentCard(),
                Config.spaceSmall,
                const Text(
                  'Meilleur docteur',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: List.generate(10, (index) {
                    return const Doctorcard(
                      route: 'doc_details',
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
