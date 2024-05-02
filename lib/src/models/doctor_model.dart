class DoctorModel {
  final String id;
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
  final int price;

  DoctorModel({
    required this.id,
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
    required this.price,
  });

  DoctorModel.empty({
    this.id = '',
    this.name = '-',
    this.assetPath = '',
    this.speciality = '-',
    this.isPaymentCash = false,
    this.patientNumber = 0,
    this.experience = 0,
    this.notation = 0,
    this.reviewNumber = 0,
    this.startDate = '-',
    this.endDate = '-',
    this.startTime = '-',
    this.endTime = '-',
    this.price = 0,
  });
}
