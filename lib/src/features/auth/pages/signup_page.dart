import '../../../config/index.dart';

class SignupPage extends StatelessWidget {
  static const path = '/signup';
  const SignupPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: CustomAppBar(title: ''),
      body: _Init(),
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
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _speciality = DataUtils().specialities.first.name;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final FirebaseAuthUtils _firebaseAuthUtils = FirebaseAuthUtils.instance;
  final ValidationUtils _validationUtils = ValidationUtils.instance;
  final FirebaseFirestoreUtils _firebaseFirestoreUtils = FirebaseFirestoreUtils.instance;

  final String _assetPath = 'assets/images/doctor${Random().nextInt(3) + 1}.jpg';

  bool _isDoctor = false;

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

  Future _signup() async {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    await _firebaseAuthUtils.signup(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      isDoctor: _isDoctor,
      assetPath: _assetPath,
      speciality: _speciality,
      onSuccess: () async {
        if (!_isDoctor) {
          router.launchHome();
          return;
        }
        await _firebaseFirestoreUtils
            .createDoctor(
          email: _emailController.text.trim(),
          price: _priceController.text.trim(),
          address: _addressController.text.trim(),
          speciality: _speciality,
          assetPath: _assetPath,
        )
            .then(
          (_) {
            router.launchHome();
          },
        );
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
            const _TextFieldTitle(text: 'Account Type*'),
            const SizedBox(height: 2.0),
            _Type(
              isDoctor: _isDoctor,
              isDoctorOnChanged: (bool? value) {
                setState(() {
                  _isDoctor = value ?? false;
                });
              },
            ),
            const SizedBox(height: 24.0),
            const _TextFieldTitle(text: 'Email*'),
            const SizedBox(height: 2.0),
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
            const SizedBox(height: 2.0),
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
            const SizedBox(height: 24.0),
            const _TextFieldTitle(text: 'Confirm password*'),
            const SizedBox(height: 2.0),
            CustomField(
              controller: _confirmPasswordController,
              hintText: 'Confirm password',
              keyboardType: TextInputType.visiblePassword,
              autofillHints: const <String>[AutofillHints.password],
              textInputAction: TextInputAction.done,
              isPassword: true,
              validator: (_) {
                return _validationUtils.validatePassword(
                  password: _?.trim() ?? 'Unkown error',
                  confirmationPassword: _passwordController.text.trim(),
                );
              },
            ),
            _DoctorAdditionalForm(
              isDoctor: _isDoctor,
              speciality: _speciality,
              specialityOnChanged: (String? value) {
                setState(() {
                  _speciality = value!;
                });
              },
              priceController: _priceController,
              addressController: _addressController,
            ),
            const SizedBox(height: 60.0),
            _Button(
              loadingFunction: _signup,
              validateFunction: _validateFunction,
            ),
            const SizedBox(height: 50),
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
            "Signup!",
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
            "Create your account to continue.",
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

class _Type extends StatelessWidget {
  final bool isDoctor;
  final Function(bool?) isDoctorOnChanged;
  const _Type({
    required this.isDoctor,
    required this.isDoctorOnChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: SizedBox(
            height: 40,
            child: RadioListTile<bool>(
              title: const Text('Patient'),
              value: false,
              groupValue: isDoctor,
              fillColor: MaterialStateProperty.all(AppTheme.primaryColor),
              contentPadding: const EdgeInsets.all(0.0),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: isDoctorOnChanged,
            ),
          ),
        ),
        Flexible(
          child: SizedBox(
            height: 40,
            child: RadioListTile<bool>(
              title: const Text('Doctor'),
              value: true,
              groupValue: isDoctor,
              fillColor: MaterialStateProperty.all(AppTheme.primaryColor),
              contentPadding: const EdgeInsets.all(0.0),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: isDoctorOnChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class _DoctorAdditionalForm extends StatelessWidget {
  final bool isDoctor;
  final String speciality;
  final Function(String?) specialityOnChanged;
  final TextEditingController priceController;
  final TextEditingController addressController;
  const _DoctorAdditionalForm({
    required this.isDoctor,
    required this.speciality,
    required this.specialityOnChanged,
    required this.priceController,
    required this.addressController,
  });
  @override
  Widget build(BuildContext context) {
    final ValidationUtils validationUtils = ValidationUtils();
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
      firstCurve: Curves.ease,
      secondCurve: Curves.ease,
      sizeCurve: Curves.ease,
      crossFadeState: isDoctor == true ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      firstChild: const SizedBox(),
      secondChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24.0),
          const _TextFieldTitle(text: 'Price*'),
          const SizedBox(height: 2.0),
          CustomField(
            controller: priceController,
            hintText: 'Price',
            keyboardType: TextInputType.datetime,
            autofillHints: const <String>[AutofillHints.birthday],
            validator: (_) {
              return validationUtils.validatePrice(
                price: _?.trim() ?? 'Unkown error',
                nullable: !isDoctor,
              );
            },
          ),
          const SizedBox(height: 24.0),
          const _TextFieldTitle(text: 'Address*'),
          const SizedBox(height: 2.0),
          CustomField(
            controller: addressController,
            hintText: 'Address',
            keyboardType: TextInputType.streetAddress,
            autofillHints: const <String>[AutofillHints.streetAddressLevel1],
            validator: (_) {
              return validationUtils.validateAddress(
                address: _?.trim() ?? 'Unkown error',
                nullable: !isDoctor,
              );
            },
          ),
          const SizedBox(height: 24.0),
          const _TextFieldTitle(text: 'Category*'),
          const SizedBox(height: 2.0),
          CustomPopupField(
            values: DataUtils().specialities.map((speciality) => speciality.name).toList(),
            value: speciality,
            onChanged: specialityOnChanged,
          ),
          const SizedBox(height: 10),
        ],
      ),
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
      text: 'SIGN UP',
      fontSize: 20,
      loadingFunction: loadingFunction,
      validateFunction: validateFunction,
    );
  }
}

class _TextFieldTitle extends StatelessWidget {
  final String text;
  const _TextFieldTitle({required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
