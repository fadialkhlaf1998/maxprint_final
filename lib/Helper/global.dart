import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Model/Customer.dart';
import 'package:maxprint_final/Model/user.dart';
import 'package:maxprint_final/Model/SaveInformation.dart';
import 'package:maxprint_final/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Global {
  static String languageCode = "en";
  static Customer? customer;
  static User? user;

  static Future<String> loadLanguage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String lang = prefs.getString("language") ?? 'default';
      if (lang != "default") {
        languageCode = lang;
      }
      else {
        languageCode = "en";
      }
      Get.updateLocale(Locale(languageCode));
      return languageCode;
    }
    catch (e) {
      return "en";
    }
  }

  static saveLanguage(BuildContext context, String lang) {
    SharedPreferences.getInstance().then((preference) {
      preference.setString("language", lang);
      languageCode = lang;
      MyApp.set_locale(context, Locale(lang));
      Get.updateLocale(Locale(lang));
    });
  }

  static saveInfo(String email, String password) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("email", email);
      prefs.setString("pass", password);
    });
  }

  static Future<SaveInformation> loadInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email") ?? "non";
    String pass = prefs.getString("pass") ?? "non";
    return SaveInformation(email, pass);
  }

  static logout() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove("email");
      prefs.remove("pass");
      Global.user = null;
    });
  }

  static void launchURL(BuildContext context, String url) async {
    if (!await launch(url)) {
      AppWidget.errorMsg(
          context, App_Localization.of(context).translate("something_wrong"));
    }
  }


}
