import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => mainState();
}

class mainState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Story',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.black,
                  fontSize: 100,
                  fontFamily: 'Times New Roman',
                )),
            Text('Original literature in 500 words or less.',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Times New Roman',
                )),
            Container(
              color: Colors.white,
              height: 80,
            ),
            Container(
              width: 300,
              decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.black)),
              child: TextField(
                autocorrect: false,
                controller: _usernameController,
                cursorColor: Colors.black,
                style: new TextStyle(
                    color: Colors.black, fontFamily: 'Times New Roman'),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hoverColor: Colors.black,
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                      color: Colors.black45, fontFamily: 'Times New Roman'),
                  hintText: 'Username',
                ),
              ),
            ),
            Container(
              color: Colors.white,
              height: 20,
            ),
            Container(
                width: 300,
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.black)),
                child: TextField(
                  autocorrect: false,
                  controller: _passwordController,
                  style: new TextStyle(
                      color: Colors.black, fontFamily: 'Times New Roman'),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(
                        color: Colors.black45, fontFamily: 'Times New Roman'),
                    hintText: 'Password',
                  ),
                  obscureText: true,
                )),
            Container(
              color: Colors.white,
              height: 20,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                    onPressed: () {
                      _passwordController.clear();
                      _usernameController.clear();
                    },
                    color: Colors.white,
                    borderSide: BorderSide(color: Colors.black),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Times New Roman',
                          fontSize: 16),
                    )),
                OutlineButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.white,
                    borderSide: BorderSide(color: Colors.black),
                    child: Text(
                      'Log-in',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Times New Roman',
                          fontSize: 16),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}