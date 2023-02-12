import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:store_app/src/views/home_page.dart';
import 'package:store_app/src/views/login_page.dart';
import 'package:store_app/src/views/register_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Store App",
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
      },
      home: const LoginPage(),
    );
  }
}
