import '../../../config/index.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatelessWidget {
  static const path = '/login';
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(backgroundColor: Colors.grey[100]),
      body: const _Init(),
    );
  }
}

class _Init extends StatefulWidget {
  const _Init();
  @override
  State<_Init> createState() => _InitState();
}

class _InitState extends State<_Init> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final FirebaseAuthUtils _firebaseAuthUtils = FirebaseAuthUtils.instance;
  final ValidationUtils _validationUtils = ValidationUtils.instance;

  final FirebaseFirestoreUtils _firebaseFirestoreUtils = FirebaseFirestoreUtils.instance;

  Future<bool> _validateFunction() async {
    final bool validation = _formKey.currentState?.validate() ?? false;
    if (!validation) {
      if (_autovalidateMode == AutovalidateMode.disabled) {
        setState(() {
          _autovalidateMode = AutovalidateMode.onUserInteraction;
        });
      }
      return false;
    }
    return true;
  }

  Future _login() async {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    await _firebaseAuthUtils.login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      onSuccess: () {
        router.launchHome();
      },
      getDoctor: (String userId) async {
        return await _firebaseFirestoreUtils.getDoctorById(userId: userId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(0.0),
          children: [
            const SizedBox(height: 30.0),
            const _Title(),
            const SizedBox(height: 4.0),
            const _Subtitle(),
            const SizedBox(height: 40.0),
            const _TextFieldTitle(text: 'Email*'),
            const SizedBox(height: 8.0),
            CustomField(
              controller: _emailController,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              autofillHints: const <String>[AutofillHints.email],
              textInputAction: TextInputAction.next,
              validator: (_) {
                return _validationUtils.validateEmail(email: _?.trim() ?? 'Unkown error');
              },
            ),
            const SizedBox(height: 24.0),
            const _TextFieldTitle(text: 'Password*'),
            const SizedBox(height: 8.0),
            CustomField(
              controller: _passwordController,
              hintText: 'Password',
              keyboardType: TextInputType.visiblePassword,
              autofillHints: const <String>[AutofillHints.password],
              textInputAction: TextInputAction.done,
              isPassword: true,
              validator: (_) {
                return _validationUtils.validatePassword(password: _?.trim() ?? 'Unkown error');
              },
            ),
            const SizedBox(height: 80.0),
            _Button(
              loadingFunction: _login,
              validateFunction: _validateFunction,
            ),
            const SizedBox(height: 10.0),
            const _Signup(),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            "Welcome!",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            "Login with your email and password to continue.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final Future Function() loadingFunction;
  final Future<bool> Function() validateFunction;
  const _Button({
    required this.loadingFunction,
    required this.validateFunction,
  });
  @override
  Widget build(BuildContext context) {
    return CustomLoadingButton(
      text: 'SIGN IN',
      fontSize: 20,
      loadingFunction: loadingFunction,
      validateFunction: validateFunction,
    );
  }
}

class _TextFieldTitle extends StatelessWidget {
  final String text;
  const _TextFieldTitle({
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _Signup extends StatelessWidget {
  const _Signup();
  @override
  Widget build(BuildContext context) {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            router.launchSignup();
          },
          child: Flexible(
            child: Text(
              "Dont't have an account? Signup!",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
