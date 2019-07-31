//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'record.dart';
//
//class StoryTab extends StatefulWidget {
//
//  DocumentSnapshot data;
//
////  String author;
////  int likes;
////  DocumentReference reference;
//
//  StoryTab(this.data);
//
//  @override
//  State<StoryTab> createState() => StoryTabState(this.data);
//}
//
//class StoryTabState extends State<StoryTab> {
//
//  Record record;
////  String author;
////  int likes;
////  DocumentReference reference;
//
//  bool _liked = false;
//
//  StoryTabState(DocumentSnapshot data) {
//    record = Record(data);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return OutlineButton(
//      borderSide: BorderSide(color: Colors.white),
//      color: Colors.white,
//      onPressed: () =>
//      {
////    Navigator.push(context, MaterialPageRoute())
//
//      },
//      child:
//      Padding(
//        key: ValueKey(record.author),
//        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//        child: Container(
//          decoration: BoxDecoration(
//            border: Border.all(color: Colors.grey),
//            borderRadius: BorderRadius.circular(5.0),
//          ),
//          child: ListTile(
//            title: Text(record.title,
//                style: TextStyle(
//                  fontFamily: 'Times New Roman',
//                  color: Colors.black,
//                  fontSize: 20,
//                  fontWeight: FontWeight.bold,
//                )),
//            trailing: Container(
//              width: 90,
//              child: Row(children: [
//                new IconButton(
////                icon: HeartButton(),
//                  icon:
//                  Icon(
//                    _liked ? Icons.favorite : Icons.favorite_border,
//                    color: _liked ? Colors.red : Colors.white,
//                  ),
//                  onPressed: () =>
//                      Firestore.instance.runTransaction((transaction) async {
//                        final freshSnapshot =
//                        await transaction.get(record.reference);
//                        final fresh = Record(freshSnapshot);
//
//                        await transaction.update(record.reference, {
//                          'likes': _liked ? fresh.likes - 1 : fresh.likes + 1,
//                          'author': 'hey'
//                        });
//
//                          print('happening');
////                          FirebaseDatabase.instance.reference().once().then((data) {
////                            print('likes : ${data.value}');
////                          });
//                        setState(() {
//                          _liked = !_liked;
//                        });
//                      }),
//                ),
//                Text(
//                  record.likes.toString(),
//                  style: TextStyle(
//                    fontFamily: 'Times New Roman',
//                    color: Colors.black,
//                    fontSize: 18,
//                  ),
//                ),
//              ]),
//            ),
//          ),
//        ),
//      ),
//    );
//
//
////      Padding(
////      key: ValueKey(record.author),
////      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
////      child: Container(
////        decoration: BoxDecoration(
////          border: Border.all(color: Colors.grey),
////          borderRadius: BorderRadius.circular(5.0),
////        ),
////        child: ListTile(
////          title: Text(record.author,
////              style: TextStyle(
////                fontFamily: 'Times New Roman',
////                color: Colors.black,
////                fontSize: 20,
////                fontWeight: FontWeight.bold,
////              )),
////          trailing: Container(
////            width: 90,
////            child: Row(children: [
////              new IconButton(
////                color: _liked ? Colors.red :  Colors.white,
////                icon: Icon(
////                  _liked ? Icons.favorite_border : Icons.favorite,
////                  color: _liked ? Colors.red :  Colors.white,
////                ),
////                onPressed: () =>
////                    Firestore.instance.runTransaction((transaction) async {
////                      final freshSnapshot =
////                      await transaction.get(record.reference);
////                      final fresh = Record.fromSnapshot(freshSnapshot);
////
////                      await transaction.update(record.reference, {
////                        'likes': fresh.likes + 1
////                      }
////                      );
////                      _liked = !_liked;
//////                      _liked ? record.likes++ : record.likes - 1;
////                    }),
////              ),
////              Text(
////                record.likes.toString(),
////                style: TextStyle(
////                  fontFamily: 'Times New Roman',
////                  color: Colors.black,
////                  fontSize: 18,
////                ),
////              ),
////            ]),
////          ),
////        ),
////      ),
////    );
//  }
//}
