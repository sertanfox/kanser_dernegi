import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examples/components/helperfunctions.dart';
import 'package:examples/components/validators.dart';
import 'package:examples/services/database.dart';
import 'package:flutter/material.dart';

import '../components/widget.dart';

class Chat extends StatefulWidget {
  final String chatRoomId;

  Chat({this.chatRoomId});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
  var value = 0;
  DatabaseMethods databaseMethods = DatabaseMethods();

  Future<bool> _addNewComplainToFirebase(sender, message) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Şikayet'),
              content: Text(
                  'Bu kullanıcı hakkında şikayette bulunmak ister misiniz?'),
              actions: [
                FlatButton(
                  child: Text('Iptal et'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                FlatButton(
                  child: Text('Devam'),
                  onPressed: () {
                    databaseMethods.addComplain(sender, message);
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ));
  }

  var arraySize;

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        arraySize = chats.length;
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    time: snapshot.data.documents[index].data()["time"],
                    onPressed: () => _addNewComplainToFirebase(
                        snapshot.data.documents[index].data()['sendBy'],
                        snapshot.data.documents[index].data()["message"]),
                    message: snapshot.data.documents[index].data()["message"],
                    sendByMe: Constants.myName == snapshot.data.documents[index].data()["sendBy"],
                    sender: snapshot.data.documents[index].data()['sendBy'],
                  );
                })
            : Container();
      },
    );
  }

  addMessage() async {
    try {
      Constants.myName = await HelperFunctions.getUserNameSharedPreference();
      value = await HelperFunctions.getMessagePositionSharedPreference();
      if (messageEditingController.text.isNotEmpty) {
        Map<String, dynamic> chatMessageMap = {
          "sendBy": Constants.myName,
          "message": messageEditingController.text,
          'time': Timestamp.now().toDate(),
          'no': 1,
        };

        DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);

        setState(() {
          messageEditingController.text = "";
          HelperFunctions.setMessagePosition(value);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    ///getChats.(widget.chatRoomId)
    DatabaseMethods().getAkcigerKanseriChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/palmiye_aydinlik.jpg"))),
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 11),
                color: Colors.black38,
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageEditingController,
                      style: simpleTextStyle(),
                      decoration: InputDecoration(
                          hintText: "Mesajınızı yazın ...",
                          hintStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 16,
                          ),
                          border: InputBorder.none),
                    )),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        addMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0x36FFFFFF),
                                    const Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight),
                              borderRadius: BorderRadius.circular(40)),
                          padding: EdgeInsets.all(12),
                          child: Image.asset(
                            "assets/images/send.png",
                            height: 25,
                            width: 25,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final String sender;
  final VoidCallback onPressed;
  final Timestamp time;

  MessageTile(
      {@required this.message,
      @required this.sendByMe,
      @required this.sender,
      @required this.onPressed,
      @required this.time});

  String timeZone;
  ///This Function sets the Time zone to AM or PM
  getTimeZone(){
    if(time.toDate().hour > 12){
      timeZone = 'PM';
    }else{
      timeZone = 'AM';
    }
  }

  @override
  Widget build(BuildContext context) {
     getTimeZone();
    return GestureDetector(
      onLongPress: onPressed,
      child: Container(
        padding: EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: sendByMe ? 0 : 24,
            right: sendByMe ? 24 : 0),
        alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin:
              sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
          padding: EdgeInsets.only(top: 10, bottom: 16, left: 16, right: 12),
          decoration: BoxDecoration(
              borderRadius: sendByMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15))
                  : BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
              gradient: LinearGradient(
                colors: sendByMe
                    ? [
                        //TODO: CHANGE COLORS OF BUBBLES
                        const Color(0xff046161),
                        const Color(0xff046161),
                      ]
                    : [
                        const Color(0xff262d31),
                        const Color(0xff262d31),
                      ],
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //TODO: FORMAT TIME TO WHATSAPP FORMAT
              sendByMe
                  ? Padding(
                    padding: EdgeInsets.fromLTRB(0,0,2,0),
                    child: RichText(
                        text: TextSpan(
                          text: '',
                          style: TextStyle(
                              color: Colors.deepOrange.shade300,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                  )
                  : Padding(
                    padding:  EdgeInsets.fromLTRB(0,2,2,6),
                    child: RichText(
                        text: TextSpan(
                          text: sender,
                          style: TextStyle(
                              color: Colors.deepOrange.shade300,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),

                        ),
                      ),
                  ),

              Text(message,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      // fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
              Padding(
                padding: EdgeInsets.fromLTRB(45,2,2,2),
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: TextStyle(
                        color: Colors.deepOrange.shade300,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          ' ${time.toDate().hour}:${time.toDate().minute} $timeZone',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 10,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
