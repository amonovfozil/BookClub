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
            'Video Qo\'lanma',
            style: StylesText().style_1_11(17),
          ),
          const SizedBox(height: 20),
          Container(
            height: 200,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const VideoPlayer1(
                'https://firebasestorage.googleapis.com/v0/b/project-d6b3b.appspot.com/o/videos%2FFan__Diskret_matematika_va_matematik_mantiqMavzu____tupikli_DHSH-tuzish%5B1%5D.mp4?alt=media&token=7f0a123d-0e65-49e9-8845-b90b87e18622',
                true),
          ),
          const SizedBox(height: 20),
          Text(
            'Diskret matematika va matematik mantiq Mavzu: DHSH tuzish',
            style: StylesText().style_1_11(14),
          ),
          const SizedBox(height: 30),
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
                    'Mobil Ilova Haqida',
                    style: StylesText().style_1_11(17),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Ilova  "Diskret tuzilmalar fanidan talabalarning mustaqil ta`limini tashkil etishning teskari aloqa muhitini yaratish" mavzusidagi  Bituruv Malakaviy Ish uchun yaratildi',
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
