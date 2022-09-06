import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/cartController.dart';
import 'package:maxprint_final/Controller/checkoutController.dart';
import 'package:maxprint_final/Helper/global.dart';

class Checkout extends StatelessWidget {
  Checkout({Key? key}) : super(key: key);

  CheckoutController checkoutController = Get.put(CheckoutController());
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
                      checkoutController.selected.value == 0 ?
                      _shippingAddress(context) : checkoutController.selected.value == 1 ?
                      _payment(context) : _summary(context),
                      const SizedBox(height: 10),
                      _footer(context),
                      const SizedBox(height: 30,)
                    ],
                  ),
                ),
                Positioned(child: _header(context))
              ],
            ),
        ),
      ))
    );
  }

  _header(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.1,
        color: AppColors.mainColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
              //    Get.back();
                },
                icon: const Icon(Icons.arrow_back,size: 35,)),
            AppWidget.appText(App_Localization.of(context).translate("checkout"),
                Colors.black, 25, FontWeight.bold),
            IconButton(
                onPressed: () {
                  //menu
                },
                icon: const Icon(Icons.menu,color: Colors.transparent,)),
          ],
        )
    );
  }
  _footer(BuildContext context){
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.1,
      width: MediaQuery.of(context).size.width,
      child: checkoutController.selected.value == 2 ?
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){
              AppWidget.successMsg(context,App_Localization.of(context).translate("order_saved"));
              Get.back();
              cartController.clearCart();
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width*0.35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.mainColor,width: 2),
                  color: AppColors.mainColor
              ),
              child: Center(
                  child: AppWidget.appText(
                    App_Localization.of(context).translate("done"),
                  Colors.black, 18, FontWeight.normal)
              ),
            ),
          ),
        ],
      )
          :Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){
              checkoutController.back();
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.mainColor,width: 2),
              ),
              child: Center(
                  child: AppWidget.appText(
                      App_Localization.of(context).translate("back"),
                      Colors.black, 18, FontWeight.normal)
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              checkoutController.next(context);
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width*0.35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.mainColor,width: 2),
                  color: AppColors.mainColor
              ),
              child: Center(
                  child: AppWidget.appText(
                      App_Localization.of(context).translate("next"),
                      Colors.black, 18, FontWeight.normal)
              ),
            ),
          ),
        ],
      ),
    );
  }
  _shippingAddress(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: AppWidget.appText(
                App_Localization.of(context).translate("shipping_address"),
                Colors.black, 25, FontWeight.normal),
          )
        ),
        const SizedBox(height: 10,),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppWidget.checkoutTextField(checkoutController.firstName, "first_name", context, MediaQuery.of(context).size.width * 0.38, 40,checkoutController.noAddress.value),
                    AppWidget.checkoutTextField(checkoutController.lastName, "last_name", context, MediaQuery.of(context).size.width * 0.38, 40,checkoutController.noAddress.value),
                  ],
                ),
                const SizedBox(height: 20),
                AppWidget.checkoutTextField(checkoutController.address1, "address1", context, MediaQuery.of(context).size.width * 0.9, 40,checkoutController.noAddress.value),
                const SizedBox(height: 20),
                AppWidget.checkoutTextField(checkoutController.address2, "address2", context, MediaQuery.of(context).size.width * 0.9, 40,checkoutController.noAddress.value),
                //SizedBox(height: 20),
                //AppWidget.checkoutTextField(checkoutController.city, "city", context, MediaQuery.of(context).size.width * 0.9, 40,checkoutController.noAddress.value),
                //SizedBox(height: 20),
                //AppWidget.checkoutTextField(checkoutController.province, "province", context, MediaQuery.of(context).size.width * 0.9, 40,checkoutController.noAddress.value),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButton<String>(
                        dropdownColor: AppColors.mainColor,
                        isExpanded: true,
                        hint:  AppWidget.appText(App_Localization.of(context).translate("country_region"),
                            Colors.black, 15, FontWeight.normal),
                        value: checkoutController.country.value=="non"?null:checkoutController.country.value,
                        items: checkoutController.countries.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: AppWidget.appText(App_Localization.of(context).translate(value),
                                Colors.black, 15, FontWeight.normal),
                          );
                        }).toList(),
                        underline: Container(color: checkoutController.noAddress.value && checkoutController.country.value=="non"?Colors.red:Colors.grey,height: 1),
                        onChanged: (val) {
                          checkoutController.country.value=val.toString();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButton<String>(
                        dropdownColor: AppColors.mainColor,
                        isExpanded: true,
                        hint: AppWidget.appText(App_Localization.of(context).translate("emirate"),
                            Colors.black, 15, FontWeight.normal),
                        value: checkoutController.emirate.value=="non"?null:checkoutController.emirate.value,
                        items: checkoutController.emirates.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: AppWidget.appText(App_Localization.of(context).translate(value),
                                Colors.black, 15, FontWeight.normal),
                          );
                        }).toList(),
                        underline: Container(color: checkoutController.noAddress.value&&checkoutController.emirate.value=="non"?Colors.red:Colors.grey,height: 1),
                        onChanged: (val) {
                          checkoutController.emirate.value=val.toString();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: Global.languageCode == "en" ? 55 : 66,
                        child: Stack(
                          children: [
                            TextField(
                              controller: checkoutController.phone,
                              maxLength: 9,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: App_Localization.of(context).translate("phone"),
                                  hintStyle: const TextStyle(color:Colors.black, fontSize:15),
                                  prefix: const Text("+971"),
                                  prefixStyle: const TextStyle(color: Colors.transparent,fontSize: 15),
                                  enabledBorder: checkoutController.noAddress.value&&checkoutController.phoneValidate.value?const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)):const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.mainColor))
                              ),
                              style: AppWidget.textFieldStyle(Colors.black, 15),
                            ),
                            Positioned(child: SizedBox(
                              height: Global.languageCode == "en" ? 35 : 40,
                              width: 40,
                              child: const Center(child: Text("+971" "  ",style: TextStyle(fontSize: 15))),
                            ),),
                          ],
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
  _payment(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: AppWidget.appText(
                  App_Localization.of(context).translate("payment"),
                  Colors.black, 25, FontWeight.normal),
            )
        ),
        Card(
          elevation: 5,
          color: AppColors.mainColor,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(

            ),
            child: ListTile(
              onTap: (){
                checkoutController.addOrder(context);
                checkoutController.selected.value ++;
                checkoutController.selectValue.value = true;
              },
              leading: const CircleAvatar(
                child: Icon(Icons.delivery_dining,color: Colors.black,),
              ),
              title: const Text("COD"),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.64-MediaQuery.of(context).padding.top,)
      ],
    );
  }
  _summary(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: AppWidget.appText(
                  App_Localization.of(context).translate("summary"),
                  Colors.black, 25, FontWeight.normal),
            )
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.23,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: cartController.myOrd.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  color: AppColors.secondaryColor,
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
                                image: NetworkImage(cartController.myOrd[index].product.value.image == null
                                    ? "https://tahoban.ru/wp-content/themes/consultix/images/no-image-found-360x250.png"
                                    : cartController.myOrd[index].product.value.image!.src.toString()),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              App_Localization.of(context).translate("title") + ": " +  cartController.myOrd[index].product.value.title.toString(),
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child:  AppWidget.appText(
                              App_Localization.of(context).translate("price") + ": " + cartController.myOrd[index].product.value.variants!.first.price!.toString() + " " +
                                  App_Localization.of(context).translate("AED"),
                              Colors.black, 14, FontWeight.normal),
                        ),
                        Expanded(
                          flex: 1,
                          child: AppWidget.appText(
                              App_Localization.of(context).translate("quantity") + ": " + cartController.myOrd[index].quantity.toString(),
                              Colors.black, 14, FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 50),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppWidget.appText(
                    App_Localization.of(context).translate("total"),
                    Colors.black, 20, FontWeight.bold),
                AppWidget.appText(cartController.getTotal().toString(), Colors.black, 20, FontWeight.bold),
              ],
            ),
          ),
        )
      ],
    );
  }

}
