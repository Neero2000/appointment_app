import '../../config/index.dart';

/// This delegate is the core piece of the [Router] widget.
/// It responds to push route and pop route intents from the engine and notifies the [Router] to rebuild.
/// It also acts as a builder for the [Router] widget and builds a navigating widget,
/// typically a [Navigator], when the [Router] widget builds.
class AppRouterDelegate extends RouterDelegate<PageConfiguration> with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  /// pages
  final List<Page> _pages = [];

  /// The state for a [Navigator] widget.
  @override
  late GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  AppRouterDelegate();

  //// Getter for a list that cannot be changed
  List<MaterialPage> get pages => List.unmodifiable(_pages);

  //// Number of pages function
  int numPages() => _pages.length;

  bool get canPop => _pages.length > 1;

  /// navigator on pop page
  bool _onPopPage(Route<dynamic> route, result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (canPop) {
      _removePage(_pages.last);
      return true;
    } else {
      return false;
    }
  }

  /// create material page
  MaterialPage createMaterialPage(PageConfiguration pageConfig, Object? arguments) {
    return MaterialPage(
      child: pageConfig.child,
      name: pageConfig.path,
      arguments: arguments,
    );
  }

  void _createPage(PageConfiguration configuration, Object? arguments) {
    addPage(createMaterialPage(configuration, arguments));
  }

  /// add page
  void addPage(Page page) {
    _pages.add(page);
    notifyListeners();
  }

  /// remove page
  void _removePage(Page? page) {
    if (page != null && _pages.contains(page)) {
      _pages.remove(page);
    }
  }

  /// Called by the [Router] when the [Router.routeInformationProvider]
  /// reports that a new route has been pushed to the application by the operating system.
  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    _pages.clear();
    _createPage(configuration, null);
    return SynchronousFuture(null);
  }

  /// Called by the [Router] when the [Router.backButtonDispatcher] reports that the operating system
  ///  is requesting that the current route be popped.
  @override
  Future<bool> popRoute() async {
    if (canPop) {
      _removePage(_pages.last);
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }

  /// Creates a widget that maintains a stack-based history of child widgets.
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: List.of(_pages),
    );
  }
}
