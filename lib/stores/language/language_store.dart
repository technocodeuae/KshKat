import 'package:erp/data/repo/repository.dart';
import 'package:erp/models/language/Language.dart';
import 'package:erp/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'language_store.g.dart';

class LanguageStore = _LanguageStore with _$LanguageStore;

abstract class _LanguageStore with Store {
  static const String TAG = "LanguageStore";

  // repository instance
  final Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // supported languages
  List<Language> supportedLanguages = [
    Language(code: 'US', locale: 'en', language: 'English'),
    Language(code: '', locale: 'ar', language: 'Arabic'),
    Language(code: 'DE', locale: 'de', language: 'Germany'),
  ];

  // constructor:---------------------------------------------------------------
  _LanguageStore(Repository repository)
      : this._repository = repository {
    init();
  }

  // store variables:-----------------------------------------------------------
  @observable
  String _locale = "en";

  @computed
  String get locale => _locale;

  // actions:-------------------------------------------------------------------
  @action
  void changeLanguage(String value) {
    _locale = value;
    _repository.changeLanguage(value).then((_) {
      // write additional logic here
    });
  }

  @action
  String getCode() {
    var code;

    if (_locale == 'en') {
      code = "en";
    } else if (_locale == 'ar') {
      code = "ar";
    } else if (_locale == 'de') {
      code = "DE";
    }

    return code;
  }

  @action
  String? getLanguage() {
    return supportedLanguages[supportedLanguages
            .indexWhere((language) => language.locale == _locale)]
        .language;
  }

  // general:-------------------------------------------------------------------
  void init() async {
    // getting current language from shared preference
    if(_repository.currentLanguage != null) {
      _locale = _repository.currentLanguage!;
    }
  }

  // dispose:-------------------------------------------------------------------
  @override
  dispose() {}

}
