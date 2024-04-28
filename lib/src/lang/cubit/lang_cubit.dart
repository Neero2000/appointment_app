import '../../config/index.dart';

class LangCubit extends Cubit<AppLangModel> {
  /// init cubit with list of supported app langs
  final List<AppLangModel> langs;

  /// default lang is the first one
  LangCubit({required this.langs}) : super(langs[0]);

  /// shared prefs key to same app lang code
  final String _appLangKey = "appLangKey";

  /// init function used to get the saved locale from shared prefs
  void init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String langCode = prefs.getString(_appLangKey) ?? langs[0].langCode;
    emit(langs.firstWhere((e) => e.langCode == langCode));
  }

  /// function used to update the app lang
  void setAppLang({required String langCode}) async {
    if (state.langCode != langCode) {
      emit(langs.firstWhere((element) => element.langCode == langCode));
      await _saveAppLang();
    }
  }

  /// handles saving new applang to shared prefs
  Future<void> _saveAppLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_appLangKey, state.langCode);
  }
}
