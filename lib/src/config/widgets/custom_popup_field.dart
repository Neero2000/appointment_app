import '../index.dart';

class CustomPopupField extends StatelessWidget {
  final List<String> values;
  final String value;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  const CustomPopupField({
    super.key,
    required this.values,
    required this.value,
    required this.onChanged,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return _TextField(
      values: values,
      value: value,
      onChanged: onChanged,
      validator: validator,
    );
  }
}

class _TextField extends StatelessWidget {
  final List<String> values;
  final String value;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  const _TextField({
    required this.values,
    required this.value,
    required this.onChanged,
    required this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return PopupMenuItem(
      height: 48,
      padding: const EdgeInsets.all(0.0),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        items: values.map(
          (value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          },
        ).toList(),
        dropdownColor: Colors.white,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        validator: validator,
        decoration: InputDecoration(
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
      ),
    );
  }
}
