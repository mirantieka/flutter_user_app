import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'lib/assets/info.png',
              width: 150,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'This is user info page.',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    ))));
  }
}
