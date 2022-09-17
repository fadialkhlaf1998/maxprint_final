import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/profileController.dart';
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/View/address.dart';
import 'package:maxprint_final/View/drawer/languages.dart';
import 'package:maxprint_final/View/signIn.dart';
import 'package:maxprint_final/View/signUp.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Obx(() => SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.secondaryColor,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    _header(context),
                    const SizedBox(height: 20),
                    Global.user == null ?
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppWidget.appText(App_Localization.of(context).translate("please_login_first"), Colors.black, 18, FontWeight.normal),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Get.to(()=>SignUp());
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.3,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))

                                  ),
                                  child: Center(
                                    child: AppWidget.appText(App_Localization.of(context).translate("sign_up"), Colors.black, 15, FontWeight.normal),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              AppWidget.appText(App_Localization.of(context).translate("or"), Colors.black, 18, FontWeight.bold),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: (){
                                  Get.to(()=>SignIn());
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.3,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
                                  ),
                                  child: Center(
                                    child: AppWidget.appText(App_Localization.of(context).translate("sign_in"), Colors.black, 15, FontWeight.normal),
                                  ),
                                ),
                              )
                            ],
                          )

                        ],
                      ),
                    ) :
                    _body(context)
                  ],
                ),
              ),
              profileController.loading.value ?
              Positioned(child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: AppColors.secondaryColor,
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.mainColor),
                ),
              )) : const Center()
            ],
          )

        ),
      ))
    );
  }

  _header(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                // border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 0,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppWidget.appText(
                    App_Localization.of(context).translate("profile"),
                    Colors.black, 20, FontWeight.bold),
              ],
            )
        ),
      ],
    );
  }
  _body(BuildContext context) {
    return Column(
      children: [
        _personal_information(context),
        const SizedBox(height: 20),
        _language_address(context),
        const SizedBox(height: 20),
        _change_password(context),
      ],
    );
  }
  _personal_information(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey)
      ),
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppWidget.appText(
                      App_Localization.of(context).translate("personal_info")+ ":",
                      Colors.black, 16, FontWeight.normal),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppWidget.appText(
                      App_Localization.of(context).translate("name") + ":",
                      Colors.black, 14, FontWeight.normal),
                  const SizedBox(width: 5),
                  AppWidget.appText(
                      Global.user!.firstName + " " + Global.user!.lastName,
                      Colors.grey, 14, FontWeight.normal),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppWidget.appText(
                      App_Localization.of(context).translate("email") + ":",
                      Colors.black, 14, FontWeight.normal),
                  const SizedBox(width: 5),
                  AppWidget.appText(
                      Global.user!.email,
                      Colors.grey, 14, FontWeight.normal),
                ],
              ),
            ],
          )
      ),
    );
  }
  _language_address(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(()=> Languages());
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppWidget.appText(
                        App_Localization.of(context).translate("change_lang"),
                        Colors.black, 15, FontWeight.normal),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(()=> Address());
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppWidget.appText(
                        App_Localization.of(context).translate("address"),
                        Colors.black, 15, FontWeight.normal),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  _change_password(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap:(){
            if(profileController.open.value){
              // profileController.open.value = false;
              profileController.changePass(context,profileController.newPassword.text, profileController.confNewPassword.text,Global.customer!);
            }else{
              profileController.open.value=true;
            }
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: MediaQuery.of(context).size.width * 0.5,
            // height: 40,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: profileController.open.value ? AppColors.mainColor : AppColors.secondaryColor,
                border: Border.all(color:Colors.grey),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppWidget.appText(
                    App_Localization.of(context).translate("change_pass"),
                    Colors.black, 15, FontWeight.normal),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn,
          width:MediaQuery.of(context).size.width * 0.8,
          height: profileController.open.value ? 100 : 0,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppWidget.textField(profileController.newPassword, "new_pass", context,validate: profileController.validateNewPass.value),
                AppWidget.textField(profileController.confNewPassword, "conf_pass", context,validate: profileController.validateConfNewPass.value),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: profileController.open.value
          ? GestureDetector(
             onTap: (){
               profileController.open.value = false;
             },
              child: Icon(Icons.clear, key: ValueKey(1)))
              : Icon(Icons.clear, size: 0, key: ValueKey(2))
        )
      ],
    );
  }

}
