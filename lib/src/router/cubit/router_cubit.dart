import '../../config/index.dart';

class RouterCubit extends Cubit<AppRouterDelegate> {
  RouterCubit({required AppRouterDelegate delegate}) : super(delegate);

  final PageConfigurations _configurations = PageConfigurations();

  void popRoute() {
    state.popRoute();
  }

  void resetRouter() {
    state.setNewRoutePath(_configurations.splashPageConfig);
  }

  void launchHome() {
    state.setNewRoutePath(_configurations.homePageConfig);
  }

  void launchClientHome() {
    state.addPage(state.createMaterialPage(_configurations.clientHomePageConfig, null));
  }

  void launchAdminHome() {
    state.addPage(state.createMaterialPage(_configurations.adminHomePageConfig, null));
  }

  void launchNotifications() {
    state.addPage(state.createMaterialPage(_configurations.notificationsPageConfig, null));
  }

  void launchLogin() {
    state.addPage(state.createMaterialPage(_configurations.loginPageConfig, null));
  }

  void launchSignup() {
    state.addPage(state.createMaterialPage(_configurations.signupPageConfig, null));
  }

  void launchChat() {
    state.addPage(state.createMaterialPage(_configurations.chatPageConfig, null));
  }

  /// deep links
  void deepLinkParser({required Uri? uri}) {
    /// if link is null return splash
    if (uri == null) {
      state.setNewRoutePath(_configurations.splashPageConfig);
      return;
    }

    /// if link has no segments, return splash
    if (uri.pathSegments.isEmpty) {
      state.setNewRoutePath(_configurations.splashPageConfig);
      return;
    }
    switch (uri.pathSegments[0]) {
      case ClientHomePage.path:
        state.setNewRoutePath(_configurations.homePageConfig);
        break;
      default:
        state.setNewRoutePath(_configurations.splashPageConfig);
        break;
    }
  }
}