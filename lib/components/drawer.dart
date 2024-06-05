import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/account_page.dart';
import 'package:flutter_chat_app/pages/setting_page.dart';
import '../services/auth/auth_service.dart';

// ignore: camel_case_types
class Drawer_Edit extends StatelessWidget {
  const Drawer_Edit({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Logo
              DrawerHeader(
                child: Center(
                  child: Image.asset(
                    'assets/Logo.png',
                    width: 70,
                    height: 70,
                  ),
                ),
              ),

              // Nút home ở list
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: Icon(
                    Icons.home_rounded,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              // Nút setting ở list
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: const Text("S E T T I N G"),
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingPage(),
                        ));
                  },
                ),
              ),

              // Nút account ở list
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: const Text("A C C O U N T"),
                  leading: Icon(
                    Icons.account_circle_rounded,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountPage(),
                        ));
                  },
                ),
              ),
            ],
          ),

          // Nút logout ở list
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              onTap: logout,
            ),
          )
        ],
      ),
    );
  }
}
