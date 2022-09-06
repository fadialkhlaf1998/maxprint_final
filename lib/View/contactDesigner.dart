import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/contactDesignerController.dart';


class ContactDesigner extends StatelessWidget {
  ContactDesigner() {contactDesignerController.clearTextfields();}

  ContactDesignerController contactDesignerController = Get.put(ContactDesignerController());

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
        color: AppColors.mainColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back,size: 28,)),
            AppWidget.appText(
                App_Localization.of(context).translate("request_for_designer"),
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
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: AppWidget.appText(
                    App_Localization.of(context).translate("request_for_designer_content"),
                    Colors.black, 15, FontWeight.normal),
              ),
              const SizedBox(height: 20),
              AppWidget.textFieldDesigner(contactDesignerController.name, const Icon(Icons.person_outline),"name", context,validate: contactDesignerController.nameValidate.value),
              const SizedBox(height: 10),
              AppWidget.textFieldDesigner(contactDesignerController.email, const Icon(Icons.email_outlined),"email", context,validate: contactDesignerController.emailValidate.value),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 40,
                child: TextField(
                  controller: contactDesignerController.phone,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      hintText: App_Localization.of(context).translate("phone"),
                      hintStyle: const TextStyle(color:Colors.grey, fontSize:15),
                      contentPadding: const EdgeInsets.all(5),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: contactDesignerController.phone.value.text.isEmpty && contactDesignerController.phoneValidate.value ? Colors.red : Colors.grey)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
                  ),
                  style: AppWidget.textFieldStyle(Colors.black, 15),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 40,
                child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 20,
                    controller: contactDesignerController.message,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.message),
                        hintText: App_Localization.of(context).translate("message"),
                        contentPadding: const EdgeInsets.all(5),
                        hintStyle: const TextStyle(color:Colors.grey, fontSize: 15),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: contactDesignerController.messageValidate.value ? Colors.grey:Colors.red)),
                        focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: contactDesignerController.messageValidate.value ? Colors.black:Colors.red))
                    ),
                    style: const TextStyle(color: Colors.black,fontSize: 15)
                ),
              )
            ],
          ),

          GestureDetector(
            onTap: () {
              contactDesignerController.sendRequest(context, contactDesignerController.name.text, contactDesignerController.email.text, contactDesignerController.phone.text,contactDesignerController.message.text);
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
                      Colors.black, 20, FontWeight.bold),
                )
            ),
          )
        ],
      ),
    );
  }
}
