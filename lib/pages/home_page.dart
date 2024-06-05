import 'package:flutter/material.dart';
import 'package:flutter_chat_app/components/chat_card.dart';
import 'package:flutter_chat_app/components/drawer.dart';
import 'package:flutter_chat_app/pages/chat_page.dart';
import 'package:flutter_chat_app/services/auth/auth_service.dart';
import 'package:flutter_chat_app/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        title: Text(
          "Chat riendly",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          // Nút tìm kiếm người dùng
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),

      // Ngăn kéo tuỳ chọn
      drawer: const Drawer_Edit(),

      body: _buildUserList(),

      // Nút thêm người dùng
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        elevation: 8.0,
        child: const Icon(Icons.person_add_alt_1_rounded),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        // Error
        if (snapshot.hasError) {
          return const Text("Error!!!");
        }

        // Hiển thị list user
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildChatCardList(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildChatCardList(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return ChatCard(
        email: userData["email"],
        message: '',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receivedEmail: userData["email"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
