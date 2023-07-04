import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // main axis ini vertical
              crossAxisAlignment:
                  CrossAxisAlignment.start, // cross axis ini horizontal
              children: [
                const Text(
                  'Login to',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                ),
                const Text(
                  'your Account',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 32.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.all(16.0), // Adjusts height
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjusts the roundness of border
                    ),
                    labelText: 'Username',
                    hintText: 'Masukkan username kamu',
                    floatingLabelBehavior: FloatingLabelBehavior
                        .always, // Keeps the label floating
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.all(16.0), // Adjusts height
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjusts the roundness of border
                    ),
                    labelText: 'Password',
                    hintText: 'Password kamu',
                    floatingLabelBehavior: FloatingLabelBehavior
                        .always, // Keeps the label floating
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
