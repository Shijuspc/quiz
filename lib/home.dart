import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentQuestionIndex = 0;
  int? selectedChoiceIndex;
  int score = 0;
  bool quizCompleted = false;
  String userId = "";
  String userScore = "";

  List<Question> questions = [
    Question(
      question: 'What is the capital of France?',
      choices: ['Paris', 'London', 'Berlin', 'Madrid'],
      correctAnswerIndex: 0,
    ),
    Question(
      question: 'Who painted the Mona Lisa?',
      choices: [
        'Leonardo da Vinci',
        'Pablo Picasso',
        'Vincent van Gogh',
        'Michelangelo'
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      question: 'What is the largest planet in our solar system?',
      choices: ['Jupiter', 'Saturn', 'Mars', 'Earth'],
      correctAnswerIndex: 0,
    ),
  ];

  void fetchScore() async {
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('score')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        setState(() {
          score = userDoc.get('score') ?? 0;
          userScore = 'Score: $score/${questions.length}';
        });
      } else {
        print('User document does not exist.');
      }
    } catch (e) {
      print('Failed to fetch score: $e');
    }
  }

  void checkAnswer() {
    if (selectedChoiceIndex ==
        questions[currentQuestionIndex].correctAnswerIndex) {
      score++;
    }

    setState(() {
      userScore = 'Score: $score/${questions.length}';
    });

    goToNextQuestion();
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedChoiceIndex = null;
      });
    } else {
      setState(() {
        quizCompleted = true;
        uploadScore();
      });
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        selectedChoiceIndex = null;
      });
    }
  }

  void resetQuiz() {
    if (quizCompleted) {}
    setState(() {
      currentQuestionIndex = 0;
      selectedChoiceIndex = null;
      score = 0;
      quizCompleted = false;
    });
  }

  void uploadScore() async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final DocumentReference userDoc =
            FirebaseFirestore.instance.collection('score').doc(currentUser.uid);

        await userDoc.set({
          'score': score,
          'timeDate': DateTime.now(),
        }, SetOptions(merge: true));

        print('Score uploaded successfully!');
      } else {
        print('User not signed in.');
      }
    } catch (e) {
      print('Failed to upload score: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final User = FirebaseAuth.instance.currentUser!;
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
                  'Quiz',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))),
            Center(
              child: quizCompleted
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                        ),
                        Text(
                          'Quiz Completed',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Your Score: $score/${questions.length}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: Text('Restart Quiz'),
                          onPressed: resetQuiz,
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Text(
                              questions[currentQuestionIndex].question,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: List.generate(
                            questions[currentQuestionIndex].choices.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(left: 100),
                              child: RadioListTile(
                                activeColor: Colors.green,
                                title: Text(questions[currentQuestionIndex]
                                    .choices[index]),
                                value: index,
                                groupValue: selectedChoiceIndex,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedChoiceIndex = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.green),
                            overlayColor:
                                MaterialStateProperty.all(Colors.grey),
                          ),
                          onPressed:
                              selectedChoiceIndex == null ? null : checkAnswer,
                        ),
                        SizedBox(height: 80),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton(
                              child: Text('Previous'),
                              onPressed: goToPreviousQuestion,
                              style: ElevatedButton.styleFrom(),
                            ),
                            SizedBox(width: 10),
                            OutlinedButton(
                              child: Text('Next'),
                              onPressed: goToNextQuestion,
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                      icon: Icon(Icons.home, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Container(
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
                            ));
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

class Question {
  final String question;
  final List<String> choices;
  final int correctAnswerIndex;

  Question({
    required this.question,
    required this.choices,
    required this.correctAnswerIndex,
  });
}
