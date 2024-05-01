import '../../../config/index.dart';
import 'package:flutter/cupertino.dart';

class DoctorDetailsArgs {
  final DoctorModel doctor;
  const DoctorDetailsArgs({required this.doctor});
}

class DoctorDetailsPage extends StatelessWidget {
  static const String path = '/doctor_details';
  const DoctorDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final DoctorDetailsArgs args = ModalRoute.of(context)?.settings.arguments as DoctorDetailsArgs;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Doctor Details'),
      bottomNavigationBar: _BottomNavBar(doctor: args.doctor),
      body: _Body(doctor: args.doctor),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final DoctorModel doctor;
  const _BottomNavBar({required this.doctor});
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
                text: 'Prendre rendez-vous',
                loadingFunction: () async {
                  router.launchBooking(arguments: BookingArgs(doctor: doctor));
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

class _Body extends StatelessWidget {
  final DoctorModel doctor;
  const _Body({required this.doctor});
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        SizedBox(height: 4.h),
        _Image(doctor: doctor),
        SizedBox(height: 2.h),
        _Name(doctor: doctor),
        _Speciality(doctor: doctor),
        SizedBox(height: 4.h),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 14,
          children: [
            _Stat(
              icon: CupertinoIcons.group_solid,
              text: 'Patients: ${doctor.patientNumber}',
            ),
            _Stat(
              icon: CupertinoIcons.briefcase_fill,
              text: 'Experience: +${doctor.experience}',
            ),
            _Stat(
              icon: CupertinoIcons.star_lefthalf_fill,
              text: 'Notation: ${doctor.notation.toStringAsFixed(1)}',
            ),
          ],
        ),
        SizedBox(height: 4.h),
        const _Title(text: 'Heures de travail'),
        SizedBox(height: 2.h),
        _Schedule(doctor: doctor),
        SizedBox(height: 20.h),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  final DoctorModel doctor;
  const _Image({required this.doctor});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            doctor.assetPath,
            width: 160.0,
            height: 160.0,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class _Name extends StatelessWidget {
  final DoctorModel doctor;
  const _Name({required this.doctor});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            doctor.name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _Speciality extends StatelessWidget {
  final DoctorModel doctor;
  const _Speciality({required this.doctor});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            doctor.speciality,
            style: const TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Stat({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 30,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String text;
  const _Title({required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}

class _Schedule extends StatelessWidget {
  final DoctorModel doctor;
  const _Schedule({required this.doctor});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Days: ${doctor.startDate}-${doctor.endDate}',
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          'Hours: ${doctor.startTime} - ${doctor.endTime}',
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
