import 'package:flutter/material.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AppWidget {

  static appText(String text,Color color,double size,FontWeight weight) {
    return Text(text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight
      ),
    );
  }
  static divider(double thick,Color color,double ind,double end) {
    return Divider(
      thickness: thick,
      color: color,
      indent: ind,
      endIndent: end,
    );
  }
  static textField(TextEditingController controller,String translate,BuildContext context,{bool validate=true}){
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 45,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: App_Localization.of(context).translate(translate),
            hintStyle: const TextStyle(color:Colors.black, fontSize: 15),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: validate?Colors.grey:Colors.red)),
            focusedBorder:  UnderlineInputBorder(borderSide: BorderSide(color: validate?AppColors.mainColor:Colors.red))
        ),
        style: textFieldStyle(Colors.black, 15)
      ),
    );
  }
  static checkoutTextField(TextEditingController controller,String translate,BuildContext context,double width,double height,bool error){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: App_Localization.of(context).translate(translate),
              hintStyle: const TextStyle(color:Colors.black, fontSize:15),
              enabledBorder: error && controller.value.text.isEmpty?const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 1)):const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey,width: 1)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1))
          ),
            style: textFieldStyle(Colors.black, 15),
          ),
        ),
      ],
    );
  }
  static registrationTextField(TextEditingController controller,String translate,BuildContext context,{bool validate=true}){
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 45,
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5),
            hintText: App_Localization.of(context).translate(translate),
            hintStyle: const TextStyle(color:Colors.black, fontSize: 15),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: validate ? Colors.grey : Colors.red)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: validate? Colors.black : Colors.red))
          ),
          style: textFieldStyle(Colors.black, 15)
      ),
    );
  }
  static textFieldStyle(Color color,double size){
    return TextStyle(color: color,fontSize: size,overflow: TextOverflow.ellipsis);
  }
  static successMsg(BuildContext context,String msg){
    return showTopSnackBar(context,
      CustomSnackBar.success(
        message: msg,
        backgroundColor: AppColors.mainColor,
        textStyle: TextStyle(color: Colors.black),
      ),
    );
  }
  static errorMsg(BuildContext context,String err){
    return showTopSnackBar(context,
      CustomSnackBar.error(message: err,),
    );
  }
  static textFieldDesigner(TextEditingController controller,Icon icon,String translate,BuildContext context,{bool validate=true}){
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 40,
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
              // prefixIcon: icon,
              prefixIcon: IconTheme(
                  data: IconThemeData(
                  color: validate? Colors.grey : Colors.red
                ),
                  child: icon
              ),
              hintText: App_Localization.of(context).translate(translate),
              contentPadding: const EdgeInsets.all(5),
              hintStyle: const TextStyle(color:Colors.grey, fontSize: 15),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: validate?Colors.grey:Colors.red)),
              focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: validate? Colors.black : Colors.red))
          ),
          style: textFieldStyle(Colors.black, 14)
      ),
    );
  }


}