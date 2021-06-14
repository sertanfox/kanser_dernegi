import 'package:examples/models/user.dart';
import 'package:examples/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UserProvider with ChangeNotifier {
  final database = DatabaseMethods();
  String _phoneNumber;
  String _username;
  String _cancertype;
  String _location;
  String _id;
  var uuid = Uuid();

  //getters
  String get phoneNumber => _phoneNumber;
  String get username => _username;
  String get cancertype => _cancertype;
  String get location => _location;
  String get id => _id;

  //setters
  changeUsername(String value) => _username = value;
  changeCancertype(String value) => _cancertype = value;
  changeLocation(String value) => _location = value;
  changePhoneNumber(String value) => _phoneNumber = value;

  saveUser() {
    var newUser = User(
        phoneNumber: phoneNumber,
        username: username,
        cancertype: cancertype,
        location: location,
        id: uuid.v4());
    print(
        "username :$_username, cancertype :$_cancertype, location :$location, id :$id");
    database.saveUser(newUser);
  }
}
