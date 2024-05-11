class DoctorModel {
  late String userId;
  late String email;
  late String name;
  late int price;
  late String address;
  late String speciality;
  late String assetPath;
  late int patientNumber;
  late int experience;
  late double notation;
  late int reviewNumber;

  DoctorModel({
    required this.userId,
    required this.email,
    required this.name,
    required this.price,
    required this.address,
    required this.speciality,
    required this.assetPath,
    required this.patientNumber,
    required this.experience,
    required this.notation,
    required this.reviewNumber,
  });

  DoctorModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    name = json['name'];
    price = json['price'];
    address = json['address'];
    speciality = json['speciality'];
    assetPath = json['assetPath'];
    patientNumber = json['patientNumber'];
    experience = json['experience'];
    notation = json['notation'];
    reviewNumber = json['reviewNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['email'] = email;
    data['name'] = name;
    data['price'] = price;
    data['address'] = address;
    data['speciality'] = speciality;
    data['assetPath'] = assetPath;
    data['patientNumber'] = patientNumber;
    data['experience'] = experience;
    data['notation'] = notation;
    data['reviewNumber'] = reviewNumber;
    return data;
  }
}
