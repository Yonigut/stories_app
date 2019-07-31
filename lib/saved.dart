import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'record.dart';
import 'package:share/share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'userPage.dart';
import 'emailVerification.dart';
import 'package:flutter/scheduler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'home.dart';

class SavedPage extends StatefulWidget {
  @override
  _SavedPageState createState() {
    return _SavedPageState();
  }
}

class _SavedPageState extends State<SavedPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SavedList(),
            ),
          );
  }
}

class SavedList extends StatefulWidget {

  @override
  State<SavedList> createState() => SavedListState();
}

class SavedListState extends State<SavedList> {

  bool _ready = false;

  List<dynamic> savedStories;

  @override
  void initState() {
    super.initState();
    _getSavedList();
  }

  Future<void> _getSavedList() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot ds = await Firestore.instance
        .collection('users')
        .document(user.displayName)
        .get();
    setState(() {
      this.savedStories = ds.data['saved'];
      _ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilding inner list');
    if (savedStories != null) {
      print(savedStories.length.toString());
    }
    return _ready ? RefreshIndicator(
      onRefresh: () {
        Future<void> rtn = _getSavedList();
//        build(context);
        return rtn;
      },
      child:
          ListView.builder(
        itemCount: savedStories.length + 1 ,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return
              Align(child:
              Text('Saved Stories',
            style: TextStyle(
              fontSize: 28,
              fontFamily: "DM-Serif-Text",
            ),
              ),
            );
          }
          return SavedListElement(savedStories[index - 1]);
        },
      ),
    ) : Container();
  }
}

class SavedListElement extends StatefulWidget {
  String storyName;

  SavedListElement(this.storyName);

  @override
  State<SavedListElement> createState() => SavedListElementState(storyName);
}

class SavedListElementState extends State<SavedListElement> {
  String storyName;

  SavedListElementState(this.storyName);

  DocumentSnapshot data;

