import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/addressController.dart';
import 'package:maxprint_final/Controller/homeController.dart';
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/View/createAddress.dart';

class Address extends StatelessWidget {
  // Address() { addressController.getAddress(); }

  AddressController addressController = Get.put(AddressController());
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Obx(() => Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateAddress());
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.secondaryColor,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    _header(context),
                    _addresses(context),
                  ],
                ),
              ),
              addressController.loading.value ?
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
      ),
    ));
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
                icon: const Icon(Icons.arrow_back,size: 28,)),
            AppWidget.appText(App_Localization.of(context).translate("address"),
                Colors.black, 20, FontWeight.bold),
            IconButton(
                onPressed: () {
                  //menu
                },
                icon: const Icon(Icons.menu,color: Colors.transparent,)),
          ],
        )
    );
  }
  _addresses(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: addressController.addresses.isEmpty ? 20 : 0),
        addressController.addresses.isEmpty && !addressController.loading.value ?
        Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
              ),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: AppWidget.appText(
                            App_Localization.of(context).translate("dear") + ", " +
                                Global.customer!.firstName! + " " + Global.customer!.lastName! , Colors.black, 16, FontWeight.w500)
                    ),
                    Center(
                      child: AppWidget.appText(
                            App_Localization.of(context).translate("no_address") + ", " +
                                App_Localization.of(context).translate("add_address"), Colors.black, 15, FontWeight.normal)
                    ),
                  ],
                ),
              ),
            )
        : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -MediaQuery.of(context).size.height * 0.25,
                child:  ListView.builder(
                  itemCount: addressController.addresses.length,
                  //physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    AppWidget.appText(App_Localization.of(context).translate("address1") + ": ",
                                        Colors.black, 15, FontWeight.bold),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Text(
                                        addressController.addresses[index].address1!.toString(),
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),

                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    AppWidget.appText( App_Localization.of(context).translate("address2") + ": ",
                                        Colors.black, 15, FontWeight.bold),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Text(
                                        addressController.addresses[index].address2!.toString(),
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),

                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    AppWidget.appText(App_Localization.of(context).translate("country")+ ": ",
                                        Colors.black, 15, FontWeight.bold),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Text(
                                        addressController.addresses[index].countryName.toString(),
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),

                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                      AppWidget.appText(App_Localization.of(context).translate("emirate")+ ": ",
                                          Colors.black, 15, FontWeight.bold),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.45,
                                      child: Text(
                                        addressController.addresses[index].city.toString(),
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),

                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    AppWidget.appText(App_Localization.of(context).translate("phone")+ ": ",
                                        Colors.black, 15, FontWeight.bold),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.45,
                                      child: Text(
                                        addressController.addresses[index].phone.toString(),
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),

                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                 GestureDetector(
                                  onTap: () {
                                    if(addressController.addresses[index].defaultAddressDefault == true) {
                                      print('########################################################');
                                      print(addressController.addresses[index].defaultAddressDefault);
                                    }
                                    else {
                                      addressController.setDefault(addressController.addresses[index]);
                                    }
                                    },
                                  child: Container(
                                    width: 60,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: addressController.addresses[index].defaultAddressDefault == true ?
                                        AppColors.mainColor : Colors.grey.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: AppWidget.appText(App_Localization.of(context).translate("default"),
                                        Colors.black, 14,FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                GestureDetector(
                                  onTap: () {
                                    addressController.deleteAddress(context,addressController.addresses[index]);
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: AppWidget.appText(
                                      App_Localization.of(context).translate("delete"),
                                        Colors.white, 14,FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ),
          ),
            ),
        SizedBox( height: MediaQuery.of(context).size.height * 0.2)
      ],
    );
  }
}
