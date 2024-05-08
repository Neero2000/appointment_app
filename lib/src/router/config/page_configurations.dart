import '../../config/index.dart';

class PageConfigurations {
  /// this class is a singleton and only have 1 instance
  static final PageConfigurations _instance = PageConfigurations._internal();
  factory PageConfigurations() => _instance;
  PageConfigurations._internal();

  /// here we define all the page configurations
  PageConfiguration signupdoc = const PageConfiguration(
    path: SignupPageDoc.path,
    page: Pages.signupdoc,
    child: SignupPageDoc(),
  );
  PageConfiguration splashPageConfig = const PageConfiguration(
    path: SplashPage.path,
    page: Pages.splash,
    child: SplashPage(),
  );
  PageConfiguration homePageConfig = const PageConfiguration(
    path: HomePage.path,
    page: Pages.home,
    child: HomePage(),
  );
  PageConfiguration notificationsPageConfig = const PageConfiguration(
    path: NotificationsPage.path,
    page: Pages.notifications,
    child: NotificationsPage(),
  );
  PageConfiguration loginPageConfig = const PageConfiguration(
    path: LoginPage.path,
    page: Pages.login,
    child: LoginPage(),
  );
  PageConfiguration signupPageConfig = const PageConfiguration(
    path: SignupPage.path,
    page: Pages.signup,
    child: SignupPage(),
  );
  PageConfiguration chatPageConfig = const PageConfiguration(
    path: ChatPage.path,
    page: Pages.chat,
    child: ChatPage(),
  );
  PageConfiguration doctorDetailsPageConfig = const PageConfiguration(
    path: DoctorDetailsPage.path,
    page: Pages.doctorDetails,
    child: DoctorDetailsPage(),
  );
  PageConfiguration bookingPageConfig = const PageConfiguration(
    path: BookingPage.path,
    page: Pages.booking,
    child: BookingPage(),
  );
  PageConfiguration paymentPageConfig = const PageConfiguration(
    path: PaymentPage.path,
    page: Pages.payment,
    child: PaymentPage(),
  );
  PageConfiguration appointmentBookedPageConfig = const PageConfiguration(
    path: AppointmentBookedPage.path,
    page: Pages.appointmentBooked,
    child: AppointmentBookedPage(),
  );
  PageConfiguration channelPageConfig = const PageConfiguration(
    path: ChannelPage.path,
    page: Pages.channel,
    child: ChannelPage(),
  );
}
