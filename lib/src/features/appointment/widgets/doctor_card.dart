import '../../../config/index.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: GestureDetector(
        child: Card(
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Adjust radius here
          ),
          child: Row(
            children: [
              const SizedBox(width: 6),
              SizedBox(
                width: 33.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    doctor.assetPath,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        doctor.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        doctor.speciality,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Spacer(flex: 1),
                      const Spacer(flex: 1),
                      const Spacer(flex: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Icon(Icons.star_border, color: Colors.yellow, size: 16),
                          const SizedBox(width: 8),
                          Text(doctor.notation.toStringAsFixed(2)),
                          const Expanded(child: SizedBox()),
                          const Text('Reviews'),
                          const SizedBox(width: 8),
                          Text('(${doctor.reviewNumber})'),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        onTap: () {
          //redirect to doctor details page
          Navigator.of(context).pushNamed(
            DoctorDetailsPage.routeName,
            arguments: DoctorDetailsArgs(doctor: doctor),
          );
        },
      ),
    );
  }
}
