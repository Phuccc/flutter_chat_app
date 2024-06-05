import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final String email;
  final void Function()? onTap;
  final String message;

  const ChatCard({
    super.key,
    required this.email,
    this.onTap,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      color: Theme.of(context).colorScheme.background,
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Theme.of(context).colorScheme.inversePrimary,
          width: 0.8,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: ListTile(
            // User avatar
            leading: const CircleAvatar(
              child: Icon(
                Icons.person,
              ),
            ),

            // User name
            title: Text(email),
          ),
        ),
      ),
    );
  }
}
