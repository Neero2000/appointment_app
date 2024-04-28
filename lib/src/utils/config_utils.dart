import '../config/index.dart';

class ConfigUtils {
  static final ConfigUtils _instance = ConfigUtils._internal();
  factory ConfigUtils() => _instance;
  ConfigUtils._internal();

  //* General Config *//

  // title of the app
  final String appTitle = 'Logo Quiz';

  // deep link prefix (ex: deeplinks://logoquiz)
  final String deepLinksPrefix = "logoquiz";

  /// list of app langugages (add or remove language configuration)
  final List<AppLangModel> appLangs = [
    AppLangModel(
      langCode: "en",
      countryCode: "us",
      langTitle: "English",
      locale: const Locale("en"),
      assetPath: 'assets/images/flags_icons/us.svg',
    ),
    AppLangModel(
      langCode: "fr",
      countryCode: "fr",
      langTitle: "Français",
      locale: const Locale("fr"),
      assetPath: 'assets/images/flags_icons/fr.svg',
    ),
  ];
}
