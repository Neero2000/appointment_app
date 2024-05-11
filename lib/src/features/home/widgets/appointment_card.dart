import '../../../config/index.dart';
import 'package:flutter/cupertino.dart';
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
            _Doctor(appointment: appointment, refresh: refresh),
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
  final VoidCallback refresh;
  const _Doctor({
    required this.appointment,
    required this.refresh,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(appointment.doctorAssetPath),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appointment.doctorName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                appointment.speciality,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        ...appointment.status == 'pending'
            ? [
                _Edit(
                  appointment: appointment,
                  refresh: refresh,
                ),
              ]
            : [],
        const SizedBox(width: 10),
      ],
    );
  }
}

class _Edit extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback refresh;
  const _Edit({
    required this.appointment,
    required this.refresh,
  });
  @override
  Widget build(BuildContext context) {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        router.launchEditAppointment(
          arguments: EditAppointmentArgs(
            appointment: appointment,
            refresh: refresh,
          ),
        );
      },
      child: Icon(
        Icons.edit,
        color: Colors.grey[300],
        size: 30,
      ),
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
          Flexible(child: _Time(appointment: appointment)),
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
        Flexible(
          child: Text(
            DateFormat('EEEE, dd/MM/yyyy').format(DateTime.parse(appointment.date)),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
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
          size: 15,
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            appointment.time,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
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
                    borderRadius: BorderRadius.circular(6),
                    loadingFunction: () async {
                      FirebaseFirestoreUtils firebaseFirestoreUtils = FirebaseFirestoreUtils();
                      await firebaseFirestoreUtils.cancelAppointment(appointmentId: appointment.id).then((value) {
                        refresh();
                      });
                    },
                  ),
                ),
              ]
            : [],
        ...(FirebaseAuthUtils.instance.isDoctor && appointment.status == 'pending')
            ? [
                const SizedBox(width: 14),
                Expanded(
                  child: SizedBox(
                    child: CustomLoadingButton(
                      text: 'Complete',
                      color: Colors.green,
                      height: 45,
                      borderRadius: BorderRadius.circular(6),
                      loadingFunction: () async {
                        FirebaseFirestoreUtils firebaseFirestoreUtils = FirebaseFirestoreUtils();
                        await firebaseFirestoreUtils.completeAppointment(appointmentId: appointment.id).then((value) {
                          refresh();
                        });
                      },
                    ),
                  ),
                ),
              ]
            : [],
      ],
    );
  }
}
