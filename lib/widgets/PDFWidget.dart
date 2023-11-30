import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

//**
// Flutter widget for PDF viewing using SyncFusion PDF Viewer
// gets the download url of the PDF and opens it in-app with the PDF viewer
// */

class PDFViewer extends StatelessWidget {
  const PDFViewer({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.background,
          ),
          title: Text("PDF", style: Theme.of(context).textTheme.titleLarge),
        ),
        body: SfPdfViewer.network(url));
  }
}
