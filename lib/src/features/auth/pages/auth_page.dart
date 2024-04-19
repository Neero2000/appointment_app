import '../../../config/index.dart';

class AuthPage extends StatefulWidget {
  static const String routeName = '/auth_page';
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  FirebaseAuthUtils firebaseAuthUtils = FirebaseAuthUtils();
  @override
  Widget build(BuildContext context) {
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
              Config.spaceSmall,
              Text(
                AppText.enText['after_welcome']!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Config.spaceSmall,
              LoginForm(
                onLogin: (String email, String password) async {
                  await firebaseAuthUtils.login(
                    email: email,
                    password: password,
                    onSuccess: () {
                      Navigator.of(context).pushReplacementNamed(MainPage.routeName);
                    },
                  );
                },
              ),
              Config.spaceSmall,
              const Spacer(),
              const Text(
                "Connexion avec social media",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B7280),
                ),
              ),
              Config.spaceSmall,
              Config.spaceSmall,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SocialButton(social: 'google'),
                  SocialButton(social: 'facebook'),
                ],
              ),
              Config.spaceSmall,
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RegisterPage.routeName);
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
