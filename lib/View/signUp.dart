import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/signInController.dart';
import 'package:maxprint_final/Controller/signUpController.dart';
import 'package:maxprint_final/View/signIn.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  SignUpController signUpController = Get.put(SignUpController());
  SignInController signInController = Get.put(SignInController());

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
      return  Scaffold(
        body: SingleChildScrollView(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _logo(),
                    const SizedBox(height: 30),
                    _inputTextField(context),
                  ],
                ),
                signUpController.loading.value ?
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

  _inputTextField(context){
    return Column(
      children: [
        Text(
          App_Localization.of(context).translate('sign_up'),
          style: const TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 40),
        customTextField(context,signUpController.firstName, false, 'first_name', false),
        const SizedBox(height: 10),
        customTextField(context,signUpController.lastName, false, 'last_name', false),
        const SizedBox(height: 10),
        customTextField(context,signUpController.email, false, 'email', false),
        const SizedBox(height: 10),
        customTextField(context,signUpController.password, signUpController.hidePassword.value, 'password', true, false),
        const SizedBox(height: 10),
        customTextField(context,signUpController.confirmPassword, signUpController.hideConfirmPassword.value, 'conf_pass', true, true),
        const SizedBox(height: 30),
       Hero(
         flightShuttleBuilder: _flightShuttleBuilder,
         tag: 'singInButton',
         child:  customButton(context, 0.5, 45, App_Localization.of(context).translate('create_my_account'),
             Colors.black, BorderRadius.circular(10), 16, AppColors.mainColor, FontWeight.bold,
                 () {
            signUpController.signUp(context, signUpController.firstName.text, signUpController.lastName.text, signUpController.email.text, signUpController.password.text);
             }),
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
            App_Localization.of(context).translate('already_have_account'),
            Colors.transparent,
            BorderRadius.circular(10),
            13,
            Colors.black,
            FontWeight.normal,
                (){
              Get.offNamed('/signIn');
            }
        ),
      ],
    );

  }




  customTextField(context, TextEditingController controller, bool obscure,String text, bool password, [bool? confirmPassword]){
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      padding: const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10)
      ),
      child:TextField(
        controller: controller,
        obscureText: obscure,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: App_Localization.of(context).translate(text),
          hintStyle: TextStyle(color:Colors.black.withOpacity(0.8), fontSize: 14),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon: password ? InkWell(
            onTap: confirmPassword! ? signUpController.hideConfirmVisibility  : signUpController.hideVisibility,
            child: confirmPassword ?
                Icon(
                  signUpController.hideConfirmPassword.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey,
                  size: 20,
                )
                : Icon(
              signUpController.hidePassword.value
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.grey,
              size: 20,
            ),
          ) : null,
        ),
        style: const TextStyle(color: Colors.black, fontSize: 15),
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
          border: Border.all(width: 1, color: Colors.grey.withOpacity(0.7))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppWidget.appText(
                App_Localization.of(context).translate("sign_up"),
                Colors.black, 25, FontWeight.bold),
          ],
        )
    );
  }



  _body(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              AppWidget.appText(App_Localization.of(context).translate("please_fill_information_below"),
                  Colors.black, 15, FontWeight.bold),
              const SizedBox(height: 5),
              const Icon(Icons.arrow_downward_sharp),
              const SizedBox(height: 5),
              AppWidget.registrationTextField(signUpController.firstName,"first_name",context,validate: signUpController.firstNameValidate.value),
              const SizedBox(height: 10),
              AppWidget.registrationTextField(signUpController.lastName,"last_name",context,validate: signUpController.firstNameValidate.value),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 45,
                child: TextField(
                    controller: signUpController.phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5),
                        hintText: App_Localization.of(context).translate('phone'),
                        hintStyle: const TextStyle(color:Colors.black, fontSize: 15),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
                    ),
                    style: AppWidget.textFieldStyle(Colors.black, 15)
                ),
              ),
              const SizedBox(height: 10),
              AppWidget.registrationTextField(signUpController.email,"email_address",context,validate: signUpController.firstNameValidate.value),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 45,
                child: TextField(
                  controller: signUpController.password,
                  obscureText: signUpController.hidePassword.value,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    hintText: App_Localization.of(context).translate("password"),
                    hintStyle: const TextStyle(color:Colors.black, fontSize: 15),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: signUpController.passValidate.value ? Colors.grey:Colors.red)),
                    focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: signUpController.passValidate.value ? Colors.black:Colors.red)),
                    suffixIcon: InkWell(
                      onTap: signUpController.hideVisibility,
                      child: Icon(
                        signUpController.hidePassword.value
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
                  signUpController.signUp(context, signUpController.firstName.text, signUpController.lastName.text, signUpController.email.text, signUpController.password.text);
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
                          App_Localization.of(context).translate("sign_up"),
                          Colors.black, 18, FontWeight.bold),
                    )
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppWidget.appText(App_Localization.of(context).translate("have_account") + "?",
                      Colors.black, 15, FontWeight.normal),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
                      Get.off(() => SignIn());
                      signInController.clearTextField();
                    },
                    child: AppWidget.appText(App_Localization.of(context).translate("sign_in"),
                        Colors.black, 15, FontWeight.bold),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

}
