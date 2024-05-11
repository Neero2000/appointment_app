import '../../../config/index.dart';
import 'package:flutter/cupertino.dart';

class DoctorsEmpty extends StatelessWidget {
  final VoidCallback refresh;
  const DoctorsEmpty({
    super.key,
    required this.refresh,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 120.0),
        CupertinoButton(
          padding: const EdgeInsets.all(0.0),
          onPressed: refresh,
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: _Title()),
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: _Subtitle()),
                ],
              ),
              SizedBox(height: 60.0),
              _Icon(),
            ],
          ),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();
  @override
  Widget build(BuildContext context) {
    return const Text(
      "No Doctors Found",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle();
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "doctors will appear here ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const TextSpan(
            text: "refresh",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppTheme.primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon();
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.medical_information,
      color: Colors.grey[400]!,
      size: 80,
    );
  }
}
