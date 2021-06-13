import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examples/models/user.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUser(User user) {
    return _db.collection('users').doc(user.id).set(user.tomap());
  }
}
