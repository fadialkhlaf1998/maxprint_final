import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Api/connector.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/View/noInternet.dart';

class NeedDesignController extends GetxController {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController message = TextEditingController();
  var nameValidate = true.obs;
  var phoneValidate = false.obs;

  clearTextfields() {
    name.clear();
    email.clear();
    phone.clear();
    message.clear();
    nameValidate = true.obs;
    phoneValidate = false.obs;
  }
  sendRequest(BuildContext context,String name, String emaill, String phone,String message){
    try{
      if(name.isEmpty||phone.isEmpty||phone.length < 9){
        if(name.isEmpty){
          nameValidate.value=false;
        }else{
          nameValidate.value = true;
        }
        if(phone.isEmpty || phone.length < 9){
          AppWidget.errorMsg(context, App_Localization.of(context).translate("wrong_phone"));
          phoneValidate.value=true;
        }else{
          phoneValidate.value=false;
        }
      }else{
        Connector.check_internet().then((internet) async {
          if(internet) {
            try {
              final Email email = Email(
                body: "Name: "+name+"\n"+
                    "Phone: " +phone+"\n"+
                    "Email: " +emaill+"\n"+
                    "Message: " +message,
                subject: "Printing Offers - Design Request",
                recipients: ["design@printingoffers.ae"],
              );
              await FlutterEmailSender.send(email);
              AppWidget.successMsg(context, App_Localization.of(context).translate("request_design_sent"));
              Get.back();
              clearTextfields();
            }
            catch (e) {
              AppWidget.successMsg(context, App_Localization.of(context).translate("request_failed"));
              //print(e);
            }
          }else {
            Get.to(() => const NoInternet())!.then((value) {
              sendRequest(context,name,emaill,phone,message);
            });
          }
        });
      }
    }catch (e){
      AppWidget.successMsg(context,App_Localization.of(context).translate("something_wrong"));
    }

  }


}