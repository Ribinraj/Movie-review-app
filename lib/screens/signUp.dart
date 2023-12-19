import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:picture_pulse/Model/login.dart';

import 'package:picture_pulse/screens/login.dart';
import 'package:picture_pulse/widgets/database_functions.dart';
import 'package:picture_pulse/widgets/functions.dart';
import 'package:picture_pulse/widgets/signup_signinfunction.dart';

class signupScreen extends StatelessWidget {
  signupScreen({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
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
                          padding: EdgeInsets.only(top: 100),
                        ),
                        titlelogo(),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .85,
                      height: MediaQuery.of(context).size.height * .55,
                      child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Signup',
                                  style: GoogleFonts.oswald(
                                      color: const Color.fromARGB(
                                          255, 192, 201, 201),
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            subtitle('Name', 17),
                            textFormFieldWidget(
                              controller: _nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }

                                return null;
                              },
                              hintText: 'Name',
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
                            ),
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
                                        signupTodatabase(
                                          Login(
                                              username: _nameController.text,
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text),
                                        );

                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const loginScreen(),
                                        ));
                                      }
                                    },
                                    buttonText: 'Signup'),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account ?",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const loginScreen()));
                                  },
                                  child: const Text(
                                    'Signin',
                                    style: TextStyle(
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
            )));
  }
}
