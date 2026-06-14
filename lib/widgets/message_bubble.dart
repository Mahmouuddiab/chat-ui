import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  final String type;
  final String text;
  final String duration;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.type,
    required this.text,
    required this.duration,
    required this.isMe,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    if (widget.type == 'voice') {
      return Align(
        alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isMe ? Colors.blue : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: widget.isMe ? Colors.white : Colors.black,
                  size: 32,
                ),
              ),

              const SizedBox(width: 8),

              Row(
                children: List.generate(18, (index) {
                  final heights = [
                    18.0,
                    30.0,
                    15.0,
                    42.0,
                    22.0,
                    36.0,
                    18.0,
                    25.0,
                    15.0,
                    40.0,
                    20.0,
                    28.0,
                    16.0,
                    34.0,
                    22.0,
                    30.0,
                    18.0,
                    24.0,
                  ];

                  return Container(
                    width: 4,
                    height: heights[index],
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: widget.isMe ? Colors.white : Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }),
              ),

              const SizedBox(width: 8),

              Text(
                widget.duration,
                style: TextStyle(
                  color: widget.isMe ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.isMe ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          widget.text,
          style: TextStyle(color: widget.isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
