import 'package:flutter/material.dart';
import 'package:user_manuals_app/model/product.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewer extends StatelessWidget {
  PDFViewer({super.key, required this.url});

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
        body: Container(child: SfPdfViewer.network(url)));
  }
}