  bool _ready = false;

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() async {
    this.data = await Firestore.instance
        .collection('stories')
        .document(storyName)
        .get();
    setState(() {
      _ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _ready
        ? _buildListItem(context, data)
        : Container(color: Color.fromRGBO(130, 198, 240, 80), height: 40);
  }
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  return Bar(data);
}
//
//
//class Bar extends StatefulWidget {
//
//  DocumentSnapshot data;
//
//  Bar(this.data);
//
//  @override
//  State<Bar> createState() => BarState(data);
//}
//
//class BarState extends State<Bar> {
//
//  DocumentSnapshot data;
//  Record record;
//  bool recordReady;
//
//  BarState(this.data) {
//    record = Record(data, this);
//  }
//
//  List buildTextViews(BuildContext context) {
//    List<Widget> strings = List();
//    strings.add(
//      Padding(
//        padding: EdgeInsets.only(
//          left: 0,
//          right: 0,
//        ),
//        child: Text(
//          record.title,
//          style: TextStyle(
//              color: Colors.black, fontFamily: "DM-Serif-Text", fontSize: 54),
//        ),
//      ),
//    );
//    strings.add(Padding(
//        padding: EdgeInsets.only(
//          left: MediaQuery.of(context).size.width * 0.05,
//          right: MediaQuery.of(context).size.width * 0.05,
//        ),
//        child: Text('by ' + record.author,
//            style: TextStyle(
//                color: Colors.black,
//                fontFamily: "Times New Roman",
//                fontSize: 24))));
//    strings.add(Container(height: 6));
//    strings.add(Padding(
//        padding: EdgeInsets.only(
//          left: MediaQuery.of(context).size.width * 0.05,
//          right: MediaQuery.of(context).size.width * 0.05,
//        ),
//        child: Text(
//            'Published on ' +
//                record.month.toString() +
//                '/' +
//                record.day.toString() +
//                '/' +
//                record.year.toString(),
//            style: TextStyle(
//                color: Colors.black,
//                fontFamily: "Times New Roman",
//                fontSize: 14))));
//    strings.add(Container(
//      height: 18,
//      width: 10,
//    ));
//    for (int i = 0; i < record.text.length; i++) {
//      strings.add(
//        Padding(
//          padding: EdgeInsets.only(
//            left: MediaQuery.of(context).size.width * 0.05,
//            right: MediaQuery.of(context).size.width * 0.05,
//          ),
//          child: Text(
//            record.text[i].toString(),
//            style: TextStyle(
//                color: Colors.black,
//                fontFamily: "Libre-Baskerville",
//                fontSize: 20),
//          ),
//        ),
//      );
//      strings.add(Container(height: 18));
//    }
//    return strings;
//  }
//
//  String _photoURL;
//
//  void initState() {
//    super.initState();
//
//    var ref = FirebaseStorage.instance
//        .ref()
//        .child('story_images')
//        .child(this.record.imageName);
//    ref.getDownloadURL().then((loc) => setState(() => _photoURL = loc));
//  }
//
////  getPhoto() async {
////    final StorageReference storageRef =
////    FirebaseStorage.instance.ref().child('story_images').child('giftofthemagi_11_zps39940c2e.jpg');
////    photoURL = await storageRef.getDownloadURL();
////    print('image URL: ' + photoURL);
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.symmetric(vertical: 2.0),
//      child: Container(
//        child: RaisedButton(
//          color: Colors.white,
//          child: Column(
//            children: [
//              Container(height: 20),
//              (_photoURL == null)
//                  ? Container(color: Colors.yellow)
//                  : Container(child: Image.network(_photoURL)),
//              Container(height: 10),
//              Align(
//                alignment: Alignment.centerLeft,
//                child: Text(record.title,
//                    textAlign: TextAlign.left,
//                    style: TextStyle(
//                        fontFamily: 'DM-Serif-Text',
//                        fontSize: 30,
//                        color: Colors.black)),
//              ),
//              Align(
//                alignment: Alignment.centerLeft,
//                child: Text(
//                  record.author,
//                  textAlign: TextAlign.left,
//                  style: TextStyle(
//                    fontFamily: 'DM-Serif-Text',
//                    fontSize: 20,
//                    color: Color.fromRGBO(80, 149, 237, 20),
//                  ),
//                ),
//              ),
//              Container(height: 10),
//              Text(record.preview,
//                  style:
//                      TextStyle(fontFamily: 'Libre-Baskerville', fontSize: 18)),
//              Container(height: 10),
//            ],
//          ),
//          splashColor: Colors.white,
//          highlightColor: Colors.white,
//          onPressed: () {
//            Navigator.of(context).push(
//              new MaterialPageRoute(
//                builder: (context) => new Scaffold(
//                  backgroundColor: Colors.white,
//                  body: CustomScrollView(
//                    slivers: [
//                      SliverAppBar(
//                          bottom:
//                              PreferredSize(child: Divider(color: Colors.grey)),
//                          floating: true,
//                          pinned: false,
//                          snap: false,
//                          expandedHeight: 30.0,
//                          backgroundColor: Colors.white,
//                          flexibleSpace: const FlexibleSpaceBar(
//                            title: Text(
//                              'S t o r y',
//                              style: TextStyle(
//                                  color: Colors.black,
//                                  fontFamily: "Times New Roman",
//                                  fontSize: 26),
//                            ),
//                          ),
//                          leading: IconButton(
//                              icon: Icon(Icons.arrow_back_ios,
//                                  color: Colors.black),
//                              onPressed: () {
//                                Navigator.pop(context);
//                              }),
//                          actions: <Widget>[
//                            Icon(Icons.mode_comment, color: Colors.red),
//                            Icon(Icons.bookmark_border,
//                                color: Colors.red, size: 30),
//                            IconButton(
//                              icon: const Icon(Icons.mobile_screen_share),
//                              color: Colors.black,
//                              tooltip: 'Add new entry',
//                              onPressed: () {
//                                Share.share(
//                                    'check out my website https://example.com');
//                              },
//                            ),
//                          ]),
//                      SliverList(
//                        delegate:
//                            SliverChildListDelegate(buildTextViews(context)),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            );
//          },
//        ),
//      ),
//    );
//  }
//}
