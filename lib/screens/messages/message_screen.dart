import 'package:flutter/material.dart';

import '../../models/ChatMessage.dart';
import '../../models/Chat.dart';
import 'components/message.dart';
import 'components/chat_input_field.dart';

class MessagesScreen extends StatelessWidget {
  Chat chat;
  MessagesScreen({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(chat.image),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                Text(chat.name, style: const TextStyle(fontSize: 16)),
                Text(chat.time, style: const TextStyle(fontSize: 12),)
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_phone),
            onPressed: (){},
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: (){},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: demoChatMessages.length,
                itemBuilder: (context, index){
                  return Message(chatMessage: demoChatMessages[index], image: chat.image);
                }
              ),
            ),
          ),
          const ChatInputField()
        ],
      ),
    );
  }
}
