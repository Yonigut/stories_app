import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';
import 'signup.dart';
import 'main2.dart';

void main() => runApp(StoryApp());

class StoryApp extends StatefulWidget {
  @override
  State<StoryApp> createState() => StoryAppState();
}

class StoryAppState extends State<StoryApp> {
  bool logInFetched = false;
  bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Story',
      // TODO: Change home: to a Backdrop with a HomePage frontLayer (104)
      home:
          logInFetched ? (isLoggedIn ? HomePage() : LoginPage()) : WhitePage(),
      // TODO: Make currentCategory field take _currentCategory (104)
      // TODO: Pass _currentCategory for frontLayer (104)
      // TODO: Change backLayer field value to CategoryMenuPage (104)
//      initialRoute: '/login',
//      onGenerateRoute: _getRoute,
      // TODO: Add a theme (103)
    );
  }

  Future<bool> checkIfLoggedIn() async {}

  @override
  void initState() {
    super.initState();
    findIfLoggedIn();
  }

  findIfLoggedIn() async {
    bool temp = await FirebaseAuth.instance.currentUser() != null;
    setState(() {
      this.logInFetched = true;
      this.isLoggedIn = temp;
    });
  }
}

Route<dynamic> _getRoute(RouteSettings settings) {
  if (settings.name != '/home') {
    return null;
  }

  return MaterialPageRoute<void>(
    settings: settings,
    builder: (BuildContext context) => HomePage(),
    fullscreenDialog: true,
  );
}

class WhitePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('drawing');
    return MaterialApp(
      home: Scaffold(
        body: Container(color: Colors.white, height: 100, width: 100),
      ),
    );
  }
}