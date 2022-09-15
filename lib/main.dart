import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Controller/cartController.dart';
import 'package:maxprint_final/Controller/productViewController.dart';
import 'package:maxprint_final/Controller/wishlistController.dart';
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/View/introduction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void set_locale(BuildContext context , Locale locale){
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.set_locale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  WishlistController wishlistController = Get.put(WishlistController());
  CartController cartController = Get.put(CartController());
  ProductViewController productViewController = Get.put(ProductViewController());

  Locale? _locale;

  void set_locale(Locale locale){
    setState(() {
      _locale=locale;
    });
  }

  @override
  void initState() {
    super.initState();
    wishlistController.loadWishlist();
    cartController.loadCart();
    productViewController.loadRecently().then((rec) {
      productViewController.recently = rec.obs;
    });
    Global.loadLanguage().then((language) {
      setState(() {
        _locale= Locale(language);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'maxprint_final',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        /// todo
          primarySwatch: generateMaterialColor( Colors.black),//const Color(0xffd9fe00)),

      ),
      locale: _locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', '')
      ],
      localizationsDelegates: const [
        App_Localization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (local, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == local!.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: const Introduction()
    );
  }

  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));
}

