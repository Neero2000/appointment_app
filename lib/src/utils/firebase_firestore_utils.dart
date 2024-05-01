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
        'status': 'upcoming',
      },
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAppointments({required String userId}) async {
    return await firebaseFirestore.collection('appointments').where('userId', isEqualTo: userId).get();
  }
}
