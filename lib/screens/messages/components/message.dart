import 'package:appchat/models/ChatMessage.dart';
import 'package:appchat/screens/messages/components/audio_message.dart';
import 'package:appchat/screens/messages/components/text_message.dart';
import 'package:appchat/screens/messages/components/video_message.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final ChatMessage chatMessage;
  String image;
  Message({Key? key, required this.chatMessage, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage chatMessage){
      switch (chatMessage.messageType){
        case ChatMessageType.text:
          return TextMessage(chatMessage: chatMessage);
        case ChatMessageType.audio:
          return AudioMessage(chatMessage: chatMessage);
        case ChatMessageType.video:
          return VideoMessage();
        default:
          return SizedBox();
      }
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: chatMessage.isSender ? MainAxisAlignment.end: MainAxisAlignment.start,
        children: [
          if(!chatMessage.isSender) ...[
            CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage(image),
            ),
            const SizedBox(width: 10/2)
          ],
          messageContaint(chatMessage),
          if (chatMessage.isSender) MessageStatusDot(status: chatMessage.messageStatus)
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus? status;
  const MessageStatusDot({Key? key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return Colors.grey;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.1);
        case MessageStatus.viewed:
          return Theme.of(context).primaryColor;
        default:
          return Colors.transparent;
      }
    }
    return Container(
      margin: const EdgeInsets.only(left: 10 / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status!),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
