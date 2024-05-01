class AppointmentModel {
  String? date;
  String? doctorId;
  String? status;
  String? time;
  String? userId;

  AppointmentModel({
    this.date,
    this.doctorId,
    this.status,
    this.time,
    this.userId,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    doctorId = json['doctorId'];
    status = json['status'];
    time = json['time'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['doctorId'] = doctorId;
    data['status'] = status;
    data['time'] = time;
    data['userId'] = userId;
    return data;
  }
}
