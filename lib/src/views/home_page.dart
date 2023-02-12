import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_colors.dart';

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
    final user = FirebaseAuth.instance.currentUser!;
    final mail = user.email;

    return SafeArea(
        child: Scaffold(
      backgroundColor: raspberry,
      body: Column(
        children: [
          RawMaterialButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            fillColor: chocolate,
            child: Text(
              "Log Out",
              style: TextStyle(color: latte),
            ),
          ),
          Center(
            child: Text(
              "Signed in as",
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Center(
            child: Text(
              mail!,
              style: GoogleFonts.poppins(fontSize: 20),
            ),
          )
        ],
      ),
    ));
  }
}
