
///____________________________________________________\
///LOGIN USER

// _loginUser() async {
//   // ignore: unnecessary_statements
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   await _auth.verifyPhoneNumber(
//       phoneNumber: '+90${widget.phoneNum}',
//       timeout: Duration(seconds: 120),
//       verificationCompleted: (AuthCredential credential) async {
//         await _auth.signInWithCredential(credential).then((value) async {
//           if (value.user != null) {
//             Navigator.of(context).pushNamed(Verify_Screen.routeName);
//           }
//         });
//         //FirebaseUser user = result.user;
//       },
//       verificationFailed: (AuthException exception) {
//         print("PROBLEM IS HERE: ");
//       },
//       codeSent: (String verificationId, [int forceResendingToken]) {
//         setState(() {
//           _verificationCode = verificationId;
//         });
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         setState(() {
//           _verificationCode = verificationId;
//         });
//       });
// }


///________________________________________________________
///VALIDATE Ordimport 'package:flutter/cupertino.dart';
// eredTraversalPolicyFuture<String> validateOtp(String otp) async {
//   try {
//     await Future.delayed(Duration(milliseconds: 2000));
//     await FirebaseAuth.instance
//         .signInWithCredential(PhoneAuthProvider.getCredential(
//         verificationId: _verificationCode, smsCode: otp))
//         .then((value) async {
//       if (value.user != null) {
//         Navigator.of(context).pushNamed(Verify_Screen.routeName);
//       }
//     });
//   } catch (e) {
//     FocusScope.of(context).unfocus();
//   }
// }
//
// void moveToNextScreen(context) {
//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => Informations()));
// }

///________________________________________________________
/// VERIFY_SCREEN 04.04.2021, GOT A NEW DESIGN.
/*Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter OTP'),
                    onChanged: (val) {
                      setState(() {
                        this._verificationCode = val;
                      });
                    },
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Container(
                    height: 45,
                    child: ElevatedButton(
                        child: Center(
                            child: Text(
                          'Login',
                          style: TextStyle(fontSize: 19),
                        )),
                        onPressed: () async {
                          bool isSignedIn = await signInWithOTP(
                              _verificationCode, verificationId);
                          if (isSignedIn != null || isSignedIn != false) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Informations(
                                        phoneNum: widget.phoneNum)));
                          } else {
                            return Center(
                                child: Text('Error while Login',
                                    style: TextStyle(fontSize: 17)));
                          }
                        }),
                  ))
            ],
          ),
        )*/

///------------------------------------------------------------------------
///GROUP_CHAT CODES
/*
Container(
decoration: BoxDecoration(
image: DecorationImage(
fit: BoxFit.cover,
image: AssetImage("assets/images/palmiye_aydinlik.jpg"))),
child: Column(
children: [
Expanded(
child: StreamBuilder(
stream: FirebaseFirestore.instance.collection('messages').snapshots(),
builder: (BuildContext context,
    AsyncSnapshot<QuerySnapshot> snapshot) {
if (snapshot.data == null)
return CircularProgressIndicator();
if (snapshot.hasError)
return Text("Error : ${snapshot.error}");
if (snapshot.connectionState == ConnectionState.waiting)
return Text("Loading...");
return ListView(
children: snapshot.data.docs
    .map((doc) => ListTile(
title: Text(doc['message_user_name']),
subtitle: Text(doc['message_text']),
))
    .toList(),
);
},
),
),
Row(
children: [
Expanded(
child: Container(
margin: EdgeInsets.all(10),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.horizontal(
left: Radius.circular(25),
right: Radius.circular(25))),
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
decoration: InputDecoration(
hintText: "Mesajınızı yazın",
border: InputBorder.none),
),
),
],
),
)),
Container(
margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
decoration: BoxDecoration(
shape: BoxShape.circle,
color: Theme.of(context).primaryColor),
child: IconButton(
icon: Icon(Icons.send),
color: Colors.white,
onPressed: () {},
),
)
],
)
],
)),
*/