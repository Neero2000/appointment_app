import '../config/index.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;

class FirebaseAuthUtils {
  static final FirebaseAuthUtils instance = FirebaseAuthUtils._internal();
  factory FirebaseAuthUtils() => instance;
  FirebaseAuthUtils._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final ToastUtils _toastUtils = ToastUtils.instance;

  final ConfigUtils _config = ConfigUtils.instance;

  final DataUtils _dataUtils = DataUtils.instance;

  final String _isDoctorKey = "isDoctorKey";
  late bool isDoctor;

  final String _assetPathKey = "assetPathKey";
  String assetPath = '';

  final String _specialityKey = "specialityKey";
  late String speciality;

  bool get isLoggedIn => _firebaseAuth.currentUser != null;

  String get name => _firebaseAuth.currentUser!.email!.split('@')[0];

  String get uid => _firebaseAuth.currentUser!.uid;

  String get email => _firebaseAuth.currentUser!.email!;

  late chat.StreamChatClient streamChatClient = chat.StreamChatClient(
    _config.streamChatApiKey,
    logLevel: chat.Level.OFF,
  );

  Future init() async {
    final prefs = await SharedPreferences.getInstance();
    isDoctor = prefs.getBool(_isDoctorKey) ?? false;
    assetPath = prefs.getString(_assetPathKey) ?? '';
    speciality = prefs.getString(_specialityKey) ?? _dataUtils.specialities.first.name;
    await _streamChatLogin();
  }

  Future _save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isDoctorKey, isDoctor);
    prefs.setString(_assetPathKey, assetPath);
    prefs.setString(_specialityKey, speciality);
  }

  Future _reset() async {
    isDoctor = false;
    assetPath = '';
    speciality = _dataUtils.specialities.first.name;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_isDoctorKey);
    prefs.remove(_assetPathKey);
    prefs.remove(_specialityKey);
  }

  Future login({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required Future<DoctorModel?> Function(String) getDoctor,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        debugPrint('Login successful for $email');
        onSuccess();
        final DoctorModel? doctor = await getDoctor(_firebaseAuth.currentUser!.uid);
        isDoctor = doctor != null;
        if (doctor != null) {
          assetPath = doctor.assetPath;
          speciality = doctor.speciality;
        }
        _save();
        _streamChatLogin();
        onSuccess();
        _toastUtils.showSuccessToast(msg: 'Signed in successfully');
      } else {
        // Handle the case where user does not exist
        debugPrint('User does not exist');
        _toastUtils.showSuccessToast(msg: 'User does not exist');
      }
    } on FirebaseAuthException catch (error) {
      debugPrint('Login failed: $error');
    } catch (error) {
      debugPrint('Login failed: $error');
    }
  }

  Future signup({
    required String email,
    required String password,
    required bool isDoctor,
    required String assetPath,
    required String speciality,
    required VoidCallback onSuccess,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      this.isDoctor = isDoctor;
      this.assetPath = assetPath;
      this.speciality = speciality;
      _save();
      _streamChatLogin();
      onSuccess();
      debugPrint('Registration successful for ${userCredential.user!.email}');
      _toastUtils.showSuccessToast(msg: 'Signed up successfully');
    } on FirebaseAuthException catch (error) {
      debugPrint('Registration failed: $error');
    } catch (error) {
      debugPrint('Registration failed: $error');
    }
  }

  Future _streamChatLogin() async {
    final token = streamChatClient.devToken(_firebaseAuth.currentUser!.uid);
    await streamChatClient.connectUser(
      chat.User(
        id: _firebaseAuth.currentUser!.uid,
        name: _firebaseAuth.currentUser?.email?.split('@').first,
      ),
      token.rawValue,
    );
  }

  Future streamChatCreateChannel({required String doctorId}) async {
    await streamChatClient.createChannel('messaging', channelData: {
      "members": [
        _firebaseAuth.currentUser!.uid,
        doctorId,
      ],
    });
  }

  Future signout({required VoidCallback onSuccess}) async {
    try {
      await _firebaseAuth.signOut();
      await _reset();
      await streamChatClient.disconnectUser();
      onSuccess();
      debugPrint('Signout successful');
      _toastUtils.showSuccessToast(msg: 'Signed out successfully');
    } on FirebaseAuthException catch (error) {
      debugPrint('Signout failed: $error');
    } catch (error) {
      debugPrint('Signout failed: $error');
    }
  }
}
