part of 'answer_cubit.dart';

@immutable
abstract class QuizzState {}

//Etat appelé à la construction du cubit
class QuizLoading extends QuizzState {}

class QuizzLoaded extends QuizzState {}

class QuizzAnswered extends QuizzState{}

class QuizzError extends QuizzState {}
