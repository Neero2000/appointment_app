import 'src/config/index.dart';

import 'package:flutter_application_1/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //define theme data here
    return MaterialApp(
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
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
      //this is initial route of the app
      initialRoute: SplashPage.routeName,
      //which is auth page (log in and sing in )
routes: {
        SplashPage.routeName: (context) => const SplashPage(),
        AuthPage.routeName: (context) => const AuthPage(),
        MainPage.routeName: (context) => const MainPage(),
        DoctorDetailsPage.routeName: (context) => const DoctorDetailsPage(),
        BookingPage.routeName: (context) => const BookingPage(),
        AppointmentBookedPage.routeName: (context) => const AppointmentBookedPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        ChatPage.routeName: (context) => const ChatPage(),
        'home_admin': (context) => const AdminPage(),
      },
    );
  }
}
