// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:project1/Helper/text_styles.dart';
import 'package:project1/Project_screens/widgets/PDF_Viewer.dart';
import 'package:project1/data/booksList.dart';

class LessonBooks extends StatefulWidget {
  const LessonBooks({super.key});

  @override
  State<LessonBooks> createState() => _LessonBooksState();
}

class _LessonBooksState extends State<LessonBooks>
    with TickerProviderStateMixin {
  late final GifController _controller = GifController(vsync: this);
  bool isSelect = false;

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
              const SizedBox(height: 10),
              Text(
                'Darsliklar:',
                style: StylesText().style_1_11(20),
              ),
              const SizedBox(height: 10),
              ExpansionTile(
                onExpansionChanged: (value) => setState(() {
                  isSelect = value;
                }),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ImageIcon(
                      AssetImage('assets/icons/sidebar/book1.png'),
                      size: 45,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Maruza',
                      style: StylesText().style_2_11(16, false),
                    )
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
                onExpansionChanged: (value) => setState(() {
                  isSelect = value;
                }),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ImageIcon(
                      AssetImage('assets/icons/sidebar/book2.png'),
                      size: 50,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Amaliy Mashg\'ilotlar',
                      style: StylesText().style_2_11(16, false),
                    )
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
                onExpansionChanged: (value) => setState(() {
                  isSelect = value;
                }),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ImageIcon(
                      AssetImage('assets/icons/naviagtion/home.png'),
                      size: 45,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Mustaqil ishlar',
                      style: StylesText().style_2_11(16, false),
                    )
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
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => PDFViewerFromAsset(
                      pdfAssetPath: 'assets/test/test.pdf',
                      title: 'TEST',
                    ),
                  ));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 20),
                    // SizedBox(
                    //   height: 40,
                    //   width: 40,
                    //   child: Image.asset(
                    //     'assets/test/test.png',
                    //   ),
                    // ),
                    ImageIcon(
                      AssetImage('assets/icons/sidebar/test1.jpg'),
                      color: Colors.grey[600],
                      size: 45,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Testlar',
                      style: StylesText().style_2_11(16, false),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (!isSelect)
                Gif(
                  image: const AssetImage("assets/icons/sidebar/bookgif.gif"),
                  controller:
                      _controller, // if duration and fps is null, original gif fps will be used.
                  //fps: 30,
                  //duration: const Duration(seconds: 3),
                  autostart: Autostart.loop,
                  placeholder: (context) => const Text('Loading...'),
                  onFetchCompleted: () {
                    _controller.reset();
                    _controller.forward();
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
