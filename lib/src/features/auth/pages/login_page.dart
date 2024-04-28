import '../../../config/index.dart';

class LoginPage extends StatefulWidget {
  static const String path = '/login';
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  FirebaseAuthUtils firebaseAuthUtils = FirebaseAuthUtils();
  @override
  Widget build(BuildContext context) {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/1.png',
                  width: 100,
                  height: 100,
                ),
              ),
              Text(
                AppText.enText['welcome_text']!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                AppText.enText['after_welcome']!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 25),
              LoginForm(
                onLogin: (String email, String password) async {
                  await firebaseAuthUtils.login(
                    email: email,
                    password: password,
                    onSuccess: () {
                      router.launchHome();
                    },
                  );
                },
              ),
              const SizedBox(height: 25),
              const Spacer(),
              const Text(
                "Connexion avec social media",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 50),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SocialButton(social: 'google'),
                  SocialButton(social: 'facebook'),
                ],
              ),
              const SizedBox(height: 25),
              TextButton(
                onPressed: () {
                  router.launchSignup();
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
