import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User? _user; // Declare a variable to hold the logged-in user

  @override
  void initState() {
    super.initState();
    _user =
        FirebaseAuth.instance.currentUser; // Get the currently logged-in user
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Settings",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/12.jpg"),
            ),
            title: Text(
              " ${_user?.email ?? ""}", // Display user's email or "Programmer" if not available
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            subtitle: Text("Profile"),
          ),
          const Divider(height: 50),
          ListTile(
            onTap: () {}, // Here is the onTap property
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.person,
                color: Colors.blue,
                size: 35,
              ),
            ),
            title: const Text(
              "Profile",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            trailing: const Icon(CupertinoIcons.forward),
          ),
          const SizedBox(height: 20),
          ListTile(
            onTap: () {}, // Here is the onTap property
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.lock_shield,
                color: Colors.indigo,
                size: 35,
              ),
            ),
            title: const Text(
              "Privacy",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            trailing: const Icon(CupertinoIcons.forward),
          ),
          const SizedBox(height: 20),
          ListTile(
            onTap: () {}, // Here is the onTap property
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.gear,
                color: Colors.green,
                size: 35,
              ),
            ),
            title: const Text(
              "General",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            trailing: const Icon(CupertinoIcons.forward),
          ),
          const SizedBox(height: 20),
          ListTile(
            onTap: () {}, // Here is the onTap property
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.info,
                color: Colors.orange,
                size: 35,
              ),
            ),
            title: const Text(
              "About Us",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            trailing: const Icon(CupertinoIcons.forward),
          ),
          const Divider(height: 40),
          ListTile(
            onTap: () {
              _signOut(); // Call the _signOut function when tapped
            },
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.redAccent.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.power,
                color: Colors.redAccent,
                size: 35,
              ),
            ),
            title: const Text(
              "Log Out",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacementNamed('/');
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
