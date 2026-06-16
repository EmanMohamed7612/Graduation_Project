import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/message/view/widgets/chatmessagetile_widget.dart';
import 'package:graduation2/feauture/message/view/widgets/searchmessage_widget.dart';

import '../manager/inboxmessage_cubit.dart';
import '../manager/inboxmessage_state.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F6), // لون الخلفية الهادئ في الصورة
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Messages",
          style: TextStyle(color: Color(0xFF4A3428), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ChatSearchBar(onChanged: (query) {
              // استدعاء ميثود الفلترة من الـ Cubit مباشرة
              context.read<InboxCubit>().filterChats(query);
            }),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<InboxCubit, InboxState>(
                builder: (context, state) {
                  if (state is InboxLoading) return const Center(child: CircularProgressIndicator());
                  if (state is InboxSuccess) {
                    return ListView.builder(
                      itemCount: state.chats.length,
                      itemBuilder: (context, index) => ChatTile(chat: state.chats[index]),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}