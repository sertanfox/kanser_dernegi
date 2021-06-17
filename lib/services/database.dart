import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examples/models/Sikayet.dart';
import 'package:examples/models/user.dart';

class DatabaseMethods {


  Future<void> saveUser(User user) {
    return Firestore.instance
        .collection('users')
        .doc(user.id)
        .set(user.tomap());
  }

  Future<void> addUserInfo(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return Firestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }


  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('username', isEqualTo: searchField)
        .getDocuments();
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  Future<bool> addNewUserToAkciger(newUser, chatRoomId) async {
    await Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .update({
      "users": FieldValue.arrayUnion([newUser])
    }).catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('no', descending: false)
        .snapshots();
  }

  Future getAkcigerKanseriChats(String chatRoomId) async {
    return await Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('no', descending: false)
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .doc(chatMessageData["time"].toString())
        .set(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addComplain(String userName, String message) async {
    var phoneNumber;
    var snapshot = await Firestore.instance
        .collection('users')
        .where('username', isEqualTo: userName)
        .get().then((snap) => snap.docs.forEach((element) {phoneNumber = element['phoneNumber'];}));
    


    var sikayet = Sikayet(
        name: userName,
        message: message,
        phoneNumber: phoneNumber);


    await Firestore.instance.collection("Sikayetler").add({
      'username': sikayet.name,
      'message': sikayet.message,
      'phoneNumber': sikayet.phoneNumber
    }).catchError((e) {
      print(e.toString());
    });

  }
  getUserChats(String itIsMyName) async {
    return await Firestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}
