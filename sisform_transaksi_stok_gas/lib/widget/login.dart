import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme.dart';
import 'auth/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String errorMessage = '';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signInWithEmailandPassword() async {
    try {
      await Auth().signInWithEmailPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message!;
    }
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool secure = false}) {
    return TextField(
      controller: controller,
      obscureText: secure,
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: signInWithEmailandPassword,
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 50),
        ),
      ),
      child: const Text('Login'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          // untuk mengatur jarak layar
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              _entryField('email', emailController),
              const SizedBox(
                height: 25,
              ),
              _entryField('password', passwordController, secure: true),
              const SizedBox(
                height: 25,
              ),
              _submitButton(),
              _errorMessage(),
              // untuk jarak yg jauh biasa digunakan buat footer contohnya
              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
