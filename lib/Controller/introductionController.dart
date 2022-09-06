import 'package:get/get.dart';
import 'package:maxprint_final/Api/connector.dart';
import 'package:maxprint_final/Api/new_api.dart';
import 'package:maxprint_final/Api/registrationApi.dart';
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/Model/Collection.dart';
import 'package:maxprint_final/Model/Product.dart';
import 'package:maxprint_final/View/home.dart';
import 'package:maxprint_final/View/noInternet.dart';
import 'package:maxprint_final/View/welcome.dart';

class IntroController extends GetxController {

  RxList<Collection> collections = <Collection>[].obs;
  RxList<Product> products = <Product>[].obs;
  RxList<Product> allProducts = <Product>[].obs;

  @override
  Future<void> onInit() async {
    get_collections();
    super.onInit();
  }

  get_collections() {
    Connector.check_internet().then((internet) {
      if (internet) {
        if (collections.isEmpty) {
          Connector.get_collections().then((value) {
            if (value.isNotEmpty) {
              collections.addAll(value);
              Future.delayed(const Duration(milliseconds: 2500), () {
                move();
              });
            }
            else {
              Future.delayed(const Duration(milliseconds: 2500), () {
                move();
              });
            }
          }).catchError((err) {
            collections.value = <Collection>[];
          });
          Connector.get_all_products().then((value) {
            allProducts.addAll(value);
          });
        }
      } else {
        Get.to(() => const NoInternet())!.then((value) {
          get_collections();
        });
      }
    });
  }

  move(){
  Global.loadInfo().then((info) {
    if(info.email=="non"){
      Get.offAll(()=>const Welcome());
    }else{
      Connector.check_internet().then((internet) {
        if(internet){
          Api.login(info.email,info.password).then((value) {
            if(value!= null){
                Get.offAll(()=>Home());
            }else{
              Get.offAll(()=>const Welcome());
            }
          });
        }else{
          Get.to(()=>const NoInternet())!.then((value) {
            //move();
          });
        }
      });
    }
  });
  }

}
