import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examples/bLoc/group_bloc.dart';
import 'package:examples/chat/chat.dart';
import 'package:examples/chat/chatrooms.dart';
import 'package:examples/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../functions.dart';
import 'dart:io';
import 'dart:math' as math;

class SearchGroup extends StatefulWidget {
  SearchGroup({Key key}) : super(key: key);
  static String routeName = "/search_group";
  @override
  _SearchGroupState createState() => _SearchGroupState();
}

class _SearchGroupState extends State<SearchGroup>
    with SingleTickerProviderStateMixin {


  String text11 = "Kaydınız Gerçekleşti !";
  String text12 =
      "Sizin için uygun bir odanın olup olmadığını kontrol ediyoruz...";
  String text21 = "Henüz size uygun bir odamız yok :(";
  String text22 =
      "Merak etmeyin ! En kısa zamanda oluşturup sizi bilgilendireceğiz :)";

  bool bool1 = true;
  bool bool2 = true;
  bool route = false;

  Timer _timer;
  int _start = 10;



  @override
  void setState(route) {
    sleep(Duration(milliseconds: 20));
  }

  void startTimer(int time) {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (time == 0) {
          setState(() {
            bool1 = false;
            bool2 = false;
          });
        } else {
          time--;
        }
      },
    );
  }

  @override
  void initState() {
    startTimer(_start);
    _animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    final _curvedAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
        reverseCurve: Curves.linear);

    _animation =
        Tween<double>(begin: 0, end: 5 * math.pi).animate(_curvedAnimation)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed)
              _animationController.reverse();
            else if (status == AnimationStatus.dismissed)
              _animationController.forward();
          });
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  Animation<double> _animation;
  AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as User;
    print('The username is ${arguments.username} , The Location is ${arguments.location}');


    return BlocConsumer<GroupBloc, GroupState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        if (state is GroupInitial ) {
          return buildFetchingData(animation: _animation, bool1: bool1, text11: text11, text21: text21, bool2: bool2, text12: text12, text22: text22, user: arguments,button: false);
        }  else if (state is GroupErrorState ) {
          return buildFetchingData(animation: _animation, bool1: false, text11: text11, text21: text21, bool2: false, text12: text12, text22: text22,user: arguments,button: false);
        } else if (state is GroupFound ) {
          return Chat(chatRoomId: 'Akciger Kanseri');
        }else {
          return buildFetchingData(animation: _animation, bool1: bool1, text11: text11, text21: text21, bool2: bool2, text12: text12, text22: text22,user: arguments,button: false);
        }
      },
    );
    //return
  }
}


class buildFetchingData extends StatelessWidget {
  const buildFetchingData({
    Key key,
    @required Animation<double> animation,
    @required this.bool1,
    @required this.text11,
    @required this.text21,
    @required this.bool2,
    @required this.text12,
    @required this.text22,
    @required this.user,
    @required this.button,
  }) : _animation = animation, super(key: key);

  final Animation<double> _animation;
  final bool bool1;
  final String text11;
  final String text21;
  final bool bool2;
  final String text12;
  final String text22;
  final User user;
  final bool button;

  ///Methods To send to Bloc => ChatRoom found Event
  void sendGetToChatRoomBloC(BuildContext context) {
    var groupBloc = context.read<GroupBloc>();
    groupBloc.add(GetToChatRoom());
  }

  ///Methods To send to Bloc => Error Event
  void sendError(BuildContext context) {
    var groupBloc = context.read<GroupBloc>();
    groupBloc.add(Error());
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 10)).then((value) {
        if ( user.location == 'İstanbul(Avrupa)' && user.cancertype == 'Akciğer Kanseri'){
          sendGetToChatRoomBloC(context);
        }
        else{
          // ignore: unnecessary_statements
          sendError(context);
        }
      }),
     builder:(context,_) => buildCenterWidget(context),
    );
  }

  Widget buildCenterWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MainImage(animation: _animation),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    bool1 ? text11 : text21,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    bool2 ? text12 : text22,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ), SizedBox(
                  height: 40,
                ),
               button ? ElevatedButton(

                  onPressed: () async {
                    Navigator.pushReplacementNamed(context, ChatRoom.routeName);
                  },
                  child: Text(
                    'Sohbet Odasına girin',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ) :Opacity(opacity: 0),
              ],
            ),
      ),
    );
  }
}

class MainImage extends AnimatedWidget {
  MainImage({
    Key key,
    @required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.rotate(angle: animation.value, child: AppLogo());
  }
}
