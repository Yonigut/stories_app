import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'record.dart';
import 'package:share/share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';
import 'emailVerification.dart';
import 'package:flutter/scheduler.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SavedPage extends StatefulWidget {
  @override
  _SavedPageState createState() {
    return _SavedPageState();
  }
}

class _SavedPageState extends State<SavedPage> {
  List<dynamic> savedStories;

  bool _ready = false;

//  StatefulWidget prevWidget;
//  StatefulWidget newWidget;

  @override
  void initState() {
    super.initState();
    _getSavedList();
//    prevWidget = Container();
  }

//  void stuff() {
//    var userQuery = await Firestore.instance
//        .collection('tbl_users').document('yogutt').listen[]
//  }

  Future<void> _getSavedList() async {
//    setState(() {
//      _ready = false;
//    });
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot ds = await Firestore.instance
        .collection('users')
        .document(user.displayName)
        .get();
    print('display name is: ' + user.displayName);
    print(ds.documentID);
    setState(() {
      print('before');
      if (savedStories != null) { print(savedStories.length.toString()); }
      print('updating stories');
      this.savedStories = ds.data['saved'];
      print('after');
      if (savedStories != null) { print(savedStories.length.toString()); }
      _ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('rebuiling saved list');
    if (savedStories != null) { print(savedStories.length.toString()); }
    return _ready
        ? Scaffold(
            backgroundColor: Color.fromRGBO(174, 198, 207, 100),
            body: Center(
              child: RefreshIndicator(
                onRefresh: () {
                  Future<void> rtn = _getSavedList();
                  build(context);
                  return rtn;
                },
                child: SavedList(this.savedStories),
              ),
            ),
          )
        : Container();
  }
}

class SavedList extends StatefulWidget {
  List<dynamic> savedStories;

  SavedList(this.savedStories);

  @override
  State<SavedList> createState() => SavedListState(savedStories);
}

class SavedListState extends State<SavedList> {
  List<dynamic> savedStories;

  SavedListState(this.savedStories);

  @override
  Widget build(BuildContext context) {
    print('rebuilding inner list');
    if (savedStories != null) { print(savedStories.length.toString()); }
    return ListView.builder(
        itemCount: savedStories.length,
        itemBuilder: (BuildContext context, int index) {
          return SavedListElement(savedStories[index]);
        });
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
//    var futures = <Future>[];
//    futures.add(getData());
//    Future.wait(futures);
  }

  getData() async {
//    print('storyname is ' + storyName);
//    print('is data null? ${data == null}');
    this.data = await Firestore.instance
        .collection('stories')
        .document(storyName)
        .get();
    setState(() {
      _ready = true;
    });
//    print('is data null? ${data == null}');
  }

  @override
  Widget build(BuildContext context) {
    return _ready
        ? _buildListItem(context, data)
        : Container(color: Color.fromRGBO(130, 198, 240, 80), height: 40);
  }
}

//
//DocumentSnapshot data = null;
//
//getData(String storyName) async {
//  this.data = await Firestore.instance.collection(stories)
//      .document(
//      storyName)
//      .get();
//}
//
//
//class BodyBuilder extends StatefulWidget {
//  @
//}
//
//Widget _buildBody(BuildContext context, List savedStories) {
//  return ListView.builder(itemBuilder: (BuildContext context, int index)
//  {
//    String currentStory = savedStories[index];
//    getData(currentStory);
//    DocumentSnapshot thisData = clone(this.data);
//    return _buildListItem(context, data);
//  }
//}

//  Widget _buildBody(BuildContext context) {
//    return StreamBuilder<QuerySnapshot>(
//      stream: Firestore.instance.collection('users').document(username).collection('saved').snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) return LinearProgressIndicator();
//
//        return _buildList(context, Firestore.instance.collection('stories').document(snapshot));
//      },
//    );
//  }
//
//  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//    return ListView(
//      padding: const EdgeInsets.only(top: 20.0),
//      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//    );
//  }

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Record.fromSnapshot(data);

  return Bar(record);
}

class Bar extends StatefulWidget {
  Record record;

  Bar(this.record);

  @override
  State<Bar> createState() => BarState(record);
}

class BarState extends State<Bar> {
  Record record;

  BarState(this.record);

  List buildTextViews(BuildContext context) {
    List<Widget> strings = List();
    strings.add(
      Padding(
        padding: EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        child: Text(
          record.title,
          style: TextStyle(
              color: Colors.black, fontFamily: "DM-Serif-Text", fontSize: 54),
        ),
      ),
    );
    strings.add(Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Text('by ' + record.author,
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Times New Roman",
                fontSize: 24))));
    strings.add(Container(height: 6));
    strings.add(Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Text(
            'Published on ' +
                record.month.toString() +
                '/' +
                record.day.toString() +
                '/' +
                record.year.toString(),
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Times New Roman",
                fontSize: 14))));
    strings.add(Container(
      height: 18,
      width: 10,
    ));
    for (int i = 0; i < record.text.length; i++) {
      strings.add(
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Text(
            record.text[i].toString(),
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Libre-Baskerville",
                fontSize: 20),
          ),
        ),
      );
      strings.add(Container(height: 18));
    }
    return strings;
  }

  String _photoURL;

  void initState() {
    super.initState();

    var ref = FirebaseStorage.instance
        .ref()
        .child('story_images')
        .child(this.record.imageName);
    ref.getDownloadURL().then((loc) => setState(() => _photoURL = loc));
  }

//  getPhoto() async {
//    final StorageReference storageRef =
//    FirebaseStorage.instance.ref().child('story_images').child('giftofthemagi_11_zps39940c2e.jpg');
//    photoURL = await storageRef.getDownloadURL();
//    print('image URL: ' + photoURL);
//  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Container(
        child: RaisedButton(
          color: Colors.white,
          child: Column(
            children: [
              Container(height: 20),
              (_photoURL == null)
                  ? Container(color: Colors.yellow)
                  : Container(child: Image.network(_photoURL)),
              Container(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(record.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'DM-Serif-Text',
                        fontSize: 30,
                        color: Colors.black)),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  record.author,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'DM-Serif-Text',
                    fontSize: 20,
                    color: Color.fromRGBO(80, 149, 237, 20),
                  ),
                ),
              ),
              Container(height: 10),
              Text(record.preview,
                  style:
                      TextStyle(fontFamily: 'Libre-Baskerville', fontSize: 18)),
              Container(height: 10),
            ],
          ),
          splashColor: Colors.white,
          highlightColor: Colors.white,
          onPressed: () {
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => new Scaffold(
                  backgroundColor: Colors.white,
                  body: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                          bottom:
                              PreferredSize(child: Divider(color: Colors.grey)),
                          floating: true,
                          pinned: false,
                          snap: false,
                          expandedHeight: 30.0,
                          backgroundColor: Colors.white,
                          flexibleSpace: const FlexibleSpaceBar(
                            title: Text(
                              'S t o r y',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Times New Roman",
                                  fontSize: 26),
                            ),
                          ),
                          leading: IconButton(
                              icon: Icon(Icons.arrow_back_ios,
                                  color: Colors.black),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          actions: <Widget>[
                            Icon(Icons.mode_comment, color: Colors.red),
                            Icon(Icons.bookmark_border,
                                color: Colors.red, size: 30),
                            IconButton(
                              icon: const Icon(Icons.mobile_screen_share),
                              color: Colors.black,
                              tooltip: 'Add new entry',
                              onPressed: () {
                                Share.share(
                                    'check out my website https://example.com');
                              },
                            ),
                          ]),
                      SliverList(
                        delegate:
                            SliverChildListDelegate(buildTextViews(context)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
