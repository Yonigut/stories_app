import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup.dart';

class UserPage extends StatelessWidget {
  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    getUser();
    return Column(
        children: [
          RaisedButton(
            color: Colors.red,
            child: Text(
              'Delete Account',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Times New Roman',
                fontSize: 22,
              ),
            ),
            onPressed: () {
              this.user.delete();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SignUpPage(),
                ),
              );
            },
          ),
        RaisedButton(
      color: Colors.lightGreen,
      child: Text(
        'Sign Out',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Times New Roman',
          fontSize: 22,
        ),
      ),
      onPressed: () {
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SignUpPage(),
          ),
        );
      },
    ),
    ],
    );
  }

  getUser() async {
    this.user = await FirebaseAuth.instance.currentUser();
  }

}
