import 'package:examples/screens/group_chat.dart';
import 'package:flutter/material.dart';

abstract class GroupChatState extends State<GroupChat> {
  TextEditingController message = TextEditingController();
  bool showIcons = true;
}
