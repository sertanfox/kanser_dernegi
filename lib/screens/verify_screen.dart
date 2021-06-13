import 'package:examples/screens/informations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Verify_Screen extends StatefulWidget {
  String phoneNum;

  Verify_Screen({Key key, this.phoneNum}) : super(key: key);
  static String routeName = "/verify_screen";

  @override
  _Verify_ScreenState createState() => _Verify_ScreenState();
}

class _Verify_ScreenState extends State<Verify_Screen> {
  String verificationId;
  String _verificationCode;
  bool codeSent;

  @override
  void initState() {
    super.initState();
    verifyPhone('+90${widget.phoneNum}');
    print('The phone number has been taken +90${widget.phoneNum}');
  }

  ///Function to Sign in with OTP. Once the Sms Code is taken
  Future<bool> signInWithOTP(smsCode, verId) async {
    PhoneAuthCredential authCred =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    await signIn(authCred);
  }

  /// Sign In to Firebase with AuthCredential
  Future<void> signIn(AuthCredential authCred) async {
    await FirebaseAuth.instance.signInWithCredential(authCred);
  }

  /// This function verifies the phone then set the sms code
  Future<void> verifyPhone(String phoneNo) async {
    print('Phone number reached verifyphone $phoneNo');
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      return signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  List<String> currentPin = ["","","","","",""];
  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();
  TextEditingController pinFiveController = TextEditingController();
  TextEditingController pinSixController = TextEditingController();

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.transparent),
  );

  int pinIndex = 0;


  @override
  Widget build(BuildContext context) {
    return _buildBodyContent(context);
  }


  Widget _buildBodyContent(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.blue[400],
          child: Column(
            children:<Widget> [
              Expanded(
                child: Container(
                  alignment: Alignment(0,0.5),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildSecurityText(),
                      SizedBox(height: 40,),
                      buildPinRow(),
                    ],
                  ),
                ),
              ),
              buildNumberPad(),
            ],
          ),
        ));
  }

  buildPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinOneController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinTwoController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinThreeController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinFourController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinFiveController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinSixController,
        ),
      ],
    );
  }

  buildSecurityText(){
    return Text("${widget.phoneNum}'e gelen PIN kodunu giriniz :", style: TextStyle(
      color: Colors.white70,
      fontSize: 21,
      fontWeight: FontWeight.bold,
    ),);
  }

  buildNumberPad() {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                    n:1,
                    onPressed: () {
                      pinIndexSetup("1");
                    },
                  ),
                  KeyboardNumber(
                    n:2,
                    onPressed: () {
                      pinIndexSetup("2");
                    },
                  ),
                  KeyboardNumber(
                    n:3,
                    onPressed: () {
                      pinIndexSetup("3");
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                    n:4,
                    onPressed: () {
                      pinIndexSetup("4");
                    },
                  ),
                  KeyboardNumber(
                    n:5,
                    onPressed: () {
                      pinIndexSetup("5");
                    },
                  ),
                  KeyboardNumber(
                    n:6,
                    onPressed: () {
                      pinIndexSetup("6");
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                    n:7,
                    onPressed: () {
                      pinIndexSetup("7");
                    },
                  ),
                  KeyboardNumber(
                    n:8,
                    onPressed: () {
                      pinIndexSetup("8");
                    },
                  ),
                  KeyboardNumber(
                    n:9,
                    onPressed: () {
                      pinIndexSetup("9");
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 60,
                    child: MaterialButton(
                      onPressed: null,
                      child: SizedBox(),
                    ),
                  ),
                  KeyboardNumber(
                    n:0,
                    onPressed: () {
                      pinIndexSetup("0");
                    },
                  ),
                  Container(
                    width: 60,
                    child: MaterialButton(
                      height: 60,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      onPressed: (){
                        clearPin();
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  clearPin() {
    if(pinIndex == 0)
      pinIndex = 0;
    else if(pinIndex == 6) {
      setPin(pinIndex, "");
      currentPin[pinIndex-1] = "";
      pinIndex--;
    }
    else
    {
      setPin(pinIndex, "");
      currentPin[pinIndex-1] = "";
      pinIndex--;
    }
  }

  pinIndexSetup(String text){
    if(pinIndex == 0)
      pinIndex = 1;
    else if(pinIndex<6)
      pinIndex++;
    setPin(pinIndex,text);
    currentPin[pinIndex-1] = text;
    String strPin = "";
    currentPin.forEach((e) {
      strPin += e;
    });
    if(pinIndex == 6)
      {
        this._verificationCode = strPin;
        print(this._verificationCode);
        Login();
        //clearAllPins();
      }
  }

  Login() async {
    bool isSignedIn = await signInWithOTP(
        _verificationCode, verificationId);
    if (isSignedIn != null || isSignedIn != false) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Informations(
                  phoneNum: widget.phoneNum)));
    }}

  setPin(int n, String text) {
    switch(n){
      case 1: pinOneController.text = text; break;
      case 2: pinTwoController.text = text; break;
      case 3: pinThreeController.text = text; break;
      case 4: pinFourController.text = text; break;
      case 5: pinFiveController.text = text; break;
      case 6: pinSixController.text = text; break;
    }
  }

  clearAllPins()
  {
    pinIndex = 0;
    setPin(0,"");
    setPin(1,"");
    setPin(2,"");
    setPin(3,"");
    setPin(4,"");
    setPin(5,"");
    setPin(6,"");
  }
}

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  List<String> currentPin = ["","","","","",""];
  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();
  TextEditingController pinFiveController = TextEditingController();
  TextEditingController pinSixController = TextEditingController();

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.transparent),
  );

  int pinIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          color: Colors.blue[400],
          child: Column(
            children:<Widget> [
              Expanded(
                child: Container(
                  alignment: Alignment(0,0.5),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildSecurityText(),
                      SizedBox(height: 40,),
                      buildPinRow(),
                    ],
                  ),
                ),
              ),
              buildNumberPad(),
            ],
          ),
        )
    );
  }


  buildNumberPad() {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                    n:1,
                    onPressed: () {
                      pinIndexSetup("1");
                    },
                  ),
                  KeyboardNumber(
                    n:2,
                    onPressed: () {
                      pinIndexSetup("2");
                    },
                  ),
                  KeyboardNumber(
                    n:3,
                    onPressed: () {
                      pinIndexSetup("3");
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                    n:4,
                    onPressed: () {
                      pinIndexSetup("4");
                    },
                  ),
                  KeyboardNumber(
                    n:5,
                    onPressed: () {
                      pinIndexSetup("5");
                    },
                  ),
                  KeyboardNumber(
                    n:6,
                    onPressed: () {
                      pinIndexSetup("6");
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                    n:7,
                    onPressed: () {
                      pinIndexSetup("7");
                    },
                  ),
                  KeyboardNumber(
                    n:8,
                    onPressed: () {
                      pinIndexSetup("8");
                    },
                  ),
                  KeyboardNumber(
                    n:9,
                    onPressed: () {
                      pinIndexSetup("9");
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 60,
                    child: MaterialButton(
                      onPressed: null,
                      child: SizedBox(),
                    ),
                  ),
                  KeyboardNumber(
                    n:0,
                    onPressed: () {
                      pinIndexSetup("0");
                    },
                  ),
                  Container(
                    width: 60,
                    child: MaterialButton(
                      height: 60,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      onPressed: (){
                        clearPin();
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  clearPin() {
    if(pinIndex == 0)
      pinIndex = 0;
    else if(pinIndex == 6) {
      setPin(pinIndex, "");
      currentPin[pinIndex-1] = "";
      pinIndex--;
    }
    else
      {
        setPin(pinIndex, "");
        currentPin[pinIndex-1] = "";
        pinIndex--;
      }
  }

  pinIndexSetup(String text){
    if(pinIndex == 0)
      pinIndex = 1;
    else if(pinIndex<6)
      pinIndex++;
    setPin(pinIndex,text);
    currentPin[pinIndex-1] = text;
    String strPin = "";
    currentPin.forEach((e) {
      strPin += e;
    });
    if(pinIndex == 6)
      print(strPin);
  }

  setPin(int n, String text) {
    switch(n){
      case 1: pinOneController.text = text; break;
      case 2: pinTwoController.text = text; break;
      case 3: pinThreeController.text = text; break;
      case 4: pinFourController.text = text; break;
      case 5: pinFiveController.text = text; break;
      case 6: pinSixController.text = text; break;
    }
  }

  buildPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinOneController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinTwoController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinThreeController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinFourController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinFiveController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinSixController,
        ),
      ],
    );
  }

  buildSecurityText(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Text("Numaranıza gelen PIN kodunu",
      style: TextStyle(
      color: Colors.white70,
      fontSize: 21,
      fontWeight: FontWeight.bold,
    ),),
        Text("giriniz :",
          textAlign: TextAlign.center,
          style: TextStyle(
          color: Colors.white70,
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),),
      ]
    );
  }

  buildExitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: MaterialButton(
            onPressed: () {},
            height: 50.0,
            minWidth: 50.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Icon(Icons.clear, color: Colors.white),
          ),
        )
      ],
    );
  }
}

class PINNumber extends StatelessWidget {

  final OutlineInputBorder outlineInputBorder;
  final TextEditingController textEditingController;
  const PINNumber({Key key, this.textEditingController, this.outlineInputBorder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.0,
      child: TextField(
        controller: textEditingController,
        enabled: false,
        obscureText: false,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16),
          border: outlineInputBorder,
          filled: true,
          fillColor: Colors.white30,
        ),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 21,
          color: Colors.white,
        ),
      ),
    );
  }
}

class KeyboardNumber extends StatelessWidget {

  final int n;
  final Function() onPressed;
  KeyboardNumber({this.n, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue[400],
        border: Border.all(width: 1, color: Colors.white30)
      ),
      alignment: Alignment.center,
      child: MaterialButton(
        padding: EdgeInsets.all(8),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        height: 90,
        child: Text("$n",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24*MediaQuery.of(context).textScaleFactor,
              color: Colors.white,
              fontWeight: FontWeight.bold)
        ),
      ),
    );
  }

}


