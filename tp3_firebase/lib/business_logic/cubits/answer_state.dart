part of 'answer_cubit.dart';

@immutable
abstract class QuizzState {}

class QuizzInitial extends QuizzState {}

class QuizzColorsLoaded extends QuizzState {}

class QuizzNextQuestionLoaded extends QuizzState {}

  class QuizzDataLoaded extends QuizzState{}