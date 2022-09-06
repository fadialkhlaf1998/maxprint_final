import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Api/connector.dart';
import 'package:maxprint_final/Api/new_api.dart';
import 'package:maxprint_final/Api/registrationApi.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/View/home.dart';
import 'package:maxprint_final/View/noInternet.dart';

class SignInController extends GetxController {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var emailValidate = true.obs;
  var passValidate = true.obs;
  var hidePassword = true.obs;
  var loading = false.obs;

  clearTextField(){
    email.clear();
    password.clear();
    emailValidate = true.obs;
    passValidate = true.obs;
  }

  void hideVisibility(){
    hidePassword.value = !hidePassword.value;
  }

  signIn(BuildContext context, String email, String pass){
    try{
      if(email.isEmpty||pass.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(email)){
        if(email.isEmpty||!RegExp(r'\S+@\S+\.\S+').hasMatch(email)){
          emailValidate.value=false;
        }
        if(pass.isEmpty){
          passValidate.value=false;
        }
      }else{
        Connector.check_internet().then((internet) {
          if(internet){
            loading.value=true;
            Api.login(email, pass).then((value) {
              if(value != null){
                Global.saveInfo(email, pass);
                Global.user= value;
                AppWidget.successMsg(context,App_Localization.of(context).translate("sign_in_success"));
                loading.value=false;
                Get.offAll(()=>Home());
              }else{
                loading.value=false;
                AppWidget.errorMsg(context,App_Localization.of(context).translate("wrong_mail_password"));
              }
            });
          }else{
            Get.to(()=>const NoInternet())!.then((value) {
              signIn(context,email,pass);
            });
          }
        });
      }
    }catch (e){
      print(e.toString());
      loading.value=false;
      AppWidget.successMsg(context,App_Localization.of(context).translate("something_wrong"));
    }
  }

}