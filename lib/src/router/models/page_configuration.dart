import '../../config/index.dart';

class PageConfiguration {
  final String path;
  final Pages page;
  final Widget child;

  const PageConfiguration({
    required this.path,
    required this.page,
    required this.child,
  });
}
