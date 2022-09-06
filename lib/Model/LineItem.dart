
class LineItem {
  int quantity;
  int variantId;

  LineItem(this.quantity, this.variantId);

  Map<String, dynamic> toMap() => {
    "quantity": quantity,
    "variant_id": variantId,
  };


}