import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Api/connector.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Controller/cartController.dart';
import 'package:maxprint_final/Helper/global.dart';

class CheckoutController extends GetxController {

  var selected = 0.obs;
  var selectValue = false.obs;
  var noAddress = false.obs;
  var phoneValidate = false.obs;
  CartController cartController = Get.find();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController province = TextEditingController();
  TextEditingController phone = TextEditingController();
  Rx<String> country="non".obs;
  Rx<String> emirate="non".obs;
  RxList<String> countries=["united_arab_emirates"].obs;
  RxList<String> emirates=["abu_dhabi","ajman","dubai","fujairah","ras_al_Khaimah","sharjah","umm_al_Quwain"].obs;

  @override
  void onInit() {
    if(Global.customer!=null){
      firstName.text = Global.customer!.firstName!;
      lastName.text = Global.customer!.lastName!;
    }
  }

  next(BuildContext context){
    if(selected.value == 0){
      // if(firstName.value.text.isEmpty||lastName.value.text.isEmpty||address1.value.text.isEmpty||
      //     address2.value.text.isEmpty||phone.value.text.isEmpty||country=="non"||emirate=="non" || phone.text.length < 9){
      //   noAddress.value = true;
      // }else{
      //   selected.value ++;
      //   noAddress.value = false;
      // }
      if(firstName.text.isEmpty){
        AppWidget.errorMsg(context, App_Localization.of(context).translate("name_empty"));
        noAddress.value = true;
      }else if(lastName.text.isEmpty){
        AppWidget.errorMsg(context, App_Localization.of(context).translate("last_name_empty"));
        noAddress.value = true;
      }else if(address1.text.isEmpty){
        AppWidget.errorMsg(context, App_Localization.of(context).translate("address1_empty"));
        noAddress.value = true;
      } else if(address2.text.isEmpty){
        AppWidget.errorMsg(context, App_Localization.of(context).translate("address2_empty"));
        noAddress.value = true;
      } else if(country.value == "non"){
        AppWidget.errorMsg(context, App_Localization.of(context).translate("country_empty"));
        noAddress.value = true;
      } else if(emirate.value == "non"){
        AppWidget.errorMsg(context, App_Localization.of(context).translate("emirate_empty"));
        noAddress.value = true;
      } else if(phone.text.isEmpty || phone.text.length < 9){
        AppWidget.errorMsg(context, App_Localization.of(context).translate("wrong_phone"));
        phoneValidate.value = true;
        noAddress.value = true;
      }else{
        phoneValidate.value = false;
        selected.value ++;
      }

    }else{
      if(!selectValue.value) {
        AppWidget.errorMsg(context,App_Localization.of(context).translate("complete_order"));
      }else if(selectValue.value){
        selected.value ++;
      }
    }
  }
  back(){
    selectValue.value=false;
    if(selected.value == 0) {
      Get.back();
    }else if(selectValue.value){
      selectValue.value=false;
    }else if(selected.value == 1){
      noAddress.value = false;
      selected.value --;
    }
  }
  addOrder(BuildContext context){
    Connector.add_order(cartController.line_items_api,Global.user!.firstName,
        Global.user!.lastName, address1.text, address2.text,
        "+971 ${phone.text}",emirate.value, country.value,Global.user!.id).then((value) {
    });
  }

}