import 'package:cloud_firestore/cloud_firestore.dart';

import '../f_products_model.dart';

class FirestoreProductRepository {
  final FirebaseFirestore firestore;

  FirestoreProductRepository(this.firestore);

  Future<void> uploadProducts(List<FirestoreProductModel> products) async {
    final batch = firestore.batch();
    for (final product in products) {
      final docRef = firestore.collection('products').doc(product.id);
      batch.set(docRef, {
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'category': product.category, // Ensure category is included
        'image': product.image,
        'rating': {
          'rate': product.rating.rate,
          'count': product.rating.count,
        },
      });
    }
    await batch.commit();
  }

  Future<List<FirestoreProductModel>> fetchProducts() async {
    final snapshot = await firestore.collection('products').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return FirestoreProductModel.fromMap(
        data as Map<String, dynamic>,
        doc.id, // Pass doc.id as documentId
      );
    }).toList();
  }
}
