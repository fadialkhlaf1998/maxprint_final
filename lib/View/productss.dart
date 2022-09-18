import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/homeController.dart';
import 'package:maxprint_final/Controller/wishlistController.dart';
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/Model/Product.dart';
import 'package:maxprint_final/View/home.dart';
import 'package:maxprint_final/View/searchDelgate.dart';

class Productss extends StatelessWidget {

  List<Product> products;
  Productss(this.products);

  HomeController homeController = Get.find();
  WishlistController wishlistController = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                _header(context),
                products.isEmpty ?
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: AppWidget.appText(
                              App_Localization.of(context).translate("this_collection_is_empty"),
                              Colors.black,
                              16, FontWeight.normal)),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          // Get.back();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.black,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: AppWidget.appText(
                                App_Localization.of(context).translate("go_to_home"),
                                AppColors.mainColor,15,FontWeight.bold
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                ) :
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.16 - MediaQuery.of(context).padding.bottom - MediaQuery.of(context).padding.top,
                      child: GridView.builder(
                        //  physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7/0.8,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5
                          ),
                          itemCount: products.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return _products(products[index], context, index);
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.16,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey.withOpacity(0.5))
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back,size: 28,)),
                  GestureDetector(
                    onTap: () {
                    //  Get.off(() => Home());
                    },
                    child: SvgPicture.asset("assets/logo/logo.svg",
                      width: 25,
                      height: 25,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        //menu
                      },
                      icon: const Icon(Icons.menu,color: Colors.transparent,)),
                ],
              )
          ),
          GestureDetector(
            onTap: () => _pressed_on_search(context),
            child: Container(
              //width: MediaQuery.of(context).size.width * 0.9,
              height: 40,
              color: AppColors.mainColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: Global.languageCode != 'en'
                            ? const BorderRadius.only(
                          bottomRight:  Radius.circular(10),
                          topRight:  Radius.circular(10),
                        )
                            : const BorderRadius.only(
                          bottomLeft:  Radius.circular(10),
                          topLeft:  Radius.circular(10),
                        ),
                        border: Border.all(width: 1,color: Colors.grey.withOpacity(0.7))
                    ),
                    // width: MediaQuery.of(context).size.width * 0.7,
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child:  AppWidget.appText(
                          App_Localization.of(context).translate("what_are_you_looking"),
                          Colors.black54, 15, FontWeight.normal),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: Global.languageCode == 'en'
                            ? const BorderRadius.only(
                          bottomRight:  Radius.circular(10),
                          topRight:  Radius.circular(10),
                        )
                            : const BorderRadius.only(
                          bottomLeft:  Radius.circular(10),
                          topLeft:  Radius.circular(10),
                        )
                    ),
                    child: const Icon(Icons.search,color: Colors.white,size: 30),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  _pressed_on_search(BuildContext context) async {
    final result = await showSearch(
        context: context,
        delegate: SearchTextField(homeController: homeController));
  }
  _products(Product product,BuildContext context,int index) {
    return GestureDetector(
      onTap: () {
        homeController.goToProductPage(product);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 10,right: 5,left: 5,top: 5),
        elevation: 5,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child:Hero(
                tag: "product-${product.id}",
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(product.image == null
                          ? "https://tahoban.ru/wp-content/themes/consultix/images/no-image-found-360x250.png"
                          : product.image!.src.toString()),
                    ),
                  ),
                ),
              ),),
            const SizedBox(height: 5,),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          product.title.toString(),
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                double.parse(product.variants!.first.price!) == 0 ?
                                Center(
                                  child: Text(
                                      App_Localization.of(context).translate('contact_us_for_price'),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black
                                      )
                                  ),
                                ) :
                                Expanded(
                                  flex: 1,
                                  child: AppWidget.appText(product.variants!.first.price.toString() + " " +
                                      App_Localization.of(context).translate("AED"),
                                      Colors.black, 13, FontWeight.bold),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    product.variants!.first.compareAtPrice == null ? "" :
                                    product.variants!.first.compareAtPrice.toString() + " " +
                                        App_Localization.of(context).translate("AED"),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Obx(() => GestureDetector(
                              onTap: () {
                                products[index].favorite.value = ! products[index].favorite.value;
                                if ( products[index].favorite.value) {
                                  wishlistController.addToWishlist(products[index]);
                                }
                                else {
                                  wishlistController.deleteFromWishlist(products[index]);
                                }
                              },
                              child: !products[index].favorite.value
                                  ? const Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                                size: 25,
                              )
                                  : const Icon(
                                Icons.favorite_outlined,
                                color: Colors.red,
                                size: 25,
                              ),
                            ))
                          ],
                        ),
                      ),
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
