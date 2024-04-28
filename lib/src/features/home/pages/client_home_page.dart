import '../../../config/index.dart';
import 'package:flutter/cupertino.dart';

class ClientHomePage extends StatefulWidget {
  static const String path = '/client_home';
  const ClientHomePage({super.key});
  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
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

  final DataUtils _dataUtils = DataUtils();

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
        userFirstName = email.split('@')[0]; // Extracting the first part of the email
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userFirstName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          CupertinoButton(
            onPressed: () {
              router.launchNotifications();
            },
            child: const Icon(
              CupertinoIcons.bell,
              size: 30,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(left: 18, right: 18, bottom: 70, top: 24),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: medCat.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 12);
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Add your onTap logic here
                    },
                    child: SizedBox(
                      width: 80,
                      child: Column(
                        children: [
                          Image.asset(
                            medCat[index]['icon'],
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            medCat[index]['Categories'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Rendez-vous aujourd\'hui',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            const AppointmentCard(),
            const SizedBox(height: 25),
            const Text(
              'Meilleur docteur',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _dataUtils.doctors.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                return DoctorCard(
                  doctor: _dataUtils.doctors[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
