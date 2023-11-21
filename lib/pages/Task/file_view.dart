import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FileView extends StatelessWidget {
  String fileUrl;
  FileView(this.fileUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDF().cachedFromUrl(
        fileUrl,
        placeholder: (progress) => Center(child: CircularProgressIndicator()),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
