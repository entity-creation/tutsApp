import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:tuts_app/models/user.dart';
import 'package:tuts_app/screens/viewPdf.dart';
import 'package:tuts_app/services/database.dart';
import 'package:tuts_app/shared/loading.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';

class PdfLanding extends StatefulWidget {
  const PdfLanding({Key? key}) : super(key: key);

  @override
  State<PdfLanding> createState() => _PdfLandingState();
}

class _PdfLandingState extends State<PdfLanding> {
  @override
  Widget build(BuildContext context) {
    dynamic launcher = Provider.of<Tester?>(context);
    var database = DatabaseService(uid: launcher.uid);
    File newFile;
    return FutureBuilder(
        future: database.getPdfs(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  Map<String, dynamic> file = snapshot.data![index];

                  if (file["description"].toString() == "Physics") {
                    return Card(
                      child: ListTile(
                        dense: false,
                        leading: Text(file["description"].toString()),
                        trailing: IconButton(
                            onPressed: () async {
                              newFile = await database.createFile(
                                  file["fileUrl"], file["fileName"]);

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ViewPdf(newFile);
                              }));
                            },
                            icon: Icon(Icons.arrow_forward_rounded)),
                      ),
                    );
                  }
                  return Loading();
                });
          } else {
            print(snapshot.error);
            return Loading();
          }
        });
  }
}
