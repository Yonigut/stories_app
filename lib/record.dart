import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String author;
  final String title;
  final List<dynamic> text;
  final int likes;
  final int day;
  final int month;
  final int year;
  final List<dynamic> likedBy;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['author'] != null),
        assert(map['title'] != null),
        assert(map['text'] != null),
        assert(map['likes'] != null),
        assert(map['day'] != null),
        assert(map['month'] != null),
        assert(map['year'] != null),
        assert(map['likedBy'] != null),
        author = map['author'],
        title = map['title'],
        text = map['text'],
        likes = map['likes'],
        day = map['day'],
        month = map['month'],
        year = map['year'],
        likedBy = map['likedBy'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$author:$title$month$day$year$likes>";
}