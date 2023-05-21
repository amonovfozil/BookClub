// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:project1/Helper/text_styles.dart';

class PDFViewerFromAsset extends StatelessWidget {
  PDFViewerFromAsset({
    Key? key,
    required this.pdfAssetPath,
    required this.title,
  }) : super(key: key);
  final String pdfAssetPath;
  final String title;
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF47406A),
        title: Center(child: Text(title)),
        actions: <Widget>[
          StreamBuilder<String>(
              stream: _pageCountController.stream,
              builder: (_, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF2F2F2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          snapshot.data!,
                          style: StylesText().style_1_1(12),
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ],
      ),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onPageChanged: (int? current, int? total) =>
            _pageCountController.add('${current! + 1} - $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
          final int? pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).fromAsset(
        pdfAssetPath,
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: FloatingActionButton(
                    heroTag: '-',
                    backgroundColor: const Color(0xFF47406A),
                    child: const Icon(Icons.arrow_back_ios),
                    onPressed: () async {
                      final PDFViewController pdfController = snapshot.data!;
                      final int currentPage =
                          (await pdfController.getCurrentPage())! - 1;
                      if (currentPage >= 0) {
                        await pdfController.setPage(currentPage);
                      }
                    },
                  ),
                ),
                FloatingActionButton(
                  heroTag: '+',
                  backgroundColor: const Color(0xFF47406A),
                  child: const Icon(Icons.arrow_forward_ios),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! + 1;
                    final int numberOfPages =
                        await pdfController.getPageCount() ?? 0;
                    if (numberOfPages > currentPage) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
