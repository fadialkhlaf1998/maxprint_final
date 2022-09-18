import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

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
      ),
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
        ],
      ),
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
                child: AppWidget.appText(App_Localization.of(context).translate("about_us"),
                    Colors.black, 20, FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Center(
        child:   Text(
          App_Localization.of(context).translate("about"),
          textAlign: TextAlign.justify,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        // AppWidget.appText(
        //   App_Localization.of(context).translate("about"),
        //     Colors.black, 15, FontWeight.normal),
      ),
    );
  }
}
