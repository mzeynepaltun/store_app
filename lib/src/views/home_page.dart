import 'package:flutter/material.dart';
import 'package:store_app/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  goto() {
    Navigator.pushNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: raspberry,
      body: Column(
        children: [
          RawMaterialButton(
            onPressed: () {
              goto();
            },
            fillColor: chocolate,
            child: Text(
              "Login",
              style: TextStyle(color: latte),
            ),
          )
        ],
      ),
    ));
  }
}
