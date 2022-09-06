import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/languageController.dart';
import 'package:maxprint_final/Helper/global.dart';

class Languages extends StatelessWidget {
  Languages() {
    if(Global.languageCode == "en") {
      languagesController.selectValue.value = 0;}
    else {languagesController.selectValue.value = 1;}
  }

  LanguagesController languagesController = Get.put(LanguagesController());

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back,size: 28,)),
              AppWidget.appText(App_Localization.of(context).translate("language"),
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
  _body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: languagesController.languages.length,
            itemBuilder: (context,index) {
              return Obx(()=> GestureDetector(
                onTap: () {
                  Global.saveLanguage(context, languagesController.languages[index]['id']);
                  languagesController.selectValue.value = index;
                  if(languagesController.languages[index]['id'] == "en" ) {
                    languagesController.value = languagesController.languages[index]["name"];
                  }
                  else {
                    languagesController.value = languagesController.languages[index]["name"];
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child:  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppWidget.appText(
                              languagesController.languages[index]['id'] == "en"?
                              App_Localization.of(context).translate("english") :
                              App_Localization.of(context).translate("arabic"),
                              Colors.black, 16, FontWeight.normal),

                          Icon(
                            Icons.check,
                            color: languagesController.selectValue.value == index ?
                            Colors.black : Colors.transparent,size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
            },
          ),
        )
      ],
    );
  }

}
