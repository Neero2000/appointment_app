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

  bool get isLoggedIn => _firebaseAuth.currentUser != null;

  String get name => _firebaseAuth.currentUser!.email!.split('@')[0];

  String get uid => _firebaseAuth.currentUser!.uid;

  String get email => _firebaseAuth.currentUser!.email!;

  late chat.StreamChatClient streamChatClient;

  Future init() async {
    final prefs = await SharedPreferences.getInstance();
    isDoctor = prefs.getBool(_isDoctorKey) ?? false;
    await _streamChatLogin();
  }

  Future _save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isDoctorKey, isDoctor);
  }

  Future _reset() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_isDoctorKey);
  }

  Future login({required String email, required String password, required VoidCallback onSuccess}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        debugPrint('Login successful for $email');
        isDoctor = _dataUtils.doctors.map((d) => d.id).contains(userCredential.user?.uid ?? '');
        _save();
        _streamChatLogin();
        onSuccess();
        _toastUtils.showSuccessToast(msg: 'Signed in successfully');
      } else {
        // Handle the case where user does not exist
        debugPrint('User does not exist');
        _toastUtils.showSuccessToast(msg: 'User does not exist');
      }
    } catch (error) {
      debugPrint('Login failed: $error');
    }
  }

  Future _streamChatLogin() async {
    streamChatClient = chat.StreamChatClient(
      _config.streamChatApiKey,
      logLevel: chat.Level.OFF,
    );
    final token = streamChatClient.devToken(_firebaseAuth.currentUser!.uid);
    await streamChatClient.connectUser(
      chat.User(id: _firebaseAuth.currentUser!.uid),
      token.rawValue,
    );
    final chat.Channel streamChatChannel = streamChatClient.channel('messaging', id: "doctor1");
    await streamChatChannel.watch();
  }

  Future signup({required String email, required String password, required VoidCallback onSuccess}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      isDoctor = false;
      _save();
      onSuccess();
      debugPrint('Registration successful for ${userCredential.user!.email}');
      _toastUtils.showSuccessToast(msg: 'Signed up successfully');
    } catch (error) {
      debugPrint('Registration failed: $error');
    }
  }

  Future signout({required VoidCallback onSuccess}) async {
    try {
      await _firebaseAuth.signOut();
      await _reset();
      onSuccess();
      debugPrint('Signout successful');
      _toastUtils.showSuccessToast(msg: 'Signed out successfully');
    } catch (error) {
      debugPrint('Signout failed: $error');
    }
  }
}
