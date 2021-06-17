import 'package:examples/bLoc/group_bloc.dart';
import 'package:examples/components/validators.dart';
import 'package:examples/providers/user_provider.dart';
import 'package:examples/routes.dart';
import 'package:examples/screens/informations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'chat/chatrooms.dart';
import 'routes.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Provider<UserProvider>(
    create: (_)=>UserProvider(),
      builder: (context,__)=> BlocProvider(
        create:(_) => GroupBloc(),
        child: MyApp()
      ),));
}
class MyApp extends StatefulWidget with Validators {
  // This widget is the root of your application.


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sosyal Destek',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[400],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Informations.routeName,
      routes: routes,
    );
  }
}
