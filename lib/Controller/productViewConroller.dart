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
import 'package:maxprint_final/Model/uploadDesign.dart';
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

  uploadFileToServer(int productId) async {
    await Api.uploadPhoto(uploadFiles).then((value) async {
      if(value.isNotEmpty){
        print('Success');
        await saveUploadDesignUrls(productId, value);
        uploadFiles.clear();
        uploadFileCheck.value = true;
        // await saveUploadDesignUrls(productId, value);
      }else{
        print('Field');
      }
    });
  }


  saveUploadDesignUrls(int productId, List<String> designsUrls) async {

    /// todo
    /// get list of uploadDesign Model
    List<UploadDesign> loadDesignList = await loadUploadDesign();
    loadDesignList.add(UploadDesign(productId: productId, designsUrls: designsUrls));
    /// save new list
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("uploadDesign", json.encode(loadDesignList));
    });

  }

  Future<List<UploadDesign>> loadUploadDesign() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uploadsDesign = prefs.getString('uploadDesign') ?? '';
    if(uploadsDesign ==''){
      return [];
    }
    var list = json.decode(uploadsDesign) as List;
    List<UploadDesign> allDesign = <UploadDesign>[];
    for(var elm in list){
      print('-*-*-*-*-');
      print(elm);
      allDesign.add(UploadDesign.fromJson(elm));
    }
    print(allDesign.length);
    return allDesign;
  }
  
  checkProductId(int id, context, product) async {
    List<UploadDesign> loadDesignList = await loadUploadDesign();
    for(var upload in loadDesignList){
      if(upload.productId == id){
        addToCart(context, product);
        return;
      }
    }
    AppWidget.errorMsg(context, App_Localization.of(context).translate('you_must_upload_design'));
  }

}