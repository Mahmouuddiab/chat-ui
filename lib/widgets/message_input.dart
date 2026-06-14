import 'package:chati_ui/widgets/image_button.dart';
import 'package:chati_ui/widgets/message_field.dart';
import 'package:chati_ui/widgets/voice_button.dart';
import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 6,
        ),
        child: Row(
          children: [
            ImageButton(),
            SizedBox(width: 6),

            Expanded(
              child: MessageField(),
            ),

            SizedBox(width: 10),
          /// voice button
            VoiceButton()
          ],
        ),
      ),
    );
  }
}