import 'package:academic/theme.dart';
import 'package:flutter/material.dart';
import 'text_and_voice_field.dart';

class ToggleButton extends StatefulWidget {
  final VoidCallback _sendTextMessage;
  final VoidCallback _sendVoiceMessage;
  final InputMode _inputMode;
  final bool _isReplying;
  final bool _isListening;
  const ToggleButton({
    super.key,
    required InputMode inputMode,
    required VoidCallback sendTextMessage,
    required VoidCallback sendVoiceMessage,
    required bool isReplying,
    required bool isListening,
  })  : _inputMode = inputMode,
        _sendTextMessage = sendTextMessage,
        _sendVoiceMessage = sendVoiceMessage,
        _isReplying = isReplying,
        _isListening = isListening;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: whiteColor,
          foregroundColor: blueColor,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
        ),
        onPressed: widget._isReplying
            ? null
            : widget._inputMode == InputMode.text
                ? widget._sendTextMessage
                : widget._sendVoiceMessage,
        child: Image.asset(
          widget._inputMode == InputMode.text
              ? "assets/images/icon/send.png"
              : widget._isListening
                  ? "assets/images/icon/micoff.png"
                  : "assets/images/icon/mic.png",
          height: 30,
        ));
  }
}
