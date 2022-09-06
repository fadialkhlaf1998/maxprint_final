import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.mainColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.perm_scan_wifi,color: AppColors.secondaryColor,size: 100),
              const SizedBox(height: 5),
              AppWidget.appText(
                  App_Localization.of(context).translate("no_internet"),
                  AppColors.secondaryColor, 25, FontWeight.bold),
              const SizedBox(height: 30),
              Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.secondaryColor
                  ),
                  child: Center(
                    child: AppWidget.appText(
                        App_Localization.of(context).translate("try_again"),
                        AppColors.mainColor, 18, FontWeight.normal),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}


