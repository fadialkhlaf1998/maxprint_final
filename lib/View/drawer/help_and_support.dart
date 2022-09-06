import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: SafeArea(
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
      ),
    );
  }
  _header(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight:Radius.circular(30)
        ),
        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
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
                  height: MediaQuery.of(context).size.height * 0.15,
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
                child: AppWidget.appText(App_Localization.of(context).translate("help_support"),
                    Colors.black,20,FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            important_notes(context),
            const SizedBox(height: 20),
            cmykColors(context),
            const SizedBox(height: 10),
            noRGBColor(context),
            const SizedBox(height: 10),
            pantoneSupport(context),
            const SizedBox(height: 10),
            pdfFormat(context)
          ],
        )
    );
  }
  important_notes(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_outlined,color: AppColors.mainColor,size: 55),
          const SizedBox(width: 5),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppWidget.appText(
                    App_Localization.of(context).translate("important_notes"),
                    Colors.black, 18, FontWeight.bold),
                AppWidget.appText(
                    App_Localization.of(context).translate("before_ordering"),
                    Colors.black, 15, FontWeight.normal),
              ],
            ),
          )
        ],
      ),
    );
  }
  cmykColors(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/home/cmyk.webp")
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppWidget.appText(
                    App_Localization.of(context).translate("cmyk"),
                    Colors.black, 16, FontWeight.bold),
                AppWidget.appText(
                    App_Localization.of(context).translate("cmyk_description"),
                    Colors.black54, 13, FontWeight.normal),
              ],
            ),
          )
        ],
      ),
    );
  }
  noRGBColor(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/home/rgb.png")
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppWidget.appText(
                    App_Localization.of(context).translate("rgb"),
                    Colors.black, 16, FontWeight.bold) ,
                AppWidget.appText(
                    App_Localization.of(context).translate("rgb_description"),
                    Colors.black54, 13, FontWeight.normal),
              ],
            ),
          )
        ],
      ),
    );
  }
  pantoneSupport(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/home/pantone-support.png")
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppWidget.appText(
                    App_Localization.of(context).translate("support"),
                    Colors.black, 16, FontWeight.bold) ,
                AppWidget.appText(
                    App_Localization.of(context).translate("support_description"),
                    Colors.black54, 13, FontWeight.normal),
              ],
            ),
          )
        ],
      ),
    );
  }
  pdfFormat(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/home/pdf.png")
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppWidget.appText(
                    App_Localization.of(context).translate("pdf"),
                    Colors.black, 16, FontWeight.bold) ,
                AppWidget.appText(
                    App_Localization.of(context).translate("pdf_description"),
                    Colors.black54, 13, FontWeight.normal),
              ],
            ),
          )
        ],
      ),
    );
  }
}
