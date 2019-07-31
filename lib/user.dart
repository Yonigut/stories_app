import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  String firstName;
  String lastName;
  String password;
  String username;
  String email;
  String bio;
  FirebaseUser fbUser;
  List<dynamic> following;
  List<dynamic> saved;
  List<dynamic> wrote;
  final ready = new ValueNotifier(false);
  DocumentReference userReference;
//  Function myCallBack;

  User(Function myCallBack){
    ready.addListener(myCallBack());
    createUser();
  }

  createUser() async {
    this.fbUser = await FirebaseAuth.instance.currentUser();
    this.username = fbUser.displayName;
//    print(this.username);
    DocumentReference userReference = await Firestore.instance.collection('users').document(username);
    DocumentSnapshot data = await userReference.get();
    this.firstName = data['firstName'];
    this.bio = data['bio'];
    this.lastName = data['lastName'];
    this.email = data['email'];
    this.password = data['password'];
    ready.value = true;
  }

}