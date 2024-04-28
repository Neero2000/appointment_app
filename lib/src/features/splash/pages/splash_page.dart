import '../../../config/index.dart';

class SplashPage extends StatefulWidget {
  static const String path = '/splash';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late FirebaseAuthUtils firebaseAuthUtils;

  @override
  void initState() {
    super.initState();
    // Delay the initialization of firebaseAuthUtils until after initState
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      firebaseAuthUtils = FirebaseAuthUtils();
      if (firebaseAuthUtils.isLoggedIn) {
        router.launchHome();
      } else {
        router.launchLogin();
      }
    });
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
