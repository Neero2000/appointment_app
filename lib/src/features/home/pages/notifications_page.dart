import '../../../config/index.dart';
import 'package:flutter/cupertino.dart';

class NotificationsPage extends StatelessWidget {
  static const String path = '/notifications';
  const NotificationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Notifications'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.bell,
              size: 100,
              color: AppTheme.primaryColor,
            ),
            SizedBox(height: 20),
            Text(
              'No new notifications',
              style: TextStyle(
                fontSize: 20,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
