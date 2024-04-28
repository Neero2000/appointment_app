import '../../config/index.dart';

/// This delegate is used when the [Router] widget is first built with initial route information
///from [Router.routeInformationProvider] and any subsequent new route notifications from it.
///The [Router] widget calls the [parseRouteInformation] with the route information from [Router.routeInformationProvider].
class AppParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.uri.path);
    final PageConfigurations pages = PageConfigurations();
    if (uri.pathSegments.isEmpty) {
      return pages.splashPageConfig;
    }

    final path = uri.pathSegments[0];
    switch (path) {
      case SplashPage.path:
        return pages.splashPageConfig;
      case HomePage.path:
        return pages.homePageConfig;
      case ClientHomePage.path:
        return pages.clientHomePageConfig;
      case AdminHomePage.path:
        return pages.adminHomePageConfig;
      case NotificationsPage.path:
        return pages.notificationsPageConfig;
      case LoginPage.path:
        return pages.loginPageConfig;
      case SignupPage.path:
        return pages.signupPageConfig;
      case ChatPage.path:
        return pages.chatPageConfig;
      default:
        return pages.splashPageConfig;
    }
  }

  /// Restore the route information from the given configuration.
  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    switch (configuration.page) {
      case Pages.splash:
        return RouteInformation(uri: Uri.parse(SplashPage.path));
      case Pages.home:
        return RouteInformation(uri: Uri.parse(ClientHomePage.path));
      case Pages.clientHome:
        return RouteInformation(uri: Uri.parse(ClientHomePage.path));
      case Pages.adminHome:
        return RouteInformation(uri: Uri.parse(AdminHomePage.path));
      case Pages.notifications:
        return RouteInformation(uri: Uri.parse(NotificationsPage.path));
      case Pages.login:
        return RouteInformation(uri: Uri.parse(LoginPage.path));
      case Pages.signup:
        return RouteInformation(uri: Uri.parse(SignupPage.path));
      case Pages.chat:
        return RouteInformation(uri: Uri.parse(ChatPage.path));
      default:
        return RouteInformation(uri: Uri.parse(SplashPage.path));
    }
  }
}
