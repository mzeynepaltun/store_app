import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/app_colors.dart';

import '../widgets/utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: beige,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Recieve and e-mail to reset your password.",
                style: GoogleFonts.poppins(
                    color: lion, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: TextFormField(
                  controller: emailController,
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
              const SizedBox(height: 20),
              RawMaterialButton(
                onPressed: () {
                  _resetPassword();
                },
                fillColor: lion,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Reset Password",
                  style: GoogleFonts.poppins(
                      color: beige, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: "LOG IN",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: lion),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, "/login");
                    },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _resetPassword() async {
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
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar("Password reset e-mail has been sent.");
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());

      Utils.showSnackBar(e.message.toString());
      Navigator.of(context).pop();
    }
  }
}
