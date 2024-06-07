// ignore_for_file: unused_import
import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatUser {
  final String id;
  final String email;
  final String image;

  ChatUser({
    required this.id,
    required this.email,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'image': image,
    };
  }
}
