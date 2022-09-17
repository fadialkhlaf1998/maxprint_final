import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/View/drawer/about.dart';
import 'package:maxprint_final/View/drawer/help_and_support.dart';
import 'package:maxprint_final/View/drawer/languages.dart';
import 'package:maxprint_final/View/drawer/policies.dart';
import 'package:maxprint_final/View/signIn.dart';
import 'package:maxprint_final/View/welcome.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget {

  static drawer(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        backgroundColor: AppColors.secondaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.17,
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
              const SizedBox(height: 20,),
              Container(
                height: MediaQuery.of(context).size.height  * 0.32,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppWidget.appText(
                                App_Localization.of(context).translate("home"),
                                Colors.black, 16, FontWeight.normal),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => Languages());
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppWidget.appText(
                                App_Localization.of(context).translate("language"),
                                Colors.black, 16, FontWeight.normal),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const About());
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppWidget.appText(
                                App_Localization.of(context).translate("about_us"),
                                Colors.black, 16, FontWeight.normal),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => Policies());
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppWidget.appText(
                                App_Localization.of(context).translate("policies"),
                                Colors.black, 16, FontWeight.normal),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const HelpSupportPage());
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppWidget.appText(
                                App_Localization.of(context).translate("help_support"),
                                Colors.black, 16, FontWeight.normal),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Global.launchURL(context, "https://wa.me/971551073649/?text=Hi");
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppWidget.appText(
                                App_Localization.of(context).translate("whatsapp"),
                                Colors.black, 16, FontWeight.normal),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Global.user!=null ? 20 : 0),
              Global.user != null ?
              GestureDetector(
                onTap: () {
                  Global.logout();
                  Get.offAll(()=> SignIn());
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppWidget.appText(
                          App_Localization.of(context).translate("logout"),
                          Colors.black, 16, FontWeight.normal),
                    ],
                  ),
                ),
              ) : const Center(),
              const SizedBox(height: 20),
              AppWidget.divider(0.5, Colors.grey, 0,0),
              _need_help(context),
              AppWidget.divider(0.5, Colors.grey, 0,0),
              _follow_us(context),
              AppWidget.divider(0.5, Colors.grey, 0,0),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Column(
                    children: [
                      AppWidget.appText(
                          "Version " "1.0.0",
                          Colors.grey, 13, FontWeight.normal),
                      AppWidget.appText(
                          "Powered By Maxart",
                          Colors.grey, 13, FontWeight.normal),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
  static _need_help(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppWidget.appText(
                  App_Localization.of(context).translate("need_help"),
                  Colors.grey, 14, FontWeight.normal),
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              if(await canLaunch('tel: +971 43433633')){
              await launch('tel: +971 43433633', forceSafariVC: false);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.settings_phone,color: Colors.black,size: 20),
                const SizedBox(width: 10),
                AppWidget.appText(
                    "+971 4 3433 633",
                    Colors.grey, 14, FontWeight.normal),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              String email = 'info@maxprint_final.ae';
              String emailUrl = "mailto:$email";
              try {
                await launch(emailUrl, enableJavaScript: true);
              } catch (e) {
                print(e.toString());
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.email_outlined,color: Colors.black,size: 22),
                const SizedBox(width: 10),
                AppWidget.appText(
                    "info@maxprint_final.ae",
                    Colors.grey, 14, FontWeight.normal),
              ],
            ),
          ),
        ],
      ),
    );
  }
  static _follow_us(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppWidget.appText(
                  App_Localization.of(context).translate("follow_us"),
                  Colors.grey, 14, FontWeight.normal),
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Global.launchURL(context,"https://www.facebook.com/printingoffers.ae");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: SvgPicture.asset("assets/socialMedia/facebook.svg",
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                AppWidget.appText(
                    App_Localization.of(context).translate("facebook"),
                    Colors.grey, 14, FontWeight.normal),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Global.launchURL(context,"https://twitter.com/printoffers_ae");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: SvgPicture.asset("assets/socialMedia/twitter.svg",
                      width: 20,
                      height: 15,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                AppWidget.appText(
                    App_Localization.of(context).translate("twitter"),
                    Colors.grey, 14, FontWeight.normal),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Global.launchURL(context,"https://www.instagram.com/accounts/login/?next=/printingoffers.ae/");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: SvgPicture.asset("assets/socialMedia/instagram.svg",
                      width: 20,
                      height: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                AppWidget.appText(
                    App_Localization.of(context).translate("instagram"),
                    Colors.grey, 14, FontWeight.normal),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Global.launchURL(context,"https://www.linkedin.com/authwall?trk=ripf&trkInfo=AQHDag-0thfC9AAAAYA75DBgyf_CLGi5473iZyavjcLa0sPS8Z0H-2QVBdACebQhVr8SNB8AVNvYvSlxQQuZMqfjzxyXGD4Un-uGE8SKxXJBY-jD0d-cfjwsAAQ0hx5JwLKOIgA=&originalReferer=https://www.maxprint_final.ae/&sessionRedirect=https%3A%2F%2Fwww.linkedin.com%2Fcompany%2Fprinting-offers-dubai");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    image: const DecorationImage(
                      image: AssetImage("assets/socialMedia/linkedin.png")
                    )
                  ),
                ),
                const SizedBox(width: 10),
                AppWidget.appText(
                    App_Localization.of(context).translate("linkedin"),
                    Colors.grey, 14, FontWeight.normal),
              ],
            ),
          ),
        ],
      ),
    );
  }

}