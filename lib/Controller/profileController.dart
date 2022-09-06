import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Api/connector.dart';
import 'package:maxprint_final/Api/registrationApi.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/Model/Customer.dart';
import 'package:maxprint_final/View/noInternet.dart';

class ProfileController extends GetxController{
  TextEditingController newPassword = TextEditingController();
  TextEditingController confNewPassword = TextEditingController();
  var open = false.obs;
  var validateNewPass = true.obs;
  var validateConfNewPass = true.obs;
  var loading = false.obs;

  changePass(BuildContext context,String password,String confPassword,Customer customer){
    if(password.isEmpty||confPassword.isEmpty){
      if(password.isEmpty){
        validateNewPass.value=false;
      }else{
        validateNewPass.value=true;
      }
      if(confPassword.isEmpty){
        validateConfNewPass.value=false;
      }else{
        validateConfNewPass.value=true;
      }
    }else{
      if(password == confPassword && password.length >= 6){
        Connector.check_internet().then((internet){
          if(internet){
            validateConfNewPass.value=true;
            validateNewPass.value=true;
            loading.value=true;
            RegistrationApi.changePassword(Global.customer!.email!, password,customer.id!).then((result) {
              //print(result);
              loading.value=false;
              if(Global.customer!.email != null){
                AppWidget.successMsg(context, App_Localization.of(context).translate("password_changed"));
                open.value = false;
                newPassword.clear();
                confNewPassword.clear();
              }else{
                AppWidget.errorMsg(context, App_Localization.of(context).translate("something_wrong"));
              }
            });
          }else{
            Get.to(()=>const NoInternet())!.then((value) {
              changePass(context,password,confPassword,customer);
            });
          }
        });
      }else{
        if(password.length<6){
          AppWidget.errorMsg(
              context, App_Localization.of(context).translate("wrong_password"));
        }else if(confPassword.length<6){
          AppWidget.errorMsg(
              context, App_Localization.of(context).translate("wrong_password"));
        }else {
          AppWidget.errorMsg(
              context, App_Localization.of(context).translate("passwords_not_matched"));
        }
      }
    }
  }
}