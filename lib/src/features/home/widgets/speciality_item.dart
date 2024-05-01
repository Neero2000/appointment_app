import '../../../config/index.dart';
import 'package:flutter/cupertino.dart';

class SpecialityItem extends StatelessWidget {
  final SpecialityModel speciality;
  const SpecialityItem({super.key, required this.speciality});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        // Add your onTap logic here
      },
      child: SizedBox(
        width: 80,
        child: Column(
          children: [
            Image.asset(
              speciality.iconPath,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 6),
            Text(
              speciality.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
