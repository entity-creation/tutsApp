import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tuts_app/models/user.dart';
import 'package:tuts_app/services/database.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

import 'pdfLanding.dart';

class TutorCourse extends StatefulWidget {
  final String courseName;
  const TutorCourse({required this.courseName, Key? key}) : super(key: key);

  @override
  State<TutorCourse> createState() => _TutorCourseState();
}

class _TutorCourseState extends State<TutorCourse> {
  var files;
  var length;
  void getFiles(String uid) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    //asyn function to get list of files
    // List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    // var root = storageInfo[0]
    //     .rootDir; //storageInfo[1] for SD card, geting the root directory
    // var fm = FileManager(root: Directory(root)); //
    // files = await fm.filesTree(
    //     excludedPaths: ["/storage/emulated/0/Android"],
    //     extensions: ["pdf"] //optional, to filter files, list only pdf files
    //     );

    FilePickerResult? picker = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    List<File>? files;
    if (picker != null) {
      files = picker.paths.map((e) => File(e!)).toList();
    }

    setState(() {
      length = files?.length ?? 0;
    });
    if (files?.length != 0) {
      for (var file in files!) {
        DatabaseService(uid: uid).uploadPdf(file, widget.courseName, uid,
            path.basenameWithoutExtension(file.path));
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Success uploading file"),
        backgroundColor: Colors.green,
      ));
    }

    // if (length > 0) {
    //   buildList(files?.length ?? 0, files);
    // }
  }

  Widget buildList(int length, dynamic file) {
    return ListView.builder(
        itemCount: length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            title: Text(files[index].path.split('/').last),
            leading: Icon(Icons.image),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Colors.green,
              ),
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    dynamic launcher = Provider.of<Tester?>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: PdfLanding(
        courseName: widget.courseName,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getFiles(launcher.uid);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
