import '../../../config/index.dart';

class SplashPage extends StatefulWidget {
  static const String path = '/splash';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final FirebaseAuthUtils _firebaseAuthUtils = FirebaseAuthUtils();

  bool _initialized = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    Future.delayed(
      const Duration(milliseconds: 2000),
      () async {
        if (!_initialized) {
          _initialized = true;
          if (_firebaseAuthUtils.isLoggedIn) {
            router.launchHome();
          } else {
            router.launchLogin();
          }
        }
      },
    );
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
