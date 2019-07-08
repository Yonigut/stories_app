import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'record.dart';
import 'package:share/share.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
    @required this.user
}) : super(key: key);

  final FirebaseUser user;


@override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontFamily: 'Times New Roman');
  static List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Write',
      style: optionStyle,
    ),
    Text(
      'Saved Stories',
      style: optionStyle,
    ),
    Text(
      'User',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
//      MaterialApp(
//      home:
      Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
//        appBar: AppBar(title: const Text('Bottom App Bar')),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30, color: Colors.black),
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
              icon: Icon(Icons.bookmark_border, size: 30, color: Colors.black),
              title: Padding(padding: EdgeInsets.all(0)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 24, color: Colors.black),
              title: Padding(padding: EdgeInsets.all(0)),
            ),
          ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
//      ),
    );
//        bottomNavigationBar: BottomAppBar(
//          child: new Row(
//            mainAxisSize: MainAxisSize.max,
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//              IconButton(
//                icon: Icon(Icons.home),
//                onPressed: () {},
//              ),
//              IconButton(
//                icon: Icon(Icons.search),
//                onPressed: () {},
//              ),
//              IconButton(
//                icon: Icon(Icons.create),
//                onPressed: () {},
//              ),
//              IconButton(
//                icon: Icon(Icons.bookmark_border),
//                onPressed: () {},
//              ),
//              IconButton(
//                icon: Icon(Icons.person),
//                onPressed: () {},
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(title: Text('Baby Name Votes')),
      body:
//        Column(
//        children: [
//          Container(height: 5),
      _buildBody(context),
//      ],
//    ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('stories').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

//  HeartButton extends IconButton {
//
//}

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
//    bool _liked = false;
//    Widget heart = HeartButton();

    return Bar(record);
//
//      Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//      child: Container(
//        decoration: BoxDecoration(
//          border: Border.all(color: Colors.grey),
//          borderRadius: BorderRadius.circular(5.0),
//        ),
//        child: ListTile(
//          title: Text(record.author),
//          trailing: Container(width: 130, child: Row(
//              children: <Widget>[
//                RaisedButton(
//                  onPressed: () {
//                    Firestore.instance.runTransaction(
//                          (transaction) async {
//                        final freshSnapshot = await transaction.get(
//                            record.reference);
//                        final fresh = Record.fromSnapshot(freshSnapshot);
//
//                        bool notLiked = true;
//                        List<dynamic> list = record.likedBy;
//                        List<dynamic> newList = []..addAll(list);
//                        for (String user in list) {
//                          if (user == 'yonigg98') {
//                            notLiked = false;
//                          }
//                        }
//                        notLiked ? newList.add('yonigg98') : newList.remove(
//                            'yonigg98');
//                        await transaction.update(
//                          record.reference,
//                          {
//                            'likes': notLiked ? fresh.likes + 1 : fresh.likes -
//                                1
//                          },
//                        );
//                        await transaction.update(record.reference, {
//                          'likedBy': newList,
//                        });
//                      },
//                    );
//                  },
//                  color: Colors.green,
//                ),
//
//
//                Text(record.likes.toString())])),
//          onTap: () {},
//        ),
//      ),
//    );
  }
}

class Bar extends StatelessWidget {


  Record record;

  Bar(this.record);

  List buildTextViews(BuildContext context) {
    List<Widget> strings = List();
    strings.add( Padding( padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right:  MediaQuery.of(context).size.width * 0.05,), child: Text(record.title, style: TextStyle(color: Colors.black, fontFamily: "Times New Roman", fontSize: 54),),),);
    strings.add( Padding( padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right:  MediaQuery.of(context).size.width * 0.05,), child : Text('by ' + record.author, style: TextStyle(color: Colors.black, fontFamily: "Times New Roman", fontSize: 24))));
    strings.add(Container(height: 6));
    strings.add(Padding( padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right:  MediaQuery.of(context).size.width * 0.05,), child : Text('Published on ' + record.month.toString() + '/' + record.day.toString() + '/' + record.year.toString(), style: TextStyle(color: Colors.black, fontFamily: "Times New Roman", fontSize: 14))));
