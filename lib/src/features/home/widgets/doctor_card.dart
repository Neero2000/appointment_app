import '../../../config/index.dart';
import 'package:flutter/cupertino.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    return SizedBox(
      child: CupertinoButton(
        onPressed: () {
          //redirect to doctor details page
          router.launchDoctorDetails(arguments: DoctorDetailsArgs(doctor: doctor));
        },
        padding: EdgeInsets.zero,
        child: Container(
          height: 150,
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
              SizedBox(
                width: 30.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    doctor.assetPath,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      doctor.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.speciality,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Icon(Icons.star, color: Colors.orange, size: 20),
                        const SizedBox(width: 2),
                        Text(
                          doctor.notation.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          'Reviews (${doctor.reviewNumber})',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
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
