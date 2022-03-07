import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuts_app/screens/authenticate/authenticate.dart';
import 'package:tuts_app/models/user.dart';
import 'package:tuts_app/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  final String uid;
  const Wrapper({Key? key, required this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    dynamic launcher = Provider.of<Tester?>(context);

    //return either home or authenticate widget
    if (launcher == null) {
      return const Authenticate();
    }
    else {
      return Home(uid: uid);
    }
  }
}
