import '../../config/index.dart';

class AppLangModel {
  late String langCode;
  late String countryCode;
  late String langTitle;
  late Locale locale;
  late String assetPath;

  AppLangModel({
    required this.langCode,
    required this.countryCode,
    required this.langTitle,
    required this.locale,
    required this.assetPath,
  });
}
