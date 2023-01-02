import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tp2/data/models/question.dart';

part 'answer_state.dart';

class QuizzCubit extends Cubit<QuizzState> {
  QuizzCubit() : super(QuizLoading()) {}

  //Instance de notre base de données
  var db = FirebaseFirestore.instance;

  //Collection de questions obtenues de firebase
  QuerySnapshot<Map<String, dynamic>>? collectionQuestions;

  //Compteur qui parcours la collection
  int compteurQuestionsCollectionFirebase = 0;

  //Compteur du nombre de bonnes réponses
  int nbBonnesReponses = 0;

  //Question actuelle
  Question? question;

  //Stocke les couleurs des boutons
  Color vrai = Colors.grey;
  Color faux = Colors.grey;

  //Permet de vérifier si l'utilisateur a répondu et si on peut passer à la question suivante ou non
  bool aRepondu = false;

  void changeButtonsColor(Color newVrai, Color newFaux) {
    //L'utilisateur a répondu on colorie les boutons de la bonne manière
    aRepondu = true;
    this.vrai = newVrai;
    this.faux = newFaux;
    emit(QuizzAnswered());
  }

  bool nextQuestionAvailable() {
    return !(compteurQuestionsCollectionFirebase == collectionQuestions?.size);
  }

  void nextQuestion() {
    if (nextQuestionAvailable()) {
      QueryDocumentSnapshot<Map<String, dynamic>>? nouvelleQuestion = collectionQuestions?.docs.elementAt(compteurQuestionsCollectionFirebase);
      question = Question(questionText: nouvelleQuestion?['questionText'],
          isCorrect: nouvelleQuestion?['isCorrect'],
          imagePath: nouvelleQuestion?['imagePath']);
      compteurQuestionsCollectionFirebase++;
      vrai = Colors.grey;
      faux = Colors.grey;
      aRepondu = false;
      emit(QuizzLoaded());
    }
  }

  void augmenterBonnesReponses() {
    nbBonnesReponses++;
    print('bonne réponse!');
  }

  Future<void> retrieveData(String categorie) async {
    //On attend que les données soient récupérées
    emit(QuizLoading());

    QuerySnapshot<Map<String, dynamic>> retrievedData = await db.collection(categorie).get();
    collectionQuestions = retrievedData;

    retrievedData.docs.forEach((doc) {
      print('Document récupéré :'+doc.data().toString());
    });

    nextQuestion();

    //On a récupéré les données
    emit(QuizzLoaded());

  }

  void restartQuizz(){
    compteurQuestionsCollectionFirebase=0;
    nbBonnesReponses=0;
  }

  int? getNombreQuestions(){
    return collectionQuestions?.size;
  }

}
