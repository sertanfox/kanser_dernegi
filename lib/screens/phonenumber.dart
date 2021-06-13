import 'package:examples/components/validators.dart';
import 'package:examples/screens/verify_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../functions.dart';

class PhoneNumber extends StatefulWidget with Validators {
  static String routeName = "/";
  PhoneNumber({Key key}) : super(key: key);

  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {


  ///Variables_______________________________________
  final phoneNumberController = TextEditingController();
  Validators valid = Validators();
  String phoneNumber = "";
  String unValidNumber = "";
  /// This function checks if the number has 10 digits__
  void _wrongNumber(int errorCode) {
    setState(() {
      if (errorCode == 0)
        unValidNumber = valid.unValidNumberEmpty;
      else if (errorCode == 1)
        unValidNumber = valid.unValidNumberMissing;
      else
        unValidNumber = valid.unValidNumberInvalid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[400],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Container(child: AppLogo())),
                    ],
                  ),
                ),
                Column(
                  children: [
                    AppText(),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text("Bir telefon uzağınızda...",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "BigShouldersStencilText",
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 100),
                      child: Divider(
                        height: 10,
                        color: Colors.white.withOpacity(1),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Theme(
                        data: ThemeData(
                            primaryColor: Colors.white,
                            primaryColorDark: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                                autofocus: false,
                                autocorrect: true,
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Colors.white),
                                controller: phoneNumberController,
                                onChanged: (value) {
                                  phoneNumber = phoneNumberController.text;
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: "5xx-xxx-xx-xx",
                                    hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.7)),
                                    prefixIcon: Icon(
                                      Icons.phone_android,
                                      color: Colors.white,
                                    ),
                                    fillColor: Colors.white,
                                    focusColor: Colors.white)),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            unValidNumber,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )),
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {
                                 int errorCode = isPhoneNumberValid(phoneNumber);
                                 if (errorCode == 101) {
                                   print("Sms doğrulamaya gidiyoruz...");
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) => Verify_Screen(
                                               phoneNum: phoneNumber)));
                                 } else
                                 _wrongNumber(errorCode);
                            },
                            child: Center(
                              child: Text(
                                "Numara Onayı",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.blue[400]),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
