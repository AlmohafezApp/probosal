import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:voice_recognition/colors.dart';

import '../componants.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar:
            AppBar(backgroundColor: backgroundColor, elevation: 0, actions: [
          const Center(
            child: Text(
              "Sign In",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16),
            ),
          ),
          IconButton(
              splashRadius: 25,
              iconSize: 40,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Material(
                color: maincolor.withOpacity(0.4),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: maincolor,
                    size: 22,
                  ),
                ),
              )),
        ]),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  "Create Account with Email",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Your email :",
                      textDirection: TextDirection.ltr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    CustomTextFormField(
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Password :",
                      textDirection: TextDirection.ltr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    CustomTextFormField(
                      isObscure: true,
                      controller: passController,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Text.rich(
                    TextSpan(
                        text: "i agree to the ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600]),
                        children: const [
                          TextSpan(
                              text: "Terms & Conditions",
                              style: TextStyle(
                                  color: maincolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                          TextSpan(text: " and "),
                          TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(
                                  color: maincolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ]),
                    textAlign: TextAlign.left),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30.0, horizontal: 75),
                child: MaterialButton(
                  onPressed: () {},
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Create Account",
                      style: TextStyle(color: backgroundColor),
                    ),
                  ),
                  color: maincolor,
                  height: 30,
                  minWidth: 300,
                ),
              ),
              // Row(
              //   textDirection: TextDirection.ltr,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   textBaseline: TextBaseline.ideographic,
              //   children: [
              //     const Text(" Already have an account?"),
              //     InkWell(
              //       onTap: () {},
              //       child: const Text(
              //         "Log in",
              //         style: TextStyle(
              //           color: maincolor,
              //           decoration: TextDecoration.underline,
              //         ),
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
