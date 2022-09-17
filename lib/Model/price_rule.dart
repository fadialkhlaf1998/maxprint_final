// To parse this JSON data, do
//
//     final priceRuleDecoder = priceRuleDecoderFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class PriceRuleDecoder {
  PriceRuleDecoder({
    required this.priceRule,
  });

  PriceRule priceRule;

  factory PriceRuleDecoder.fromJson(String str) => PriceRuleDecoder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PriceRuleDecoder.fromMap(Map<String, dynamic> json) => PriceRuleDecoder(
    priceRule: PriceRule.fromMap(json["price_rule"]),
  );

  Map<String, dynamic> toMap() => {
    "price_rule": priceRule.toMap(),
  };
}

class PriceRule {
  PriceRule({
    required this.id,
    required this.valueType,
    required this.value,
    required this.customerSelection,
    required this.targetType,
    required this.targetSelection,
    required this.allocationMethod,
    required this.allocationLimit,
    required this.oncePerCustomer,
    required this.usageLimit,
    required this.startsAt,
    required this.endsAt,
    required this.createdAt,
    required this.updatedAt,
    required this.entitledProductIds,
    required this.entitledVariantIds,
    required this.entitledCollectionIds,
    required this.entitledCountryIds,
    required this.prerequisiteProductIds,
    required this.prerequisiteVariantIds,
    required this.prerequisiteCollectionIds,
    required this.prerequisiteSavedSearchIds,
    required this.prerequisiteCustomerIds,
    required this.prerequisiteSubtotalRange,
    required this.prerequisiteQuantityRange,
    required this.prerequisiteShippingPriceRange,
    required this.prerequisiteToEntitlementQuantityRatio,
    required this.prerequisiteToEntitlementPurchase,
    required this.title,
    required this.adminGraphqlApiId,
  });

  int id;
  String valueType;
  String value;
  String customerSelection;
  String targetType;
  String targetSelection;
  String allocationMethod;
  dynamic allocationLimit;
  bool oncePerCustomer;
  dynamic usageLimit;
  DateTime startsAt;
  dynamic endsAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<int> entitledProductIds;
  List<int> entitledVariantIds;
  List<int> entitledCollectionIds;
  List<int> entitledCountryIds;
  List<int> prerequisiteProductIds;
  List<int> prerequisiteVariantIds;
  List<int> prerequisiteCollectionIds;
  List<int> prerequisiteSavedSearchIds;
  List<int> prerequisiteCustomerIds;
  PrerequisiteQuantityRange prerequisiteSubtotalRange;
  PrerequisiteQuantityRange prerequisiteQuantityRange;
  PrerequisiteQuantityRange prerequisiteShippingPriceRange;
  PrerequisiteToEntitlementQuantityRatio prerequisiteToEntitlementQuantityRatio;
  PrerequisiteToEntitlementPurchase prerequisiteToEntitlementPurchase;
  String title;
  String adminGraphqlApiId;

