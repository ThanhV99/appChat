import 'package:appchat/models/ChatMessage.dart';
import 'package:flutter/material.dart';

class AudioMessage extends StatelessWidget {
  final ChatMessage? chatMessage;
  const AudioMessage({Key? key, this.chatMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.symmetric(
        horizontal: 10*0.75,
        vertical: 10/2.5
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30)
      ),
      child: Row(
        children: [
          Icon(
            Icons.play_arrow,
            color: chatMessage!.isSender ? Colors.white : Colors.green,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10/2),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: chatMessage!.isSender ? Colors.white : Theme.of(context).primaryColor.withOpacity(0.4),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: chatMessage!.isSender ? Colors.white : Theme.of(context).primaryColor,
                        shape: BoxShape.circle
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text("0.37", style: TextStyle(fontSize: 12, color: chatMessage!.isSender ? Colors.white : null))
        ],
      ),
    );
  }
}
