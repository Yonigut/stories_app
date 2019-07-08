import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _email;
  String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
        Form(
          key : _formKey,
          child: Column(
            children : [
              TextFormField(
                validator : (input) {
                  if(input.isEmpty) {
                    return 'Please type an email';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'Email'
                ),
              ),
              TextFormField(
                validator : (input) {
                  if(input.length < 6) {
                    return 'Your password needs to contain at least 6 characters';;
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
                obscureText: true,
              ),
              RaisedButton(
                onPressed: () { signIn(); },
                child: Text('Sign in'),
              ),
            ],
          ),
        ),
//      Container(
//        color: Colors.white,
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: [
//            Text('Story',
//                style: TextStyle(
//                  fontStyle: FontStyle.normal,
//                  color: Colors.black,
//                  fontSize: 100,
//                  fontFamily: 'Times New Roman',
//                )),
//            Text('Original literature in 500 words or less.',
//                style: TextStyle(
//                  fontStyle: FontStyle.normal,
//                  color: Colors.black,
//                  fontSize: 16,
//                  fontFamily: 'Times New Roman',
//                )),
//            Container(
//              color: Colors.white,
//              height: 80,
//            ),
//            Container(
//              width: 300,
//              decoration: new BoxDecoration(
//                  border: new Border.all(color: Colors.black)),
//              child: TextField(
//                autocorrect: false,
//                controller: _usernameController,
//                cursorColor: Colors.black,
//                style: new TextStyle(
//                    color: Colors.black, fontFamily: 'Times New Roman'),
//                decoration: InputDecoration(
//                  focusedBorder: UnderlineInputBorder(
//                    borderSide: BorderSide(color: Colors.black),
//                  ),
//                  hoverColor: Colors.black,
//                  fillColor: Colors.white,
//                  filled: true,
//                  hintStyle: TextStyle(
//                      color: Colors.black45, fontFamily: 'Times New Roman'),
//                  hintText: 'Username',
//                ),
//              ),
//            ),
//            Container(
//              color: Colors.white,
//              height: 20,
//            ),
//            Container(
//                width: 300,
//                decoration: new BoxDecoration(
//                    border: new Border.all(color: Colors.black)),
//                child: TextField(
//                  autocorrect: false,
//                  controller: _passwordController,
//                  style: new TextStyle(
//                      color: Colors.black, fontFamily: 'Times New Roman'),
//                  cursorColor: Colors.black,
//                  decoration: InputDecoration(
//                    focusedBorder: UnderlineInputBorder(
//                      borderSide: BorderSide(color: Colors.black),
//                    ),
//                    fillColor: Colors.white,
//                    filled: true,
//                    hintStyle: TextStyle(
//                        color: Colors.black45, fontFamily: 'Times New Roman'),
//                    hintText: 'Password',
//                  ),
//                  obscureText: true,
//                )),
//            Container(
//              color: Colors.white,
//              height: 20,
//            ),
//            ButtonBar(
//              alignment: MainAxisAlignment.center,
//              children: <Widget>[
//                OutlineButton(
//                    onPressed: () {
//                      _passwordController.clear();
//                      _usernameController.clear();
//                    },
//                    color: Colors.white,
//                    borderSide: BorderSide(color: Colors.black),
//                    child: Text(
//                      'Cancel',
//                      style: TextStyle(
//                          color: Colors.black,
//                          fontFamily: 'Times New Roman',
//                          fontSize: 16),
//                    )),
//                OutlineButton(
//                    onPressed: () {
//                      Navigator.pop(context);
//                    },
//                    color: Colors.white,
//                    borderSide: BorderSide(color: Colors.black),
//                    child: Text(
//                      'Log-in',
//                      style: TextStyle(
//                          color: Colors.black,
//                          fontFamily: 'Times New Roman',
//                          fontSize: 16),
//                    )),
//              ],
//            ),
//          ],
//        ),
//      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: user)));

      } catch(e) {
        print(e.message);
        print(e.toString());
      }

    }
  }
}