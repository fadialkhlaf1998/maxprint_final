import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Const/drawer.dart';
import 'package:maxprint_final/Controller/homeController.dart';
import 'package:maxprint_final/Controller/wishlistController.dart';
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/Model/Collection.dart';
import 'package:maxprint_final/Model/Product.dart';
import 'package:maxprint_final/View/cart.dart';
import 'package:maxprint_final/View/categories.dart';
import 'package:maxprint_final/View/productss.dart';
import 'package:maxprint_final/View/profile.dart';
import 'package:maxprint_final/View/searchDelgate.dart';
import 'package:maxprint_final/View/wishlist.dart';

class Home extends StatelessWidget {

  HomeController homeController = Get.put(HomeController());
  WishlistController wishlistController = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Obx((){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: AppColors.mainColor,
      ));
      return Scaffold(
          key: homeController.key,
          drawer: DrawerWidget.drawer(context),
          bottomNavigationBar: _btn_nav_bar(context),
          floatingActionButton: homeController.selectNavBar.value == 0 ? FloatingActionButton(
            onPressed: () {
              Global.launchURL(context,"https://tawk.to/chat/619513ee6885f60a50bc408a/1fkn5bndp");
            },
            child: const Icon(Icons.chat),
          ) : null,
          body: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: AppColors.secondaryColor,
              child: Obx(() {
                return PageView(
                  controller: homeController.pageController,
                  onPageChanged: (index){
                    homeController.selectNavBar.value = index;
                  },
                  children: [
                    _home(context),
                    Wishlist(),
                    Cart(),
                    Profile(),
                  ],
                );
                // return homeController.selectNavBar.value == 0 ? _home(context) :
                // homeController.selectNavBar.value == 1 ? Wishlist() :
                // homeController.selectNavBar.value == 2 ? Cart() : Profile();
              }),
            ),
          )
      );
    });
  }

  _btn_nav_bar(BuildContext context) {
    return Obx(() => Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      padding: const EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              homeController.pageController.animateToPage(0, duration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn);
              // homeController.pageController.jumpTo(0);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: homeController.selectNavBar.value == 0
                        ? const Icon(Icons.home,key: ValueKey(1) )
                        : const Icon(Icons.home_outlined,key: ValueKey(2))
                ),
                // Icon(homeController.selectNavBar.value == 0 ?
                // Icons.home : Icons.home_outlined),
                AppWidget.appText(
                    App_Localization.of(context).translate("home"),
                    Colors.black, 12,homeController.selectNavBar.value == 0 ?
                FontWeight.bold : FontWeight.normal)
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              homeController.pageController.animateToPage(1, duration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn);
              // homeController.selectNavBar.value = 1;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: homeController.selectNavBar.value == 1
                        ? const Icon(Icons.favorite,key: ValueKey(1) )
                        : const Icon(Icons.favorite_border,key: ValueKey(2))
                ),
                // Icon(homeController.selectNavBar.value == 1 ?
                // Icons.favorite : Icons.favorite_border),
                AppWidget.appText(
                    App_Localization.of(context).translate("wishlist"),
                    Colors.black, 12,homeController.selectNavBar.value == 1 ?
                FontWeight.bold : FontWeight.normal)
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              homeController.pageController.animateToPage(2, duration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn);
              // homeController.selectNavBar.value = 2;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: homeController.selectNavBar.value == 2
                        ? const Icon(Icons.shopping_cart,key: ValueKey(1) )
                        : const Icon(Icons.shopping_cart_outlined,key: ValueKey(2))
                ),
                // Icon(homeController.selectNavBar.value == 2 ?
                // Icons.shopping_cart : Icons.shopping_cart_outlined),
                AppWidget.appText(
                    App_Localization.of(context).translate("cart"),
                    Colors.black, 12,homeController.selectNavBar.value == 2 ?
                FontWeight.bold : FontWeight.normal)
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              homeController.pageController.animateToPage(3, duration: const Duration(milliseconds: 700), curve: Curves.fastOutSlowIn);
              // homeController.selectNavBar.value = 3;

            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: homeController.selectNavBar.value == 3
                  ? const Icon(Icons.person,key: ValueKey(1) )
                  : const Icon(Icons.person_outline,key: ValueKey(2))
                ),
                // Icon(homeController.selectNavBar.value == 3 ?
                // Icons.person : Icons.person_outline),
                AppWidget.appText(
                    App_Localization.of(context).translate("profile"),
                    Colors.black, 12,homeController.selectNavBar.value == 3?
                FontWeight.bold : FontWeight.normal)
              ],
            ),
          ),
        ],
      ),
    ));
  }
  _home(BuildContext context) {
    return SingleChildScrollView(
      child:
      Column(
        children: [
          _header(context),
          _body(context),
        ],
      ),
    );
  }
  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.mainColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      homeController.key.currentState!.openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                  SvgPicture.asset("assets/logo/logo.svg",
                    width: 30,
                    height: 30,
                  ),
                  IconButton(
                      onPressed: () {
                      },
                      icon: const Icon(Icons.menu,color: Colors.transparent,size: 35,)),
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
          const SizedBox(height: 5),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.14,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/home/homePicture.PNG',),
                    fit: BoxFit.fill
                )
            ),
          )
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppWidget.appText(
                  App_Localization.of(context).translate("our_categories"),
                  Colors.black54, 16, FontWeight.bold),
              GestureDetector(
                onTap: () {
                  Get.to(()=> Categories());
                },
                child: Container(
                  width: 90,
                  height: 30,
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child:  AppWidget.appText(
                        App_Localization.of(context).translate("view_all"),
                        Colors.black, 16, FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.18,
          // color: Colors.red,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: homeController.collection.length ~/2,
              itemBuilder: (context, index) {
                return _categories(homeController.collection[index],context, index);
              }),
        ),
        Divider(height: 20, color: Colors.grey.withOpacity(0.5),indent: MediaQuery.of(context).size.width * 0.05,endIndent: MediaQuery.of(context).size.width * 0.05),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppWidget.appText(
                  App_Localization.of(context).translate("our_products"),
                  Colors.black54, 16, FontWeight.bold),
              GestureDetector(
                onTap: () {
                 Get.to(()=> Productss(homeController.products));
                },
                child: Container(
                  width: 90,
                  height: 30,
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child:  AppWidget.appText(
                        App_Localization.of(context).translate("view_all"),
                        Colors.black, 16, FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
        homeController.loading.value ?
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Center(child: CircularProgressIndicator(color: AppColors.mainColor,))):
        homeController.products.isEmpty ?
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Center(
                child: AppWidget.appText(
                    App_Localization.of(context).translate("this_collection_is_empty"),
                    Colors.black,
                    16, FontWeight.bold))) :
        Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Container(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7/0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                ),
                itemCount: homeController.products.length > 10 ? 10 : homeController.products.length,
                itemBuilder: (BuildContext ctx, index) {
                  return  _products(homeController.products[index], context, index);
                }),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
  _categories(Collection collection,BuildContext context , int index) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: GestureDetector(
          onTap: () {
            homeController.selectedCategory(index);
            homeController.getProducts(collection);
          },
          child: SizedBox(
           width: MediaQuery.of(context).size.width * 0.23,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: MediaQuery.of(context).size.width * 0.22,
                  height: MediaQuery.of(context).size.width * 0.22,
                  decoration: BoxDecoration(
                    border: homeController.selectCategory.value == index
                    ? Border.all(color: AppColors.mainColor,width: 2)
                        : Border.all(color: Colors.grey),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(collection.image == null
                          ? "https://tahoban.ru/wp-content/themes/consultix/images/no-image-found-360x250.png"
                          : collection.image!.src.toString()),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Column(
                  children: [
                    Text(
                      collection.title.toString(),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: homeController.selectCategory.value == index ? Colors.black : Colors.black54,
                        fontWeight: homeController.selectCategory.value == index ? FontWeight.bold : FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
  _products(Product product,BuildContext context,int index) {
    return GestureDetector(
        onTap: () {
          homeController.goToProductPage(product);
        },
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child:Hero(
                      tag: "product-${product.id}",
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(product.image == null
                                ? "https://tahoban.ru/wp-content/themes/consultix/images/no-image-found-360x250.png"
                                : product.image!.src.toString()),
                          ),
                        ),
                      ),
                    ),),
                  const SizedBox(height: 5),
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  product.title.toString(),
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            ),
                          ),
                          const SizedBox(height: 5),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      double.parse( product.variants!.first.price!) == 0
                                          ? Text(
                                        App_Localization.of(context).translate('contact_us_for_price'),
                                        style: const TextStyle(
                                            fontSize: 12,
                                          color: Colors.black
                                        )
                                      )
                                          :
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
                                          product.variants!.first.compareAtPrice.toString() + " "
                                              + App_Localization.of(context).translate("AED"),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Obx(() => GestureDetector(
                                        onTap: () {
                                          homeController.products[index].favorite.value = ! homeController.products[index].favorite.value;
                                          if ( homeController.products[index].favorite.value) {
                                            wishlistController.addToWishlist(homeController.products[index]);
                                          }
                                          else {
                                            wishlistController.deleteFromWishlist(homeController.products[index]);
                                          }
                                        },
                                        child: !homeController.products[index].favorite.value
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
                                  )
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
            Positioned(
              child: product.variants!.first.compareAtPrice == null ?
              const Center() :
              Container(
                width: 100,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red,
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
            )
          ],
        )
    );
  }
  _pressed_on_search(BuildContext context) async {
    final result = await showSearch(
        context: context,
        delegate: SearchTextField(homeController: homeController));
  }
}


