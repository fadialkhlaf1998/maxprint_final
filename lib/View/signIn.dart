import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/signInController.dart';
import 'package:maxprint_final/Controller/signUpController.dart';
import 'package:maxprint_final/View/home.dart';
import 'package:maxprint_final/View/signUp.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  SignInController signInController = Get.put(SignInController());
  SignUpController signUpController = Get.put(SignUpController());

  Widget _flightShuttleBuilder(
      BuildContext flightContext,
      Animation<double> animation,
      HeroFlightDirection flightDirection,
      BuildContext fromHeroContext,
      BuildContext toHeroContext,
      ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
       const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark
    ));
    return Obx((){
      return Scaffold(
        body:SingleChildScrollView(
          child: Container(
            color: AppColors.secondaryColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SvgPicture.asset('assets/images/background1.svg',fit: BoxFit.cover,),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 50,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _logo(),
                        const SizedBox(height: 30),
                        _inputTextField(context),
                      ],
                    ),
                    customButton(
                        context,
                        0.4,
                        60,
                        App_Localization.of(context).translate('continue'),
                        Colors.transparent,
                        BorderRadius.zero,
                        13,
                        Colors.black,
                        FontWeight.normal,
                            () {
                              signInController.continueAsGuest();
                            }),
                  ],
                ),
                signInController.loading.value ?
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white.withOpacity(0.4),
                  child: Center(
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Lottie.asset('assets/animation/Loading.json'),
                    ),
                  ),
                ) : const Text('')
              ],
            ),
          ),
        ),
      );
    });
  }

  _logo(){
    return Hero(
      tag: 'logo',
      child: Container(
        key: const ValueKey('2'),
        child: SvgPicture.asset("assets/logo/logo.svg",
          width: 50,
          height: 50,
        ),
      ),
    );
  }

  _inputTextField(context){
    return Column(
      children: [
        Text(
            App_Localization.of(context).translate('sign_in'),
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 40),
        customTextField(context,'email',signInController.email, false, 'email', false),
        const SizedBox(height: 10),
        customTextField(context,'lock',signInController.password, signInController.hidePassword.value, 'password', true),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: (){

          },
          child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                App_Localization.of(context).translate('forget_password'),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Hero(
          flightShuttleBuilder: _flightShuttleBuilder,

          tag: 'singInButton',
          child: customButton(
            context,
            0.5,
            45,
            App_Localization.of(context).translate('sign_in'),
            Colors.black,
            BorderRadius.circular(10),
            16,
            AppColors.mainColor,
            FontWeight.bold,
                (){
              signInController.signIn(context, signInController.email.text, signInController.password.text);
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text(
                App_Localization.of(context).translate('or'),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black
              ),
            ),
          ),
        ),
        customButton(
            context,
            0.5,
            20,
            App_Localization.of(context).translate('new_user_sign_up_here'),
            Colors.transparent,
            BorderRadius.circular(10),
            13,
            Colors.black,
            FontWeight.normal,
            (){
            Get.offNamed('/signUp');
            }
            ),
      ],
    );
  }

  customTextField(context, String icon, TextEditingController controller, bool obscure,String text, bool password){
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.12,
            height: 50,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10)
              ),
            ),
            child: Image.asset('assets/icons/$icon.png'),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.68,
            height: 50,
            padding: const EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              )
            ),
            child:TextField(
                controller: controller,
                obscureText: obscure,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  // contentPadding: const EdgeInsets.only(left: 5),
                  hintText: App_Localization.of(context).translate(text),
                  hintStyle: TextStyle(color:Colors.black.withOpacity(0.8), fontSize: 14),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  suffixIcon: password ? InkWell(
                    onTap: signInController.hideVisibility,
                    child: Icon(
                      signInController.hidePassword.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ) : null,
                ),
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
          ),
        ],
      ),
    );
  }

  customButton(context, double width, double height, String text, Color boxColor, BorderRadius radius, double fontSize, Color textColor, FontWeight fontWeight, VoidCallback onTap){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: radius,
            color: boxColor
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontWeight: fontWeight
            ),
          ),
        ),
      ),
    );
  }

  // Container(
  //   width: MediaQuery.of(context).size.width ,
  //   height: MediaQuery.of(context).size.height * 0.5,
  //   margin: const EdgeInsets.symmetric(horizontal: 60),
  //   decoration: const BoxDecoration(
  //     image: DecorationImage(
  //       image: AssetImage('assets/images/Character.png')
  //     )
  //   ),
  // ),
  // AppWidget.registrationTextField(signInController.email,"email_address",context,validate: signInController.emailValidate.value),
  // SizedBox(
  //   width: MediaQuery.of(context).size.width * 0.8,
  //   height: 45,
  //   child: TextField(
  //     controller: signInController.password,
  //     obscureText: signInController.hidePassword.value,
  //     decoration: InputDecoration(
  //       contentPadding: const EdgeInsets.all(5),
  //       hintText: App_Localization.of(context).translate("password"),
  //       hintStyle: const TextStyle(color:Colors.black, fontSize: 15),
  //       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: signInController.passValidate.value ? Colors.grey:Colors.red)),
  //       focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: signInController.passValidate.value ? Colors.black:Colors.red)),
  //       suffixIcon: InkWell(
  //         onTap: signInController.hideVisibility,
  //         child: Icon(
  //           signInController.hidePassword.value
  //               ? Icons.visibility_off
  //               : Icons.visibility,
  //           color: Colors.grey,
  //           size: 20,
  //         ),
  //       ),
  //     ),
  //     style: const TextStyle(color: Colors.black, fontSize: 15),
  //   ),
  // ),
  // Column(
  //   children: [
  //     GestureDetector(
  //       onTap: (){
  //         signInController.signIn(context,signInController.email.text,signInController.password.text);
  //       },
  //       child: Container(
  //           width: MediaQuery.of(context).size.width * 0.5,
  //           height: 40,
  //           decoration: BoxDecoration(
  //               color: AppColors.mainColor,
  //               borderRadius: BorderRadius.circular(20),
  //               border: Border.all(width: 1, color: Colors.grey.withOpacity(0.7))
  //           ),
  //           child: Center(
  //             child: AppWidget.appText(
  //                 App_Localization.of(context).translate("sign_in"),
  //                 Colors.black, 18, FontWeight.bold),
  //           )
  //       ),
  //     ),
  //     const SizedBox(height: 15),
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         AppWidget.appText(App_Localization.of(context).translate("new_customer") + "?",
  //             Colors.black, 15, FontWeight.normal),
  //         const SizedBox(width: 5,),
  //         GestureDetector(
  //           onTap: (){
  //             Get.off(() => SignUp());
  //             signUpController.clearTextFields();
  //           },
  //           child: AppWidget.appText(App_Localization.of(context).translate("sign_up"),
  //               Colors.black, 15, FontWeight.bold),
  //         ),
  //       ],
  //     ),
  //   ],
  // ),

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
