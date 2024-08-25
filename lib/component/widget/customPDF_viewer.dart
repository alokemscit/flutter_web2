import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

// ignore: non_constant_identifier_names
Widget CustomPDFviewer(String pdfUrl) => PDFView(
      filePath: pdfUrl,
      // You can use either `filePath` or `url` to load the PDF.
      // If the PDF is on the server, use `url` instead of `filePath`.
      // url: 'https://example.com/path/to/your/file.pdf',
      onRender: (pages) {
        // PDF document is rendered
      },
      onError: (error) {
        // Handle error during PDF loading
      },
      onPageError: (page, error) {
        // Handle error during page loading
      },
      onViewCreated: (PDFViewController controller) {
        // Do something with the controller
      },
      onPageChanged: (int? page, int? total) {
        // Handle page change
      },
      
      // onPageTap: (int? page) {
      //   // Handle page tap
      // },
      // onDoubleTap: () {
      //   // Handle double tap
      // },
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      },
    );
