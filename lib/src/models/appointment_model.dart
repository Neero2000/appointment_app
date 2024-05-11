class AppointmentModel {
  late String id;
  late String date;
  late String doctorId;
  late String status;
  late String time;
  late String userId;
  late String doctorName;
  late String doctorAssetPath;
  late String speciality;
  late bool isCashPayment;
  late int total;

  AppointmentModel({
    required this.id,
    required this.date,
    required this.doctorId,
    required this.status,
    required this.time,
    required this.userId,
    required this.doctorName,
    required this.doctorAssetPath,
    required this.speciality,
    required this.isCashPayment,
    required this.total,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    doctorId = json['doctorId'];
    status = json['status'];
    time = json['time'];
    userId = json['userId'];
    doctorName = json['doctor_name'];
    doctorAssetPath = json['doctor_assetPath'];
    speciality = json['speciality'];
    isCashPayment = json['isCashPayment'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['doctorId'] = doctorId;
    data['status'] = status;
    data['time'] = time;
    data['userId'] = userId;
    data['doctor_name'] = doctorName;
    data['doctor_assetPath'] = doctorAssetPath;
    data['speciality'] = speciality;
    data['isCashPayment'] = isCashPayment;
    data['total'] = total;
    return data;
  }
}
