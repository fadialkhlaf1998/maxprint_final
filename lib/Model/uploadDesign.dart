
import 'dart:convert';

class UploadDesign {

  List<String>? designsUrls;
  int? productId;

  UploadDesign({this.designsUrls, this.productId});

  factory UploadDesign.fromJson(String str) => UploadDesign.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UploadDesign.fromMap(Map<String, dynamic> json) => UploadDesign(
    designsUrls: List<String>.from(json["designsUrls"].map((x) => x)),
    productId: json["productId"] ?? -1,
  );

  Map<String, dynamic> toMap() =>{
    "designsUrls" : List<dynamic>.from(designsUrls!.map((x) => x)),
    "productId" : productId
  };



}