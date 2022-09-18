import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/addressController.dart';
import 'package:maxprint_final/Helper/global.dart';

class CreateAddress extends StatelessWidget {
  CreateAddress({Key? key}) : super(key: key){
    addressController.back();
  }

  AddressController addressController = Get.find();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Obx(() => Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: AppColors.mainColor,
            elevation: 0,
          )
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.secondaryColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                const SizedBox(height: 10),
                _add_address(context),
              ],
            ),
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
            AppWidget.appText(App_Localization.of(context).translate("create_address"),
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
  _add_address(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: Column(
                children: [
                  AppWidget.checkoutTextField(addressController.address1, "address1", context, MediaQuery.of(context).size.width * 0.9, 40,addressController.address1Validate.value),
                  const SizedBox(height: 20),
                  AppWidget.checkoutTextField(addressController.address2, "address2", context, MediaQuery.of(context).size.width * 0.9, 40,addressController.address2Validate.value),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButton<String>(
                          dropdownColor: AppColors.mainColor,
                          isExpanded: true,
                          hint: AppWidget.appText(App_Localization.of(context).translate("country_region"),
                              Colors.black, 15, FontWeight.normal),
                          value: addressController.country.value=="non"?null:addressController.country.value,
                          items: addressController.countries.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: AppWidget.appText(App_Localization.of(context).translate(value),
                                  Colors.black, 15, FontWeight.normal),
                            );
                          }).toList(),
                          underline: Container(color: addressController.countryValidate.value && addressController.country.value=="non"?Colors.red:Colors.grey,height: 1),
                          onChanged: (val) {
                            addressController.country.value=val.toString();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButton<String>(
                          dropdownColor: AppColors.mainColor,
                          isExpanded: true,
                          hint: AppWidget.appText(App_Localization.of(context).translate("emirate"),
                              Colors.black, 15, FontWeight.normal),
                          value: addressController.emirate.value=="non"?null:addressController.emirate.value,
                          items: addressController.emirates.value.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: AppWidget.appText(App_Localization.of(context).translate(value),
                                  Colors.black, 15, FontWeight.normal),
                            );
                          }).toList(),
                          underline: Container(color: addressController.emirateValidate.value && addressController.emirate.value=="non"?Colors.red:Colors.grey,height: 1),
                          onChanged: (val) {
                            addressController.emirate.value=val.toString();
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
                                controller: addressController.phone,
                                maxLength: 9,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: App_Localization.of(context).translate("phone"),
                                    hintStyle: const TextStyle(color:Colors.black, fontSize:15),
                                    prefix: const Text("+971 "),
                                    prefixStyle: const TextStyle(color: Colors.transparent,fontSize: 15),
                                    enabledBorder: addressController.phoneValidate.value&&addressController.phone.value.text.isEmpty?const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)):const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black))
                                ),
                                style: AppWidget.textFieldStyle(Colors.black, 15),
                              ),
                              Positioned(child: SizedBox(
                                height: Global.languageCode == "en" ? 35 : 40,
                                width: 40,
                                child: const Center(child: Text("+971" "  ",style: TextStyle(fontSize: 15),),),
                              ),),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              addressController.addAddress(context,addressController.address1.text,
                  addressController.address2.text,addressController.country.value,
                  addressController.emirate.value,addressController.phone.text);
            },
            child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: 50,
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
                ),
                child: Center(
                  child: AppWidget.appText(
                      App_Localization.of(context).translate("create"),
                      Colors.black, 18, FontWeight.bold),
                )
            ),
          ),
        ],
      ),
    );
  }
}
