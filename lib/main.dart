import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_auth_task/auth_controller.dart';
import 'package:number_auth_task/firebase_options.dart';
import 'package:number_auth_task/pages/home_page.dart';
import 'package:number_auth_task/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AuthController authcont = AuthController();
  authcont.init();
  authcont.listenUserAuthState();
  Get.put<AuthController>(authcont);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
          stream: Get.find<AuthController>().userstream.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LoginPage();
            }
            return const HomePage();
          },
        ),
    );
  }
}
