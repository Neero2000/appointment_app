import '../../../config/index.dart';

class AppointmentBookedPage extends StatelessWidget {
  static const String routeName = '/appointment_booked_page';
  const AppointmentBookedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Lottie.asset('assets/succes.json'),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                ' félicitations!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            const Text(
              ' Votre rendez-vous est confimé',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // back to home
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Button(
                  width: double.infinity,
                  title: "Terminé",
                  onPressed: () {
                    router.launchHome();
                  },
                  disable: false),
            )
          ],
        ),
      ),
    );
  }
}
