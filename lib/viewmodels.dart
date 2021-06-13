import 'package:flutter/material.dart';
import 'styles.dart';

class TextMessage extends StatelessWidget {
  final String username;
  final String message;
  final bool;

  TextMessage(
      this.username, this.message, this.bool);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: bool != true ? Alignment.bottomLeft : Alignment.bottomRight,
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Container(
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: bool != true ? messageContainerColor : Colors.blue[300],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(username,
                    style: TextStyle(
                        color: colorOfUsername,
                        fontWeight: FontWeight.w500,
                        fontSize: 20)),
                SizedBox(height: 10),
                Text(message,
                    style: TextStyle(color: colorOfMessage, fontSize: 20)),
              ],
            ),
          )),
    );
  }
}
