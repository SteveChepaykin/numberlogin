import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_auth_task/auth_controller.dart';
import 'package:number_auth_task/pages/code_verification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Введите свой телефон:'),
            TextField(
              controller: phoneCont,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: action,
              child: const Text('Регистрация'),
            ),
          ],
        ),
      ),
    );
  }

  void action() {
    Get.find<AuthController>().loginByPhone(phoneCont.text.trim());
    Get.to(() => const CodeVerificationPage());
  }
}
