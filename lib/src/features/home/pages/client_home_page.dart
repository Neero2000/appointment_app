import '../../../config/index.dart';
import 'package:flutter/cupertino.dart';

class ClientHomePage extends StatelessWidget {
  static const String path = '/client_home';
  const ClientHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _AppBar(),
      body: _Body(),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    return AppBar(
      title: Text(
        FirebaseAuthUtils.instance.name,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: false,
      actions: [
        CupertinoButton(
          onPressed: () {
            router.launchNotifications();
          },
          child: const Icon(
            CupertinoIcons.bell,
            size: 30,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: const <Widget>[
        SizedBox(height: 24),
        _Title(text: 'Categories'),
        SizedBox(height: 16),
        _SpecialityList(),
        // SizedBox(height: 25),
        // _Title(text: 'Rendez-vous aujourd\'hui'),
        // SizedBox(height: 16),
        // AppointmentCard(),
        SizedBox(height: 25),
        _Title(text: 'Meilleur docteur'),
        SizedBox(height: 16),
        _DoctorsList(),
        SizedBox(height: 70),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  final String text;
  const _Title({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _SpecialityList extends StatelessWidget {
  const _SpecialityList();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        itemCount: DataUtils().specialities.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 12);
        },
        itemBuilder: (context, index) {
          return SpecialityItem(speciality: DataUtils().specialities[index]);
        },
      ),
    );
  }
}

class _DoctorsList extends StatelessWidget {
  const _DoctorsList();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      itemCount: DataUtils().doctors.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
      itemBuilder: (context, index) {
        return DoctorCard(doctor: DataUtils().doctors[index]);
      },
    );
  }
}
