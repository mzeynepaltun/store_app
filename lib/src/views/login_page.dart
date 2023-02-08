import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:store_app/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isProcessOn = false;
  bool hidePassword = true;
  String? email;
  String? password;
  goto() {
    Navigator.pushNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: raspberry,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 400, 0, 0),
        shrinkWrap: true,
        reverse: true,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "WELCOME",
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
                            padding: const EdgeInsets.only(top: 10),
                            child: FormHelper.inputFieldWidget(
                              context,
                              "email",
                              "E-mail",
                              (onValidateVal) {
                                if (onValidateVal.isEmpty) {
                                  return "Please enter e-mail.";
                                }
                                return null;
                              },
                              (onSavedVal) {
                                email = onSavedVal;
                              },
                              borderFocusColor: lion,
                              prefixIconColor: lion,
                              suffixIcon: Icon(
                                Icons.person,
                                color: lion.withOpacity(0.7),
                              ),
                              borderColor: lion,
                              textColor: lion,
                              hintColor: lion.withOpacity(0.7),
                              borderRadius: 10,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: FormHelper.inputFieldWidget(
                                context, "password", "Password",
                                (onValidateVal) {
                              if (onValidateVal.isEmpty) {
                                return "Please enter password.";
                              }
                              return null;
                            }, (onSavedVal) {
                              password = onSavedVal;
                            },
                                borderFocusColor: lion,
                                prefixIconColor: lion,
                                borderColor: lion,
                                textColor: lion,
                                obscureText: hidePassword,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  icon: Icon(hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  color: lion.withOpacity(0.7),
                                ),
                                hintColor: lion.withOpacity(0.7),
                                borderRadius: 10),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: FormHelper.submitButton("LOGIN", () {
                              if (validateAndSave()) {
                                setState(() {
                                  isProcessOn = true;
                                });
                              }
                            },
                                btnColor: lion,
                                borderColor: lion,
                                txtColor: beige,
                                borderRadius: 30),
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
                                    const TextSpan(
                                        text: "Don't have an account? "),
                                    TextSpan(
                                        text: "SIGN UP",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushNamed(
                                                context, "/home");
                                          })
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -375),
                    child: Image.asset(
                      'assets/images/logo2.png',
                      scale: 3,
                      width: double.infinity,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    ));
  }

  bool validateAndSave() {
    return true;
    // final form = globalFromKey.currentState;
    // if (form!.validate()) {
    //   form.save();
    //   return true;
    // } else {
    //   return false;
    // }
  }
}
// Column(
//         children: [
//           RawMaterialButton(
//             onPressed: () {
//               goto();
//             },
//             fillColor: chocolate,
//             child: Text(
//               "HomePage",
//               style: GoogleFonts.poppins(color: latte),
//             ),
//           ),
//         ],
//       ),