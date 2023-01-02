import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quizz!'),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Center(
                child: Text('Bienvenue dans mon TP3',
                    style: const TextStyle(
                      color: Colors.black,
                      letterSpacing: 2.0,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Center(
                child: Text('Deux options sont possibles :',
                    style: const TextStyle(
                      color: Colors.black,
                      letterSpacing: 2.0,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 200, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey[600],
                    ),
                    icon: const Icon(
                      Icons.quiz,
                    ),
                    label: Text('Quizz à thème'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/themes');
                    },
                  ),
                  ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey[600],
                    ),
                    icon: const Icon(
                      Icons.question_mark,
                    ),
                    label: Text('Créer une question'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/themesCreationQuestion');
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
