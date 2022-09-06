import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Api/new_api.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Controller/cartController.dart';
import 'package:maxprint_final/Controller/wishlistController.dart';
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/Model/Product.dart';
import 'package:maxprint_final/View/productView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductViewController extends GetxController {

  var activeIndex = 0.obs;
  var cartCount= 1.obs;
  CartController cartController = Get.find();
  RxList<Product> recently = <Product>[].obs;
  WishlistController wishlistController = Get.find();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController message = TextEditingController();
  var nameValidate = true.obs;
  var phoneValidate = false.obs;
  RxList<File> uploadFiles = <File>[].obs;
  RxBool uploadFileCheck = false.obs;

  setIndex(int selected){
    activeIndex.value=selected;
  }
  increase(){
    cartCount.value++;
    cartController.saveCart();
  }
  decrease(){
    if(cartCount.value>1) {
      cartCount.value--;
      cartController.saveCart();
    }
  }

  addToCart(BuildContext context,Product product) async {
    cartController.addToCart(product, cartCount.value);
    await AppWidget.successMsg(context,App_Localization.of(context).translate("added_to_cart"));
    cartCount = 1.obs;
  }

  addToRecently(Product recent){
    if(recently.length >= 10){
      recently.removeAt(0);
      for(int i=0;i<recently.length;i++){
        if(recently[i].id==recent.id){
          return;
        }
      }
      recently.add(recent);
    }else{
      for(int i=0;i<recently.length;i++){
        if(recently[i].id==recent.id){
          return;
        }
      }
      recently.add(recent);
    }
    saveRecently(recently);
  }

  saveRecently(List<Product> _products){
    SharedPreferences.getInstance().then((prefs) {
      String rec = json.encode(List<dynamic>.from(_products.map((x) => x.toMap())));
      prefs.setString("recently", rec).then((value) {
        ////////////////////////////////////check later
        wishlistController.loadWishlist();
      });
    });
  }


  Future<List<Product>> loadRecently()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rec = prefs.getString("recently")??"non";
    if(rec=="non"){
      return <Product>[];
    }else{
      var jsonlist = jsonDecode(rec) as List;
      List<Product> list = <Product>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(Product.fromMap(jsonlist[i]));
      }
      return list;
    }
  }
  go(int index) {
    Get.back();
    Get.to(() => ProductView(recently[index]))!.then((value) {});
  }

  Future uploadDesign() async {
    await FilePicker.platform.pickFiles(allowMultiple: false).then((recordedFile) {
      uploadFiles.add(File(recordedFile!.paths.first.toString()));
    });
  }

  uploadFileToServer() async {
    await Api.uploadPhoto(uploadFiles).then((value) async {
      if(value.isNotEmpty){
        print('Success');
        uploadFiles.clear();
        uploadFileCheck.value = true;
        await Global.saveUploadDesignUrls('note', value);
      }else{
        print('Field');
      }
    });
  }

}