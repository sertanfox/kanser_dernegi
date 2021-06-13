import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class MessageProvider with ChangeNotifier {
  String _message;
  String _user_name;
  int _message_id;

  //getters
  String get username => _user_name;
  String get message => _message;
  int get message_id => _message_id;

  //setters
  changeMessage(String value) {
    _message = value;
    notifyListeners();
  }
}
