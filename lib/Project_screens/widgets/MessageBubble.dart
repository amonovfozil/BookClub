// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project1/Helper/text_styles.dart';
import 'package:project1/Project_screens/widgets/videoPlayer.dart';

class MesssageBubble extends StatefulWidget {
  final Map<String, dynamic> message;
  final String userName;
  final String avatar;
  final bool isMe;

  final String userid;
  const MesssageBubble(
      {required this.message,
      required this.userName,
      required this.avatar,
      required this.isMe,
      required this.userid,
      super.key});

  @override
  State<MesssageBubble> createState() => _MesssageBubbleState();
}

class _MesssageBubbleState extends State<MesssageBubble> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return widget.message != null
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment:
                widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!widget.isMe)
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.avatar),
                  radius: 18,
                ),
              Padding(
                padding: widget.message['type'] == 'String'
                    ? const EdgeInsets.all(10)
                    : const EdgeInsets.all(0),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: widget.message['type'] != 'String'
                        ? Colors.transparent
                        : const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(15),
                      topRight: const Radius.circular(15),
                      bottomRight: widget.isMe
                          ? const Radius.circular(0)
                          : const Radius.circular(15),
                      bottomLeft: widget.isMe
                          ? const Radius.circular(15)
                          : const Radius.circular(0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: widget.isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        if (!widget.isMe)
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(
                              widget.userName,
                              style: const TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        if (!widget.isMe) const SizedBox(height: 3),
                        if ((widget.message['type'] as String)
                            .startsWith('image/'))
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(15),
                                topRight: const Radius.circular(15),
                                bottomRight: widget.isMe
                                    ? const Radius.circular(0)
                                    : const Radius.circular(15),
                                bottomLeft: widget.isMe
                                    ? const Radius.circular(15)
                                    : const Radius.circular(0),
                              ),
                            ),
                            height: 200,
                            width: 300,
                            child: Image.network(
                              widget.message['main'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        if (widget.message['type'] == 'video/mp4')
                          Container(
                            height: 200,
                            width: 300,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(15),
                                topRight: const Radius.circular(15),
                                bottomRight: widget.isMe
                                    ? const Radius.circular(0)
                                    : const Radius.circular(15),
                                bottomLeft: widget.isMe
                                    ? const Radius.circular(15)
                                    : const Radius.circular(0),
                              ),
                            ),
                            child: VideoPlayer1(widget.message['main'], true),
                          ),
                        if (widget.message['type'] == 'String')
                          Text(
                            widget.message['main']!,
                            maxLines: 5,
                            style: StylesText().style_4(14),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              // if (widget.isMe)
              //   CircleAvatar(
              //     backgroundImage: NetworkImage(widget.Avatar),
              //     radius: 18,
              //   ),
            ],
          )
        : const Center();
  }
}
