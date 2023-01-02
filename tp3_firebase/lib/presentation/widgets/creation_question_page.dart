import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp2/business_logic/cubits/creation_cubit.dart';

class CreationQuestionPage extends StatefulWidget {
  const CreationQuestionPage({Key? key}) : super(key: key);

  @override
  State<CreationQuestionPage> createState() => _CreationQuestionPageState();
}

class _CreationQuestionPageState extends State<CreationQuestionPage> {
  bool _selectedOption = false;
  String questionText = "";
  String imagePath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizz!'),
        centerTitle: false,
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 200, 10, 10),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Texte de la question vrai ou faux',
              ),
              onChanged: (value) {
                questionText = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Lien vers une image',
              ),
              onChanged: (value) {
                imagePath = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            CheckboxListTile(
              title: Text(
                  'Cochez cette case si la réponse à votre question est VRAI'),
              value: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value ?? false;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
                icon: const Icon(
                  Icons.quiz,
                ),
                label: Text('Envoyer la question'),
                onPressed: () {
                  BlocProvider.of<CreationCubit>(context).addQuestion(questionText, imagePath, _selectedOption);
                  Navigator.pushNamed(context, '/');
                  const snackBar = SnackBar(
                    content: Text('Question ajoutée!'),
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snackBar);
                }),
          ],
        ),
      ),
    );
  }
}
