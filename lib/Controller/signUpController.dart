import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Api/connector.dart';
import 'package:maxprint_final/Api/new_api.dart';
import 'package:maxprint_final/Api/registrationApi.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/View/home.dart';
import 'package:maxprint_final/View/noInternet.dart';

class SignUpController extends GetxController {

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  var firstNameValidate = true.obs;
  var lastNameValidate = true.obs;
  var emailValidate = true.obs;
  var passValidate = true.obs;
  var hidePassword = true.obs;
  var loading = false.obs;

  clearTextFields(){
    firstName.clear();
    lastName.clear();
    email.clear();
    password.clear();
    firstNameValidate = true.obs;
    lastNameValidate = true.obs;
    emailValidate = true.obs;
    passValidate = true.obs;
  }

  void hideVisibility(){
    hidePassword.value = !hidePassword.value;
  }

  signUp(BuildContext context, String fName, String lName,String email, String pass) {
    try{
      if(!RegExp(r'\S+@\S+\.\S+').hasMatch(email)|| email.isEmpty || pass.isEmpty || fName.isEmpty || lName.isEmpty || pass.length<6){
        if(email.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(email)){
          emailValidate.value=false;
        }else{
          emailValidate.value=true;
        }
        if(pass.isEmpty||pass.length<6){
          if(pass.length<6&&pass.isNotEmpty){
            AppWidget.errorMsg(context, App_Localization.of(context).translate("wrong_password"));
            passValidate.value=false;
          }else{
            passValidate.value=false;
          }
        }else{
          passValidate.value=true;
        }
        if(fName.isEmpty){
          firstNameValidate.value=false;
        }else{
          firstNameValidate.value=true;
        }
        if(lName.isEmpty){
          lastNameValidate.value=false;
        }else{
          lastNameValidate.value=true;
        }
      }else{
        Connector.check_internet().then((internet) {
          if(internet){
            loading.value=true;
            Api.signUp(fName,lName, '', email, pass).then((value) {
              if(value!=null){
                Global.saveInfo(email, pass);
                Global.user = value;
                AppWidget.successMsg(context, App_Localization.of(context).translate("sign_up_success"));
                loading.value=false;
                Get.offAll(() => Home());
              }else{
                loading.value=false;
                AppWidget.errorMsg(context, App_Localization.of(context).translate("sign_up_failed"));
              }
            });
          }else{
            Get.to(()=>const NoInternet())!.then((value) {
              signUp(context,fName,lName,email,pass);
            });
          }
        });
      }
    }
    catch(e){
    loading.value=false;
    AppWidget.errorMsg(context, App_Localization.of(context).translate("something_wrong"));
    }
  }
}