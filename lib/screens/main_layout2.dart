import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_admin.dart';
import 'package:flutter_application_1/screens/appointment_page.dart';
import 'package:flutter_application_1/screens/chat_page.dart';
import 'package:flutter/cupertino.dart';

class MainLayout2 extends StatefulWidget {
  const MainLayout2({Key? key}) : super(key: key);

  @override
  State<MainLayout2> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout2> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: ((value) {
          setState(() {
            _selectedIndex = value;
          });
        }),
        children: <Widget>[
          AdminPage(),
          AppointmentPage(),
          ChatPage(),
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF7165D6),
          unselectedItemColor: Colors.black26,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _pageController.jumpToPage(index);
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.calendar),
              label: "Schedule",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_text_fill),
              label: "Messages",
            ),
          ],
        ),
      ),
    );
  }
}
