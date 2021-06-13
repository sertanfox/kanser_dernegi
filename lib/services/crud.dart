import 'package:cloud_firestore/cloud_firestore.dart';


class crudMethods {
  /*
  bool isloggedIn() {
    if (FirebaseAuth.instance.currentUser() != null)
      return true;
    else
      return false;
  }
  */

  Future<void> addData(Map userData) async {
    print("İŞLEM TAMAM");
    FirebaseFirestore.instance.collection('test').add(userData).catchError((e) {
      print(e);
    });
  }
}
