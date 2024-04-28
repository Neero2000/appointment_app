import '../index.dart';

/// the custom error widget to override flutter's default red and yellow error
/// we override it to better manage the errors in the app
class CustomErrorWidget extends StatelessWidget {
  final String errorText;
  const CustomErrorWidget({
    super.key,
    required this.errorText,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      alignment: Alignment.center,
      child: _Text(errorText: errorText),
    );
  }
}

class _Text extends StatelessWidget {
  final String errorText;
  const _Text({
    required this.errorText,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      errorText,
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }
}
