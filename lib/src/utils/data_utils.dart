import 'package:flutter_application_1/src/config/index.dart';

class DataUtils {
  static final DataUtils instance = DataUtils._internal();
  factory DataUtils() => instance;
  DataUtils._internal();

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
