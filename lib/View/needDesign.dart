import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/needDesignController.dart';


class NeedDesign extends StatelessWidget {
  NeedDesign() {
    needDesignController.clearTextfields();
  }

  NeedDesignController needDesignController = Get.put(NeedDesignController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: AppBar(
              backgroundColor: AppColors.mainColor,
              elevation: 0,
            )
        ),
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
                    App_Localization.of(context).translate("request_for_designer_content"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  )
                // AppWidget.appText(
                //     App_Localization.of(context).translate("request_for_designer_content"),
                //     Colors.black, 14, FontWeight.normal),
              ),
              const SizedBox(height: 20),
              AppWidget.textFieldDesigner(needDesignController.name, const Icon(Icons.person_outline), "name", context,validate: needDesignController.nameValidate.value),
              const SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 40,
                child: TextField(
                  controller: needDesignController.phone,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone,size: 18,),
                      hintText: App_Localization.of(context).translate("phone"),
                      hintStyle: const TextStyle(color:Colors.grey, fontSize: 14),
                      contentPadding: const EdgeInsets.all(5),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: needDesignController.phone.value.text.isEmpty && needDesignController.phoneValidate.value ? Colors.red : Colors.grey)),
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
              AppWidget.textFieldDesigner(needDesignController.email, const Icon(Icons.email_outlined), "email", context),
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
                    controller: needDesignController.message,
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
          GestureDetector(
            onTap: () async{
              needDesignController.sendRequest(context, needDesignController.name.text, needDesignController.email.text, needDesignController.phone.text,needDesignController.message.text);
            },
            child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: 45,
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
                ),
                child: Center(
                  child: AppWidget.appText(
                      App_Localization.of(context).translate("send_request"),
                      Colors.black, 16, FontWeight.bold),
                )
            ),
          ),
        ],
      ),
    );
  }
}