  factory PriceRule.fromJson(String str) => PriceRule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PriceRule.fromMap(Map<String, dynamic> json) => PriceRule(
    id: json["id"],
    valueType: json["value_type"],
    value: json["value"],
    customerSelection: json["customer_selection"],
    targetType: json["target_type"],
    targetSelection: json["target_selection"],
    allocationMethod: json["allocation_method"],
    allocationLimit: json["allocation_limit"],
    oncePerCustomer: json["once_per_customer"],
    usageLimit: json["usage_limit"],
    startsAt: DateTime.parse(json["starts_at"]),
    endsAt: json["ends_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    entitledProductIds: List<int>.from(json["entitled_product_ids"].map((x) => x)),
    entitledVariantIds: List<int>.from(json["entitled_variant_ids"].map((x) => x)),
    entitledCollectionIds: List<int>.from(json["entitled_collection_ids"].map((x) => x)),
    entitledCountryIds: List<int>.from(json["entitled_country_ids"].map((x) => x)),
    prerequisiteProductIds: List<int>.from(json["prerequisite_product_ids"].map((x) => x)),
    prerequisiteVariantIds: List<int>.from(json["prerequisite_variant_ids"].map((x) => x)),
    prerequisiteCollectionIds: List<int>.from(json["prerequisite_collection_ids"].map((x) => x)),
    prerequisiteSavedSearchIds: List<int>.from(json["prerequisite_saved_search_ids"].map((x) => x)),
    prerequisiteCustomerIds: List<int>.from(json["prerequisite_customer_ids"].map((x) => x)),
    prerequisiteSubtotalRange: PrerequisiteQuantityRange.fromMap(json["prerequisite_subtotal_range"]),
    prerequisiteQuantityRange: PrerequisiteQuantityRange.fromMap(json["prerequisite_quantity_range"]),
    prerequisiteShippingPriceRange: PrerequisiteQuantityRange.fromMap(json["prerequisite_shipping_price_range"]),
    prerequisiteToEntitlementQuantityRatio: PrerequisiteToEntitlementQuantityRatio.fromMap(json["prerequisite_to_entitlement_quantity_ratio"]),
    prerequisiteToEntitlementPurchase: PrerequisiteToEntitlementPurchase.fromMap(json["prerequisite_to_entitlement_purchase"]),
    title: json["title"],
    adminGraphqlApiId: json["admin_graphql_api_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "value_type": valueType,
    "value": value,
    "customer_selection": customerSelection,
    "target_type": targetType,
    "target_selection": targetSelection,
    "allocation_method": allocationMethod,
    "allocation_limit": allocationLimit,
    "once_per_customer": oncePerCustomer,
    "usage_limit": usageLimit,
    "starts_at": startsAt.toIso8601String(),
    "ends_at": endsAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "entitled_product_ids": List<dynamic>.from(entitledProductIds.map((x) => x)),
    "entitled_variant_ids": List<dynamic>.from(entitledVariantIds.map((x) => x)),
    "entitled_collection_ids": List<dynamic>.from(entitledCollectionIds.map((x) => x)),
    "entitled_country_ids": List<dynamic>.from(entitledCountryIds.map((x) => x)),
    "prerequisite_product_ids": List<dynamic>.from(prerequisiteProductIds.map((x) => x)),
    "prerequisite_variant_ids": List<dynamic>.from(prerequisiteVariantIds.map((x) => x)),
    "prerequisite_collection_ids": List<dynamic>.from(prerequisiteCollectionIds.map((x) => x)),
    "prerequisite_saved_search_ids": List<dynamic>.from(prerequisiteSavedSearchIds.map((x) => x)),
    "prerequisite_customer_ids": List<dynamic>.from(prerequisiteCustomerIds.map((x) => x)),
    "prerequisite_subtotal_range": prerequisiteSubtotalRange,
    "prerequisite_quantity_range": prerequisiteQuantityRange.toMap(),
    "prerequisite_shipping_price_range": prerequisiteShippingPriceRange,
    "prerequisite_to_entitlement_quantity_ratio": prerequisiteToEntitlementQuantityRatio.toMap(),
    "prerequisite_to_entitlement_purchase": prerequisiteToEntitlementPurchase.toMap(),
    "title": title,
    "admin_graphql_api_id": adminGraphqlApiId,
  };
}

class PrerequisiteQuantityRange {
  PrerequisiteQuantityRange({
    required this.greaterThanOrEqualTo,
  });

  int greaterThanOrEqualTo;

  factory PrerequisiteQuantityRange.fromJson(String str) => PrerequisiteQuantityRange.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrerequisiteQuantityRange.fromMap(Map<String, dynamic> json) => PrerequisiteQuantityRange(
    greaterThanOrEqualTo: json["greater_than_or_equal_to"],
  );

  Map<String, dynamic> toMap() => {
    "greater_than_or_equal_to": greaterThanOrEqualTo,
  };
}

class PrerequisiteToEntitlementPurchase {
  PrerequisiteToEntitlementPurchase({
    required this.prerequisiteAmount,
  });

  dynamic prerequisiteAmount;

  factory PrerequisiteToEntitlementPurchase.fromJson(String str) => PrerequisiteToEntitlementPurchase.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrerequisiteToEntitlementPurchase.fromMap(Map<String, dynamic> json) => PrerequisiteToEntitlementPurchase(
    prerequisiteAmount: json["prerequisite_amount"],
  );

  Map<String, dynamic> toMap() => {
    "prerequisite_amount": prerequisiteAmount,
  };
}

class PrerequisiteToEntitlementQuantityRatio {
  PrerequisiteToEntitlementQuantityRatio({
    required this.prerequisiteQuantity,
    required this.entitledQuantity,
  });

  dynamic prerequisiteQuantity;
  dynamic entitledQuantity;

  factory PrerequisiteToEntitlementQuantityRatio.fromJson(String str) => PrerequisiteToEntitlementQuantityRatio.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrerequisiteToEntitlementQuantityRatio.fromMap(Map<String, dynamic> json) => PrerequisiteToEntitlementQuantityRatio(
    prerequisiteQuantity: json["prerequisite_quantity"],
    entitledQuantity: json["entitled_quantity"],
  );

  Map<String, dynamic> toMap() => {
    "prerequisite_quantity": prerequisiteQuantity,
    "entitled_quantity": entitledQuantity,
  };
}
