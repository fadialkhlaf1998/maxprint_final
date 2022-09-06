import 'package:get/get.dart';

class LanguagesController extends GetxController {

  var selectValue = 0.obs;
  String? value = "non";

  List languages = [
    {
      "name":"English",
      "id":"en"},
    {
      "name":"Arabic",
      "id":"ar"}
  ].obs;

}