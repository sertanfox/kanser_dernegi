import 'package:examples/chat/chatrooms.dart';
import 'package:examples/screens/group_chat.dart';
import 'package:examples/screens/phonenumber.dart';
import "package:flutter/material.dart";
import 'screens/informations.dart';
import 'package:flutter/widgets.dart';
import 'screens/verify_screen.dart';
import 'package:examples/screens/search_group.dart';

final Map<String, WidgetBuilder> routes = {
  Informations.routeName: (context) => Informations(),
  PhoneNumber.routeName: (context) => PhoneNumber(),
  GroupChat.routeName: (context) => GroupChat(),
  SearchGroup.routeName: (context) => SearchGroup(),
  Verify_Screen.routeName: (context) => Verify_Screen(),
  ChatRoom.routeName: (context) => ChatRoom(),
};
