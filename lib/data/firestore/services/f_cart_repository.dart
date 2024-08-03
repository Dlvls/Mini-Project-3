import 'package:cloud_firestore/cloud_firestore.dart';

import '../f_cart_model.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<FirestoreCartModel>> fetchCarts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('carts').get();
      return snapshot.docs
          .map((doc) => FirestoreCartModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      throw Exception('Error fetching carts from Firestore: $e');
    }
  }

  Future<void> saveCart(FirestoreCartModel cart) async {
    try {
      await _firestore.collection('carts').doc(cart.id).set(cart.toMap());
    } catch (e) {
      throw Exception('Error saving cart to Firestore: $e');
    }
  }
}
