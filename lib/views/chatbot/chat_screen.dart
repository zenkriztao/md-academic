import 'package:academic/providers/chats_provider.dart';
import 'package:academic/widgets/chat_item.dart';
import 'package:academic/widgets/custom_appbar.dart';
import 'package:academic/widgets/text_and_voice_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreenBot extends StatelessWidget {
  const ChatScreenBot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                final chats = ref.watch(chatsProvider).reversed.toList();
                return ListView.builder(
                  reverse: true,
                  itemCount: chats.length,
                  itemBuilder: (context, index) => ChatItem(
                    text: chats[index].message,
                    isMe: chats[index].isMe,
                  ),
                );
              }),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: TextAndVoiceField(),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
