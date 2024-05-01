import '../../../config/index.dart';
import 'package:flutter/cupertino.dart';

class PaymentMethodItem extends StatelessWidget {
  final String text;
  final String assetPath;
  final bool? isSelected;
  final VoidCallback onChanged;
  const PaymentMethodItem({
    super.key,
    required this.text,
    required this.assetPath,
    required this.isSelected,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onChanged,
      padding: EdgeInsets.zero,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: isSelected == true
              ? Border.all(
                  width: 1,
                  color: const Color(0xFF1C2A3A),
                )
              : Border.all(
                  width: 0.3,
                  color: Colors.grey,
                ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio(
              value: isSelected,
              groupValue: true,
              onChanged: (_) {
                onChanged();
              },
              activeColor: const Color(0xFF1C2A3A),
            ),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelected == true ? const Color(0xFF1C2A3A) : Colors.black,
              ),
            ),
            const Expanded(child: SizedBox()),
            Image.asset(
              assetPath,
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
