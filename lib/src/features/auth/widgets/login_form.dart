import '../../../config/index.dart';

class LoginForm extends StatefulWidget {
  final Future Function(String email, String password) onLogin;

  const LoginForm({
    super.key,
    required this.onLogin,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: AppTheme.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(FontAwesomeIcons.envelope),
              prefixIconColor: Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(height: 25),
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: AppTheme.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              alignLabelWithHint: true,
              prefixIcon: const Icon(FontAwesomeIcons.lock),
              prefixIconColor: const Color(0xFF9CA3AF),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obsecurePass = !obsecurePass;
                  });
                },
                icon: obsecurePass
                    ? const Icon(
                        FontAwesomeIcons.eyeSlash,
                        color: Color(0xFF9CA3AF),
                      )
                    : const Icon(
                        FontAwesomeIcons.eye,
                        color: AppTheme.primaryColor,
                      ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          CustomLoadingButton(
            width: double.infinity,
            text: 'Sign In',
            validateFunction: () async {
              return _formKey.currentState!.validate();
            },
            loadingFunction: () async {
              final email = _emailController.text.trim();
              final password = _passController.text.trim();
              await widget.onLogin(email, password);
            },
          ),
        ],
      ),
    );
  }
}
