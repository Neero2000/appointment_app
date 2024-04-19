import '../../../config/index.dart';
import 'package:flutter/cupertino.dart';

class MainPage extends StatefulWidget {
  static const String routeName = '/main_page';
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final FirebaseAuthUtils firebaseAuthUtils = FirebaseAuthUtils();

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
        children: firebaseAuthUtils.isAdmin
            ? [
                const AdminPage(),
                const AppointmentPage(),
                const ChatPage(),
              ]
            : [
                const HomePage(),
                const AppointmentPage(),
                const ChatPage(),
                const ProfilePage(),
              ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(
        height: 80,
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
          items: firebaseAuthUtils.isAdmin
              ? [
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    label: "Home",
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.calendar),
                    label: "Schedule",
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chat_bubble_text_fill),
                    label: "Messages",
                  ),
                ]
              : [
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    label: "Home",
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.calendar),
                    label: "Schedule",
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chat_bubble_text_fill),
                    label: "Messages",
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.settings),
                    label: "Settings",
                  ),
                ],
        ),
      ),
    );
  }
}
