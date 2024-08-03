class FirestoreProductQuantity {
  final int productId;
  final int quantity;

  FirestoreProductQuantity({
    required this.productId,
    required this.quantity,
  });

  factory FirestoreProductQuantity.fromMap(Map<String, dynamic> map) {
    return FirestoreProductQuantity(
      productId: map['productId'],
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
