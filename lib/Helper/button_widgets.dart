
// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:project1/Helper/text_styles.dart';


class widgets {
  Widget Button_1(String title, Function function, Color color, double height,
      double width, double textsize) {
    return InkWell(
      onTap: () => function(),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Text(
            title,
            style: StylesText().style_1(textsize),
          ),
        ),
      ),
    );
  }
}
