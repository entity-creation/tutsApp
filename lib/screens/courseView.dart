import 'package:flutter/material.dart';
import 'package:tuts_app/services/database.dart';
import 'package:tuts_app/shared/loading.dart';

import '../models/user.dart';

class CourseView extends StatelessWidget {
  final String courseName;
  final String courseDesc;
  final uid;
  const CourseView(
      {required this.courseName,
      required this.courseDesc,
      required this.uid,
      Key? key})
      : super(key: key);

  void courseClicked(dynamic function, BuildContext context) {
    if (function == '1') {
      Navigator.pushNamed(context, "/tutorCourse");
    } else if (function == "2") {
      Navigator.pushNamed(context, "/studentCourse");
    } else {
      Loading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MainUser>(
        stream: DatabaseService(uid: this.uid).oneUser,
        builder: (context, snapshot) {
          String function = "0";
          if (!snapshot.hasData) {
            print("No data");
          } else {
            MainUser? mainUser = snapshot.data;
            function = mainUser!.function.toString();
          }
          return InkWell(
            onTap: () {
              courseClicked(function, context);
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.orange),
                    height: 30.0,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        courseName,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Center(
                      child: Text(
                        courseDesc,
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
