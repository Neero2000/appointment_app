import '../../../config/index.dart';
import 'package:flutter/cupertino.dart';

class TimeSlotItem extends StatelessWidget {
  final TimeSlotModel timeSlot;
  final bool isSelected;
  final VoidCallback onPressed;
  const TimeSlotItem({
    super.key,
    required this.timeSlot,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: isSelected ? Colors.white : Colors.black),
              borderRadius: BorderRadius.circular(16),
              color: isSelected ? AppTheme.primaryColor : null,
            ),
            alignment: Alignment.center,
            child: Text(
              timeSlot.time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : null,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
