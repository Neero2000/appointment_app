import '../../../config/index.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/';
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  FirebaseAuthUtils firebaseAuthUtils = FirebaseAuthUtils();

  @override
  void initState() {
    Config().init(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (firebaseAuthUtils.isLoggedIn) {
        Navigator.pushReplacementNamed(context, MainPage.routeName);
      } else {
        Navigator.pushReplacementNamed(context, AuthPage.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
