import 'package:flutter/material.dart';

import 'pdfLanding.dart';

class StudentCourse extends StatefulWidget {
  final String courseName;
  const StudentCourse({required this.courseName, Key? key}) : super(key: key);

  @override
  State<StudentCourse> createState() => _StudentCourseState();
}

class _StudentCourseState extends State<StudentCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: PdfLanding(courseName: widget.courseName),
    );
  }
}
