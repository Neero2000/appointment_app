import '../../../config/index.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  static const String path = '/home';
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final FirebaseAuthUtils _firebaseAuthUtils = FirebaseAuthUtils();

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
        children: _firebaseAuthUtils.isAdmin
            ? [
                const AdminHomePage(),
                const AppointmentPage(),
                const ChatPage(),
              ]
            : [
                const ClientHomePage(),
                const AppointmentPage(),
                const ChatPage(),
                const ProfilePage(),
              ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(
        height: 100,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF7165D6),
          unselectedItemColor: Colors.black26,
          selectedLabelStyle: const TextStyle(
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
          items: _firebaseAuthUtils.isAdmin
              ? [
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home, size: 26),
                    label: "Home",
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.calendar, size: 26),
                    label: "Schedule",
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chat_bubble_text_fill, size: 26),
                    label: "Messages",
                  ),
                ]
              : [
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home, size: 26),
                    label: "Home",
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.calendar, size: 26),
                    label: "Schedule",
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chat_bubble_text_fill, size: 26),
                    label: "Messages",
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.settings, size: 26),
                    label: "Settings",
                  ),
                ],
        ),
      ),
    );
  }
}
