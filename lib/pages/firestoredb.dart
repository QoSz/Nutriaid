import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add or update user data
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _db.collection('users').doc(uid).set(data, SetOptions(merge: true));
      // ignore: empty_catches
    } catch (e) {}
  }

  // Retrieve user data
  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }
}

void main() async {
  FirestoreService firestoreService = FirestoreService();

  // Sample user ID
  String uid = 'jgabWM1p9gMedqJuKTg1Z8JzMtq2';

  // Sample data to update
  Map<String, dynamic> userData = {
    'CaloriesBurned': 890,
    'CaloriesEaten': 2540,
    'CaloriesRemaining': 460,
    'Crabs': 196.3,
    'CurrentHydration': 2800,
    'Fats': 80.4,
    'HydrationTarget': 4000,
    'Protein': 80.4,
  };

  // Update user data
  await firestoreService.updateUserData(uid, userData);

  // Retrieve user data
  Map<String, dynamic> retrievedData = await firestoreService.getUserData(uid);
}
