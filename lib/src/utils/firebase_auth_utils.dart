import '../config/index.dart';

class FirebaseAuthUtils {
  static final FirebaseAuthUtils instance = FirebaseAuthUtils._internal();
  factory FirebaseAuthUtils() => instance;
  FirebaseAuthUtils._internal();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => firebaseAuth.currentUser != null;

  bool get isAdmin => firebaseAuth.currentUser!.email == 'mensefgames@gmail.com';

  String get name => firebaseAuth.currentUser!.email!.split('@')[0];

  String get uid => firebaseAuth.currentUser!.uid;

  Future<void> login({
    required String email,
    required String password,
    required VoidCallback onSuccess,
  }) async {
    try {
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        debugPrint('Login successful for $email');

        onSuccess();
      } else {
        // Handle the case where user does not exist
        debugPrint('User does not exist');
      }
    } catch (error) {
      // Handle login failure
      debugPrint('Login failed: $error');
    }
  }
}
