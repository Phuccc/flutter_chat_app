import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/models/chat_user.dart';

class AuthService {
  //khởi tạo và lưu trữ một instance để truy cập và sử dụng các API xác thực
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  String? getEmail() {
    return _auth.currentUser!.email;
  }

  Stream<String?> getImageUrl() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) => snapshot.data()?['image'] as String?);
  }

  // Sign in
  Future<UserCredential> signIn(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign up
  Future<UserCredential> signUp(String email, password) async {
    try {
      // Tạo tài khoản
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Tạo 1 user mới
      ChatUser newUser = ChatUser(
        id: userCredential.user!.uid,
        email: email,
        image:
            'https://firebasestorage.googleapis.com/v0/b/chat-app-4f0cb.appspot.com/o/image%2Fuser_ava.png?alt=media&token=f5cf081f-f305-4c3d-a9ed-7cb83ce6d434',
      );

      // Lưu trữ thông tin tài khoản vào doc
      _firestore
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set(newUser.toMap());

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
