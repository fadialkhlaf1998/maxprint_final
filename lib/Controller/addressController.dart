import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Api/connector.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/Model/Order.dart';
import 'package:maxprint_final/View/noInternet.dart';

class AddressController extends GetxController {

  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController phone = TextEditingController();
  Rx<String> country="non".obs;
  Rx<String> emirate="non".obs;
  var address1Validate = false.obs;
  var address2Validate = false.obs;
  var countryValidate = false.obs;
  var emirateValidate = false.obs;
  var phoneValidate = false.obs;
  var loading = false.obs;
  RxList<String> countries=["united_arab_emirates"].obs;
  RxList<String> emirates=["abu_dhabi","ajman","dubai","fujairah","ras_al_Khaimah","sharjah","umm_al_Quwain"].obs;
  RxList<DefaultAddress> addresses = <DefaultAddress>[].obs;


  @override
  void onInit() {
    super.onInit();
    getAddress();
  }

  back() {
    address1.clear();
    address2.clear();
    phone.clear();
    country="non".obs;
    emirate="non".obs;
    address1Validate = false.obs;
    address2Validate = false.obs;
    countryValidate = false.obs;
    emirateValidate = false.obs;
    phoneValidate = false.obs;
  }
  getAddress() {
    loading.value = true;
    Connector.check_internet().then((internet) {
      if(internet) {
        Connector.get_address(Global.user!).then((value) {
          if(value.isNotEmpty) {
            addresses.clear();
            addresses.addAll(value);
            loading.value = false;
            back();
          }else{
            loading.value = false;
          }
        });
      }else {
        Get.to(() => const NoInternet())!.then((value) {
          // getAddress();
        });
      }
    });
  }
  deleteAddress(BuildContext context,DefaultAddress defaultAdd) {
    loading.value = true;
    Connector.check_internet().then((internet) {
      if(internet) {
        Connector.delete_address(Global.customer!,defaultAdd.id!).then((value) {
          addresses.remove(defaultAdd);
          loading.value = false;
        });
      }else {
        Get.to(() => const NoInternet())!.then((value) {
          // getAddress();
        });
      }
    });
  }
  addAddress(BuildContext context,String adrs1,String adrs2,String country,String emirate,String phone) {
    if(adrs1.isEmpty || adrs2.isEmpty || phone.isEmpty || country == "non" || emirate == "non" || phone.length < 9){
      if(adrs1.isEmpty){
        address1Validate.value=true;
      }else{
        address1Validate.value=false;
      }
      if(adrs2.isEmpty){
        address2Validate.value=true;
      }else{
        address2Validate.value=false;
      }
      if(phone.isEmpty || phone.length < 9){
        AppWidget.errorMsg(context, App_Localization.of(context).translate("wrong_phone"));
        phoneValidate.value=true;
      }else{
        phoneValidate.value=false;
      }
      if(country == "non"){
        countryValidate.value=true;
      }else{
        countryValidate.value=false;
      }
      if(emirate == "non"){
        emirateValidate.value=true;
      }else{
        emirateValidate.value=false;
      }
    }
    else {
      loading.value = true;
      Connector.check_internet().then((internet) {
        if(internet) {
          Connector.create_address(Global.customer!,Global.customer!.firstName!,Global.customer!.lastName!,adrs1,adrs2,country,emirate,phone).then((value) {
          }).then((value) {
            AppWidget.successMsg(context,App_Localization.of(context).translate("adrs_saved"));
            Get.back();
            getAddress();
          });
        }else{
          Get.to(() => const NoInternet())!.then((value) {
            addAddress(context, adrs1, adrs2, country, emirate, phone);
          });
        }
      });
    }
  }
  setDefault(DefaultAddress defaultAdd) {
    loading.value = true;
    Connector.check_internet().then((internet) {
      if(internet) {
        Connector.set_address_default(Global.customer!,defaultAdd.id!).then((value) {
          getAddress();
        });
      }else {
        Get.to(() => const NoInternet())!.then((value) {
          getAddress();
        });
      }
    });
  }

}
