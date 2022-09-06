import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App_Localization {
  final Locale locale;

  App_Localization(this.locale);

  static const App_Localization_delegate delegate=App_Localization_delegate();

  static App_Localization of(BuildContext context){
    return Localizations.of<App_Localization>(context, App_Localization)!;
  }

  Map<String,String>? _localizationString;

  Future<bool> load() async{
    String jsonString=await rootBundle.loadString("languages/${locale.languageCode}.json");
    Map<String,dynamic> jsonMap= json.decode(jsonString);
    _localizationString=jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }
  String translate(String key){
    return _localizationString![key]!;
  }

}

class App_Localization_delegate extends LocalizationsDelegate<App_Localization>{

  const App_Localization_delegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<App_Localization> load(Locale locale) async{
    App_Localization appLocalization = App_Localization(locale);
    await appLocalization.load();
    return appLocalization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<App_Localization> old) {
    return false;
  }

}