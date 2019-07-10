import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _email;
  String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void>  printUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) {
      print('Not signed in');
    } else {
      print('Signed in');
    }
  }

  @override
  Widget build(BuildContext context) {

    printUserInfo();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
//        Form(
//          key : _formKey,
//          child: Column(
//            children : [
//              TextFormField(
//                validator : (input) {
//                  if(input.isEmpty) {
//                    return 'Please type an email';
//                  }
//                },
//                onSaved: (input) => _email = input,
//                decoration: InputDecoration(
//                  labelText: 'Email'
//                ),
//              ),
//              TextFormField(
//                validator : (input) {
//                  if(input.length < 6) {
//                    return 'Your password needs to contain at least 6 characters';;
//                  }
//                },
//                onSaved: (input) => _password = input,
//                decoration: InputDecoration(
//                    labelText: 'Password'
//                ),
//                obscureText: true,
//              ),
//              RaisedButton(
//                onPressed: () { signIn(); },
//                child: Text('Sign in'),
//              ),
//            ],
//          ),
//        ),
      Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('HUCK',
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
                child: TextFormField(
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
                        color: Colors.black45, fontFamily: 'Times New Roman'),
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
                  controller: _passwordController,
                  validator: (input) {
                    if (input.length < 6) {
                      return 'Your password needs to contain at least 6 characters';
                    }
                  },
                  onSaved: (input) => _password = input,
//                  decoration: InputDecoration(
//                      labelText: 'Password'
//                  ),
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
                        color: Colors.black45, fontFamily: 'Times New Roman'),
                    hintText: 'Password',
                  ),
                  autocorrect: false,
                ),
              ),
              Container(
                color: Colors.white,
                height: 20,
              ),
//              ButtonBar(
//                alignment: MainAxisAlignment.center,
//                children: <Widget>[
                  OutlineButton(
                      onPressed: () {
                        _passwordController.clear();
                        _emailController.clear();
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
                        signUp();
                      },
                      color: Colors.white,
                      borderSide: BorderSide(color: Colors.black),
                      child: Text(
                        'Sign-up',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Times New Roman',
                            fontSize: 16),
                      )),
                  Container(
                    color: Colors.white,
                    height: 20,
                  ),
                  Text('Already have an account?',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Times New Roman',
                        fontSize: 12),
                  ),
                  OutlineButton(
                      onPressed: () {
                        Navigator.pushReplacement( context,
                          MaterialPageRoute(builder: (BuildContext context) => LoginPage(),),
                        );
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
//              ),
//            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement( context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage(user: user),),
        );
//        Navigator.pushReplacementNamed(context,
//            MaterialPageRoute(builder: (context) => HomePage(user: user)));
      } catch (e) {
        print(e.message);
        print(e.toString());
      }
    }
  }


}

class SecondRoute<T> extends Route<T> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}