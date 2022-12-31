import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp2/data/models/question.dart';

  class FireStoreTP3 {
  var db = FirebaseFirestore.instance;

  FireStoreTP3() {

    final user = <String, dynamic>{
      "first": "Ada",
      "last": "Lovelace",
      "born": 1815
    };

    db.collection("users").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));

    final user2 = <String, dynamic>{
      "first": "Alan",
      "middle": "Mathison",
      "last": "Turing",
      "born": 1912
    };

    db.collection("users").add(user2).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));

  }

  Future<Question> readDataFromFirebaseDatabase(int numQuestion) async {
    Question question = Question(isCorrect: true ,imagePath:  "",questionText:  "");
    await db.collection("superHeros").get().then((event) {
      if (event.docs.isNotEmpty) {
        DocumentSnapshot firstDoc = event.docs.elementAt(0);
        Map<String, dynamic> data = firstDoc.data() as Map<String, dynamic>;
        question = Question(questionText: data['questionText'], isCorrect: data['isCorrect'], imagePath: data['imagePath']);
      }
    });

    return question;
  }
}
