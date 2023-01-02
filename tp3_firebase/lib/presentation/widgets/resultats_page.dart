import 'package:flutter/material.dart';
import 'package:tp2/business_logic/cubits/answer_cubit.dart';
import 'package:provider/provider.dart';

class ResultatsPage extends StatefulWidget {
  const ResultatsPage({Key? key}) : super(key: key);

  @override
  State<ResultatsPage> createState() => _ResultatsPageState();
}

class _ResultatsPageState extends State<ResultatsPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Quizz!'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.white,
      body: Card(
        margin: EdgeInsets.fromLTRB(10,250,10,0),
        elevation: 0,
        color: Colors.grey[600],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
              'Vous avez répondu correctement à ' +
                  Provider.of<QuizzCubit>(context, listen: false).nbBonnesReponses.toString() +
                  ' questions !'+
                  ' Ce qui vous fait un score de : '+Provider.of<QuizzCubit>(context, listen: false).nbBonnesReponses.toString()+'/'+Provider.of<QuizzCubit>(context, listen: false).compteurQuestionsCollectionFirebase.toString(),
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
                fontSize: 19.0,
              )),
        ),
      ),
    );
  }
}
