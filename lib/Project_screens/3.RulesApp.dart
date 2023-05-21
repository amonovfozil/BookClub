// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:project1/Helper/text_styles.dart';
import 'package:project1/Project_screens/widgets/videoPlayer.dart';

class Qollanma extends StatelessWidget {
  Qollanma({super.key});

  var selectedRange = const RangeValues(90, 420);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 26),
          Text(
            'Видеоролик',
            style: StylesText().style_1_11(17),
          ),
          const SizedBox(height: 20),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const VideoPlayer1(
                'https://firebasestorage.googleapis.com/v0/b/chatt-b6d58.appspot.com/o/videos%2Fanimation.mp4?alt=media&token=b39e6db7-8ab5-473b-adc2-c66153d41fb8',
                true),
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 245, 245, 245),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Info Project',
                    style: StylesText().style_1_11(17),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Практикую все свои умения на работе, поэтому даю реальные знания и опыт. Отдельные программы обучения для детей и взрослых.',
                    style: StylesText().style_2_2(14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
