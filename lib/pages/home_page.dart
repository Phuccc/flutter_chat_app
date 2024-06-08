// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/components/chat_card.dart';
import 'package:flutter_chat_app/components/drawer.dart';
import 'package:flutter_chat_app/components/textfield.dart';
import 'package:flutter_chat_app/pages/chat_page.dart';
import 'package:flutter_chat_app/services/auth/auth_service.dart';
import 'package:flutter_chat_app/services/chat/chat_service.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  final TextEditingController _searchController = TextEditingController();
  // Dach sách người dùng
  List<Map<String, dynamic>> _userList = [];
  // Danh sách người dùng đã lọc
  List<Map<String, dynamic>> _filteredUserList = [];

  bool _showSearchBar = false;

  @override
  void initState() {
    super.initState();
    _fetchUserList();
  }

  // Cập nhật danh sách người dùng
  void _fetchUserList() {
    _chatService.getUsersStream().listen((users) {
      setState(() {
        _userList = users;
        _filteredUserList = users;
      });
    });
  }

  // Lọc danh sách người dùng
  void _filterUserList(String query) {
    setState(() {
      _filteredUserList = _userList.where((user) {
        return user["email"].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

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
          "Chat Friendly",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          // Nút tìm kiếm người dùng
          IconButton(
            onPressed: () {
              // Khi IconButton được nhấn, thay đổi trạng thái của thanh tìm kiếm
              setState(() {
                if (_showSearchBar) {
                  // Nếu đang hiển thị thanh tìm kiếm, đặt lại bộ điều khiển tìm kiếm
                  _searchController.clear();
                  _filteredUserList = _userList;
                }
                _showSearchBar = !_showSearchBar;
              });
            },
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),

      // Ngăn kéo tuỳ chọn
      drawer: const Drawer_Edit(),

      // Body
      body: Column(
        children: [
          // Hiển thị danh sách người dùng
          if (_showSearchBar)
            // Mở thanh tìm kiếm theo email
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField_Edit(
                controller: _searchController,
                onChanged: _filterUserList,
                hintText: "Search by email",
                obscureText: false,
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          Expanded(
            child: _buildUserList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Error
        if (snapshot.hasError) {
          return const Text("Error!!!");
        }

        // Hiển thị list user
        return ListView(
          children: _filteredUserList
              .where((userData) =>
                  userData["email"] != _authService.getCurrentUser()!.email)
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
        imageUrl: userData["image"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receivedEmail: userData["email"],
                receiverID: userData["id"],
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
