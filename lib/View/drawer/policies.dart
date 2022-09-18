import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/homeController.dart';
import 'package:maxprint_final/View/drawer/policy_page.dart';

class Policies extends StatelessWidget {
  Policies({Key? key}) : super(key: key);

  var open = false.obs;
  HomeController homeController = Get.find();

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
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.secondaryColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                const SizedBox(height: 30),
                _body(context),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      )
    );
  }
  _header(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight:Radius.circular(30)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 0,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back,color: Colors.black,size: 28,)),
              Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  color: AppColors.mainColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Center(
                        child: SvgPicture.asset("assets/logo/logo.svg",
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ],
                  )
              ),
              IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back,color: Colors.transparent,size: 28,)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: AppWidget.appText(App_Localization.of(context).translate("policies"),
                    Colors.black,20,FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return Column(
      children: [
        _privacy(context),
        _refund(context),
        _return(context),
        _shipping(context),
        _terms_of_services(context)
      ],
    );
  }
  _privacy(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PolicyPage(App_Localization.of(context).translate("privacy_policy"),
            App_Localization.of(context).translate("privacy_policy_content")));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.mainColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppWidget.appText(
                App_Localization.of(context).translate("privacy_policy"),
                Colors.black, 16, FontWeight.normal),
            const Icon(Icons.arrow_forward_ios,size: 20,)
          ],
        ),
      ),
    );
  }
  _refund(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PolicyPage(App_Localization.of(context).translate("refund_policy"),
            App_Localization.of(context).translate("refund_policy_content")));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppWidget.appText(
                App_Localization.of(context).translate("refund_policy"),
                Colors.black, 16, FontWeight.normal),
            const Icon(Icons.arrow_forward_ios,size: 20,)
          ],
        ),
      ),
    );
  }
  _return(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
        homeController.key.currentState!.openEndDrawer();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),

        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.mainColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppWidget.appText(
                App_Localization.of(context).translate("return_policy"),
                Colors.black, 16, FontWeight.normal),
            const Icon(Icons.arrow_forward_ios,size: 20,)
          ],
        ),
      ),
    );
  }
  _shipping(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
        homeController.key.currentState!.openEndDrawer();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),

        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppWidget.appText(
                App_Localization.of(context).translate("shipping_policy"),
                Colors.black, 16, FontWeight.normal),
            const Icon(Icons.arrow_forward_ios,size: 20,)
          ],
        ),
      ),
    );
  }
  _terms_of_services(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PolicyPage(App_Localization.of(context).translate("terms_of_service"),
            App_Localization.of(context).translate("terms_of_services_content")));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.mainColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppWidget.appText(
                App_Localization.of(context).translate("terms_of_service"),
                Colors.black, 16, FontWeight.normal),
            const Icon(Icons.arrow_forward_ios,size: 20,)
          ],
        ),
      ),
    );
  }
}
