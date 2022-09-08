import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/signInController.dart';
import 'package:maxprint_final/Controller/signUpController.dart';
import 'package:maxprint_final/View/signUp.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  SignInController signInController = Get.put(SignInController());
  SignUpController signUpController = Get.put(SignUpController());

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
                      Container(
                        width: MediaQuery.of(context).size.width ,
                        height: MediaQuery.of(context).size.height * 0.5,
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/Character.png')
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                signInController.loading.value ?
                Positioned(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: AppColors.secondaryColor,
                      child: Center(
                       child: CircularProgressIndicator(color: AppColors.mainColor),
                    ),
                  )
                )
                    : const Center()
              ],
            ),
          ),
        ))
    );
  }


  _frontFace(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height  * 0.85,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50)
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              AppWidget.appText(App_Localization.of(context).translate("please_fill_information_below"),
                  Colors.black, 15, FontWeight.bold),
              const SizedBox(height: 5),
              const Icon(Icons.arrow_downward_sharp),
              const SizedBox(height: 5),
              AppWidget.registrationTextField(signInController.email,"email_address",context,validate: signInController.emailValidate.value),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 45,
                child: TextField(
                  controller: signInController.password,
                  obscureText: signInController.hidePassword.value,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    hintText: App_Localization.of(context).translate("password"),
                    hintStyle: const TextStyle(color:Colors.black, fontSize: 15),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: signInController.passValidate.value ? Colors.grey:Colors.red)),
                    focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: signInController.passValidate.value ? Colors.black:Colors.red)),
                    suffixIcon: InkWell(
                      onTap: signInController.hideVisibility,
                      child: Icon(
                        signInController.hidePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: (){
                  signInController.signIn(context,signInController.email.text,signInController.password.text);
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.7))
                    ),
                    child: Center(
                      child: AppWidget.appText(
                          App_Localization.of(context).translate("sign_in"),
                          Colors.black, 18, FontWeight.bold),
                    )
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppWidget.appText(App_Localization.of(context).translate("new_customer") + "?",
                      Colors.black, 15, FontWeight.normal),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
                      Get.off(() => SignUp());
                      signUpController.clearTextFields();
                    },
                    child: AppWidget.appText(App_Localization.of(context).translate("sign_up"),
                        Colors.black, 15, FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


  _header(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          border: Border.all(width: 1,color: Colors.grey.withOpacity(0.7))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppWidget.appText(
                App_Localization.of(context).translate("sign_in"),
                Colors.black, 25, FontWeight.bold),
          ],
        )
    );
  }
  _body(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              AppWidget.appText(App_Localization.of(context).translate("please_fill_information_below"),
                  Colors.black, 15, FontWeight.bold),
              const SizedBox(height: 5),
              const Icon(Icons.arrow_downward_sharp),
              const SizedBox(height: 5),
              AppWidget.registrationTextField(signInController.email,"email_address",context,validate: signInController.emailValidate.value),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 45,
                child: TextField(
                  controller: signInController.password,
                  obscureText: signInController.hidePassword.value,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    hintText: App_Localization.of(context).translate("password"),
                    hintStyle: const TextStyle(color:Colors.black, fontSize: 15),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: signInController.passValidate.value ? Colors.grey:Colors.red)),
                    focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: signInController.passValidate.value ? Colors.black:Colors.red)),
                    suffixIcon: InkWell(
                      onTap: signInController.hideVisibility,
                      child: Icon(
                        signInController.hidePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: (){
                  signInController.signIn(context,signInController.email.text,signInController.password.text);
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.grey.withOpacity(0.7))
                    ),
                    child: Center(
                      child: AppWidget.appText(
                          App_Localization.of(context).translate("sign_in"),
                          Colors.black, 18, FontWeight.bold),
                    )
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppWidget.appText(App_Localization.of(context).translate("new_customer") + "?",
                      Colors.black, 15, FontWeight.normal),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
                      Get.off(() => SignUp());
                      signUpController.clearTextFields();
                    },
                    child: AppWidget.appText(App_Localization.of(context).translate("sign_up"),
                        Colors.black, 15, FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

}
