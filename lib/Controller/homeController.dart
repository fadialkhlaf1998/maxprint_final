import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Api/connector.dart';
import 'package:maxprint_final/Controller/introductionController.dart';
import 'package:maxprint_final/Controller/wishlistController.dart';
import 'package:maxprint_final/Model/Collection.dart';
import 'package:maxprint_final/Model/Product.dart';
import 'package:maxprint_final/View/noInternet.dart';
import 'package:maxprint_final/View/productView.dart';
import 'package:maxprint_final/View/productss.dart';


class HomeController extends GetxController {

  GlobalKey<ScaffoldState> key =  GlobalKey<ScaffoldState>();
  final PageController pageController = PageController();
  IntroController introController = Get.find();
  var selectSearch = 0.obs;
  var selectNavBar = 0.obs;
  RxInt selectCategory = 0.obs;
  var loading = false.obs;
  var loading2 = false.obs;
  List<Collection> collection = <Collection>[].obs;
  RxList<Product> products = <Product>[].obs;
  RxList<Product> allProducts = <Product>[].obs;
  Product? product;
  WishlistController wishlistController = Get.find();

  @override
  Future<void> onInit() async {
    super.onInit();
    getData();
  }

  selectedCategory(int index) {
    selectCategory = index.obs;
  }

  getData(){
    allProducts = introController.allProducts;
    if(introController.collections.isNotEmpty){
      collection.addAll(introController.collections);
      Connector.get_products_by_Collection(wishlistController.wishlist,collection.first.id!).then((_products) {
        products.addAll(_products);
      });
    }else{
      introController.get_collections();
      getData();
    }
  }

  getProducts(Collection collection) {
    loading.value = true;
    Connector.check_internet().then((internet) {
      if(internet) {
        Connector.get_products_by_Collection(wishlistController.wishlist,collection.id!).then((value) {
          products.clear();
          products.addAll(value);
          loading.value = false;
        });
      }
      else {
        Get.to(() => const NoInternet())!.then((value) {
          getProducts(collection);
        });
      }
    });
  }

  goToCollectionPage(Collection collection) {
    loading2.value = true;
    Connector.check_internet().then((internet) {
      if(internet) {
        Connector.get_products_by_Collection(wishlistController.wishlist,collection.id!).then((value) {
          //  products.clear();
          //products.addAll(value);
          //print(value.length);
          Get.to(() => Productss(value));
          loading2.value = false;
        });
      }
      else {
        Get.to(() => const NoInternet())!.then((value) {
          getProducts(collection);
        });
      }
    });
  }

  goToProductPage(Product product) {
    Get.to(() => ProductView(product));
  }
}