import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/cartController.dart';
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/View/checkout.dart';

class Cart extends StatelessWidget {
  Cart({Key? key}) : super(key: key);

  CartController cartController = Get.find();

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
                    cartController.myOrd.isEmpty ?
                    Center(
                      child: Container(
                        height: 150,
                        alignment: Alignment.center,
                        child: AppWidget.appText(
                            App_Localization.of(context).translate("your_cart_is_empty"),
                            Colors.black, 16, FontWeight.bold),
                      )
                    ) :
                    _cart_body(context),
                  ],
                ),
              ),
              Positioned(child: _header(context)),
              cartController.myOrd.isEmpty ? const Center() :
              Positioned(
                bottom: 0,
                child: Global.user != null ?
                _checkout(context) : const Center()),
              cartController.loading.value ?
              Positioned(child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: AppColors.secondaryColor.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )) : const Center()
            ],
          ),
        ),
      ))
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
                    App_Localization.of(context).translate("cart"),
                    Colors.black, 20, FontWeight.bold),
              ],
            )
        ),
      ],
    );
  }
  _cart_body(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartController.myOrd.length,
                itemBuilder: (context, index) {
                  return Obx((){
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withOpacity(0.9),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 4,
                                offset: const Offset(0, 4), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(cartController.myOrd[index].product.value.image == null
                                          ? "https://tahoban.ru/wp-content/themes/consultix/images/no-image-found-360x250.png"
                                          : cartController.myOrd[index].product.value.image!.src
                                          .toString()),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(cartController.myOrd[index].product.value.title.toString(),
                                          maxLines: 1,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  AppWidget.appText("${double.parse(cartController.myOrd[index].product.value.variants!.first.price!) * cartController.myOrd[index].quantity.value}"
                                                      " ${App_Localization.of(context).translate("AED")}",
                                                      Colors.black, 15, FontWeight.bold),
                                                ],
                                              ),
                                              const SizedBox(height: 3),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    cartController.myOrd[index].product.value.variants!.first.compareAtPrice == null ? "" :
                                                    "${double.parse(cartController.myOrd[index].product.value.variants!.first.compareAtPrice!) * cartController.myOrd[index].quantity.value} ${App_Localization.of(context).translate("AED")}",
                                                    style: const TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 15,
                                                        decoration: TextDecoration.lineThrough,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Obx(() {
                                              return Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey.withOpacity(0.3),
                                                        border: Border.all(color: Colors.black54),
                                                        shape: BoxShape.circle
                                                    ),
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          cartController.increaseOnCart(cartController.myOrd[index], index);
                                                        },
                                                        child: const Icon(Icons.add,size: 20,)),
                                                  ),
                                                  const SizedBox(width: 10,),
                                                  Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey.withOpacity(0.3),
                                                        border: Border.all(color: Colors.black54),
                                                        shape: BoxShape.circle
                                                    ),
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          cartController.increaseOnCart(cartController.myOrd[index], index);
                                                        },
                                                        child: Center(
                                                          child: AppWidget.appText(cartController.myOrd[index].quantity.toString(),
                                                              Colors.black, 15, FontWeight.bold),
                                                        )),
                                                  ),
                                                  const SizedBox(width: 10,),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey.withOpacity(0.3),
                                                        border: Border.all(color: Colors.black54),
                                                        shape: BoxShape.circle
                                                    ),
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          cartController.decreaseFromCart(cartController.myOrd[index], index);
                                                        },
                                                        child: const Icon(  Icons.remove,size: 20)),
                                                  ),
                                                ],
                                              );
                                            }),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      cartController.deleteFromCart(cartController.myOrd[index]);
                                                    },
                                                    icon: const Icon(Icons.delete, color: Colors.red,size: 30,)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  });
                },
              ),
            ),
          ),
        ),
        SizedBox( height: MediaQuery.of(context).size.height * 0.2)
      ],
    );
  }
  _checkout(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(3, -4), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10,),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppWidget.appText(
                        App_Localization.of(context).translate("total"),
                        Colors.black, 14, FontWeight.bold),
                    const SizedBox(width: 5),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints constraints) {
                          final boxWidth = constraints.constrainWidth();
                          const dashWidth = 4.0;
                          const dashHeight = 1.0;
                          final dashCount = (boxWidth / (2 * dashWidth)).floor();
                          return Flex(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            direction: Axis.horizontal,
                            children: List.generate(dashCount, (_) {
                              return const SizedBox(
                                width: dashWidth,
                                height: dashHeight,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(color: Colors.black),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    AppWidget.appText(cartController.total.toString(), Colors.black, 14, FontWeight.bold),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  cartController.loading.value = true;
                  Get.to(() => Checkout())!.then((value) {
                    cartController.loading.value = false;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: AppWidget.appText(
                            App_Localization.of(context).translate("checkout"),
                            Colors.black, 16, FontWeight.bold),
                      )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
