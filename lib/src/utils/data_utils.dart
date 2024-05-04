import 'package:flutter_application_1/src/config/index.dart';

class DataUtils {
  static final DataUtils instance = DataUtils._internal();
  factory DataUtils() => instance;
  DataUtils._internal();

  // doctors
  List<DoctorModel> doctors = [
    DoctorModel(
      id: 'CVi0SwVcA1TcMZPMu6Pa2vCmmzC2',
      name: 'Doctor 1',
      assetPath: 'assets/images/doctor1.jpg',
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
      id: '6K47Cakze4T96ICSthCsEzATSKF2',
      name: 'Doctor 2',
      assetPath: 'assets/images/doctor2.jpg',
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
      id: 'bQiedXNOFrQnd1j0IRqa23EfQwx2',
      name: 'Doctor 3',
      assetPath: 'assets/images/doctor3.jpg',
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
      id: 'KCEJawRZkJQhpFKYKtsfGX0Vg6a2',
      name: 'Doctor 4',
      assetPath: 'assets/images/doctor4.jpg',
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
