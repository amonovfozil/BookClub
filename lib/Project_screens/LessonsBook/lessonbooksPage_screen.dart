// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project1/Project_screens/widgets/PDF_Viewer.dart';
import 'package:project1/data/booksList.dart';

class LessonBooks extends StatelessWidget {
  const LessonBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpansionTile(
                title: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageIcon(
                      AssetImage('assets/icons/sidebar/cart.png'),
                    ),
                    SizedBox(width: 10),
                    Text('Maruza')
                  ],
                ),
                children: booklist.lecture
                    .map(
                      (element) => Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => PDFViewerFromAsset(
                                pdfAssetPath: element['url'],
                                title: element['title'],
                              ),
                            ));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 60,
                                width: 50,
                                child: Image.asset(element['img']),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  element['title'],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              ExpansionTile(
                title: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageIcon(
                      AssetImage('assets/icons/sidebar/img1.png'),
                    ),
                    SizedBox(width: 10),
                    Text('Amaliy Mashg\'ilotlar')
                  ],
                ),
                children: booklist.amaliy
                    .map(
                      (element) => Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => PDFViewerFromAsset(
                                pdfAssetPath: element['url'],
                                title: element['title'],
                              ),
                            ));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 60,
                                width: 50,
                                child: Image.asset(element['img']),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  element['title'],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              ExpansionTile(
                title: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageIcon(
                      AssetImage('assets/icons/naviagtion/home.png'),
                    ),
                    SizedBox(width: 10),
                    Text('Mustaqil ishlar')
                  ],
                ),
                children: booklist.mustaqil
                    .map(
                      (element) => Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => PDFViewerFromAsset(
                                pdfAssetPath: element['url'],
                                title: element['title'],
                              ),
                            ));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 60,
                                width: 50,
                                child: Image.asset(element['img']),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  element['title'],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
