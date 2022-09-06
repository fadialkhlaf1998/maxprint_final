import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:maxprint_final/Helper/global.dart';
import 'package:maxprint_final/Model/user.dart';

class Api {

  static var url = "https://phpstack-548447-2866839.cloudwaysapps.com";


  static Future<User?> login(String email ,String password) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$url/sign-in'));
    request.body = json.encode({
      "email": email,
      "password": password
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      var jsonData = jsonDecode(data);
      Global.user = User.fromMap(jsonData);
      return Global.user;
    }
    else {
      return null;
    }

  }

  static Future<User?> signUp(String name, String lastName, String phone, String email, String password) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$url/sign-up'));
    request.body = json.encode({
      "first_name": name,
      "lastname": lastName,
      "phone": phone,
      "email": email,
      "password": password
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      var jsonData = jsonDecode(data);
      Global.saveInfo(email, password);
      return User.fromMap(jsonData);
    }
    else {
      print(response.reasonPhrase);
      return null;
    }

  }

  static Future<List<String>> uploadPhoto(List<File> images) async {

    var request = http.MultipartRequest('POST', Uri.parse('$url/upload-avatar'));

    for (int i = 0; i < images.length; i++){
      request.files.add(await http.MultipartFile.fromPath('profile-files', images[i].path));
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      var jsonData = jsonDecode(data);
      List<String> imagesUrls = [];
      for (var url in jsonData['images']){
        imagesUrls.add(url);
      }
      return imagesUrls;
    }
    else {
      return [];
    }

  }

}