class ChatModel {
  final String? text;
  final bool isMe;
  final bool isAudio;
  final String? duration;

  ChatModel({
    this.text,
    required this.isMe,
    this.isAudio = false,
    this.duration,
  });
}