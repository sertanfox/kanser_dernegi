import "package:flutter/material.dart";
import '../viewmodels.dart';

class GroupChat extends StatefulWidget {
  static String routeName = "/group_chat";
  @override
  _GroupChatState createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  TextEditingController message = TextEditingController();
  TextMessage NewMessage;

  @override
  Widget build(BuildContext context) {
    //   FirebaseFirestore.instance
    //       .collection('messageStorage')
    //       .snapshots()
    //       .listen((data) => data.docs.forEach((doc) => print(doc['message'])));
    return Scaffold(
        appBar: AppBar(
          title: Text("KONUŞMA GRUBU"),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/palmiye_aydinlik.jpg"))),
          child: Column(
            children: [_listMessagesWidget(), _sendMessageWidget()],
          ),
        ));
  }

  Widget _headerWidget() {
    return Container();
  }

  Widget _listMessagesWidget({TextMessage message}) {
    return Expanded(
      child: ListView(
        children: [
          TextMessage("Sertan", "Merhaba arkadaşlar", true),
          TextMessage("Ahmet", "Merhaba arkadaşlar selamlar", false),
          TextMessage("Ayşe", "Merhaba arkadaşlar günaydın herkese", false),
          TextMessage("Fatma", "Merhaba arkadaşlar nasılsınız", false),
          TextMessage("Hayriye", "Merhabalar", false),

        ],
      ),
    );
  }

  Widget _sendMessageWidget() {
    bool showIcons = true;
    return Row(
      children: [
        Expanded(
            child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(25), right: Radius.circular(25))),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Icon(Icons.tag_faces, color: Colors.grey),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: message,
                  onChanged: (String text) {
                    if (text.length > 0)
                      setState(() {
                        showIcons = false;
                      });
                    else
                      setState(() {
                        showIcons = true;
                      });
                  },
                  decoration: InputDecoration(
                      hintText: "Mesajınızı yazın", border: InputBorder.none),
                ),
              ),
              showIcons
                  ? Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.attach_file),
                        color: Colors.grey,
                        onPressed: () {},
                      ),
                    )
                  : SizedBox.shrink(),
              showIcons
                  ? Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        color: Colors.grey,
                        onPressed: () {},
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        )),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Theme.of(context).primaryColor),
          child: IconButton(
            icon: Icon(Icons.send),
            color: Colors.white,
            onPressed: () async {
              print('TAPPED');
              NewMessage =  TextMessage('Jordan',message.text,true);
              print(NewMessage.toString());
              setState(() {
                _listMessagesWidget(message:NewMessage);

              });
            },
          ),
        )
      ],
    );
  }
}
