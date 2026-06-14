import 'package:chati_ui/widgets/private_header.dart';
import 'package:flutter/material.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';

class PrivateChatScreen extends StatelessWidget {
  const PrivateChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = [
      {
        'type': 'text',
        'text': 'Hello 👋',
        'isMe': false,
      },
      {
        'type': 'text',
        'text': 'Hi Mahmoud',
        'isMe': true,
      },
      {
        'type': 'voice',
        'duration': '0:05',
        'isMe': true,
      },
      {
        'type': 'text',
        'text': 'How are you?',
        'isMe': false,
      },
      {
        'type': 'voice',
        'duration': '0:12',
        'isMe': false,
      },
      {
        'type': 'text',
        'text': 'Flutter Clean Architecture.',
        'isMe': true,
      },
    ];

    return Scaffold(
      appBar: const PrivateChatHeader(
        username: 'Mahmoud Diab',
        isOnline: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];

                return MessageBubble(
                  type: message['type'] as String,
                  text: message['text']?.toString() ?? '',
                  duration:
                  message['duration']?.toString() ?? '',
                  isMe: message['isMe'] as bool,
                );
              },
            ),
          ),
          const Divider(height: 1),
          const MessageInput(),
        ],
      ),
    );
  }
}