// ignore_for_file: file_names, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project1/Helper/text_styles.dart';
import 'package:project1/Project_screens/HomeScreen.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    Widget SideBarIteams(Widget RoutPage, IconData icon, String label) {
      return TextButton.icon(
        onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => RoutPage,
          ),
        ),
        icon: Icon(
          icon,
          size: 25,
          color: const Color(0xFF47406A),
        ),
        label: Text(
          label,
          style: const TextStyle(fontSize: 16, color: Color(0xFF47406A)),
        ),
      );
    }

    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        endDrawerEnableOpenDragGesture: false,
        backgroundColor: const Color(0xFF47406A),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>> != null
            ? StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        streamsnapshots) {
                  if (streamsnapshots.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  final userdata = streamsnapshots.data!.docs
                      .where((element) => element.id == user!.uid)
                      .toList();

                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () => showDialog(
                          context: context,
                          builder: (ctx) => Center(
                            child: SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: Image.network(
                                userdata[0]['AvatarUrl'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            userdata[0]['AvatarUrl'],
                          ),
                          radius: 90,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        userdata[0]['username'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SideBarIteams(
                                    const HomeScreen(),
                                    Icons.home,
                                    'Bosh Sahifa',
                                  ),
                                  const Divider(height: 0),
                                ]),
                          ),
                        ),
                      )
                    ],
                  );
                })
            : const Center(
                child: Text('data now'),
              ),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(
                  Icons.exit_to_app_outlined,
                  color: Color(0xFF363853),
                ),
                label: Text(
                  'Exit From App',
                  style: StylesText().style_2_11(14, false),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  final user = FirebaseAuth.instance.currentUser;
                  Future.delayed(const Duration(milliseconds: 300))
                      .then((_) async {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user!.uid)
                        .delete();
                    FirebaseStorage.instance
                        .ref()
                        .child('UserAvatar')
                        .child('${user.uid}.jpg')
                        .delete();
                    user.delete();

                    FirebaseAuth.instance.signOut();
                  });
                },
                icon: Icon(
                  Icons.logout,
                  color: Theme.of(context).errorColor,
                ),
                label: Text(
                  'Log out',
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
