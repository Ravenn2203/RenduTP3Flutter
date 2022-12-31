import 'package:tp2/data/models/question.dart';

class QuestionRepository {
  List<Question> listeQuestions = [];

  QuestionRepository() {
    listeQuestions.add(Question(
        questionText: "Est-ce que Pascal est un caméléon ?",
        isCorrect: true,
        imagePath: 'assets/images/pascal.jpg'));
    listeQuestions.add(Question(
        questionText: "Est-ce que Polochon est le meilleur ami de Raiponce ?",
        isCorrect: false,
        imagePath: 'assets/images/polochon.webp'));
    listeQuestions.add(Question(
        questionText: "Est-ce que Remy est un cuisinier ?",
        isCorrect: true,
        imagePath: 'assets/images/remy.jpeg'));
    listeQuestions.add(Question(
        questionText: "Est-ce que Big Ben est un personnage courageux ?",
        isCorrect: false,
        imagePath: 'assets/images/bigben.jpg'));
    listeQuestions.add(Question(
        questionText: "Est-ce que Mulan a sauvé la Chine ?",
        isCorrect: true,
        imagePath: 'assets/images/mulan.webp'));
    listeQuestions.add(Question(
        questionText: "Est-ce que Raiponce est le meilleur dessin animé de tous les temps ?",
        isCorrect: true,
        imagePath: 'assets/images/raiponce.jpg'));
    listeQuestions.add(Question(
        questionText: "Est-ce que Mushu est un lézard ?",
        isCorrect: false,
        imagePath: 'assets/images/mushu.webp'));
  }

  Question getFirstQuestion() {
    return listeQuestions.last;
  }

  Question getNextQuestion(int nbQuestion) {
    return listeQuestions.elementAt(nbQuestion-1);
  }
}
