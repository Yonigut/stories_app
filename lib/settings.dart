import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsPage extends StatelessWidget {

  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          RaisedButton(
            key: Key('delete account button'),
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
              String username = user.displayName;
              print('displayName is $username');
              Firestore.instance.collection('users').document(username).delete();
              this.user.delete();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage(),
                ),
              );
            },
          ),
          RaisedButton(
            key: Key('sign out button'),
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
                  builder: (BuildContext context) => LoginPage(),
                ),
              );
            },
          ),
      ],
    );
  }
}