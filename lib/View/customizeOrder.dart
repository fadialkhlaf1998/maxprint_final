import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/customizeOrderController.dart';


class CustomizeOrder extends StatelessWidget {
  CustomizeOrder() {
    customizeOrderController.clearTextfields();
  }

  CustomizeOrderController customizeOrderController = Get.put(CustomizeOrderController());

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
                  const SizedBox(height: 20),
                  _body(context)
                ],
              ),
            ),
          ),
        ),)
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
                icon: const Icon(Icons.arrow_back,size: 28,)),
            AppWidget.appText(
                App_Localization.of(context).translate("customize_this_order"),
                Colors.black, 20, FontWeight.bold),
            IconButton(
                onPressed: () {
                  //menu
                },
                icon: const Icon(Icons.menu,color: Colors.transparent,size: 10,)),
          ],
        )
    );
  }
  _body(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(
                    App_Localization.of(context).translate("customize_this_order_content"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  )
              ),
              const SizedBox(height: 20),
              AppWidget.textFieldDesigner(customizeOrderController.name, const Icon(Icons.person_outline), "name", context,validate: customizeOrderController.nameValidate.value),
              const SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 40,
                child: TextField(
                  controller: customizeOrderController.phone,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      hintText: App_Localization.of(context).translate("phone"),
                      hintStyle: const TextStyle(color:Colors.grey, fontSize:14),
                      contentPadding: const EdgeInsets.all(5),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: customizeOrderController.phone.value.text.isEmpty && customizeOrderController.phoneValidate.value ? Colors.red : Colors.grey)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
                  ),
                  style: AppWidget.textFieldStyle(Colors.black, 14),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery.of(context).size.width * 0.8,
                // height: 25,
                child: Text(
                  App_Localization.of(context).translate("optional"),
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              AppWidget.textFieldDesigner(customizeOrderController.email, const Icon(Icons.email_outlined), "email", context),
              const SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery.of(context).size.width * 0.8,
                // height: 25,
                child: Text(
                  App_Localization.of(context).translate("optional"),
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 40,
                child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 20,
                    controller: customizeOrderController.message,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.message),
                        hintText: App_Localization.of(context).translate("message"),
                        contentPadding: const EdgeInsets.all(5),
                        hintStyle: const TextStyle(color:Colors.grey, fontSize: 14),
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
                    ),
                    style: const TextStyle(color: Colors.black,fontSize: 14)
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () async{
              customizeOrderController.sendRequest(context, customizeOrderController.name.text, customizeOrderController.email.text, customizeOrderController.phone.text,customizeOrderController.message.text);
            },
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 50,
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
                ),
                child: Center(
                  child: AppWidget.appText(
                      App_Localization.of(context).translate("send_request"),
                      Colors.black, 18, FontWeight.bold),
                )
            ),
          ),
        ],
      ),
    );
  }
}
