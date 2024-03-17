import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/doctor_card.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/main_layout.dart';
import 'package:flutter_application_1/screens/main_layout2.dart';
import 'package:flutter_application_1/screens/auth_page.dart';
import 'package:flutter_application_1/screens/booking_page.dart';
import 'package:flutter_application_1/screens/chat_page.dart';
import 'package:flutter_application_1/screens/doctor_details.dart';
import 'package:flutter_application_1/screens/home_admin.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/register_page.dart';
import 'package:flutter_application_1/screens/succes_booked.dart';
import 'package:flutter_application_1/utils/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //hadi bah ndiro push lel naviagateur
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    //define theme data here

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Agenda doctor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Config.primaryColor,
          border: Config.outlinedBorder,
          focusedBorder: Config.focusBorder,
          errorBorder: Config.errorBorder,
          enabledBorder: Config.outlinedBorder,
          floatingLabelStyle: TextStyle(color: Config.primaryColor),
          prefixIconColor: Colors.black38,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          selectedItemColor: Config.primaryColor,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedItemColor: Config.primaryColor,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
        ).copyWith(
          selectedItemColor: Config.primaryColor,
          selectedIconTheme: IconThemeData(
            color: Config.primaryColor,
            size: 24.0,
            // Add shadow when icon is selected
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
      initialRoute: '/',
      //this is initial route of the app
      //which is auth page (log in and sing in )
      routes: {
        '/': (context) => const AuthPage(),
        // this is for main layout after log in
        'main': (context) => const MainLayout(),
        'maaaain': (context) => const MainLayout2(),
        'doc_details': (context) => const DoctorDetails(),
        'booking_page': (context) => const BookingPage(),
        'succes_booked': (context) => const AppointmentBooked(),
        'register_page': (context) => const RegisterPage(),
        'chat': (context) => ChatPage(),
        'home_admin': (context) => AdminPage(),
      },
    );
  }
}
