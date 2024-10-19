import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatInterface extends StatelessWidget {
  final ChatUser currentUser;
  final List<ChatMessage> messages;
  final Function(ChatMessage) onSend;
  final TextEditingController inputController;
  final bool isListening;
  final VoidCallback startListening;
  final VoidCallback stopListening;

  const ChatInterface({
    super.key,
    required this.currentUser,
    required this.messages,
    required this.onSend,
    required this.inputController,
    required this.isListening,
    required this.startListening,
    required this.stopListening,
  });

  @override
  Widget build(BuildContext context) {
    return DashChat(
      currentUser: currentUser,
      onSend: onSend,
      messages: messages,
      messageOptions: const MessageOptions(
        borderRadius: 12,
      ),
      inputOptions: InputOptions(
        sendOnEnter: true,
        inputDecoration: InputDecoration(
          hintText: "Ask Anything...",
          hintStyle: GoogleFonts.bricolageGrotesque(
            color: Color(0xFF8A8A8A),
          ),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
        textController: inputController,
        inputMaxLines: 20,
        trailing: [
          IconButton(
            icon: Icon(isListening ? Icons.stop : Icons.mic_none),
            onPressed: isListening ? stopListening : startListening,
          ),
        ],
      ),
    );
  }
}
