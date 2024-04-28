import '../../config/index.dart';

class PageConfigurations {
  /// this class is a singleton and only have 1 instance
  static final PageConfigurations _instance = PageConfigurations._internal();
  factory PageConfigurations() => _instance;
  PageConfigurations._internal();

  /// here we define all the page configurations
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
  PageConfiguration clientHomePageConfig = const PageConfiguration(
    path: ClientHomePage.path,
    page: Pages.clientHome,
    child: ClientHomePage(),
  );
  PageConfiguration adminHomePageConfig = const PageConfiguration(
    path: AdminHomePage.path,
    page: Pages.adminHome,
    child: AdminHomePage(),
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
}
