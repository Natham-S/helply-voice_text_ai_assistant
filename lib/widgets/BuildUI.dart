import 'dart:async';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../ui/ChatInterface.dart';
import 'LoadingAnimation.dart';

class BuildUI extends StatefulWidget {
  const BuildUI({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BuildUI();
  }
}

class _BuildUI extends State<BuildUI> {
  List<ChatMessage> messages = [];

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  final TextEditingController _inputController = TextEditingController();
  Timer? _listeningTimer;
  bool _showAnimation = false;


  final Gemini gemini = Gemini.instance;

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
      id: "1",
      firstName: "Gemini",
      profileImage:
          "https://seeklogo.com/images/G/google-gemini-logo-A5787B2669-seeklogo.com.png");

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      await _speech.initialize();
      setState(() {
        _isListening = true;
        _showAnimation = true;
      });

      _speech.listen(onResult: (result) {
        setState(() {
          _text = result.recognizedWords;
          _inputController.text = _text;
          _resetListeningTimer();
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Microphone permission is required to use this feature.')),
      );
    }
  }

  void _resetListeningTimer() {
    _listeningTimer?.cancel();
    _listeningTimer = Timer(Duration(seconds: 2), () {
      _stopListening();
    });
  }

  void _stopListening() {
    _speech.stop();
    _listeningTimer?.cancel();
    setState(() {
      _isListening = false;
      _showAnimation = false;

    });
  }

  void _handleTap() {
    if (_isListening) {
      _stopListening();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ChatInterface(
          currentUser: currentUser,
          messages: messages,
          onSend: sendMessage,
          inputController: _inputController,
          isListening: _isListening,
          startListening: _startListening,
          stopListening: _stopListening,
        ),
        if (_showAnimation)
          LoadingAnimation(
            onTap: _handleTap,
          ),
      ]
    );
  }

  void sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;

      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          lastMessage.text += response;
          setState(
            () {
              messages = [lastMessage!, ...messages];
            },
          );
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
