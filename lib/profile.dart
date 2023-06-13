import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference scoreCollection =
      FirebaseFirestore.instance.collection('score');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 50,
              color: Color.fromARGB(255, 72, 72, 72),
              width: double.maxFinite,
              child: Center(
                child: Text(
                  'Profile',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: usersCollection.doc(currentUser?.uid).snapshots(),
              builder: (context, userSnapshot) {
                if (userSnapshot.hasData) {
                  final userData = userSnapshot.data!.data()
                      as Map<String, dynamic>?; // Add null check
                  if (userData != null) {
                    final name = userData['name'];
                    final email = currentUser?.email;
                    final phoneNumber = userData['phoneNumber'];

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            height: 180,
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.green, width: 2),
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        'https://img.freepik.com/premium-photo/hand-camera-photographer-forest-his-love-photography-his-camera_24883-1429.jpg',
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Score: ',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        StreamBuilder<DocumentSnapshot>(
                                          stream: scoreCollection
                                              .doc(currentUser!.uid)
                                              .snapshots(),
                                          builder: (context, scoreSnapshot) {
                                            if (scoreSnapshot.hasData) {
                                              final scoreData = scoreSnapshot
                                                      .data!
                                                      .data()
                                                  as Map<String,
                                                      dynamic>?; // Add null check
                                              final scoreValue = scoreData?[
                                                          'score']
                                                      ?.toString() ??
                                                  'N/A'; // Use null-aware operator and provide fallback value
                                              return Text(
                                                scoreValue,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            }
                                            return Text(
                                              'Loading...',
                                              style: TextStyle(fontSize: 20),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 2, color: Colors.green),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  'Name: ',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  name ?? 'N/A',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 2, color: Colors.green),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  'Email: ',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  email ?? 'N/A',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 2, color: Colors.green),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  'Phone Number: ',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  phoneNumber ?? 'N/A',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            child: Container(
                              width: 100,
                              child: Center(
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 2, color: Colors.green),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  title: Text(
                                    'Log Out',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                } else if (userSnapshot.hasError) {
                  return Text('Error: ${userSnapshot.error}');
                }
                return Column(
                  children: [
                    Text(
                      'Loading...',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          child: BottomAppBar(
            color: Color.fromARGB(255, 72, 72, 72),
            elevation: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 50, left: 40),
                  child: Container(
                    child: IconButton(
                      icon: Icon(Icons.home, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
