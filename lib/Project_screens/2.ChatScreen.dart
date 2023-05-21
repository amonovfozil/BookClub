// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:project1/Helper/text_styles.dart';
import 'package:project1/Project_screens/widgets/MessageBubble.dart';
import 'package:project1/Project_screens/widgets/videoPlayer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MessageField(),
        ),
        const NewMessage(),
        const SizedBox(height: 5),
      ],
    );
  }
}
// ignore_for_file: avoid_print

class MessageField extends StatelessWidget {
  MessageField({Key? key}) : super(key: key);
  File? sendfile;
  void getfile(File file) {
    sendfile = file;
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats/W7K4XjWUiCvJuyiIrLJ8/GROUP')
          .orderBy('writeTime', descending: true)
          .snapshots(),
      builder: (ctx, streamsnapshot) {
        if (streamsnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return streamsnapshot.data != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  reverse: true,
                  itemCount: streamsnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var message = streamsnapshot.data!.docs[index];
                    return MesssageBubble(
                      message: message['message'] as Map<String, dynamic>,
                      userName: message['username'],
                      avatar: message['avatar'],
                      isMe: message['userid'] == currentUser!.uid,
                      userid: message['userid'],
                    );
                  },
                ),
              )
            : const Center(
                child: Text('data now'),
              );
      },
    );
  }
}

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var isSelect = false;
  final Messagecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String? _newMessage;

  User? user;
  late final userdata;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () async {
      user = FirebaseAuth.instance.currentUser;
      userdata = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
    });
  }

  void sendNewMessage(String message, String type, String title) async {
    // FocusScope.of(context).unfocus();

    if (message.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('chats/W7K4XjWUiCvJuyiIrLJ8/GROUP')
            .add(
          {
            'message': {
              "main": message,
              'type': type,
              'name': title,
            },
            'writeTime': DateTime.now(),
            'username': userdata['username'],
            'avatar': userdata['AvatarUrl'],
            'userid': user!.uid,
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }

  void _takeFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => ViewFileSend(
              file,
              lookupMimeType(result.files.single.path!)!,
              result.files[0].name,
              sendNewMessage)));
      // final storagePath = FirebaseStorage.instance
      //     .ref()
      //     .child('chats')
      //     .child(result.files[0].name);
      // print(file);
      // print(result.files[0].name);

      // await storagePath.putFile(file);
      // final urlStorageFile = await storagePath.getDownloadURL();
      // sendNewMessage(urlStorageFile, lookupMimeType(result.files.single.path!)!,
      //     result.files[0].name);
    } else {
      // User canceled the picker
    }
  }

  void saveMassage() {
    FocusScope.of(context).unfocus();

    _formkey.currentState!.save();
    if (_newMessage != null && _newMessage!.isNotEmpty) {
      sendNewMessage(_newMessage!, 'String', 'text');
    }
    Messagecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(
                  5,
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: _takeFile,
                    icon: const Icon(
                      Icons.attach_file_outlined,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextFormField(
                        controller: Messagecontroller,
                        decoration: const InputDecoration(
                          hintText: 'new message:',
                        ),
                        onSaved: (newValue) => _newMessage = newValue!,
                      ),
                    ),
                  ),
                  IconButton(
                    iconSize: 25,
                    onPressed: saveMassage,
                    icon: const Icon(
                      Icons.send,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewFileSend extends StatefulWidget {
  final File file;
  final String type;
  final String name;
  final Function function;
  const ViewFileSend(this.file, this.type, this.name, this.function,
      {super.key});

  @override
  State<ViewFileSend> createState() => _ViewFileSendState();
}

class _ViewFileSendState extends State<ViewFileSend> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.9),
      child: isloading
          ? const Center(child: LinearProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: widget.type.startsWith('image/')
                      ? Image.file(
                          widget.file,
                          fit: BoxFit.cover,
                        )
                      : VideoPlayer1(widget.file, false),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade500,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 12),
                      ),
                      child: Text(
                        'BEKOR QILISH',
                        style: StylesText().style_1(12),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isloading = true;
                        });
                        final storagePath = FirebaseStorage.instance
                            .ref()
                            .child('chats')
                            .child(widget.name);
                        // print(file);
                        // print(result.files[0].name);

                        await storagePath.putFile(widget.file);
                        final urlStorageFile =
                            await storagePath.getDownloadURL();
                        widget.function(
                            urlStorageFile, widget.type, widget.name);
                        setState(() {
                          isloading = false;
                        });
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF47406A),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 12),
                      ),
                      child: Text(
                        'YUBORISH',
                        style: StylesText().style_1(14),
                      ),
                    ),

                    //
                  ],
                )
              ],
            ),
    );
  }
}
