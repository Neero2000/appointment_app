import 'package:flutter_application_1/src/models/appointment_model.dart';

import '../config/index.dart';
import 'package:intl/intl.dart';

class FirebaseFirestoreUtils {
  static final FirebaseFirestoreUtils instance = FirebaseFirestoreUtils._internal();
  factory FirebaseFirestoreUtils() => instance;
  FirebaseFirestoreUtils._internal();

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future createAppointment({
    required DoctorModel doctor,
    required DateTime date,
    required TimeSlotModel timeSlot,
    required bool isCashPayment,
    required String userId,
  }) async {
    await firebaseFirestore.collection('appointments').doc().set(
      {
        'doctorId': doctor.id,
        'userId': userId,
        'date': DateFormat('yyyy-MM-dd').format(date),
        'time': timeSlot.time,
        'status': 'pending',
      },
    );
  }

  Future<List<AppointmentModel>> getAppointments({required String userId}) async {
    final List<AppointmentModel> appointments = [];
    final Query<Map<String, dynamic>> query = firebaseFirestore.collection('appointments').where('userId', isEqualTo: userId);
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();
    querySnapshot.docs.map((e) => e.data()..addAll({'id': e.id})).forEach((v) {
      appointments.add(AppointmentModel.fromJson(v));
    });
    return appointments;
  }

  Future cancelAppointment({required String appointmentId}) async {
    await firebaseFirestore.collection('appointments').doc(appointmentId).update(
      {'status': 'canceled'},
    );
  }
}
