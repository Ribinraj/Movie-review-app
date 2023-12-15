// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, camel_case_types, unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:picture_pulse/main.dart';
import 'package:picture_pulse/screens/admin_login.dart';
import 'package:picture_pulse/screens/home.dart';
import 'package:picture_pulse/screens/signUp.dart';
import 'package:picture_pulse/widgets/functions.dart';
import 'package:picture_pulse/widgets/signup_signinfunction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  late Box loginbox;

  @override
  void initState() {
    loginbox = Hive.box('login');

    super.initState();
  }

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  bool _isDataMatched = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 120, bottom: 120),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: customblueColor(),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50)),
                border: Border.all(width: 2, color: custombordercolor())),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
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
                              'Login',
                              style: GoogleFonts.oswald(
                                  color:
                                      const Color.fromARGB(255, 220, 214, 214),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        subtitle('Email', 17),
                        textFormFieldWidget(
                          controller: _emailController,
                          validator: validateEmail,
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        subtitle('Password', 17),
                        textFormFieldWidget(
                            controller: _passwordController,
                            validator: validatePassword,
                            hintText: 'Password',
                            obscureText: true),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            loginSigninButton(
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    bool isuser = false;

                                    for (int i = 0; i < loginbox.length; i++) {
                                      final storeduser = loginbox.get(i);
                                      if (_emailController.text ==
                                              storeduser.email &&
                                          _passwordController.text ==
                                              storeduser.password) {
                                        isuser = true;
                                        await _indexinSharedpref(i);

                                        final _sharedpref =
                                            await SharedPreferences
                                                .getInstance();
                                        await _sharedpref.setBool(
                                            SAVE_KEY_NAME, true);

                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) => homeScreen(),
                                        ));
                                        break;
                                      } else {
                                        setState(() {
                                          _isDataMatched = false;
                                        });
                                      }
                                    }
                                    if (isuser == false) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(createCustomSnackBar(
                                              text:
                                                  'invalid user name or password',
                                              backgroundColor: Colors.red));
                                    }
                                  }
                                },
                                buttonText: 'Login'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => signupScreen()));
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 29, 236, 36),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AdminloginScreen()));
                            },
                            child: Text(
                              'Admin?',
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 29, 236, 36),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> _indexinSharedpref(int index) async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    await sharedpref.setInt('userIndex', index);
  }
}
