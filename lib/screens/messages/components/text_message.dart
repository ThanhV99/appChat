import 'package:flutter/material.dart';
import '../../../models/ChatMessage.dart';

class TextMessage extends StatelessWidget {
  final ChatMessage? chatMessage;
  const TextMessage({Key? key, this.chatMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10*0.75,
        vertical: 10/2
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(chatMessage!.isSender? 1: 0.1),
        borderRadius: BorderRadius.circular(30)
      ),
      child: Text(
        chatMessage!.text,
        style: TextStyle(
          color: chatMessage!.isSender
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1!.color
        ),
      ),
    );
  }
}
