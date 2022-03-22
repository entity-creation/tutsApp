import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SharedPref {
  String? value;
  SharedPref({this.value});

  saveString() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("profileUrl", value ?? "");
  }

  getString() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String url = pref.getString("profileUrl") ?? "";
    return url;
  }
}
