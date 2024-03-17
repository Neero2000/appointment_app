import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/login_form.dart';
import 'package:flutter_application_1/components/social_button.dart';
import 'package:flutter_application_1/utils/text.dart';
import 'package:flutter_application_1/utils/config.dart';
import '../screens/register_page.dart'; // Import the RegisterPage

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
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
                onLogin: loginUser,
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
                  Navigator.of(context).pushNamed('register_page');
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

  Future<void> loginUser(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        print('Login successful for $email');

        // Check if the logged-in user's email is mensefgames@gmail.com
        if (email == 'mensefgames@gmail.com') {
          // Navigate to admin page
          Navigator.of(context).pushReplacementNamed('maaaain');
        } else {
          // Navigate to main page for regular users
          Navigator.of(context)
              .pushReplacementNamed('main', arguments: {'email': email});
        }
      } else {
        print('User does not exist');
        // Handle the case where user does not exist
      }
    } catch (error) {
      print('Login failed: $error');
      // Handle login failure
    }
  }
}
