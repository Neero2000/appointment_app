import 'package:flutter_application_1/src/models/time_slot_model.dart';

import '../config/index.dart';
import 'package:intl/intl.dart';

class FirebaseFirestoreUtils {
  static final FirebaseFirestoreUtils instance = FirebaseFirestoreUtils._internal();
  factory FirebaseFirestoreUtils() => instance;
  FirebaseFirestoreUtils._internal();

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final FirebaseAuthUtils _firebaseAuthUtils = FirebaseAuthUtils.instance;

  Future createDoctor({
    required String email,
    required String price,
    required String address,
    required String speciality,
    required String assetPath,
  }) async {
    Random random = Random();
    await firebaseFirestore.collection('doctors').doc().set(
      {
        'userId': _firebaseAuthUtils.uid,
        'email': email,
        'name': email.split('@').first,
        'price': int.parse(price),
        'address': address,
        'speciality': speciality,
        'assetPath': assetPath,
        'patientNumber': random.nextInt(1000),
        'experience': random.nextInt(30),
        'notation': double.parse((random.nextDouble() * 5).toStringAsFixed(1)),
        'reviewNumber': random.nextInt(100),
      },
    );
  }

  Future<DoctorModel?> getDoctorById({required String userId}) async {
    final Query<Map<String, dynamic>> query = firebaseFirestore.collection('doctors').where('userId', isEqualTo: userId);
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();
    final List<DoctorModel> doctors = [];
    querySnapshot.docs.map((e) => e.data()).forEach((v) {
      doctors.add(DoctorModel.fromJson(v));
    });
    return doctors.isEmpty ? null : doctors.first;
  }

  Future<List<DoctorModel>> getBestDoctors() async {
    final List<DoctorModel> doctors = [];
    final Query<Map<String, dynamic>> query = firebaseFirestore.collection('doctors').orderBy('notation', descending: true).limit(10);
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();
    querySnapshot.docs.map((e) => e.data()).forEach((v) {
      doctors.add(DoctorModel.fromJson(v));
    });
    return doctors;
  }

  Future<List<DoctorModel>> getDoctorsBySpeciality({required String speciality}) async {
    final List<DoctorModel> doctors = [];
    final Query<Map<String, dynamic>> query = firebaseFirestore.collection('doctors').where('speciality', isEqualTo: speciality);
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();
    querySnapshot.docs.map((e) => e.data()).forEach((v) {
      doctors.add(DoctorModel.fromJson(v));
    });
    return doctors;
  }

  Future createAppointment({
    required DoctorModel doctor,
    required DateTime date,
    required TimeSlotModel timeSlot,
    required bool isCashPayment,
    required String userId,
    required int total,
  }) async {
    await firebaseFirestore.collection('appointments').doc().set(
      {
        'doctorId': doctor.userId,
        'userId': userId,
        'date': DateFormat('yyyy-MM-dd').format(date),
        'time': timeSlot.time,
        'status': 'pending',
        'doctor_name': doctor.name,
        'doctor_assetPath': doctor.assetPath,
        'speciality': doctor.speciality,
        'isCashPayment': isCashPayment,
        'total': total,
      },
    );
  }

  Future editAppointment({
    required AppointmentModel appointment,
    required DateTime date,
    required TimeSlotModel timeSlot,
  }) async {
    await firebaseFirestore.collection('appointments').doc(appointment.id).set(
      {
        'doctorId': appointment.doctorId,
        'userId': appointment.userId,
        'date': DateFormat('yyyy-MM-dd').format(date),
        'time': timeSlot.time,
        'status': appointment.status,
        'doctor_name': appointment.doctorName,
        'doctor_assetPath': appointment.doctorAssetPath,
        'speciality': appointment.speciality,
        'isCashPayment': appointment.isCashPayment,
        'total': appointment.total,
      },
    );
  }

  Future<List<AppointmentModel>> getAppointments({required String userId}) async {
    final List<AppointmentModel> appointments = [];
    final Query<Map<String, dynamic>> query = firebaseFirestore.collection('appointments').where(_firebaseAuthUtils.isDoctor ? 'doctorId' : 'userId', isEqualTo: userId);
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();
    querySnapshot.docs.map((e) => e.data()..addAll({'id': e.id})).forEach((v) {
      appointments.add(AppointmentModel.fromJson(v));
    });
    return appointments;
  }

  Future<List<AppointmentModel>> getAppointmentByDoctorDateTime({
    required String doctorId,
    required DateTime date,
    required TimeSlotModel timeSlot,
  }) async {
    final List<AppointmentModel> appointments = [];
    final Query<Map<String, dynamic>> query = firebaseFirestore.collection('appointments').where('doctorId', isEqualTo: doctorId);
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();
    querySnapshot.docs.map((e) => e.data()..addAll({'id': e.id})).forEach((v) {
      final AppointmentModel appointment = AppointmentModel.fromJson(v);
      if (appointment.date == DateFormat('yyyy-MM-dd').format(date) && appointment.time == timeSlot.time && appointment.status == 'pending') {
        appointments.add(appointment);
      }
    });
    return appointments;
  }

  Future cancelAppointment({required String appointmentId}) async {
    await firebaseFirestore.collection('appointments').doc(appointmentId).update(
      {'status': 'canceled'},
    );
  }

  Future completeAppointment({required String appointmentId}) async {
    await firebaseFirestore.collection('appointments').doc(appointmentId).update(
      {'status': 'completed'},
    );
  }
}
