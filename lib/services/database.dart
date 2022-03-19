import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tuts_app/models/info.dart';
import 'package:tuts_app/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference userData =
      FirebaseFirestore.instance.collection('User');

  Future updateUserData(
      String name,
      String number,
      String address,
      int gender,
      int function,
      String urlAvatar,
      String lastMessageTime,
      List<dynamic> faculty,
      List<dynamic> courses) async {
    return await userData.doc(uid).set({
      'Name': name,
      'Phone Number': number,
      'Address': address,
      'Gender': gender,
      'Function': function,
      'Faculty': faculty,
      'Courses': courses,
      'urlAvatar': urlAvatar,
      'lastMessageTime': lastMessageTime,
    });
  }

  //User data from snapshot
  MainUser _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return MainUser(
        uid: uid,
        name: snapshot['Name'],
        number: snapshot['Phone Number'],
        address: snapshot['Address'],
        gender: snapshot['Gender'],
        function: snapshot['Function'],
        faculty: snapshot['Faculty'],
        courses: snapshot['Courses'],
        urlAvatar: snapshot['urlAvatar'],
        lastMessageTime: snapshot['lastMessageTime']);
  }

  //List from snapshot
  List<Info> _infoFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Info(
        name: doc.data().toString().contains('Name') ? doc.get('Name') : '',
        number: doc.data().toString().contains('Phone Number')
            ? doc.get('Phone Number')
            : '',
        address:
            doc.data().toString().contains('Address') ? doc.get('Address') : '',
        gender:
            doc.data().toString().contains('Gender') ? doc.get('Gender') : 0,
        function: doc.data().toString().contains('Function')
            ? doc.get('Function')
            : 0,
        faculty:
            doc.data().toString().contains('Faculty') ? doc.get('Faculty') : [],
        courses:
            doc.data().toString().contains('Courses') ? doc.get('Courses') : [],
        lastMessageTime: doc.data().toString().contains('lastMessageTime')
            ? doc.get('lastMessageTime')
            : '',
        urlAvatar: doc.data().toString().contains('urlAvatar')
            ? doc.get('urlAvatar')
            : '',
      );
    }).toList();
  }

  //Get Streams
  Stream<List<Info>> get users {
    return userData.snapshots().map(_infoFromSnapshot);
  }

  Stream<MainUser> get oneUser {
    return userData.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future uploadPdf(
      File file, String course, String uid, String fileName) async {
    String url;
    bool status;
    Reference reference = FirebaseStorage.instance
        .ref()
        .child("Files/${Path.basename(file.path)}");

    UploadTask uploadTask = reference.putFile(
        file,
        SettableMetadata(customMetadata: {
          "uploaded_by": uid,
          "description": course,
          "fileName": fileName
        }));
    await uploadTask.whenComplete(() => {status = true});
    reference.getDownloadURL().then((value) => url = value);
  }

  Future<List<Map<String, dynamic>>> getPdfs() async {
    List<Map<String, dynamic>> files = [];
    Reference reference = FirebaseStorage.instance.ref("Files/");
    ListResult result = await reference.list();
    List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();

      files.add({
        "fileUrl": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? "Nobody",
        "description":
            fileMeta.customMetadata?["description"] ?? "No description",
        "fileName": fileMeta.customMetadata?['uploaded_by'] ?? "SomeFile",
      });
    });

    return files;
  }

  Future<File> createFile(String url, String fileName) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    if (await File("$dir/$fileName").exists()) {
      return File("$dir/$fileName");
    }
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);

    File file = new File("$dir/$fileName");
    await file.writeAsBytes(bytes);

    return file;
  }
}
