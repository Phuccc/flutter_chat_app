import 'package:flutter/material.dart';
import 'package:flutter_chat_app/auth/auth_service.dart';
import 'package:flutter_chat_app/components/buttom.dart';
import 'package:flutter_chat_app/components/textfield.dart';
import 'package:flutter_chat_app/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  // Email và mật khẩu (Text controller)
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  LoginPage({super.key});

  // Login method
  void login(BuildContext context) async {
    final auth = AuthService();

    try {
      await auth.signIn(
        _emailController.text,
        _pwController.text,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/Logo.png',
              width: 140,
              height: 140,
            ),

            // Tên app
            Text(
              'Chat Friendly',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 50),

            // Email
            TextField_Edit(
              hintText: 'Email . . . ',
              obscureText: false,
              controller: _emailController,
            ),

            const SizedBox(height: 10),

            // Mật khẩu
            TextField_Edit(
              hintText: 'Password . . . ',
              obscureText: true,
              controller: _pwController,
            ),

            const SizedBox(height: 25),

            // Nút login
            Buttom_Edit(
              text: 'Login',
              onTap: () => login(context),
            ),

            const SizedBox(height: 25),

            // Chọn register
            GestureDetector(
              onTap: () {
                // Chuyển trang sang RegisterPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No account ? ",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  Text(
                    "Register now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
