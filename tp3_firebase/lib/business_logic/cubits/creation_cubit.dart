import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'creation_state.dart';

class CreationCubit extends Cubit<CreationState> {
  CreationCubit() : super(CreationLoading()) {
    retrieveData();
  }

  //Instance de notre base de données
  var db = FirebaseFirestore.instance;

  QuerySnapshot<Map<String, dynamic>>? collectionDisney;
  QuerySnapshot<Map<String, dynamic>>? collectionSuperHeros;

  //Variables pour créer une questions
  String? themeChoisi;

  Future<void> retrieveData() async {
    QuerySnapshot<Map<String, dynamic>> retrievedData =
        await db.collection('disney').get();
    collectionDisney = retrievedData;
    QuerySnapshot<Map<String, dynamic>> retrievedData2 =
        await db.collection('superHeros').get();
    collectionSuperHeros = retrievedData2;

    //On a récupéré les données
    emit(CreationLoaded());
  }

  void changeTheme(String theme) {
    themeChoisi = theme;
  }

  Future<void> addQuestion(
      String questionText, String imagePath, bool isCorrect) async {

    CollectionReference collection =
        FirebaseFirestore.instance.collection(themeChoisi!);
    await collection.add({
      'questionText': questionText,
      'imagePath': imagePath,
      'isCorrect': isCorrect,
    });

  }
}
