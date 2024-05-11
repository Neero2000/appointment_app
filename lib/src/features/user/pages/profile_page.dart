import '../../../config/index.dart';
import 'package:flutter/cupertino.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        addBackButton: false,
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();
  @override
  Widget build(BuildContext context) {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    return ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        const SizedBox(height: 28),
        const _Profile(),
        const SizedBox(height: 28),
        const Divider(indent: 18, endIndent: 18),
        _SettingsItem(
          title: "Privacy",
          icon: Icons.lock,
          color: Colors.indigo,
          onPressed: () {},
        ),
        _SettingsItem(
          title: "Language",
          icon: Icons.translate,
          color: Colors.green,
          onPressed: () {},
        ),
        _SettingsItem(
          title: "About Us",
          icon: Icons.info_outline,
          color: Colors.orange,
          onPressed: () {},
        ),
        const Divider(indent: 18, endIndent: 18),
        _SettingsItem(
            title: "Logout",
            icon: Icons.exit_to_app,
            color: Colors.redAccent,
            onPressed: () async {
              FirebaseAuthUtils firebaseAuthUtils = FirebaseAuthUtils.instance;
              await firebaseAuthUtils.signout(
                onSuccess: () {
                  router.launchLogin();
                },
              );
            }),
      ],
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 18),
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey[300],
          ),
          child: const Icon(
            Icons.person,
            size: 50,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              FirebaseAuthUtils.instance.email,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            const Text("Profile"),
          ],
        ),
        const SizedBox(width: 18),
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  const _SettingsItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            const SizedBox(width: 18),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),
            const SizedBox(width: 18),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            const Expanded(child: SizedBox()),
            const Icon(CupertinoIcons.forward),
            const SizedBox(width: 18),
          ],
        ),
      ),
    );
  }
}
