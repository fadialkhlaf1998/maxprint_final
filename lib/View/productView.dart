import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/homeController.dart';
import 'package:maxprint_final/Controller/productViewConroller.dart';
import 'package:maxprint_final/Controller/wishlistController.dart';
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/Model/Product.dart';
import 'package:maxprint_final/View/contactDesigner.dart';
import 'package:maxprint_final/View/customizeOrder.dart';
import 'package:maxprint_final/View/home.dart';
import 'package:maxprint_final/View/needDesign.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductView extends StatelessWidget {
  ProductView(this.product) {
    Future.delayed(Duration.zero, () async {
      productController.addToRecently(product);
      product.favorite.value = wishlistController.isFavorite(product);
    });
  }

  Product product;
  ProductViewController productController = Get.put(ProductViewController());
  WishlistController wishlistController = Get.find();
  HomeController homeController = Get.find();
  String url = "https://cdn.shopify.com/s/files/1/0195/9329/8020/files/BC_5.5_X_9.pdf?v=1641990476";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Obx(() => SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.secondaryColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                _body(context)
              ],
            ),
          ),
        ),
      ))
    );
  }

  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey.withOpacity(0.5))
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back,size: 25,)),
          GestureDetector(
            onTap: () {
              Get.off(() => Home());
            },
            child: SvgPicture.asset("assets/logo/logo.svg", width: 25, height: 25,
            ),
          ),
          IconButton(
              onPressed: () {
                //menu
              },
              icon: const Icon(Icons.menu,color: Colors.transparent)),
        ],
      )
    );
  }
  _body(BuildContext context) {
    return Column(
      children: [
        _slider_images(context),
        const SizedBox(height: 10,),
        _title_and_code_and_price(context),
        _Description(context),
        const SizedBox(height: 10),
        productController.uploadFiles.isEmpty ? const Center()
            : _design_files_list(context),
        const SizedBox(height: 10),
        _cart(context),
        const SizedBox(height: 10),
        _need_design(context),
        const SizedBox(height: 10),
        customize_this_order(context),
        const SizedBox(height: 20),
        productController.recently.isEmpty ? const Center() :
        Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 30,
              child: AppWidget.appText(App_Localization.of(context).translate("recently"),
                  Colors.black,16, FontWeight.bold),
            ),
            _recently(context),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
  _slider_images(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: "product-"+product.id.toString(),
          child: Container(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  CarouselSlider.builder(
                    options: CarouselOptions(
                      autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                      viewportFraction: 1,
                      autoPlay: product.images!.length <= 1 ? false : true,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.vertical,
                      onPageChanged: (index, reason) => productController.setIndex(index),
                    ),
                    itemCount: product.images!.length,
                    itemBuilder: (BuildContext context, int index, int realIndex) {
                      return Padding(
                          padding: const EdgeInsets.all(10),
                          child:  Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(product.image == null
                                    ? "https://tahoban.ru/wp-content/themes/consultix/images/no-image-found-360x250.png"
                                    : product.images![index].src.toString()
                                ),
                              ),
                            ),
                          )
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSmoothIndicator(
                        activeIndex: productController.activeIndex.value,
                        count: product.images!.length,
                        effect: SlideEffect(
                          dotWidth: 10,
                          dotHeight: 10,
                          activeDotColor: AppColors.mainColor,
                          dotColor: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  product.favorite.value = ! product.favorite.value;
                  if (product.favorite.value) {
                    wishlistController.addToWishlist(product);
                  }
                  else {
                    wishlistController.deleteFromWishlist(product);
                  }
                  },
                icon: Icon(
                  !product.favorite.value ?
                  Icons.favorite_border :
                  Icons.favorite_outlined,color: Colors.red,size: 30,),
              )),
        ),
      ],
    );
  }
  _title_and_code_and_price(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: AppWidget.appText(
                product.title.toString(),Colors.black,18,FontWeight.w500
              )
            )
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              product.variants!.first.compareAtPrice == null ?
              const Center() :
              Container(
                width: 100,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: AppWidget.appText(
                          App_Localization.of(context).translate("save") + " " + App_Localization.of(context).translate("AED") + " ",
                          Colors.white,12,FontWeight.bold
                      ),
                    ),
                    Center(
                      child: AppWidget.appText(
                          (double.parse(product.variants!.first.compareAtPrice!.toString()) - double.parse(product.variants!.first.price!)).toStringAsFixed(2),
                          Colors.white,12,FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppWidget.appText(
                      "Product Code:" " ",Colors.black54,14,FontWeight.normal
                  ),
                  AppWidget.appText(
                      product.variants!.first.sku.toString(),Colors.black54,14,FontWeight.normal
                  )
                ],
              ) ,
            ],
          ),
        ),
        const SizedBox(height: 10),
        AppWidget.divider(0.5, Colors.grey.withOpacity(0.5), 20, 20),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5)
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppWidget.appText(
                        App_Localization.of(context).translate("new_price") + " ",Colors.black54,14,FontWeight.normal
                    ),
                    AppWidget.appText(
                        product.variants!.first.price.toString(),Colors.black,14,FontWeight.bold
                    ),
                    AppWidget.appText(
                        " " +  App_Localization.of(context).translate("AED"),Colors.black,14,FontWeight.normal
                    )
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppWidget.appText(
                        App_Localization.of(context).translate("old_price") + " ",Colors.black54,14,FontWeight.normal
                    ),
                    Text(
                      product.variants!.first.compareAtPrice.toString() + App_Localization.of(context).translate("AED"),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        AppWidget.divider(0.5, Colors.grey.withOpacity(0.5), 20, 20),
        const SizedBox(height: 10),
      ],
    );
  }
  _Description(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppWidget.appText(
                  App_Localization.of(context).translate("description"),Colors.black,16,FontWeight.bold
              ),
              AppWidget.divider(1, Colors.black, 0, 0),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Html(
                  data: product.bodyHtml,
                  onLinkTap: (url, _, __, ___) async {
                    if (await canLaunch(url!)) {
                      await launch(url);
                    }
                  },
                  style: {
                    "p": Style(
                      fontSize: const FontSize(14),
                        textAlign: TextAlign.left
                    ),
                    "img" : Style(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft
                    ),
                    "a span" : Style(
                        fontSize: const FontSize(12),
                        width: MediaQuery.of(context).size.width,
                      //   textAlign: TextAlign.center,
                    ),
                  },
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {
            productController.uploadDesign();
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4 + 70,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 10,),
                  productController.uploadFiles.isEmpty
                      ? AppWidget.appText(App_Localization.of(context).translate("upload_design"),
                          Colors.white, 18,FontWeight.normal)
                  :  AppWidget.appText(App_Localization.of(context).translate("add_more"),
                      Colors.white, 18,FontWeight.normal),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.upload_file,size: 30,color: Colors.white),
                  ),
                ],
              )
            ),
          ),
        )
      ],
    );
  }
  _design_files_list(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.16,
          child: ListView.builder(
              // shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: productController.uploadFiles.length,
              itemBuilder: (context, index) {
                String fileName = productController.uploadFiles[index].path.substring(1,productController.uploadFiles[index].path.length - 1 ).split('file_picker/')[1];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () async{
                      _show_image(context, index);
                    },
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.09,
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text(
                                  fileName,
                                  textAlign: TextAlign.center,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              )
                              //Image.file(productController.uploadFiles[index]),
                            ),
                            GestureDetector(
                                onTap: () {
                                  productController.uploadFiles.removeAt(index);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(Icons.delete,color: Colors.red,size: 20,),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        GestureDetector(
          onTap: (){
            productController.uploadFileToServer(product.id!);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Text(
                App_Localization.of(context).translate('upload'),
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ),
        Divider(
           color: Colors.grey,
          height: 20,
          endIndent: MediaQuery.of(context).size.width * 0.15,
          indent: MediaQuery.of(context).size.width * 0.15,
          thickness: 1,
        )
      ],
    );
  }
  _cart(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4 + 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
            ),
            child: IconButton(
              onPressed: () async {
                /// todo
                /// check if i upload design to this order
                productController.checkProductId(product.id!);
                 // await Global.getUploadDesignUrls().then((value){
                 //   print('-------------------');
                 //   print(value.urlsList.length);
                 //   print('-------------------');
                 //   if(value.urlsList.isNotEmpty){
                 //     productController.addToCart(context,product);
                 //   }else{
                 //     showDialog(context);
                 //   }
                 // });
              },
              icon: Icon(Icons.shopping_cart_outlined,size: 25,color: AppColors.mainColor),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    productController.decrease();
                  },
                  icon: Icon(Icons.remove,size: 25,color: AppColors.mainColor,),
                ),
                AppWidget.appText(productController.cartCount.toString(), AppColors.mainColor, 16, FontWeight.normal),
                IconButton(
                  onPressed: () {
                    productController.increase();
                  },
                  icon: Icon(Icons.add,size: 25,color: AppColors.mainColor,),
                ),
              ],
            )
          )
        ],
      ),
    );
  }
  _need_design(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NeedDesign());
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
        ),
        child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.add, size: 0),
                AppWidget.appText(App_Localization.of(context).translate("need_design"),
                    Colors.black, 15,FontWeight.normal),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset('assets/design.svg',color: Colors.black,),
                )
              ],
            )
        ),
      ),
    );
  }
  customize_this_order(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.to(() => CustomizeOrder());
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
        ),
        child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.add, size: 0),
                AppWidget.appText(App_Localization.of(context).translate("customize_this_order"),
                    Colors.black, 15,FontWeight.normal),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset('assets/customize.svg',color: Colors.black,),
                )
              ],
            )
        ),
      ),
    );
  }
  _recently(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.23,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: productController.recently.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                productController.go(index);
            },
              child: Card(
                color: AppColors.secondaryColor,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(productController.recently[index].image == null
                                  ? "https://tahoban.ru/wp-content/themes/consultix/images/no-image-found-360x250.png"
                                  : productController.recently[index].image!.src.toString()),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              productController.recently[index].title.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AppWidget.appText(product.variants!.first.price!.toString() + " " +
                            App_Localization.of(context).translate("AED"),
                            Colors.black, 12, FontWeight.bold),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          productController.recently[index].variants!.first.compareAtPrice == null ? "" :
                          productController.recently[index].variants!.first.compareAtPrice.toString() + " "
                              + App_Localization.of(context).translate("AED"),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
      ),
    );
  }
  showDialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, __, ___){
        return Dialog(
          backgroundColor: AppColors.secondaryColor,
          child: SizedBox(
            height: Global.languageCode == "en" ? 310 : 330,
            child: Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    children: [
                      const Icon(Icons.group_rounded,size: 35,color: Colors.black),
                      Text(
                        App_Localization.of(context).translate("contact_designer"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      // AppWidget.appText(App_Localization.of(context).translate("contact_designer"),
                      //     Colors.black, 14, FontWeight.normal),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ContactDesigner());
                        },
                        child: Container(
                          width: 150,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
                          ),
                          child: AppWidget.appText(App_Localization.of(context).translate("contact_designer2"),
                              Colors.black, 14, FontWeight.normal),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                AppWidget.divider(0.5, Colors.grey, 0,0),
                const SizedBox(height: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    children: [
                      const Icon(Icons.upload_file,size: 35,color: Colors.black),
                      Text(
                        App_Localization.of(context).translate("upload_files"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      // AppWidget.appText(App_Localization.of(context).translate("upload_files"),
                      //     Colors.black, 15, FontWeight.normal),
                      const SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () async {
                          // FilePickerResult? result = await FilePicker.platform.pickFiles();
                          // if (result != null) {
                          // File file = File(result.files.single.path!);
                          // } else {
                          //
                          // }
                          Get.back();
                        },
                        child: Container(
                          width: 80,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))

                          ),
                          child: AppWidget.appText(App_Localization.of(context).translate("ok"),
                              Colors.black, 14, FontWeight.normal),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.forward) {
          tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        }
        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
  _show_image(BuildContext context,int index) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, __, ___){
        return GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Stack(
              children: [
                Container(
                  color: AppColors.secondaryColor,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment:  CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              color: Colors.red,
                              child: Image.file(productController.uploadFiles[index],fit: BoxFit.cover,)
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height - 80,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(Icons.arrow_back_ios,
                      color: AppColors.mainColor,
                      size: 25,
                    ),
                  ),
                ),
              ],
            )
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }
        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
