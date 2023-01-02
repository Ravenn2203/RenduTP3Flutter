import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tp2/business_logic/cubits/answer_cubit.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage({Key? key}) : super(key: key);

  final String title = 'Quizz!';

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quizz!'),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 70, 30, 30),
          child: ListView(
            children: [
              _getImage(),
              SizedBox(
                height: 40,
              ),
              _getQuestionCard(),
              SizedBox(
                height: 150,
              ),
              _getAnswerButtons(),
            ],
          ),
        ));
  }

  Container _getImage() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: Colors.black),
      ),
      child: BlocBuilder<QuizzCubit, QuizzState>(
          buildWhen: (previousState, state) {
        // rebuild the widget only if the state is QuizCorrect or QuizIncorrect
        return state is QuizLoading || state is QuizzLoaded;
      }, builder: (context, state) {
        if (state is QuizLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        } else if (state is QuizzLoaded) {
          return Image.network(
            BlocProvider.of<QuizzCubit>(context).question?.imagePath ?? "",
            height: 180,
            width: 450,
            fit: BoxFit.fitWidth,
          );
        }
        return Text('erreur dans getImage');
      }),
    );
  }

  Card _getQuestionCard() {
    return Card(
      elevation: 0,
      color: Colors.grey[600],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<QuizzCubit, QuizzState>(
            buildWhen: (previousState, state) {
          // rebuild the widget only if the state is QuizCorrect or QuizIncorrect
          return state is QuizLoading || state is QuizzLoaded;
        }, builder: (context, state) {
          if (state is QuizLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          } else if (state is QuizzLoaded) {
            return Text(
                BlocProvider.of<QuizzCubit>(context).question?.questionText ??
                    "",
                style: const TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 18.0,
                ));
          }
          return Text('erreur dans getQuestionCard');
        }),
      ),
    );
  }

  Row _getAnswerButtons() {
    return Row(
      children: [
        BlocBuilder<QuizzCubit, QuizzState>(
          builder: (context, state) {
            if (state is QuizLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            } else if (state is QuizzLoaded || state is QuizzAnswered) {
              return Row(
                children: [
                  TextButton(
                      child: Text('Vrai'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            BlocProvider.of<QuizzCubit>(context).vrai,
                      ),
                      onPressed: () {
                        if (!BlocProvider.of<QuizzCubit>(context).aRepondu) {
                          if (_checkAnswer(true, context)) {
                            BlocProvider.of<QuizzCubit>(context)
                                .changeButtonsColor(Colors.green, Colors.grey);
                            const snackBar = SnackBar(
                              content: Text('Bien joué!'),
                              duration: Duration(seconds: 1),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            BlocProvider.of<QuizzCubit>(context)
                                .changeButtonsColor(Colors.red, Colors.grey);
                          }
                        }
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    child: Text('Faux'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          BlocProvider.of<QuizzCubit>(context).faux,
                    ),
                    onPressed: () {
                      if (!Provider.of<QuizzCubit>(context, listen: false)
                          .aRepondu) {
                        if (_checkAnswer(false, context)) {
                          BlocProvider.of<QuizzCubit>(context)
                              .changeButtonsColor(Colors.grey, Colors.green);

                          const snackBar = SnackBar(
                            content: Text('Bien joué!'),
                            duration: Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          BlocProvider.of<QuizzCubit>(context)
                              .changeButtonsColor(Colors.grey, Colors.red);
                        }
                      }
                    },
                  ),
                ],
              );
            }
            return Text('erreur dans getButtons');
          },
        ),
        SizedBox(
          width: 10,
        ),
        ElevatedButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey[600],
          ),
          icon: const Icon(
            Icons.arrow_forward_outlined,
          ),
          label: Text('Question suivante'),
          onPressed: () {
            if (!Provider.of<QuizzCubit>(context, listen: false)
                    .nextQuestionAvailable() &&
                Provider.of<QuizzCubit>(context, listen: false).aRepondu) {
              Navigator.pushNamed(context, '/resultats');
            } else {
              if (Provider.of<QuizzCubit>(context, listen: false).aRepondu) {
                context.read<QuizzCubit>().nextQuestion();
              } else {
                const snackBar = SnackBar(
                  content:
                      Text('Veuillez répondre avant de changer de question !'),
                  duration: Duration(seconds: 1),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }
          },
        ),
      ],
    );
  }

  bool _checkAnswer(bool userChoice, BuildContext context) {
    bool response =
        Provider.of<QuizzCubit>(context, listen: false).question!.isCorrect;

    if (response == userChoice) {
      context.read<QuizzCubit>().augmenterBonnesReponses();
    }
    return response == userChoice;
  }
}
