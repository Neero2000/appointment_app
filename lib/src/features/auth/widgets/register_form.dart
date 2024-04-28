import '../../../config/index.dart';

class RegisterForm extends StatefulWidget {
  final Function(String email, String password) onRegister;

  const RegisterForm({
    super.key,
    required this.onRegister,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email address';
              }
              return null;
            },
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          TextFormField(
            controller: _confirmPassController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: AppTheme.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              labelText: 'Confirm Password',
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              } else if (value != _passController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          Button(
            width: double.infinity,
            title: 'Register',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final email = _emailController.text.trim();
                final password = _passController.text.trim();
                widget.onRegister(email, password);
              }
            },
            disable: false,
          ),
        ],
      ),
    );
  }
}
