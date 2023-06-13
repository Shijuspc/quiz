import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<Signup> {
  final key = GlobalKey<FormState>();
  late String _name, _phoneNumber, _email, _password, _confirmPassword;
  final auth = FirebaseAuth.instance;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'REGISTER',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 40),
                  child: TextFormField(
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
                      labelText: "Name",
                      hintText: "Enter your Name",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.green,
                      ),
                      hintStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      labelStyle: TextStyle(fontSize: 15, color: Colors.green),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _name = value.trim();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
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
                      labelText: "Phone Number",
                      hintText: "Enter your Phone Number",
                      prefixIcon: Icon(
                        Icons.perm_contact_cal,
                        color: Colors.green,
                      ),
                      hintStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      labelStyle: TextStyle(fontSize: 15, color: Colors.green),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _phoneNumber = value.trim();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
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
                    left: 50,
                    right: 50,
                    top: 20,
                  ),
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
                      labelText: "Confirm Password",
                      hintText: "Confirm your Password",
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
                        _confirmPassword = value.trim();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                      overlayColor: MaterialStateProperty.all(Colors.green),
                    ),
                    onPressed: () {
                      if (_password == _confirmPassword) {
                        auth
                            .createUserWithEmailAndPassword(
                                email: _email, password: _password)
                            .then((userCredential) {
                          // Store the user data in Firestore
                          usersCollection
                              .doc(userCredential.user!
                                  .uid) // Use the user's UID as the document ID
                              .set({
                            'name': _name,
                            'phoneNumber': _phoneNumber,
                            'email': _email,
                          }).then((_) {
                            print('User saved successfully');
                            // Navigate to the login page
                            Navigator.pushNamed(context, '/');
                          }).catchError((error) {
                            print('Error saving user: $error');
                          });
                        }).catchError((error) {
                          print('Error creating user: $error');
                        });
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Password Error'),
                              content: Text('Passwords do not match'),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text(
                        'Login',
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
}
