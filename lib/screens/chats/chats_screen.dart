import 'package:flutter/material.dart';

import '../../models/Chat.dart';
import 'components/chat_card.dart';
import '../messages/message_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late String search;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        centerTitle: true,
        automaticallyImplyLeading: false, // disapper back
      ),
      body: Material(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.search),
                    ),
                    hintText: "SEARCH"
                  ),
                  onSaved: (value){
                    search = value!;
                  },
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: chatsData.length,
                itemBuilder: (context, index){
                  return ChatCard(
                    chat: chatsData[index],
                    press: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MessagesScreen(chat: chatsData[index])));
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
