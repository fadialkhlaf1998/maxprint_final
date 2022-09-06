import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:maxprint_final/Controller/homeController.dart';


class SearchTextField extends SearchDelegate<String> {
  String? result;
  HomeController homeController;

  SearchTextField({required this.homeController});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.isEmpty ?
      const Visibility(
        child: Text(''),
        visible: false,) :
      IconButton(
        icon: const Icon(Icons.close, color: Colors.black),
        onPressed: () {
          query="";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back,size: 30),
      onPressed: () {
        Get.back();
      },
    );
  }


  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
      appBarTheme: AppBarTheme(
        color: AppColors.mainColor, //new AppBar color
        elevation: 0,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
      ),
      hintColor: Colors.black,
      textTheme: const TextTheme(
        headline6: TextStyle(
            color: Colors.black,
            fontSize: 18
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = homeController.allProducts.where((elm) {
      return elm.title!.toLowerCase().contains(query.toLowerCase());
    });
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.secondaryColor,
        child: Center(
          child: AppWidget.appText(
              App_Localization.of(context).translate("no_result_matched"),
              Colors.black, 20, FontWeight.bold),
        )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = homeController.allProducts.where((elm) {
      return elm.title!.toLowerCase().contains(query.toLowerCase());
    });
    return Container(
      color: AppColors.secondaryColor,
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Column(
              children: [
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: () {
                    //query = suggestions.elementAt(index).title!;
                    homeController.goToProductPage(suggestions.elementAt(index));
                  },
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage( suggestions.elementAt(index).image == null ?
                                    "https://tahoban.ru/wp-content/themes/consultix/images/no-image-found-360x250.png" :
                                    suggestions.elementAt(index).image!.src!),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(suggestions.elementAt(index).title!,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(suggestions.elementAt(index).tags!,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child:  AppWidget.appText(suggestions.elementAt(index).variants!.first.price! +
                                       " "+ App_Localization.of(context).translate("AED"),
                                      Colors.black, 14, FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
          return ListTile(
            title: AppWidget.appText(suggestions.elementAt(index).title!,
                Colors.black, 16, FontWeight.normal),
            subtitle: AppWidget.appText(suggestions.elementAt(index).tags!,
                Colors.black54, 14, FontWeight.normal),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black54),
                  image: DecorationImage(
                      image: NetworkImage( suggestions.elementAt(index).image == null ?
                      "https://tahoban.ru/wp-content/themes/consultix/images/no-image-found-360x250.png" :
                      suggestions.elementAt(index).image!.src!),
                      fit: BoxFit.cover
                  )
              ),
            ),
            onTap: () {
              //query = suggestions.elementAt(index).title!;
              homeController.goToProductPage(suggestions.elementAt(index));
            },
          );
        },
      ),
    );
  }
}