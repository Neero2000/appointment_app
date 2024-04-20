import '../../../config/index.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late FirebaseAuthUtils firebaseAuthUtils;

  @override
  void initState() {
    super.initState();
    // Delay the initialization of firebaseAuthUtils until after initState
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      firebaseAuthUtils = FirebaseAuthUtils();
      if (firebaseAuthUtils.isLoggedIn) {
        Navigator.pushReplacementNamed(context, MainPage.routeName);
      } else {
        Navigator.pushReplacementNamed(context, AuthPage.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ensure Config().init(context) is called within build or didChangeDependencies
    Config().init(context);
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
