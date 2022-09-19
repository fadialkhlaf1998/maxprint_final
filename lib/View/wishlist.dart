import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/wishlistController.dart';
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/View/signIn.dart';
import 'package:maxprint_final/View/signUp.dart';

class Wishlist extends StatelessWidget {
  Wishlist({Key? key}) : super(key: key);

  WishlistController wishlistController = Get.find();

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
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    // Global.user == null ?
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.4,
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       AppWidget.appText(App_Localization.of(context).translate("please_login_first"), Colors.black, 18, FontWeight.normal),
                    //       const SizedBox(height: 10,),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           GestureDetector(
                    //             onTap: (){
                    //               Get.to(()=>SignUp());
                    //             },
                    //             child: Container(
                    //               width: MediaQuery.of(context).size.width*0.3,
                    //               height: 35,
                    //               decoration: BoxDecoration(
                    //                   color: AppColors.mainColor,
                    //                   borderRadius: BorderRadius.circular(20),
                    //                   border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
                    //
                    //               ),
                    //               child: Center(
                    //                 child: AppWidget.appText(App_Localization.of(context).translate("sign_up"), Colors.black, 15, FontWeight.normal),
                    //               ),
                    //             ),
                    //           ),
                    //           const SizedBox(width: 10),
                    //           AppWidget.appText(App_Localization.of(context).translate("or"), Colors.black, 18, FontWeight.bold),
                    //           const SizedBox(width: 10),
                    //           GestureDetector(
                    //             onTap: (){
                    //               Get.to(()=>SignIn());
                    //             },
                    //             child: Container(
                    //               width: MediaQuery.of(context).size.width*0.3,
                    //               height: 35,
                    //               decoration: BoxDecoration(
                    //                   color: AppColors.mainColor,
                    //                   borderRadius: BorderRadius.circular(20),
                    //                   border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
                    //               ),
                    //               child: Center(
                    //                 child: AppWidget.appText(App_Localization.of(context).translate("sign_in"), Colors.black, 15, FontWeight.normal),
                    //               ),
                    //             ),
                    //           )
                    //         ],
                    //       )
                    //
                    //     ],
                    //   ),
                    // ) :
                    wishlistController.wishlist.isEmpty ?
                        Center(
                          child: Container(
                            alignment: Alignment.center,
                            height: 150,
                            child: AppWidget.appText(
                                App_Localization.of(context).translate("your_wishlist_is_empty"),
                                Colors.black, 16, FontWeight.bold),
                          )
                        ) :
                    _wishlist_body(context)
                  ],
                ),
              ),
             Positioned(child: _header(context))
            ],
          ),
        ),
      ),)
    );
  }

  _header(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.mainColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
                // border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 0,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               AppWidget.appText(
               App_Localization.of(context).translate("your_wishlist"),
               Colors.black, 20, FontWeight.bold),
              ],
            )
        ),
      ],
    );
  }
  _wishlist_body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7/0.8,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5
            ),
            itemCount: wishlistController.wishlist.length,
            itemBuilder: (BuildContext ctx, index) {
              return Card(
                elevation: 5,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child:Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(wishlistController.wishlist[index].image == null
                                ? "https://tahoban.ru/wp-content/themes/consultix/images/no-image-found-360x250.png"
                                : wishlistController.wishlist[index].image!.src.toString()),
                          ),
                        ),
                      ),),
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                wishlistController.wishlist[index].title.toString(),
                                maxLines: 2,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  double.parse(wishlistController.wishlist[index].variants!.first.price!) == 0
                                  ?  Text(
                                      App_Localization.of(context).translate('contact_us_for_price'),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black
                                      )
                                  )
                                      :
                                  Container(
                                    child: AppWidget.appText(wishlistController.wishlist[index].variants!.first.price.toString() + " AED",
                                        Colors.black, 15, FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      wishlistController.deleteFromWishlist(wishlistController.wishlist[index]);
                                    },
                                    child: const Icon(Icons.delete,color: Colors.red,size: 25,),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

}
