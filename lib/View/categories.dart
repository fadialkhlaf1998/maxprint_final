import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/cartegoriesController.dart';
import 'package:maxprint_final/Controller/homeController.dart';
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/View/home.dart';
import 'package:maxprint_final/View/searchDelgate.dart';

class Categories extends StatelessWidget {
  Categories({Key? key}) : super(key: key);

  HomeController homeController = Get.find();
  CategoriesController categoriesController = Get.put(CategoriesController());


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
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    _header(context),
                    // const SizedBox(height: 5),
                    _body(context)
                  ],
                ),
              ),
              homeController.loading2.value ?
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
      ),)
    );
  }

  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.18,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back, size: 27,)),
                  GestureDetector(
                    onTap: () {
                      Get.off(() => Home());
                    },
                    child: SvgPicture.asset("assets/logo/logo.svg",
                      width: 25,
                      height: 25,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        //menu
                      },
                      icon: const Icon(Icons.menu,color: Colors.transparent,)),
                ],
              )
          ),
          GestureDetector(
            onTap: () => _pressed_on_search(context),
            child: Container(
              //width: MediaQuery.of(context).size.width * 0.9,
              height: 40,
              color: AppColors.mainColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: Global.languageCode != 'en'
                            ? const BorderRadius.only(
                          bottomRight:  Radius.circular(10),
                          topRight:  Radius.circular(10),
                        )
                            : const BorderRadius.only(
                          bottomLeft:  Radius.circular(10),
                          topLeft:  Radius.circular(10),
                        ),
                        border: Border.all(width: 1,color: Colors.grey.withOpacity(0.7))
                    ),
                    // width: MediaQuery.of(context).size.width * 0.7,
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child:  AppWidget.appText(
                          App_Localization.of(context).translate("what_are_you_looking"),
                          Colors.black54, 15, FontWeight.normal),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: Global.languageCode == 'en'
                            ? const BorderRadius.only(
                          bottomRight:  Radius.circular(10),
                          topRight:  Radius.circular(10),
                        )
                            : const BorderRadius.only(
                          bottomLeft:  Radius.circular(10),
                          topLeft:  Radius.circular(10),
                        )
                    ),
                    child: const Icon(Icons.search,color: Colors.white,size: 30),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  _pressed_on_search(BuildContext context) async {
    final result = await showSearch(
        context: context,
        delegate: SearchTextField(homeController: homeController));
  }

  _body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.78,
        child:  ListView.builder(
          itemCount: homeController.collection.length,
          //physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                homeController.goToCollectionPage(homeController.collection[index]);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 7),
                child: Center(
                  child:  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          boxShadow:  const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 7,
                              offset: Offset(2,1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(homeController.collection[index].image == null
                                ? "https://tahoban.ru/wp-content/themes/consultix/images/no-image-found-360x250.png"
                                : homeController.collection[index].image!.src.toString()),
                          ),
                        ),
                        // child: Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     AppWidget.appText(
                        //         homeController.collection[index].title.toString(),
                        //         Colors.white, 20, FontWeight.bold),
                        //     SizedBox(height: homeController.collection[index].image == null ? 10 : 0),
                        //   ],
                        // ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: Center(
                            child: AppWidget.appText(
                                homeController.collection[index].title.toString(),
                                Colors.white, 20, FontWeight.bold),
                          )
                      ),
                    ],
                  ),
                )
              ),
            );
          },
        ),
      ),
    );
  }
}



