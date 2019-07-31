import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Record {
  String author;
  String title;
  List<dynamic> text;
  int likes;
  int day;
  int month;
  int year;
  List<dynamic> likedBy;
  DocumentReference reference;
  String preview;
  final _ready = new ValueNotifier(false);
  bool savedByUser;
  String imageName;
  String documentID;
  FirebaseUser fbUser;
  DocumentSnapshot data;
//  DocumentSnapshot newData;

//  bool ready = false;

  Record(DocumentSnapshot data, Function myCallBack) {
//    this.data = data;
    _ready.addListener(
        myCallBack()
    );
//    replaceData();
    this.fromSnapshot(data);
  }


//  replaceData() async {
//    this.newData = await Firestore.instance
//        .collection('stories')
//        .document(data.documentID)
//        .get();
//  }


  fromMap(Map<String, dynamic> map) {
//        assert(map['author'] != null),
//        assert(map['title'] != null),
//        assert(map['text'] != null),
//        assert(map['likes'] != null),
//        assert(map['day'] != null),
//        assert(map['month'] != null),
//        assert(map['year'] != null),
//        assert(map['likedBy'] != null),
//        assert(map['preview'] != null),
//        assert(map['imageName'] != null),
        author = map['author'];
        title = map['title'];
        text = map['text'];
        likes = map['likes'];
        day = map['day'];
        month = map['month'];
        year = map['year'];
        likedBy = map['likedBy'];
        preview = map['preview'];
        imageName = map['imageName'];
        isSaved();
}

  fromSnapshot(DocumentSnapshot snapshot) {
    this.documentID = snapshot.documentID;
    this.reference = snapshot.reference;
    this.fromMap(snapshot.data);
  }

  isSaved() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot data = await Firestore.instance.collection('users').document(user.displayName).get();
    List<dynamic> savedStories = data['saved'];
    if (savedStories.contains(documentID)) {
      savedByUser = true;
    } else {
      savedByUser = false;
    }
      _ready.value = true;
//    print('record ready? ' + _ready.value.toString());
//    _ready.notifyListeners();
//    print('made true');
  }

  @override
  String toString() => "Record<$author:$title$month$day$year$likes>";
}