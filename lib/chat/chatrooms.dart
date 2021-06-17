import 'package:examples/components/helperfunctions.dart';
import 'package:examples/components/validators.dart';
import 'package:examples/providers/user_provider.dart';
import 'package:examples/screens/search.dart';
import 'package:examples/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat.dart';

class ChatRoom extends StatefulWidget {
  final BuildContext context;
  static String routeName = "/chatrooms";

  const ChatRoom({Key key, this.context}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data.documents[index].data()['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myName, ""),
                    chatRoomId: snapshot.data.documents[index].data()["chatRoomId"],
                  );
                })
            :  Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    // Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    // //DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
    //   setState(() {
    //     //chatRooms = snapshots;
    //     print(
    //         "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akciğer Kanseri', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
        elevation: 0.0,
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
            //  AuthService().signOut();
            //   Navigator.pushReplacement(context,
            //       MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: Container(
        child: chatRoomsList(),
      ),

    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName,@required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Chat(
            chatRoomId: chatRoomId,
          )
        ));
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30)),
              child: Image.asset('assets/images/lung.jpg')
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    //fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
