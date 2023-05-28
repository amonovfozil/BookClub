// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project1/Helper/text_styles.dart';
import 'package:project1/Project_screens/1.MianPageScreen.dart';
import 'package:project1/Project_screens/2.ChatScreen.dart';
import 'package:project1/Project_screens/3.RulesApp.dart';
import 'package:project1/Project_screens/LessonsBook/lessonbooksPage_screen.dart';
import 'package:project1/Project_screens/SideBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var index = 0;
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    List<Map<String, dynamic>> menus = [
      {
        'title': 'DARSLIKLAR',
        'icon': 'assets/icons/naviagtion/letter.png',
      },
      {
        'title': 'KUTUBXONA',
        'icon': 'assets/icons/naviagtion/home.png',
      },
      {
        'title': '  CHAT  ',
        'icon': 'assets/icons/naviagtion/main.png',
      },
      {
        'title': 'QO\'LLANMA',
        'icon': 'assets/icons/naviagtion/pupil.png',
      },
    ];
    return Scaffold(
      key: scaffoldKey,
      drawer: const SideBar(),
      body: Column(
        children: [
          Container(
            height: 90,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              color: index == 4 ? Colors.transparent : const Color(0xFF47406A),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => scaffoldKey.currentState!.openDrawer(),
                    icon: Icon(
                      Icons.format_align_left,
                      color:
                          index == 4 ? const Color(0xFF363853) : Colors.white,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Smart Book',
                      style: StylesText().style_1(22),
                    ),
                  ),
                  const SizedBox(
                    width: 45,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: index == 0
                ? const LessonBooks()
                : index == 1
                    ? const MainPage()
                    : index == 2
                        ? const ChatScreen()
                        : index == 3
                            ? Qollanma()
                            : Container(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          color: Color(0xFF47406A),
        ),
        // alignment: Alignment.topCenter,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: menus
              .map(
                (menu) => InkWell(
                  onTap: () {
                    setState(() {
                      index = menus.indexOf(menu);
                      // if (index == 2) {
                      //   Navigator.of(context).push(
                      //       MaterialPageRoute(builder: (ctx) => Qollanma()));
                      // }
                      // widget.getIndex(menus.indexOf(menu));
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        menu['icon'],
                        height: 25,
                        color: index == menus.indexOf(menu)
                            ? const Color(0xFFF4B840)
                            : const Color(0xFF69628D),
                      ),
                      const SizedBox(height: 8),
                      Text(menu['title'],
                          style: index == menus.indexOf(menu)
                              ? StylesText().style_3_1(10)
                              : StylesText().style_3(10)),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
