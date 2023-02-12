import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_colors.dart';
import '../../main.dart';
import '../widgets/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: raspberry,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logo2.png',
              scale: 3,
              width: double.infinity,
            ),
            Container(
              height: 535,
              width: double.infinity,
              decoration: BoxDecoration(
                color: beige,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "SIGN UP",
                        style: GoogleFonts.poppins(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: lion),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: TextFormField(
                        controller: emailController = TextEditingController(),
                        cursorColor: lion,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: lion),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: lion),
                          ),
                          label: Text(
                            "E-Mail",
                            style: GoogleFonts.poppins(color: lion),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? "Enter a valid e-mail"
                                : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController =
                            TextEditingController(),
                        cursorColor: lion,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: lion),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: lion),
                          ),
                          label: Text(
                            "Password",
                            style: GoogleFonts.poppins(color: lion),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (password) =>
                            password != null && password.length < 6
                                ? "Enter at least 6 characters"
                                : null,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: RawMaterialButton(
                        onPressed: () {
                          _signUp();
                        },
                        fillColor: lion,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.poppins(
                              color: beige, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: lion,
                          ),
                          children: <TextSpan>[
                            const TextSpan(text: "Already have an account? "),
                            TextSpan(
                              text: "LOG IN",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, "/login");
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future _signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: raspberry,
        ),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());

      Utils.showSnackBar(e.message.toString());
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
