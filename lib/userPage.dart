import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'home.dart';
import 'record.dart';

class UserPage extends StatefulWidget {
  User user;

  UserPage(this.user);

  @override
  State<UserPage> createState() => UserPageState(user);
}

class UserPageState extends State<UserPage> {
  User user;

  UserPageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(220, 220, 220, 100),
      body: SavedList(this.user),
    );
  }
}

class AllStories extends StatefulWidget {
  @override
  State<AllStories> createState() => AllStoriesState();
}

class AllStoriesState extends State<AllStories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('yoguttfeed')
            .orderBy('moment', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          print('new snapshot');
          if (!snapshot.hasData) return Container();
          print(snapshot.data.documents.length.toString());
          return _buildList(context, snapshot.data.documents);
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    print(snapshot.length.toString());
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }
}

class TempPage extends StatefulWidget {
  User user;

  TempPage(this.user);

  @override
  _TempPageState createState() {
    return _TempPageState();
  }
}

class _TempPageState extends State<TempPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(220, 220, 220, 100),
      body: SavedList(widget.user),
    );
  }
}

class SavedList extends StatefulWidget {
  User user;

  SavedList(this.user);

  @override
  State<SavedList> createState() => SavedListState(this.user);
}

class SavedListState extends State<SavedList> {
  User user;
  bool _ready = false;
  bool allStoriesMode = true;
  int numStories;
  int numFollowers;

  List<dynamic> savedStories;

  SavedListState(this.user);

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
      this.savedStories = ds.data['wrote'];
      this.numStories = this.savedStories.length;
      this.numFollowers = ds.data['followers'].length;
      _ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilding inner list');
    if (savedStories != null) {
      print(savedStories.length.toString());
    }
    return _ready
        ? RefreshIndicator(
            onRefresh: () {
              Future<void> rtn = _getSavedList();
              return rtn;
            },
            child: ListView.builder(
              itemCount: savedStories.length + 2,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return makeFirstIndex();
                } else if (savedStories.length == 0) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 00.0, 0.0),
                    child: Center(
                      child: Text(
                        'No stories to show at the moment',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Crimson',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                } else if (index == 1) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: Align(
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: FlatButton(
                                      color: allStoriesMode
                                          ? Colors.black
                                          : Colors.white,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Text(
                                        'All Stories',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          color: allStoriesMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          this.allStoriesMode = true;
//                                          this.savedStories = this.savedStories.reversed.toList();
                                        });
                                      },
                                    ),
                                  ),
                                  FlatButton(
                                    color: allStoriesMode
                                        ? Colors.white
                                        : Colors.black,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: Text(
                                      'Top Stories',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        color: allStoriesMode
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        this.allStoriesMode = false;
//                                        this.savedStories = this.savedStories.reversed.toList();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return FadeIn(SavedListElement(savedStories[index - 2]));
              },
            ),
          )
        : Container();
  }

  Widget makeFirstIndex() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
//          child: Center(
                  child: Text(
                    user.firstName + ' ' + user.lastName,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'DM-Serif-Text',
//              ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 5.0),
//          child: Center(
                  child: Text(
                    user.username,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontFamily: 'DM-Serif-Text',
                    ),
                  ),
                ),
                Center(
                  child: Divider(
                    color: Colors.black,
                    indent: MediaQuery.of(context).size.width * 0.2,
                    endIndent: MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 5.0, 10.0, 10.0),
                  child: Text(
                    '\"' + user.bio + '\"',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Crimson',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Padding(
              padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    child: Text(
                      this.numStories.toString() + ' Stories',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Heebo',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: Container(
                      height: 50,
                      child: VerticalDivider(
                        color: Colors.black,
                        indent: 10.0,
                        endIndent: 10.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    child: Text(
                      this.numFollowers.toString() + ' Followers',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Heebo',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: Container(
                      height: 50,
                      child: VerticalDivider(
                        color: Colors.black,
                        indent: 10.0,
                        endIndent: 10.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    child: FlatButton(
                      color: Colors.black,
                      onPressed: () {},
                      child: Text(
                        'Following',
                        style: TextStyle(
                          fontFamily: 'Heebo',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget makeSecondIndex() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: Align(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.95,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                        color: allStoriesMode ? Colors.blue : Colors.white,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Text(
                          'All Stories',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            color: allStoriesMode ? Colors.white : Colors.blue,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            this.allStoriesMode = true;
                          });
                        },
                      ),
                    ),
                    FlatButton(
                      color: allStoriesMode ? Colors.white : Colors.blue,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Text(
                        'Top Stories',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          color: allStoriesMode ? Colors.blue : Colors.white,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          this.allStoriesMode = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FadeIn extends StatefulWidget {
  Widget child;

  FadeIn(this.child);

  @override
  State<FadeIn> createState() => FadeInState(child);
}

class FadeInState extends State<FadeIn> {
  Widget child;

  FadeInState(this.child);

  bool visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 600),
      child: this.child,
    );
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
    return _ready ? _buildListItem(context, data) : Container();
  }
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  return BarBlah(data);
}

class BarBlah extends StatefulWidget {
  DocumentSnapshot data;

  BarBlah(this.data);

  getName() {
    return data.documentID;
  }

  @override
  State<BarBlah> createState() => BarBlahState(data);
}

class BarBlahState extends State<BarBlah> {
  DocumentSnapshot data;
  DocumentSnapshot newData;
  Record record;

//  bool recordReady = false;

  BarBlahState(this.data);

  List buildTextViews(BuildContext context) {
    List<Widget> strings = List();
    strings.add(
      Padding(
        padding: EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Text(
            record.title,
            style: TextStyle(
                color: Colors.black, fontFamily: "DM-Serif-Text", fontSize: 40),
          ),
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
                color: Colors.black, fontFamily: "Crimson", fontSize: 20),
          ),
        ),
      );
      strings.add(Container(height: 18));
    }
    return strings;
  }

  bool ready = false;

  Function myCallBack() {
    return () {
      setState(() {
        this.ready = true;
      });
    };
  }

  String _photoURL;

  setUpData() async {
    this.newData = await Firestore.instance
        .collection('stories')
        .document(data.documentID)
        .get();
  }

  @override
  void initState() {
    setUpData().then((_) {
      this.record = Record(newData, myCallBack);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('building ' + data.documentID);
    return !ready
        ? Container()
        : Align(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              child: FlatButton(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            record.title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Crimson',
                                fontSize: 22,
                                color: Colors.black),
                          ),
                        ),
                        SaveButton(record),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        record.month.toString() +
                            '/' +
                            record.day.toString() +
                            '/' +
                            record.year.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Heebo',
                            fontSize: 10,
                            color: Colors.grey),
                      ),
                    ),
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
                                bottom: PreferredSize(
                                    child: Divider(color: Colors.grey)),
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
                                    onPressed: () {},
                                  ),
                                ]),
                            SliverList(
                              delegate: SliverChildListDelegate(
                                  buildTextViews(context)),
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
