import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:chati_ui/service/speech_service.dart';

class VoiceButton extends StatefulWidget {
  final Function(String text)? onResult;

  const VoiceButton({
    super.key,
    this.onResult,
  });

  @override
  State<VoiceButton> createState() => _VoiceButtonState();
}

class _VoiceButtonState extends State<VoiceButton> {
  final SpeechService _speechService = SpeechService();

  bool _speechEnabled = false;
  bool _isRecording = false;

  String _recognizedText = '';

  Timer? _timer;
  int _seconds = 0;

  double _dragDistance = 0;

  static const double _cancelThreshold = -120;

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _initializeSpeech() async {
    _speechEnabled = await _speechService.initialize(
      onStatus: (status) {
        debugPrint('STATUS: $status');
        setState(() {});
      },
      onError: (error) {
        debugPrint('ERROR: $error');
      },
    );

    setState(() {});
  }

  Future<void> _startListening() async {
    if (!_speechEnabled) return;

    _recognizedText = '';
    _seconds = 0;
    _dragDistance = 0;

    await _speechService.startListening(
      onResult: _onSpeechResult,
    );

    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) {
        if (mounted) {
          setState(() {
            _seconds++;
          });
        }
      },
    );

    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopListening() async {
    _timer?.cancel();

    await _speechService.stopListening();

    final text = _recognizedText;

    setState(() {
      _isRecording = false;
      _dragDistance = 0;
    });

    if (text.isNotEmpty) {
      widget.onResult?.call(text);
    }
  }

  Future<void> _cancelRecording() async {
    _timer?.cancel();

    await _speechService.stopListening();

    setState(() {
      _recognizedText = '';
      _isRecording = false;
      _dragDistance = 0;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _recognizedText = result.recognizedWords;
    });
  }

  String get _formattedTime {
    final minutes = _seconds ~/ 60;
    final seconds = _seconds % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (!_isRecording) {
      return GestureDetector(
        onTap: _startListening,
        child: Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          child: const Icon(
            Icons.mic_none,
            color: Color(0xFFE55646),
            size: 24,
          ),
        ),
      );
    }

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _dragDistance += details.delta.dx;
        });

        if (_dragDistance <= _cancelThreshold) {
          _cancelRecording();
        }
      },
      onHorizontalDragEnd: (_) {
        if (_isRecording) {
          _stopListening();
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.62,
        height: 56,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.mic,
                color: Color(0xFFE55646),
                size: 24,
              ),

              const SizedBox(width: 8),

              Text(
                _formattedTime,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Transform.translate(
                  offset: Offset(_dragDistance, 0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chevron_left,
                        color: Colors.white54,
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          'slide to cancel',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}