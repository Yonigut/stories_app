import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailVerificationPage extends StatefulWidget {
  @override
  State<EmailVerificationPage> createState() => EmailVerificationPageState();
}

class EmailVerificationPageState extends State<EmailVerificationPage> {
  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'We sent you an email.',
            style: TextStyle(
                fontSize: 48,
                fontFamily: 'Times New Roman',
                color: Colors.black),
          ),
          Text(
            'Please verify your account there before continuing.',
            style: TextStyle(
                fontSize: 22,
                fontFamily: 'Times New Roman',
                color: Colors.black),
          ),
        ],
      ),
    );
  }
}
