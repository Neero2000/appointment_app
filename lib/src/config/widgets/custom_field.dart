import '../index.dart';
import 'package:flutter/cupertino.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isPhoneField;
  final bool isPassword;
  final Widget? prefix;
  final Widget? suffix;
  final int maxLines;
  const CustomField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
    this.inputFormatters,
    this.autofillHints,
    this.keyboardType,
    this.textInputAction,
    this.isPhoneField = false,
    this.isPassword = false,
    this.prefix,
    this.suffix,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return _TextField(
      controller: controller,
      hintText: hintText,
      validator: validator,
      inputFormatters: inputFormatters,
      autofillHints: autofillHints,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      isPhoneField: isPhoneField,
      isPassword: isPassword,
      prefix: prefix,
      suffix: suffix,
      maxLines: maxLines,
    );
  }
}

class _TextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isPhoneField;
  final bool isPassword;
  final Widget? prefix;
  final Widget? suffix;
  final int maxLines;
  const _TextField({
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.inputFormatters,
    required this.autofillHints,
    required this.keyboardType,
    required this.textInputAction,
    required this.isPhoneField,
    required this.isPassword,
    required this.prefix,
    required this.suffix,
    required this.maxLines,
  });

  @override
  State<_TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<_TextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorWidth: 1,
      cursorColor: AppTheme.primaryColor,
      controller: widget.controller,
      maxLines: widget.maxLines,
      autofocus: false,
      enableSuggestions: true,
      keyboardType: widget.keyboardType,
      autofillHints: widget.autofillHints,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.isPassword ? _obscureText : false,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIconConstraints: widget.prefix != null ? const BoxConstraints(minWidth: 60) : null,
        suffixIcon: widget.suffix ??
            (widget.isPassword
                ? _Suffix(
                    obscureText: _obscureText,
                    toggleObscureText: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[500]!,
            width: 1,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.primaryColor,
            width: 2,
          ),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF8D8D8D),
            width: 2,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      ),
      validator: widget.validator,
    );
  }
}

class _Suffix extends StatelessWidget {
  final bool obscureText;
  final VoidCallback toggleObscureText;
  const _Suffix({
    required this.obscureText,
    required this.toggleObscureText,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoButton(
          padding: const EdgeInsets.all(0.0),
          onPressed: () {
            toggleObscureText();
          },
          child: Icon(
            obscureText ? FontAwesomeIcons.solidEyeSlash : FontAwesomeIcons.solidEye,
            size: 16,
            color: Colors.grey[700]!,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
