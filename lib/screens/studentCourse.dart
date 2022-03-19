import 'package:flutter/material.dart';

import 'pdfLanding.dart';

class StudentCourse extends StatefulWidget {
  const StudentCourse({Key? key}) : super(key: key);

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
      body: PdfLanding(),
    );
  }
}
