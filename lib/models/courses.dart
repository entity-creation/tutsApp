import 'package:cloud_firestore/cloud_firestore.dart';

class Dept {
  final List<dynamic> dept;

  const Dept({required this.dept});

  static Dept fromJson(DocumentSnapshot snapshot) => Dept(
        dept: snapshot['departments'],
      );
}

class Courses {
  final List<dynamic> courses;

  const Courses({required this.courses});

  static Courses fromJson(DocumentSnapshot snapshot) =>
      Courses(courses: snapshot['courses']);
}
