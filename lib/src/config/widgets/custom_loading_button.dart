import '../index.dart';
import 'package:flutter/cupertino.dart';

class CustomLoadingButton extends StatelessWidget {
  final String text;
  final Future Function() loadingFunction;
  final Future<bool> Function()? validateFunction;
  final Color color;
  final Color loadingColor;
  final Color textColor;
  final bool isEnabled;
  final double width;
  final double height;
  final double fontSize;
  final BorderRadius? borderRadius;
  const CustomLoadingButton({
    super.key,
    required this.text,
    required this.loadingFunction,
    this.validateFunction,
    this.color = AppTheme.primaryColor,
    this.loadingColor = Colors.white,
    this.textColor = Colors.white,
    this.isEnabled = true,
    this.width = double.infinity,
    this.height = 60,
    this.fontSize = 17,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: _Button(
        text: text,
        loadingFunction: loadingFunction,
        validateFunction: validateFunction,
        color: color,
        loadingColor: loadingColor,
        textColor: textColor,
        isEnabled: isEnabled,
        fontSize: fontSize,
        borderRadius: borderRadius,
      ),
    );
  }
}

class _Button extends StatefulWidget {
  final String text;
  final Future Function() loadingFunction;
  final Future<bool> Function()? validateFunction;
  final Color color;
  final Color loadingColor;
  final Color textColor;
  final bool isEnabled;
  final double fontSize;
  final BorderRadius? borderRadius;
  const _Button({
    required this.text,
    required this.loadingFunction,
    required this.validateFunction,
    required this.color,
    required this.loadingColor,
    required this.textColor,
    required this.isEnabled,
    required this.fontSize,
    required this.borderRadius,
  });

  @override
  State<_Button> createState() => _ButtonState();
}

class _ButtonState extends State<_Button> {
  late bool _isLoading;

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    _isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0.0),
      borderRadius: widget.borderRadius ?? BorderRadius.circular(18.0),
      color: widget.color,
      onPressed: widget.isEnabled
          ? () async {
              if (_isLoading) {
                return;
              }
              if (widget.validateFunction != null) {
                final bool validate = await widget.validateFunction!();
                if (!validate) {
                  return;
                }
              }
              setState(() {
                _isLoading = true;
              });
              await widget.loadingFunction().then((value) {
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              });
            }
          : null,
      child: _Child(
        text: widget.text,
        isLoading: _isLoading,
        loadingColor: widget.loadingColor,
        textColor: widget.textColor,
        fontSize: widget.fontSize,
      ),
    );
  }
}

class _Child extends StatelessWidget {
  final String text;
  final bool isLoading;
  final Color loadingColor;
  final Color textColor;
  final double fontSize;
  const _Child({
    required this.text,
    required this.isLoading,
    required this.loadingColor,
    required this.textColor,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        height: 20,
        width: 20,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: loadingColor,
          strokeWidth: 1.8,
        ),
      );
    }
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor,
        fontWeight: FontWeight.w800,
        fontFamily: "Montserrat",
      ),
    );
  }
}
