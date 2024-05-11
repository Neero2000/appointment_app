import '../../../config/index.dart';

class AppointmentSuccessArgs {
  final String successText;
  const AppointmentSuccessArgs({required this.successText});
}

class AppointmentSuccessPage extends StatelessWidget {
  static const String path = '/appointment_success';
  const AppointmentSuccessPage({super.key});
  @override
  Widget build(BuildContext context) {
    final AppointmentSuccessArgs args = ModalRoute.of(context)?.settings.arguments as AppointmentSuccessArgs;
    return Scaffold(
      bottomNavigationBar: const _BottomNavBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            child: Lottie.asset(
              'assets/animations/succes_animation.json',
              repeat: false,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  args.successText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();
  @override
  Widget build(BuildContext context) {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SizedBox(width: 4.w),
            Expanded(
              child: CustomLoadingButton(
                width: double.infinity,
                text: 'Continue',
                loadingFunction: () async {
                  router.popRoute();
                },
              ),
            ),
            SizedBox(width: 4.w),
          ],
        ),
        SizedBox(height: 4.h),
      ],
    );
  }
}
