// To parse this JSON data, do
//
//     final discountCodeDecoder = discountCodeDecoderFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class DiscountCodeDecoder {
  DiscountCodeDecoder({
    required this.discountCode,
  });

  ShopifyDiscountCode discountCode;

  factory DiscountCodeDecoder.fromJson(String str) => DiscountCodeDecoder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DiscountCodeDecoder.fromMap(Map<String, dynamic> json) => DiscountCodeDecoder(
    discountCode: ShopifyDiscountCode.fromMap(json["discount_code"]),
  );

  Map<String, dynamic> toMap() => {
    "discount_code": discountCode.toMap(),
  };
}

class ShopifyDiscountCode {
  ShopifyDiscountCode({
    required this.id,
    required this.priceRuleId,
    required this.code,
    required this.usageCount,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int priceRuleId;
  String code;
  int usageCount;
  DateTime createdAt;
  DateTime updatedAt;

  factory ShopifyDiscountCode.fromJson(String str) => ShopifyDiscountCode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShopifyDiscountCode.fromMap(Map<String, dynamic> json) => ShopifyDiscountCode(
    id: json["id"],
    priceRuleId: json["price_rule_id"],
    code: json["code"],
    usageCount: json["usage_count"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "price_rule_id": priceRuleId,
    "code": code,
    "usage_count": usageCount,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
