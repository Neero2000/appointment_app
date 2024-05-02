import '../../../config/index.dart';
import 'package:intl/intl.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback refresh;
  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.refresh,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 18),
            _Doctor(appointment: appointment),
            const SizedBox(height: 25),
            _DateAndTime(appointment: appointment),
            const SizedBox(height: 25),
            _Actions(appointment: appointment, refresh: refresh),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

class _Doctor extends StatelessWidget {
  final AppointmentModel appointment;
  const _Doctor({required this.appointment});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(appointment.doctor.assetPath),
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appointment.doctor.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              appointment.doctor.speciality,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _DateAndTime extends StatelessWidget {
  final AppointmentModel appointment;
  const _DateAndTime({required this.appointment});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.13),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 18),
          _Date(appointment: appointment),
          const SizedBox(width: 18),
          _Time(appointment: appointment),
          const SizedBox(width: 18),
        ],
      ),
    );
  }
}

class _Date extends StatelessWidget {
  final AppointmentModel appointment;
  const _Date({required this.appointment});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          DateFormat('EEEE, dd/MM/yyyy').format(DateTime.parse(appointment.date)),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class _Time extends StatelessWidget {
  final AppointmentModel appointment;
  const _Time({required this.appointment});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          FontAwesomeIcons.clock,
          color: Colors.white,
          size: 16,
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            appointment.time,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class _Actions extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback refresh;
  const _Actions({
    required this.appointment,
    required this.refresh,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...['pending', 'confirmed'].contains(appointment.status)
            ? [
                Expanded(
                  child: CustomLoadingButton(
                    text: 'Cancel',
                    color: Colors.red,
                    height: 45,
                    loadingFunction: () async {
                      FirebaseFirestoreUtils firebaseFirestoreUtils = FirebaseFirestoreUtils();
                      await firebaseFirestoreUtils.cancelAppointment(appointmentId: appointment.id).then((value) {
                        refresh();
                      });
                    },
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ]
            : [],
        // const SizedBox(width: 14),
        // Expanded(
        //   child: SizedBox(
        //     child: CustomLoadingButton(
        //       text: 'Confirm',
        //       color: const Color(0xFF245FF4),
        //       height: 45,
        //       loadingFunction: () async {},
        //       borderRadius: BorderRadius.circular(6),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
