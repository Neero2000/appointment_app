import 'src/config/index.dart';
import 'package:flutter/cupertino.dart';

import 'firebase_options.dart';

import 'package:device_preview/device_preview.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;

/// this is the main function of flutter, this is where the app start
Future<void> main() async {
  /// we call this method because we need the binding to be initialized before calling [runApp]
  WidgetsFlutterBinding.ensureInitialized();

  /// Initializes a new [FirebaseApp] instance by [options] and returns the created app.
  /// This method is called before any usage of FlutterFire plugins.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Initialize firebase app check (play intergrity api)
  await FirebaseAppCheck.instance.activate(androidProvider: AndroidProvider.playIntegrity);

  /// Sets the presentation options for Apple notifications when received in the foreground.
  /// By default, on Apple devices notification messages are only shown when the application is in the background or terminated.
  /// Calling this method updates these options to allow customizing notification presentation behavior whilst the application is in the foreground.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

  /// background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// foreground notifications
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Creates android notification channel
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  /// Requests the specified permission(s) from user and returns current permission status
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, badge: true, sound: true);

  /// Specifies the set of orientations the application interface can be displayed in.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// Specifies the style to use for the system overlays that are visible (if any).
  /// we specify that the status bar color, brightness and icon brightness
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));

  /// this will override the red flutter error screens
  /// we show our own custom error widget better than the red and yellow default error.
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return CustomErrorWidget(errorText: details.exception.toString());
  };

  final client = chat.StreamChatClient(
    'b67pax5b2wdq',
    logLevel: chat.Level.INFO,
  );

  await client.connectUser(
    chat.User(id: 'tutorial-flutter'),
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidHV0b3JpYWwtZmx1dHRlciJ9.S-MJpoSwDiqyXpUURgO5wVqJ4vKlIVFLSEyrFYCOE1c',
  );

  /// this is the runApp function that runs our app from the root level (RootApp)
  runApp(const RootApp());
}

/// we defince an android notification with 'high_importance_channel' so it always show the notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.max,
);

/// This handles background notifications, even when the app is closed, we can still receive notifications.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  /// If you're going to use other Firebase services in the background, such as Firestore,
  /// make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

/// This is our root app
class RootApp extends StatefulWidget {
  const RootApp({super.key});
  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  late final AppRouterDelegate _routerHandler = AppRouterDelegate();

  final ConfigUtils _config = ConfigUtils();

  _RootAppState() {
    _routerHandler.setNewRoutePath(PageConfigurations().splashPageConfig);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RouterCubit>(
          create: (BuildContext context) => RouterCubit(delegate: _routerHandler),
        ),
        BlocProvider<LangCubit>(
          create: (BuildContext context) => LangCubit(langs: _config.appLangs)..init(),
          lazy: true,
        ),
      ],
      child: const _NotificationLayer(),
    );
  }
}

class _NotificationLayer extends StatefulWidget {
  const _NotificationLayer();
  @override
  State<_NotificationLayer> createState() => _NotificationLayerState();
}

class _NotificationLayerState extends State<_NotificationLayer> {
  late StreamSubscription _deepLinkSubscription;

  final ConfigUtils _config = ConfigUtils();

  @override
  void initState() {
    /// init deep links
    _initDeepLinks();

    /// init notification click
    _initOpenedNotifications();

    /// init receiving foreground notirications
    _initForegroundNotifications();

    /// subscribe the app notification to a notification topic
    _subscribeTopicNotification();

    /// _listenToFCMTokenRefresh();
    super.initState();
  }

  @override
  void dispose() {
    _deepLinkSubscription.cancel();
    super.dispose();
  }

  Future<void> _initDeepLinks() async {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    _deepLinkSubscription = uriLinkStream.listen((Uri? uri) {
      if (!mounted) return;
      setState(() {
        router.deepLinkParser(uri: uri!);
      });
    }, onError: (Object err) {
      /// if there's an error, catch it and print it
      debugPrint('$err');
    });
  }

  Future<void> _initOpenedNotifications() async {
    /// Get any messages which caused the application to open from
    /// a terminated state.
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    /// If the message also contains a data property with a "type" of "chat",
    /// navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    /// Also handle any interaction when the app is in the background via a
    /// Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  /// when clicking on notification, the parameter 'path' contains the router deep link information
  void _handleMessage(RemoteMessage message) {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    if (message.data['path'] != null) {
      setState(() {
        router.deepLinkParser(
          uri: Uri.parse("deeplinks://${_config.deepLinksPrefix}/${message.data['path']}"),
        );
      });
    }
  }

  /// this handles foreground notifications, per default, only background notification is supported
  /// so in order to receive notifications even when the app is open, we create a custom notification
  /// whenever we recieve a notification.
  void _initForegroundNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");
    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _handleForegroundMessage,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: "@mipmap/ic_launcher",
            ),
          ),
          payload: jsonEncode(message.data),
        );
      }
    });
  }

  /// this handles when clicking on a foreground notification (path contains the deep link router information)
  void _handleForegroundMessage(NotificationResponse? notificationResponse) {
    final RouterCubit router = BlocProvider.of<RouterCubit>(context, listen: false);
    if (notificationResponse != null) {
      if (notificationResponse.payload != null) {
        Map<String, dynamic> data = jsonDecode(notificationResponse.payload!);
        if (data["path"] != null) {
          setState(() {
            router.deepLinkParser(
              uri: Uri.parse("deeplinks://${_config.deepLinksPrefix}/${data['path']}"),
            );
          });
        }
      }
    }
  }

  void onDidReceiveLocalNotification(int? id, String? title, String? body, String? payload) async {
    /// display a dialog with the notification details, tap ok to go to another page
    await _showIOSNotificationDialog(context: context, title: title!, content: body!);
  }

  Future _showIOSNotificationDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Proceed'),
              onPressed: () async {},
            )
          ],
        );
      },
    );
  }

  /// this subscribes the notification to the topic general but only in staging and prod modes
  void _subscribeTopicNotification() async {
    /// subscribing to general
    await FirebaseMessaging.instance.subscribeToTopic('general');
  }

  /// void _listenToFCMTokenRefresh() {
  ///   UserCubit userCubit = BlocProvider.of<UserCubit>(context, listen: false);
  ///   if (userCubit.loggedIn) {
  ///     userCubit.sendInitialDeviceInfo();
  ///     FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
  ///       userCubit.sendDeviceInfo(fcmToken: fcmToken);
  ///     }).onError((err) {
  ///       debugPrint("error: {$err}");
  ///     });
  ///   }
  /// }

  @override
  Widget build(BuildContext context) {
    return const _App();
  }
}

class _App extends StatefulWidget {
  const _App();
  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  final AppTheme _appTheme = AppTheme();
  final AppParser _appParser = AppParser();
  final ConfigUtils _config = ConfigUtils();
  @override
  Widget build(BuildContext context) {
    final LangCubit langCubit = BlocProvider.of<LangCubit>(context, listen: true);
    final RouterCubit routerCubit = BlocProvider.of<RouterCubit>(context, listen: false);
    return DevicePreview(
      enabled: false,
      builder: (context) => Sizer(
        builder: (context, orientation, deviceType) => MaterialApp.router(
          /// App title
          title: _config.appTitle,
          debugShowCheckedModeBanner: false,
          theme: _appTheme.themeData,
          locale: langCubit.state.locale,
          routerDelegate: routerCubit.state,
          routeInformationParser: _appParser,
          supportedLocales: _config.appLangs.map((l) => l.locale).toList(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) => child!,
        ),
      ),
    );
  }
}
