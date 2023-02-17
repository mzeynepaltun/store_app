import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app_colors.dart';
import '../../main.dart';
import '../widgets/curve_painter.dart';
import '../widgets/utils.dart';
import 'forgot_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

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
      backgroundColor: beige,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              CustomPaint(
                painter: CurvePainter(),
                child: Container(height: 150),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "LOG IN",
                        style: GoogleFonts.poppins(
                            color: lion,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: TextFormField(
                        controller: emailController,
                        cursorColor: lion,
                        textInputAction: TextInputAction.next,
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
                        controller: passwordController,
                        cursorColor: lion,
                        textInputAction: TextInputAction.done,
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
                    const SizedBox(height: 20),
                    Center(
                      child: RawMaterialButton(
                        onPressed: () {
                          _login();
                        },
                        fillColor: lion,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Log In",
                          style: GoogleFonts.poppins(
                              color: beige, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      child: Text(
                        "Forgot password?",
                        style: GoogleFonts.poppins(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: lion,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: lion,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Don't have an account? ",
                                style: GoogleFonts.poppins()),
                            TextSpan(
                              text: "SIGN UP",
                              style: GoogleFonts.poppins(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, "/signup");
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future _login() async {
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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
