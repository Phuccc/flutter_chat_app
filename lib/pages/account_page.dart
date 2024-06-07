// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/services/auth/auth_service.dart';
import 'package:image_picker/image_picker.dart';
import '../components/buttom.dart';

class AccountPage extends StatefulWidget {
  final String email;
  final String userID;
  const AccountPage({
    super.key,
    required this.email,
    required this.userID,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final ImagePicker _imagePicker = ImagePicker();
  String? pickedFile;
  String? image;

  // Hiển thị thông báo "Update thành công"
  void showUpdateSuccessSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Update successful'),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Lựa chọn ảnh trong thư viện máy
  Future<void> pickImage(userID) async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    // Cập nhật trạng thái của widget
    setState(() {
      pickedFile = image.path;
    });
  }

  // Phương thức đẩy ảnh lên firebase
  Future<void> uploadImageToFirebase(String userID) async {
    final image = File(pickedFile!);
    // Lấy đuôi của file ảnh
    final tail = image.path.split('.').last;

    final reference =
        FirebaseStorage.instance.ref().child("image/${DateTime.now()}.$tail");
    await reference.putFile(image);

    final imageUrl = await reference.getDownloadURL();

    // Update vào field 'image' của người dùng hiện tại
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userID)
        .update({'image': imageUrl});

    // Hiển thị thông báo "Update thành công"
    showUpdateSuccessSnackbar(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        centerTitle: true,
        title: const Text("Account"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                // Avatar của người dùng
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 0, 122, 222),
                  radius: 120,
                  child: StreamBuilder<String?>(
                    stream: AuthService().getImageUrl(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Icon(
                          Icons.error,
                          size: 150,
                          color: Colors.white,
                        );
                      } else {
                        final imageUrl = snapshot.data;
                        if (imageUrl != null && pickedFile == null) {
                          return ClipOval(
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: 240,
                              height: 240,
                            ),
                          );
                        } else {
                          return ClipOval(
                            child: Image.file(
                              File(pickedFile!),
                              fit: BoxFit.cover,
                              width: 240,
                              height: 240,
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),

                // Nút lựa chọn hình ảnh
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      pickImage(widget.userID);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Tên email
            Text(
              widget.email,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 60),

            // Nút Update
            SizedBox(
              width: 200, // Đặt chiều rộng của nút
              child: Buttom_Edit(
                text: 'Update',
                onTap: () {
                  uploadImageToFirebase(widget.userID);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
