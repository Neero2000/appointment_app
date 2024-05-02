import '../config/index.dart';
import 'package:collection/collection.dart';

class AppointmentModel {
  late String id;
  late String date;
  late String doctorId;
  late String status;
  late String time;
  late String userId;
  late DoctorModel doctor;

  AppointmentModel({
    required this.id,
    required this.date,
    required this.doctorId,
    required this.status,
    required this.time,
    required this.userId,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    doctorId = json['doctorId'];
    status = json['status'];
    time = json['time'];
    userId = json['userId'];
    doctor = DataUtils().doctors.firstWhereOrNull((doctor) => doctor.id == json['doctorId']) ?? DoctorModel.empty();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['doctorId'] = doctorId;
    data['status'] = status;
    data['time'] = time;
    data['userId'] = userId;
    return data;
  }
}
