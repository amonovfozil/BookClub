// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project1/Auth_screen/get_img.dart';
import 'package:project1/Helper/text_styles.dart';

class AuthField extends StatefulWidget {
  final Function getAuthData;
  final bool isloading;
  const AuthField(this.getAuthData, this.isloading, {super.key});

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  final _formkey = GlobalKey<FormState>();
  bool isLogin = true;
  File? getImage;

  // ignore: non_constant_identifier_names
  Map<String, String> AuthData = {
    'email': '',
    'password': '',
    "userName": '',
  };

  void getImageOfAvatar(File image) {
    getImage = image;
  }

  void submitAuthData() {
    FocusScope.of(context).unfocus();

    if (getImage == null && !isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: const Text(
            'Please enter Avatar',
          ),
        ),
      );
      return;
    }

    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      widget.getAuthData(
        AuthData,
        isLogin,
        getImage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
        ),
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isLogin) getAvatarImage(getImageOfAvatar),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      suffixIconColor: Colors.black,
                      labelText: 'email:',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Email adresingizni kiriting';
                      } else if (!email.contains('@')) {
                        return 'Bu email adress xato';
                      }
                      return null;
                    },
                    onSaved: (newValue) => AuthData['email'] = newValue!,
                  ),
                  if (!isLogin)
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,

                      decoration: const InputDecoration(
                        labelText: 'I.F.O:',
                      ),
                      textInputAction: TextInputAction.next,

                      // ignore: non_constant_identifier_names
                      validator: (Username) {
                        if (Username == null || Username.isEmpty) {
                          return 'F.I.O kiriting';
                        }
                        return null;
                      },
                      onSaved: (newValue) => AuthData['userName'] = newValue!,
                    ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Parol:',
                    ),
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'parol kiriting';
                      } else if (password.length < 6) {
                        return 'parol 6ta simboldan kam bo`ldi';
                      }
                      return null;
                    },
                    onSaved: (newValue) => AuthData['password'] = newValue!,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: submitAuthData,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF47406A),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 15)),
                    child: widget.isloading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            isLogin ? 'KIRISH' : "Ro'xatdan o'tish",
                            style: StylesText().style_1(14),
                          ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(
                      isLogin ? "Ro'xatdan o'tish" : 'Kirish',
                      style: StylesText().style_5(14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
