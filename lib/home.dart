import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'record.dart';
import 'package:share/share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'userPage.dart';
import 'saved.dart';
import 'user.dart';

class HomePage extends StatefulWidget {
  User myUser;

  HomePage(this.user);

  FirebaseUser user;

  @override
  State<HomePage> createState() => HomePageState(user);
}

class HomePageState extends State<HomePage> {
  FirebaseUser user;
  User myUser;
  bool ready = false;

//  bool userVerified = false;

  HomePageState(this.user);

  static Widget homePage;
  static Widget savedPage;
  static Widget userPage;

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontFamily: 'Times New Roman');
  static List<Widget> _widgetOptions = <Widget>[
    homePage,
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Write',
      style: optionStyle,
    ),
    savedPage,
    userPage,
  ];

  Function myCallBack() {
    return () {
      setState(() {
        this.ready = true;
      });
    };
  }

  @override
  void initState() {
    this.myUser = new User(myCallBack);
    super.initState();
    savedPage = SavedPage();
    userPage = UserPage(myUser);
    homePage = MyHomePage2(myUser);
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  getUser() async {
    this.user = await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return !ready
        ? Container(
            color: Colors.white,
            child: Center(
              child: SizedBox(
                height: 30.0,
                width: 30.0,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  strokeWidth: 5.0,
                ),
              ),
            ),
          )
        :
        Scaffold(
            key: Key('home'),
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.book, size: 30, color: Colors.black),
                  title: Padding(padding: EdgeInsets.all(0)),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search, size: 30, color: Colors.black),
                  title: Padding(padding: EdgeInsets.all(0)),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.create, size: 30, color: Colors.black),
                  title: Padding(padding: EdgeInsets.all(0)),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_border,
                      size: 30, color: Colors.black),
                  title: Padding(padding: EdgeInsets.all(0)),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 24,
                    color: Colors.black,
                    key: Key('user icon'),
                  ),
                  title: Padding(padding: EdgeInsets.all(0)),
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped,
            ),
          );
  }
}

class MyHomePage2 extends StatefulWidget {
  User user;

  MyHomePage2(this.user);

  @override
  _MyHomePageState2 createState() {
    return _MyHomePageState2(user);
  }
}

class _MyHomePageState2 extends State<MyHomePage2> {
  User user;

  _MyHomePageState2(this.user);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    print(snapshot.length.toString());
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    print('building a list item called ' + data.documentID);
    Bar updatedBar = new Bar(data);
    print(updatedBar.data.documentID);
    List v = [5, 3];
    v.insert(0, 2);
    return FadeIn(updatedBar);
  }
}

class FadeIn extends StatefulWidget {
  Bar child;

  FadeIn(this.child);

  @override
  State<FadeIn> createState() => FadeInState(child);
}

class FadeInState extends State<FadeIn> {
  Bar child;

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
    print('building fadeIn of ' + child.getName());
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 350),
      child: this.child,
    );
  }
}

class Bar extends StatefulWidget {
  DocumentSnapshot data;

  Bar(this.data);

  getName() {
    return data.documentID;
  }

  @override
  State<Bar> createState() => BarState(data);
}

class BarState extends State<Bar> {
  DocumentSnapshot data;
  DocumentSnapshot newData;
  Record record;

  BarState(this.data);

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
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Container(
              child: RaisedButton(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(height: 20),
                    Container(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        record.title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'DM-Serif-Text',
                            fontSize: 30,
                            color: Colors.black),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          record.author,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'DM-Serif-Text',
                            fontSize: 20,
                            color: Color.fromRGBO(130, 198, 240, 100),
//                  color: Color.fromRGBO(100, 180, 230, 50),
                          ),
                        ),
                        SaveButton(record),
                      ],
                    ),
                    Container(height: 10),
                    Text(record.preview,
                        style: TextStyle(fontFamily: 'Crimson', fontSize: 18)),
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
                                    onPressed: () {
                                      Share.share(
                                          'check out my website https://example.com');
                                    },
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

class SaveButton extends StatefulWidget {
  Record record;

  SaveButton(this.record);

  @override
  State<SaveButton> createState() => SaveButtonState(record);
}

class SaveButtonState extends State<SaveButton> {
  bool _saved = false;
  Record record;

  SaveButtonState(this.record);

  @override
  void initState() {
    super.initState();
    _saved = record.savedByUser;
    getSavedState();
  }

  getSavedState() async {}

  flipSavedState() async {
    setState(() {
      _saved = !_saved;
    });
    record.savedByUser = !record.savedByUser;
    Firestore.instance.collection('users');
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot data = await Firestore.instance
        .collection('users')
        .document(user.displayName)
        .get();
    // add firebase transaction implementation - add or remove from the saved stories list
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        flipSavedState();
      },
      icon: _saved
          ? Icon(Icons.bookmark, color: Colors.black, size: 30)
          : Icon(Icons.bookmark_border, color: Colors.black, size: 30),
    );
  }
}

class ReadIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Read'),
      Icon(Icons.book),
    ]);
  }
}
