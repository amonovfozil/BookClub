// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayer1 extends StatefulWidget {
  final videoUrl;
  final bool isString;
  const VideoPlayer1(this.videoUrl, this.isString, {super.key});

  @override
  State<VideoPlayer1> createState() => _VideoPlayer1State();
}

class _VideoPlayer1State extends State<VideoPlayer1> {
  bool isloading = true;
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    setState(() {});
    super.initState();
    videoPlayerController = widget.isString
        ? VideoPlayerController.network(widget.videoUrl)
        : VideoPlayerController.file(widget.videoUrl)
      ..initialize().then((value) => setState(() {
            isloading = false;
          }));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        : CustomVideoPlayer(
            customVideoPlayerController: _customVideoPlayerController);
  }
}
