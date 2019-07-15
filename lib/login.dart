import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _email;
  String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
//    Future.delayed(const Duration(seconds: 2), () {
//      setState(() {
//        _visible = true;
//      });
//    });
    return Scaffold(
      key: Key('log-in'),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Blank',
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
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      height: 80,
                    ),
                    Container(
                      width: 300,
                      decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.black)),
                      child: TextFormField(
                        key: Key('log-in email'),
                        validator: (input) {
                          if (!input.contains('@')) {
                            return 'Please type an email';
                          }
                        },
                        onSaved: (input) => _email = input,
                        autocorrect: false,
                        controller: _emailController,
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
                              color: Colors.black45,
                              fontFamily: 'Times New Roman'),
                          hintText: 'Email',
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
                      child: TextFormField(
                        key: Key('log-in password'),
                        controller: _passwordController,
                        validator: (input) {
                          if (input.length < 6) {
                            return 'Your password needs to contain at least 6 characters';
                          }
                        },
                        onSaved: (input) => _password = input,
                        obscureText: true,
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
                              color: Colors.black45,
                              fontFamily: 'Times New Roman'),
                          hintText: 'Password',
                        ),
                        autocorrect: false,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 10,
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlineButton(
                          onPressed: () {
                            _passwordController.clear();
                            _emailController.clear();
                          },
                          color: Colors.white,
                          borderSide: BorderSide(color: Colors.black),
                          child: Text(
                            'Clear',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Times New Roman',
                                fontSize: 16),
                          ),
                        ),
                        OutlineButton(
                          key: Key('log-in button'),
                          onPressed: () {
                            signIn();
                          },
                          color: Colors.white,
                          borderSide: BorderSide(color: Colors.black),
                          child: Text(
                            'Log-in',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Times New Roman',
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.white,
                      height: 60,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Times New Roman',
                          fontSize: 14,
                        ),
                      ),
                        FlatButton(
                          child: Text(
                            'Sign-up',
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              fontFamily: 'Times New Roman',
                              fontSize: 14,
                            ),
                          ),
                          splashColor: Colors.white,
                          highlightColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SignUpPage(),
                              ),
                            );
                          },
                        ),
                        ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(user),
          ),
        );
      } catch (e) {
        print(e.message);
        print(e.toString());
      }
    }
  }
}
