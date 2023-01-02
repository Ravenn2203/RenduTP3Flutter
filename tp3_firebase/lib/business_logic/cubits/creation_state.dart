part of 'creation_cubit.dart';

@immutable
abstract class CreationState {}

class CreationLoading extends CreationState {}

class CreationLoaded extends CreationState {}

class CreationThemeChosen extends CreationState{}

class CreationError extends CreationState {}
