class DoctorModel {
  final String name;
  final String assetPath;
  final String speciality;
  final bool isPaymentCash;
  final int patientNumber;
  final int experience;
  final double notation;
  final int reviewNumber;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;

  DoctorModel({
    required this.name,
    required this.assetPath,
    required this.speciality,
    required this.isPaymentCash,
    required this.patientNumber,
    required this.experience,
    required this.notation,
    required this.reviewNumber,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
  });
}
