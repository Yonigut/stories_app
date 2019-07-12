import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  String _email;
  String _password;
  String _firstName;
  String _lastName;
  String _username;
  FirebaseUser user;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> printUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) {
      print('Not signed in');
    } else {
      print('Signed in');
      print('with the account ${user.email}');
    }
  }

  @override
  Widget build(BuildContext context) {
    printUserInfo();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                height: 50,
              ),
              Text(
                'Blank',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.black,
                  fontSize: 100,
                  fontFamily: 'Times New Roman',
                ),
              ),
              Text(
                'Original literature in 500 words or less.',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Times New Roman',
                ),
              ),
              Container(
                color: Colors.white,
                height: 40,
              ),
              Container(
                width: 300,
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.black)),
                child: TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Please type a first name';
                    }
                  },
                  onSaved: (input) => _firstName = input,
                  autocorrect: false,
                  controller: _firstNameController,
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
                    hintText: 'First Name',
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
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Please type an last name';
                    }
                  },
                  onSaved: (input) => _lastName = input,
                  autocorrect: false,
                  controller: _lastNameController,
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
                    hintText: 'Last Name',
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
                  validator: (input) {
                    if (input.length > 30) {
                      return 'Please type a username with at most thirty characters';
                    } else if (!validateUsernameCharacters(input)) {
                      return 'The username can only contain lower case letters, numbers, periods and underscores';
                    }
                    // TODO: MAKE SURE TO TEST THAT THIS USERNAME ISN'T ALREADY TAKEN
                  },
                  onSaved: (input) => _username = input,
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
                child: TextFormField(
                  validator: (input) {
                    if (!input.contains('@')) {
                      // TODO: ACTUALLY MAKE A BETTER CHECK FOR A VALID EMAIL
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
              Container(
                width: 300,
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.black)),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  validator: (input) {
                    if (input != _passwordController.text) {
                      return 'This does not match the given password.';
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
                        color: Colors.black45, fontFamily: 'Times New Roman'),
                    hintText: 'Confirm Password',
                  ),
                  autocorrect: false,
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
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
                  OutlineButton(
                      onPressed: () {
                        _passwordController.clear();
                        _emailController.clear();
                        _confirmPasswordController.clear();
                        _firstNameController.clear();
                        _usernameController.clear();
                        _lastNameController.clear();
                      },
                      color: Colors.white,
                      borderSide: BorderSide(color: Colors.black),
                      child: Text(
                        'Clear',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Times New Roman',
                            fontSize: 16),
                      )),
                ],
              ),
              Container(
                color: Colors.white,
                height: 20,
              ),
              Column(
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Times New Roman',
                        fontSize: 12),
                  ),
                  FlatButton(
                    child: Text(
                      'Log-in',
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
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
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
        FirebaseUser tempUser = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        this.user = tempUser;
        addUser();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(),
          ),
        );
      } catch (e) {
//        print(e.message);
        print(e.toString());
      }
    }
  }

  Future<void> addUser() {
    Map<String, dynamic> newUser = {'firstName' : _firstName, 'lastName' : _lastName, 'email' : _email, 'password' : _password};
    Firestore.instance.collection('users').document(_username).setData(newUser);
//    this.getUser();

    UserUpdateInfo uui = new UserUpdateInfo();
    uui.displayName = _username;
    user.updateProfile(uui);

    print(uui.displayName);
    print(user.displayName);
  }

  bool validateUsernameCharacters(String input) {
    for (int i = 0; i < input.length; i++) {
      print('printing the letter at index: $i');
      String currentLetter = input.substring(i, i + 1);
      print(currentLetter);
      if (currentLetter != 'a' &&
          currentLetter != 'b' &&
          currentLetter != 'c' &&
          currentLetter != 'd' &&
          currentLetter != 'e' &&
          currentLetter != 'f' &&
          currentLetter != 'g' &&
          currentLetter != 'h' &&
          currentLetter != 'i' &&
          currentLetter != 'j' &&
          currentLetter != 'k' &&
          currentLetter != 'l' &&
          currentLetter != 'm' &&
          currentLetter != 'n' &&
          currentLetter != 'o' &&
          currentLetter != 'p' &&
          currentLetter != 'q' &&
          currentLetter != 'r' &&
          currentLetter != 's' &&
          currentLetter != 't' &&
          currentLetter != 'u' &&
          currentLetter != 'v' &&
          currentLetter != 'w' &&
          currentLetter != 'x' &&
          currentLetter != 'y' &&
          currentLetter != 'z' &&
          currentLetter != '0' &&
          currentLetter != '1' &&
          currentLetter != '2' &&
          currentLetter != '3' &&
          currentLetter != '4' &&
          currentLetter != '5' &&
          currentLetter != '6' &&
          currentLetter != '7' &&
          currentLetter != '8' &&
          currentLetter != '9' &&
          currentLetter != '.' &&
          currentLetter != '_') {
        return false;
      }
    }
    return true;
  }

  getUser() async {
    this.user = await FirebaseAuth.instance.currentUser();
  }

}
