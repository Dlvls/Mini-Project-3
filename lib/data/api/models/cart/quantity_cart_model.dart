class ProductQuantity {
  final int productId;
  final int quantity;

  ProductQuantity({
    required this.productId,
    required this.quantity,
  });

  factory ProductQuantity.fromJson(Map<String, dynamic> json) {
    return ProductQuantity(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
