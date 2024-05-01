import 'package:flutter_application_1/src/config/index.dart';

class DataUtils {
  static final DataUtils _instance = DataUtils._internal();
  factory DataUtils() => _instance;
  DataUtils._internal();

  // doctors
  List<DoctorModel> doctors = [
    DoctorModel(
      id: 'john_doe',
      name: 'Dr. John Doe',
      assetPath: 'assets/images/doctor2.jpg',
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
      price: 2500,
    ),
    DoctorModel(
      id: 'jane_doe',
      name: 'Dr. Jane Doe',
      assetPath: 'assets/images/doctor1.jpg',
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
      price: 3000,
    ),
    DoctorModel(
      id: 'james_doe',
      name: 'Dr. James Doe',
      assetPath: 'assets/images/doctor2.jpg',
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
      price: 2000,
    ),
    DoctorModel(
      id: 'jessica_doe',
      name: 'Dr. Jessica Doe',
      assetPath: 'assets/images/doctor1.jpg',
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
      price: 4000,
    ),
  ];

  // time slots
  List<TimeSlotModel> timeSlots = [
    TimeSlotModel(time: '09:00 AM'),
    TimeSlotModel(time: '10:00 AM'),
    TimeSlotModel(time: '11:00 AM'),
    TimeSlotModel(time: '12:00 PM'),
    TimeSlotModel(time: '01:00 PM'),
    TimeSlotModel(time: '02:00 PM'),
    TimeSlotModel(time: '03:00 PM'),
    TimeSlotModel(time: '04:00 PM'),
  ];

  // specialities
  List<SpecialityModel> specialities = [
    SpecialityModel(iconPath: 'assets/images/general_icon.png', name: 'General'),
    SpecialityModel(iconPath: 'assets/images/cardiology_icon.png', name: 'Cardiology'),
    SpecialityModel(iconPath: 'assets/images/immunology_icon.png', name: 'Immunology'),
    SpecialityModel(iconPath: 'assets/images/pulmonologist_icon.png', name: 'Pulmonologist'),
    SpecialityModel(iconPath: 'assets/images/ophthalmology_icon.png', name: 'Ophthalmology'),
    SpecialityModel(iconPath: 'assets/images/dentistry_icon.png', name: 'Dentistry'),
  ];
}
