// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project1/Helper/text_styles.dart';
import 'package:project1/Project_screens/widgets/PDF_Viewer.dart';
import 'package:project1/data/booksList.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child:
          //  SingleChildScrollView(
          //   child:
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Text(
            'KITOBLAR',
            style: StylesText().style_1_1(18),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: booklist.books.map((element) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => PDFViewerFromAsset(
                          pdfAssetPath: element['url'],
                          title: element['title'],
                        ),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 150,
                              width: 130,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                element['img'] == ''
                                    ? 'assets/fon2.png'
                                    : element['img'],
                                fit: BoxFit.fill,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      element['title'],
                                      textAlign: TextAlign.center,
                                      style: StylesText().style_1_11(15),
                                    ),
                                    const SizedBox(height: 10),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'muallif:  ',
                                              style:
                                                  StylesText().style_2_2(14)),
                                          TextSpan(
                                              text: element['dictor'],
                                              style:
                                                  StylesText().style_1_11(14)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
   // Container(
                    //   child: TextButton(
                    //     onPressed: () => Navigator.push(
                    //       context,
                    //       MaterialPageRoute<dynamic>(
                    //         builder: (_) => PDFViewerFromAsset(
                    //           pdfAssetPath: 'assets/lectures/lec.pdf',
                    //         ),
                    //       ),
                    //     ),
                    //     child: Text(
                    //       '1 Лекция',
                    //       style: TextStyle(fontSize: 18, color: Colors.white),
                    //     ),
                    //   ),
                    // ),