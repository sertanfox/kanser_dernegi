import 'package:flutter/material.dart';

String appTitle = "Sosyal Destek";
Color messageContainerColor = Colors.lightBlueAccent;

Color colorOfUsername = Colors.black;
Color colorOfMessage = Colors.black;
TextStyle usernameOfMessage = TextStyle(color: colorOfUsername, fontWeight: FontWeight.w500, fontSize: 16);
TextStyle textOfMessage = TextStyle(color: colorOfMessage, fontSize: 14);

ThemeData mainTheme = ThemeData(
primarySwatch: Colors.blue,
primaryColor: Colors.blue[400],
visualDensity: VisualDensity.adaptivePlatformDensity);