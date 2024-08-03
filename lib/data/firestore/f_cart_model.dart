import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCartModel {
  final String id;
  final String userId;
  final DateTime createdAt;
  final List<FirestoreProductQuantity> products;

  FirestoreCartModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.products,
  });

  factory FirestoreCartModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    // Log the raw data from the snapshot
    print('Raw snapshot data: $data');

    // Check if data contains the required fields and log their values
    if (data.containsKey('userId') &&
        data.containsKey('date') &&
        data.containsKey('products')) {
      print('userId: ${data['userId']}');
      print('date: ${data['date']}');
      print('products: ${data['products']}');
    } else {
      print('Missing required fields in snapshot data');
    }

    return FirestoreCartModel(
      id: snapshot.id,
      userId: data['userId'].toString(),
      createdAt: DateTime.parse(data['date'] as String),
      products: (data['products'] as List)
          .map((item) => FirestoreProductQuantity.fromMap(item))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'date': createdAt.toIso8601String(),
      'products': products.map((p) => p.toMap()).toList(),
    };
  }
}

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
