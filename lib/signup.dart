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
      backgroundColor: Color.fromRGBO(130, 198, 240, 80),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
//          color: Color.fromRGBO(130, 198, 240, 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
              ),
              Text(
                'Story',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                  fontSize: 100,
                  fontFamily: 'Times New Roman',
                ),
              ),
              Text(
                'Original literature in 500 words or less.',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Times New Roman',
                ),
              ),
              Container(
                height: 40,
              ),
              Container(
                width: 300,
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.black)),
                child: TextFormField(
                  key: Key('sign-up first name'),
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Please type a first name';
                    } else if (input.length > 30) {
                      return 'First names can contain at most thirty characters';
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
                height: 20,
              ),
              Container(
                width: 300,
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.black)),
                child: TextFormField(
                  key: Key('sign-up last name'),
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Please type an last name';
                    } else if (input.length > 30) {
                      return 'Last names can contain at most thirty characters';
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
                height: 20,
              ),
              Container(
                width: 300,
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.black)),
                child: TextFormField(
                  key: Key('sign-up username'),
                  validator: (input) {
                    if (input.length > 30) {
                      return 'Usernames can contain at most thirty characters';
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
                height: 20,
              ),
              Container(
                width: 300,
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.black)),
                child: TextFormField(
                  key: Key('sign-up email'),
                  validator: (input) {
                    if (!input.contains('@')) {
                      // TODO: ACTUALLY MAKE A BETTER CHECK FOR A VALID EMAIL
                      return 'Please type a valid email';
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
                height: 20,
              ),
              Container(
                width: 300,
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.black)),
                child: TextFormField(
                  key: Key('sign-up password'),
                  controller: _passwordController,
                  validator: (input) {
                    if (input.length < 6) {
                      return 'Your password needs to contain at least 6 characters';
                    } else if (input.length > 30) {
                      return 'Passwords can contain at most thirty characters';
                    } else if (!validPasswordCharacters(input)) {
                      return 'Passwords must contain at least one letter, number and other symbol';
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
                height: 20,
              ),
              Container(
                width: 300,
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.black)),
                child: TextFormField(
                  key: Key('sign-up confirm password'),
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
                    key: Key('sign-up button'),
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
        this.user.sendEmailVerification();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(user),
          ),
        );
      } catch (e) {
        if (e == 'ERROR_EMAIL_ALREADY_IN_USE') {
          print('caught');
        }
        print('not caught');
//        print(e.message);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                  content: Container(child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          e.message,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                      OutlineButton(
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Times New Roman',
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  ),
              );
            }
        );
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

  bool validPasswordCharacters(String input) {
    bool hasNumber = false;
    bool hasLetter = false;
    bool hasSymbol = false;
    for (int i = 0; i < input.length; i++) {
      String currentLetter = input.substring(i, i + 1);
      if (currentLetter == 'a' ||
          currentLetter == 'b' ||
          currentLetter == 'c' ||
          currentLetter == 'd' ||
          currentLetter == 'e' ||
          currentLetter == 'f' ||
          currentLetter == 'g' ||
          currentLetter == 'h' ||
          currentLetter == 'i' ||
          currentLetter == 'j' ||
          currentLetter == 'k' ||
          currentLetter == 'l' ||
          currentLetter == 'm' ||
          currentLetter == 'n' ||
          currentLetter == 'o' ||
          currentLetter == 'p' ||
          currentLetter == 'q' ||
          currentLetter == 'r' ||
          currentLetter == 's' ||
          currentLetter == 't' ||
          currentLetter == 'u' ||
          currentLetter == 'v' ||
          currentLetter == 'w' ||
          currentLetter == 'x' ||
          currentLetter == 'y' ||
          currentLetter == 'z' ||
          currentLetter == 'A' ||
          currentLetter == 'B' ||
          currentLetter == 'C' ||
          currentLetter == 'D' ||
          currentLetter == 'E' ||
          currentLetter == 'F' ||
          currentLetter == 'G' ||
          currentLetter == 'H' ||
          currentLetter == 'I' ||
          currentLetter == 'J' ||
          currentLetter == 'K' ||
          currentLetter == 'L' ||
          currentLetter == 'M' ||
          currentLetter == 'N' ||
          currentLetter == 'O' ||
          currentLetter == 'P' ||
          currentLetter == 'Q' ||
          currentLetter == 'R' ||
          currentLetter == 'S' ||
          currentLetter == 'T' ||
          currentLetter == 'U' ||
          currentLetter == 'V' ||
          currentLetter == 'W' ||
          currentLetter == 'X' ||
          currentLetter == 'Y' ||
          currentLetter == 'Z') {
        print('has letter');
        hasLetter = true;
      } else if (currentLetter == '0' ||
          currentLetter == '1' ||
          currentLetter == '2' ||
          currentLetter == '3' ||
          currentLetter == '4' ||
          currentLetter == '5' ||
          currentLetter == '6' ||
          currentLetter == '7' ||
          currentLetter == '8' ||
          currentLetter == '9') {
        hasNumber = true;
        print('has number');
      } else {
        print('has symbol');
        hasSymbol = true;
      }
      if (hasLetter && hasNumber && hasSymbol) {
        print('so its true!');
        return true;
      }
    }

      print('has letter?: $hasLetter');
      print('has number?: $hasNumber');
      print('has symbol?: $hasSymbol');

    print('its actuall false!');
    return false;
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
