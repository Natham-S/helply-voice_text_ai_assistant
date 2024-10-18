import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class BuildUI extends StatefulWidget {
  const BuildUI({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BuildUI();
  }
}

class _BuildUI extends State<BuildUI> {
  List<ChatMessage> messages = [];

  final Gemini gemini = Gemini.instance;

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
      id: "1",
      firstName: "Gemini",
      profileImage:
          "https://seeklogo.com/images/G/google-gemini-logo-A5787B2669-seeklogo.com.png");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0,),
      child: DashChat(
        currentUser: currentUser,
        onSend: sendMessage,
        messages: messages,


        inputOptions: InputOptions(
          sendOnEnter: true,
          inputDecoration: InputDecoration(hintText: "Ask Anything...", hintStyle: const TextStyle(
            height: 0.5,
            color: Colors.grey,
            fontSize: 16,
          ),

          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          )),

          trailing: [
            IconButton(onPressed: (){}, icon: Icon(Icons.mic_none))
          ]
        ),
      ),
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
          String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";
          lastMessage.text += response;
          setState(() {
              messages = [lastMessage!, ...messages];
            },
          );
        } else {
          String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";
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
