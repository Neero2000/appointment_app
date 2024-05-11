import '../../../config/index.dart';
import 'package:flutter/cupertino.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorCard({super.key, required this.doctor});
  @override
  Widget build(BuildContext context) {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    return SizedBox(
      height: 16.h,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          router.launchDoctorDetails(arguments: DoctorDetailsArgs(doctor: doctor));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              _Image(doctor: doctor),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _Name(doctor: doctor),
                    const SizedBox(height: 4),
                    _Speciality(doctor: doctor),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Icon(Icons.star, color: Colors.orange, size: 20),
                        const SizedBox(width: 2),
                        _Notation(doctor: doctor),
                        const Expanded(child: SizedBox()),
                        _Reviews(doctor: doctor),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final DoctorModel doctor;
  const _Image({required this.doctor});
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: 30.w,
        height: 14.h,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            doctor.assetPath,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}

class _Name extends StatelessWidget {
  final DoctorModel doctor;
  const _Name({required this.doctor});
  @override
  Widget build(BuildContext context) {
    return Text(
      doctor.name,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _Speciality extends StatelessWidget {
  final DoctorModel doctor;
  const _Speciality({required this.doctor});
  @override
  Widget build(BuildContext context) {
    return Text(
      doctor.speciality,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

class _Notation extends StatelessWidget {
  final DoctorModel doctor;
  const _Notation({required this.doctor});
  @override
  Widget build(BuildContext context) {
    return Text(
      doctor.notation.toStringAsFixed(2),
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}

class _Reviews extends StatelessWidget {
  final DoctorModel doctor;
  const _Reviews({required this.doctor});
  @override
  Widget build(BuildContext context) {
    return Text(
      'Reviews (${doctor.reviewNumber})',
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}
