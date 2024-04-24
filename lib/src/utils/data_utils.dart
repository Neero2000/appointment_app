import '../config/index.dart';

class DataUtils {
  static final DataUtils _instance = DataUtils._internal();
  factory DataUtils() => _instance;
  DataUtils._internal();

  List<DoctorModel> doctors = [
    DoctorModel(
      name: 'Dr. John Doe',
      assetPath: 'assets/doctor2.jpg',
      speciality: 'Cardiologist',
      isPaymentCash: true,
      patientNumber: 100,
      experience: 10,
      notation: 4,
      reviewNumber: 20,
      startDate: 'Monday',
      endDate: 'Friday',
      startTime: '08.00 Am',
      endTime: '06:00 Pm',
    ),
    DoctorModel(
      name: 'Dr. Jane Doe',
      assetPath: 'assets/doctor1.jpg',
      speciality: 'Dermatologist',
      isPaymentCash: false,
      patientNumber: 200,
      experience: 15,
      notation: 5,
      reviewNumber: 30,
      startDate: 'Monday',
      endDate: 'Friday',
      startTime: '08.00 Am',
      endTime: '06:00 Pm',
    ),
    DoctorModel(
      name: 'Dr. James Doe',
      assetPath: 'assets/doctor2.jpg',
      speciality: 'Neurologist',
      isPaymentCash: true,
      patientNumber: 150,
      experience: 12,
      notation: 4,
      reviewNumber: 25,
      startDate: 'Monday',
      endDate: 'Friday',
      startTime: '08.00 Am',
      endTime: '06:00 Pm',
    ),
    DoctorModel(
      name: 'Dr. Jessica Doe',
      assetPath: 'assets/doctor1.jpg',
      speciality: 'Pediatrician',
      isPaymentCash: false,
      patientNumber: 250,
      experience: 20,
      notation: 5,
      reviewNumber: 35,
      startDate: 'Monday',
      endDate: 'Friday',
      startTime: '08.00 Am',
      endTime: '06:00 Pm',
    ),
  ];
}
