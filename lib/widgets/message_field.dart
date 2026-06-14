import 'package:chati_ui/service/speech_service.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'send_button.dart';

class MessageField extends StatefulWidget {
  const MessageField({super.key});

  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  final TextEditingController _controller = TextEditingController();
  final SpeechService _speechService = SpeechService();

  bool get _hasText => _controller.text.trim().isNotEmpty;

  String _recognizedText = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    _initSpeech();
  }

  @override
  void dispose() {
    _speechService.stopListening();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initSpeech() async {
    await _speechService.initialize(
      onStatus: (status) => debugPrint("STATUS: $status"),
      onError: (error) => debugPrint("ERROR: $error"),
    );
  }

  void _onSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    debugPrint("Send message: $text");

    _controller.clear();
    _recognizedText = '';
    setState(() {});
  }

  Future<void> _startListening() async {
    _recognizedText = '';

    await _speechService.startListening(
      onResult: _onSpeechResult,
    );

    setState(() {});
  }

  Future<void> _stopListening() async {
    await _speechService.stopListening();

    if (_recognizedText.isNotEmpty) {
      _controller.text = _recognizedText;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }

    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _recognizedText = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isListening = _speechService.isListening;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          /// Text input
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
              ),
            ),
          ),

          /// RIGHT SIDE BUTTON (Send replaces voice button)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _hasText
                ? SendButton(
              key: const ValueKey("send"),
              onPressed: _onSend,
            )
                : SendButton(
              key: const ValueKey("mic"),
              onPressed: () {
                if (isListening) {
                  _stopListening();
                } else {
                  _startListening();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}