import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:quiz/register.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String _email, _password;
  final auth = FirebaseAuth.instance;
  final key = GlobalKey<FormState>();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.symmetric(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LOG IN',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.green,
                            width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.grey,
                            width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: "Email",
                      hintText: "Enter your Email",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
                      hintStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      labelStyle: TextStyle(fontSize: 15, color: Colors.green),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 50, right: 50, top: 20, bottom: 30),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.green,
                            width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.grey,
                            width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: "Password",
                      hintText: "Enter your Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.green,
                      ),
                      hintStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      labelStyle: TextStyle(fontSize: 15, color: Colors.green),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _password = value.trim();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: ElevatedButton(
                    child: Text(
                      'Log In',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.grey),
                      overlayColor: MaterialStateProperty.all(Colors.green),
                    ),
                    onPressed: () {
                      _signIn();
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    child: Text(
                      'Password Reset',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.grey),
                      overlayColor: MaterialStateProperty.all(Colors.green),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Title(
                                        color: Colors.black,
                                        child: Text(
                                          'Password Reset',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.close))
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 0, top: 20, bottom: 20),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: Colors.green,
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: Colors.grey,
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      labelText: "Email",
                                      hintText: "Enter your Email",
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.green,
                                      ),
                                      hintStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      labelStyle: TextStyle(
                                          fontSize: 15, color: Colors.green),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _email = value.trim();
                                      });
                                    },
                                  ),
                                ),
                                ElevatedButton(
                                  child: Text(
                                    'Reset',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.grey),
                                    overlayColor:
                                        MaterialStateProperty.all(Colors.green),
                                  ),
                                  onPressed: () {
                                    _resetPassword();
                                    Navigator.pop(context);
                                  },
                                ),
                              ]),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                          fontSize: 17,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      auth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Home()),
        );
      }).catchError((error) {
        setState(() {
          _errorMessage = _getErrorMessage(error);
        });
      });
    }
  }

  void _resetPassword() {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      auth.sendPasswordResetEmail(email: _email).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent')),
        );
      }).catchError((error) {
        setState(() {
          _errorMessage = _getErrorMessage(error);
        });
      });
    }
  }

  String _getErrorMessage(error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No user found with this email.';
        case 'wrong-password':
          return 'Invalid password.';
        case 'invalid-email':
          return 'Invalid email address.';
        default:
          return 'Authentication failed. Please try again later.';
      }
    } else {
      return 'An error occurred. Please try again later.';
    }
  }
}
