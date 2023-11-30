import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:user_manuals_app/model/product.dart';
import 'package:user_manuals_app/util/database_manager.dart';
import 'package:user_manuals_app/widgets/PDFWidget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:user_manuals_app/widgets/favorites_button.dart';

//TODO: ADD MORE COMMENTS

class ProductScreen extends StatelessWidget {
  ProductScreen({
    super.key,
    required this.item,
  });

  final Product item;
  final DatabaseManager db = DatabaseManager();

  Future<void> _launchPDFViewer(BuildContext context, String pdfUrl) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PDFViewer(url: pdfUrl)),
    );
  }

  Future<void> downloadFile(BuildContext context, String url) async {
    EasyLoading.show(status: "Product.download".tr());
    Dio dio = Dio();
    try {
      // Fetch the file
      Response response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes, // Ensure response type is bytes
        ),
      );

      // Get the external storage directory (Downloads folder for Android)
      bool dirDownloadExists = true;
      var directory;
      if (Platform.isAndroid) {
        //work around for downloading to android downloads folder
        directory = "/storage/emulated/0/Download";

        dirDownloadExists = await Directory(directory).exists();
        if (dirDownloadExists) {
          directory = "/storage/emulated/0/Download";
        } else {
          directory = "/storage/emulated/0/Downloads";
        }
      } else {
        //for other devices
        directory = await getDownloadsDirectory();
      }
      if (directory != null) {
        // Specify the file path and name where you want to save the file
        String filePath = '$directory/${item.title}-downloaded_file.pdf';
        // Write the file to the downloads directory
        await File(filePath).writeAsBytes(response.data);
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File downloaded to: $filePath'),
            duration: const Duration(seconds: 5),
          ),
        );
      } else {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not access downloads directory.'),
            duration: Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Download error: $e'),
          duration: const Duration(seconds: 5),
        ),
      );
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (shouldPop) async {
        if (shouldPop) {
          EasyLoading.dismiss();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.background,
          ),
          title:
              Text(item.title, style: Theme.of(context).textTheme.titleLarge),
          actions: [
            FavoritesButton(
              item: item,
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.onSecondary,
                width: double.infinity,
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(500.0),
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: const Color(0xFFABD1C6),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        item.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Product.modelNumber".tr() +
                            (item.modelNumber?.toString() ?? 'N/A'),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        "Product.releaseYear".tr() +
                            (item.releaseYear?.toString() ?? 'N/A'),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                if (item.pdfUrl.isNotEmpty) {
                                  _launchPDFViewer(context, item.pdfUrl);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Product.error".tr(),
                                      ),
                                      duration: const Duration(seconds: 5),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.picture_as_pdf,
                                color: Color(0xFF001E1D),
                              ),
                              label: Text(
                                "Product.OpenPDF".tr(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                if (item.pdfUrl.isNotEmpty) {
                                  downloadFile(context, item.pdfUrl);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Product.error".tr(),
                                      ),
                                      duration: const Duration(seconds: 5),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.download,
                                color: Color(0xFF001E1D),
                              ),
                              label: Text(
                                "Product.DownloadPDF".tr(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
