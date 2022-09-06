import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/View/home.dart';
import 'package:maxprint_final/View/signIn.dart';
import 'package:maxprint_final/View/signUp.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
              ),
              Container(
                child: SvgPicture.asset("assets/logo/logo.svg", width: 50, height: 50,),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.offAll(() => Home());
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(20),
                                border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
                            ),
                            child: Center(
                              child: AppWidget.appText(App_Localization.of(context).translate("continue"),
                                  Colors.black, 15, FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SignUp());
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 35,
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
                              ),
                              child: Center(
                                child: AppWidget.appText(App_Localization.of(context).translate("sign_up"),
                                    Colors.black, 15, FontWeight.bold),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SignIn());
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 35,
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
                              ),
                              child: Center(
                                child: AppWidget.appText(App_Localization.of(context).translate("sign_in"),
                                    Colors.black, 15, FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
