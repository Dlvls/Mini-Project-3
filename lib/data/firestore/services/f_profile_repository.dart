import 'package:cloud_firestore/cloud_firestore.dart';

import '../f_profile_model.dart';

class FirestoreProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<FirestoreProfileModel> fetchProfile(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('profiles').doc(userId).get();
      if (snapshot.exists) {
        return FirestoreProfileModel.fromSnapshot(snapshot);
      } else {
        throw Exception('Profile not found');
      }
    } catch (e) {
      throw Exception('Error fetching profile from Firestore: $e');
    }
  }

  Future<void> saveProfile(FirestoreProfileModel profile) async {
    try {
      await _firestore
          .collection('profiles')
          .doc(profile.id.toString())
          .set(profile.toMap());
    } catch (e) {
      throw Exception('Error saving profile to Firestore: $e');
    }
  }
}
