// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project1/Helper/text_styles.dart';
import 'package:project1/Project_screens/widgets/PDF_Viewer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> books = [
      {
        'title': 'Maruza 1',
        'dictor': 'Tohir Malik',
        'url': 'assets/lectures/lec.pdf',
        'info':
            'Практикую все свои умения на работе, поэтому даю реальные знания и опыт. Отдельные программы обучения для детей и взрослых.',
      },
      {
        'title': 'Maruza 2',
        'dictor': 'Muhammad Yusuf',
        'url': 'assets/lectures/3LEC.pdf',
        'info': '',
      },
      {
        'title': 'Maruza 3',
        'dictor': 'Abdullo Yusupov',
        'url': 'assets/lectures/4LEC.pdf',
        'info': '',
      },
      {
        'title': 'Maruza 4',
        'dictor': 'Tom Nyurk',
        'url': 'assets/lectures/5LEC.pdf',
        'info': '',
      },
      {
        'title': 'Maruza 5',
        'dictor': 'Eddison',
        'url': 'assets/lectures/6LEC.pdf',
        'info': '',
      },
      {
        'title': 'Maruza 6',
        'dictor': 'Pushkin',
        'url': 'assets/lectures/7LEC.pdf',
        'info': '',
      },
      {
        'title': 'Maruza 7',
        'dictor': 'Amonov Fozil',
        'url': 'assets/lectures/8LEC.pdf',
        'info': '',
      },
    ];
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
            'Новости сервиса',
            style: StylesText().style_1_1(18),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: books.map((element) {
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
                                'assets/fon2.png',
                                fit: BoxFit.cover,
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
                                      style: StylesText().style_1_11(18),
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
                                    Text(
                                      element['info'],
                                      style: const TextStyle(
                                          fontSize: 11,
                                          height: 1.3,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF9A9A9A),
                                          fontFamily: 'Gotham Pro medium'),
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