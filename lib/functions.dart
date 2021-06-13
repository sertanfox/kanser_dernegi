import 'package:flutter/material.dart';

///Logical Function Check if number has 10 digits-----///
int isPhoneNumberValid(String number) {
  print(number);
  int errorCode = 0;
  if (number.length == 0)
    errorCode = 0;
  else if (number.length < 10)
    errorCode = 1;
  else
    errorCode = 101;
  return errorCode;
}


/// Widget for App logo--------------------------------///
class AppLogo extends StatelessWidget {
  const AppLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 75,
        backgroundImage: AssetImage('assets/images/social-support.jpg'));
  }
}


/// Widget For AppText------------------------------------///
class AppText extends StatelessWidget {
  const AppText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "KANSER  DESTEK",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          "PLATFORMU",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

