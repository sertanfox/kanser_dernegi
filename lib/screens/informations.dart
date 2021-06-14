import 'package:examples/chat/chatrooms.dart';
import 'package:examples/components/helperfunctions.dart';
import 'package:examples/components/validators.dart';
import 'package:examples/providers/user_provider.dart';
import 'package:examples/screens/search_group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../functions.dart';

class Informations extends StatefulWidget {
  Informations({Key key, this.phoneNum}) : super(key: key);
  static String routeName = "/informations";
  String phoneNum;
  @override
  _InformationsState createState() => _InformationsState();
}

class _InformationsState extends State<Informations> with Validators {

  TextEditingController userNameController = TextEditingController();
  TextEditingController cancerNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _cancerFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();
  Validators valid = Validators();
  bool _isVisible = false;
  bool _loadingPage =false;

  List<DropdownMenuItem<String>> _dropdownMenuItems;
  String _selectedCancer;

  List<DropdownMenuItem<String>> _dropdownCityItems;
  String _selectedCity;


  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropdownMenuItems(valid.cancerTypes);
    _dropdownCityItems = buildDropdownCityItems(valid.cities);
  }

  List<DropdownMenuItem<String>> buildDropdownMenuItems(List _cancerTypes) {
    List<DropdownMenuItem<String>> items = List();
    for (String cancer in _cancerTypes) {
      items.add(DropdownMenuItem(
        value: cancer,
        child: Text(cancer),
      ));
    }
    return items;
  }

  List<DropdownMenuItem<String>> buildDropdownCityItems(List _cities) {
    List<DropdownMenuItem<String>> items = List();
    for (String city in _cities) {
      items.add(DropdownMenuItem(
        value: city,
        child: Text(city),
      ));
    }
    return items;
  }

  onChangeDropdownItem(String selectedCancer) {
    setState(() {
      _selectedCancer = selectedCancer;
    });
  }

  onChangeDropdownCityItem(String selectedCity) {
    setState(() {
      _selectedCity = selectedCity;
    });
  }

  isVisible() {
    setState(() {
      _isVisible = true;
      print("Visible setState tetiklendi");
    });
  }

  @override
  Widget build(BuildContext context) {
    String userName;

    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: Scaffold(
        backgroundColor: Colors.blue[400],
        body: SafeArea(
          child: _loadingPage ? CircularProgressIndicator() : Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppLogo(),
                  SizedBox(
                    height: 40,
                  ),
                  buildForm(context, userName, valid.errorTextEmpty)
                ],
              ),
            ),
          ) ,
        ),
      ),
    );
  }

  Widget buildForm(BuildContext context, String userName, String errorText) {
    //TODO: RESET THIS PART IF BUG OCCURS
    //UserProvider userProvider = new UserProvider();
    final userProvider = Provider.of<UserProvider>(context,listen:false);
    return Form(
        key: formKey,
        child: Column(
          children: [
            AppText(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextFormField(
                      focusNode: _usernameFocusNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        if (userNameController.text.isNotEmpty) {
                          FocusScope.of(context).requestFocus(_cancerFocusNode);
                        }
                      },
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white.withOpacity(0.3),
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: "Adınız",
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.6)),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      controller: userNameController,
                      validator: (input) => input.length == null
                          ? "Lütfen bir isim giriniz"
                          : null,
                      onChanged: (value) {
                        userName = userNameController.text;
                        print(userName);
                      }),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: DropdownButton(
                      focusNode: _cancerFocusNode,
                      iconEnabledColor: Colors.white,
                      hint: Text('Kanser tipinizi seçiniz',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.6))),
                      value: _selectedCancer,
                      items: _dropdownMenuItems,
                      onChanged: onChangeDropdownItem,
                      dropdownColor: Colors.blue,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      isExpanded: true,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: DropdownButton(
                      focusNode: _cityFocusNode,
                      iconEnabledColor: Colors.white,
                      hint: Text('İl seçiniz',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.6))),
                      value: _selectedCity,
                      items: _dropdownCityItems,
                      onChanged: onChangeDropdownCityItem,
                      dropdownColor: Colors.blue,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      isExpanded: true,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              // ignore: deprecated_member_use
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  onPressed: () async {

                    if (_selectedCancer.length == null ||
                        _selectedCity.length == null ||
                        userName.length < 3)
                      isVisible();
                    else {
                      await HelperFunctions.saveUserNameSharedPreference(userNameController.text);
                      var userName = await HelperFunctions.getUserNameSharedPreference();
                      print('The userName is $userName');

                        Navigator.pushReplacementNamed(context, ChatRoom.routeName);

                      print(_selectedCancer);
                      print(_selectedCity);
                      print(userNameController.text);

                      userProvider.changePhoneNumber("+90${widget.phoneNum}");
                      userProvider.changeUsername(userNameController.text);
                      userProvider.changeLocation(_selectedCity);
                      userProvider.changeCancertype(_selectedCancer);
                      userProvider.saveUser();

                    }
                    setState(() {
                      _loadingPage = true;
                    });
                  },
                  child: Center(
                    child: Text(
                      "GÖNDER",
                      style: TextStyle(fontSize: 17, color: Colors.blue[400]),
                    ),
                  )),
            ),
            Visibility(
                visible: _isVisible,
                child: Text(errorText,
                    style: TextStyle(color: Colors.white, fontSize: 15)))
          ],
        ));
  }
}