//    strings.add(Container(height: 18, width: 10,));
//    strings.add( Padding( padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right:  MediaQuery.of(context).size.width * 0.1,), child: Divider(color: Colors.black),),);
    strings.add(Container(height: 18, width: 10,));
    for (int i = 0; i < record.text.length; i++) {
      strings.add( Padding( padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right:  MediaQuery.of(context).size.width * 0.05,), child: Text(record.text[i].toString(), style: TextStyle(color: Colors.black, fontFamily: "Times New Roman", fontSize: 20))));
      strings.add(Container(height: 18));
    }
    return strings;
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(

          title: Text(record.author + '\n' + record.title

              , style: TextStyle(fontFamily: 'Times New Roman', fontSize: 20, color : Colors.black)),
          trailing: Container(width: 130, child: Row(
              children: <Widget>[
//                RaisedButton(
//                  onPressed: () {
//                    Firestore.instance.runTransaction(
//                          (transaction) async {
//                        final freshSnapshot = await transaction.get(
//                            record.reference);
//                        final fresh = Record.fromSnapshot(freshSnapshot);
//
//                        bool notLiked = true;
//                        List<dynamic> list = record.likedBy;
//                        List<dynamic> newList = []..addAll(list);
//                        for (String user in list) {
//                          if (user == 'yonigg98') {
//                            notLiked = false;
//                          }
//                        }
//                        notLiked ? newList.add('yonigg98') : newList.remove(
//                            'yonigg98');
//                        await transaction.update(
//                          record.reference,
//                          {
//                            'likes': notLiked ? fresh.likes + 1 : fresh.likes -
//                                1
//                          },
//                        );
//                        await transaction.update(record.reference, {
//                          'likedBy': newList,
//                        });
//                      },
//                    );
//                  },
//                  color: Colors.green,
//                ),


                Text(record.likes.toString())])),
          onTap: () {
            Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (context) => new Scaffold(
                      backgroundColor: Colors.white,

                    body: CustomScrollView(

                  slivers: [
                        SliverAppBar(
                          bottom: PreferredSize(child:Divider(color:Colors.grey)),
                            floating: true,
                            pinned: false,
                            snap: false,
                        expandedHeight: 30.0,
                            backgroundColor: Colors.white,

                        flexibleSpace: const FlexibleSpaceBar(
                          title: Text('S t o r y', style: TextStyle(color: Colors.black, fontFamily: "Times New Roman", fontSize: 26),),
                        ),
                        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                        onPressed : () {
                          Navigator.pop(context);
                }),

                            actions: <Widget>[
                          Icon(Icons.mode_comment, color: Colors.red),
                          Icon(Icons.bookmark_border, color: Colors.red, size: 30),
                          IconButton(
                            icon: const Icon(Icons.mobile_screen_share),
                            color: Colors.black,
                            tooltip: 'Add new entry',
                            onPressed: () { Share.share('check out my website https://example.com');},
                          ),
                        ]
                    ),
                    SliverList(
                        delegate : SliverChildListDelegate(
                            buildTextViews(context)
                        ),
                    ),
                  ],
                    ),

//                        Text(record.title, style: TextStyle(color: Colors.black, fontFamily: "Times New Roman", fontSize: 54)),
//                        Text('by ' + record.author, style: TextStyle(color: Colors.black, fontFamily: "Times New Roman", fontSize: 24))),
//                  Text('Published on ' + record.month.toString() + record.day.toString() + ', ' + record.year.toString(), style: TextStyle(color: Colors.black, fontFamily: "Times New Roman", fontSize: 14)),
//                  Text(record.text, style: TextStyle(color: Colors.black, fontFamily: "Times New Roman", fontSize: 18)),

//                    Text(record.title, style: TextStyle(color: Colors.black, fontFamily: "Times New Roman", fontSize: 54)),
//                    Text('by ' + record.author, style: TextStyle(color: Colors.black, fontFamily: "Times New Roman", fontSize: 24)),
//                    Text('Published on ' + record.month.toString() + record.day.toString() + ', ' + record.year.toString(), style: TextStyle(color: Colors.black, fontFamily: "Times New Roman", fontSize: 14)),
//                    Text(record.text, style: TextStyle(color: Colors.black, fontFamily: "Times New Roman", fontSize: 18)),
                    ),
                ),
            );

          },
        ),
      ),
    );
  }
}

//  HEART BUTTON CODE:
//RaisedButton(
//onPressed: () {
//Firestore.instance.runTransaction(
//(transaction) async {
//final freshSnapshot = await transaction.get(
//record.reference);
//final fresh = Record.fromSnapshot(freshSnapshot);
//
//bool notLiked = true;
//List<dynamic> list = record.likedBy;
//List<dynamic> newList = []..addAll(list);
//for (String user in list) {
//if (user == 'yonigg98') {
//notLiked = false;
//}
//}
//notLiked ? newList.add('yonigg98') : newList.remove(
//'yonigg98');
//await transaction.update(
//record.reference,
//{
//'likes': notLiked ? fresh.likes + 1 : fresh.likes -
//1
//},
//);
//await transaction.update(record.reference, {
//'likedBy': newList,
//});
//},
//);
//},
//color: Colors.green,
//),













