import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class ViewPdf extends StatelessWidget {
  final dynamic file;
  const ViewPdf(this.file, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String path = file.path;
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
        ),
        path: path);
  }
}
