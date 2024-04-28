import '../../../config/index.dart';

class SignupPage extends StatefulWidget {
  static const String path = '/signup';
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final welcomeText = AppText.enText['welcome_text'] ?? '';
    final afterWelcomeText = AppText.enText['after_welcome'] ?? '';
    final haveAccText = AppText.enText['have_acc'] ?? '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/1.png',
                  width: 250,
                  height: 250,
                ),
              ),
              Text(
                welcomeText,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                afterWelcomeText,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 25),
              RegisterForm(onRegister: registerUser),
              const SizedBox(height: 25),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    haveAccText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    child: const Text(
                      '   Sign in',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerUser(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Registration successful, navigate back to AuthPage
      Navigator.of(context).pushReplacementNamed('/');
      print('Registration successful for ${userCredential.user!.email}');
    } catch (error) {
      // Registration failed, handle error here
      print('Registration failed: $error');
      // You can show an error message to the user if needed
    }
  }
}
