// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:picture_pulse/screens/admin_panel.dart';
import 'package:picture_pulse/screens/login.dart';
import 'package:picture_pulse/widgets/functions.dart';
import 'package:picture_pulse/widgets/signup_signinfunction.dart';

class AdminloginScreen extends StatelessWidget {
  AdminloginScreen({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: getGradientDecoration(),
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
                left: 40, right: 40, top: 120, bottom: 120),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: customblueColor(),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50)),
                border: Border.all(width: 2, color: custombordercolor())),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 150),
                    ),
                    titlelogo(),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .85,
                  height: MediaQuery.of(context).size.height * .50,
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Admin login',
                              style: GoogleFonts.oswald(
                                  color:
                                      const Color.fromARGB(255, 25, 239, 239),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        subtitle('Email', 17),
                        textFormFieldWidget(
                            controller: _emailController,
                            validator: validateEmail,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false),
                        const SizedBox(
                          height: 10,
                        ),
                        subtitle('Password', 17),
                        textFormFieldWidget(
                            controller: _passwordController,
                            validator: validatePassword,
                            hintText: 'Password',
                            keyboardType: TextInputType.text,
                            obscureText: true),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            loginSigninButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    if (_emailController.text ==
                                            'ribinrajop@gmail.com' &&
                                        _passwordController.text ==
                                            '1234*Ribin') {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminpanelScreen(),
                                      ));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(createCustomSnackBar(
                                              text:
                                                  'invalid username or password',
                                              backgroundColor: Colors.red));
                                    }
                                  }
                                },
                                buttonText: 'Login'),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Are you user ?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const loginScreen()),
                                );
                              },
                              // ignore: prefer_const_constructors
                              child: Text(
                                'Sign In',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 29, 236, 36),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
