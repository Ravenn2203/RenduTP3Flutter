import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp2/business_logic/cubits/creation_cubit.dart';

import '../../business_logic/cubits/answer_cubit.dart';

class QuizzThemePage extends StatelessWidget {
  final int creationQuestion;

  const QuizzThemePage(this.creationQuestion, {Key? key}) : super(key: key);

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
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: BlocBuilder<CreationCubit, CreationState>(
          builder: (context, state) {
            if (state is CreationLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            } else if(state is CreationLoaded){
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.grey[600],
                      ),
                      icon: const Icon(
                        Icons.category_rounded,
                      ),
                      label: Text('Quizz sur le thème Disney'),
                      onPressed: () {
                        if(creationQuestion==0){
                          BlocProvider.of<QuizzCubit>(context).retrieveData('disney');
                          BlocProvider.of<QuizzCubit>(context).restartQuizz();
                          Navigator.pushNamed(context, '/quizz');
                        }else{
                          Navigator.pushNamed(context, '/creationQuestion');
                          BlocProvider.of<CreationCubit>(context).changeTheme('disney');
                        }
                      },
                    ),
                    ElevatedButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.grey[600],
                      ),
                      icon: const Icon(
                        Icons.category_rounded,
                      ),
                      label: Text('Quizz sur le thème des supers Héros'),
                      onPressed: () {
                        if(creationQuestion==0){
                          BlocProvider.of<QuizzCubit>(context).retrieveData('superHeros');
                          BlocProvider.of<QuizzCubit>(context).restartQuizz();
                          Navigator.pushNamed(context, '/quizz');
                        }else{
                          Navigator.pushNamed(context, '/creationQuestion');
                          BlocProvider.of<CreationCubit>(context).changeTheme('superHeros');
                        }
                      },
                    ),
                  ],
                ),
              );
            }
            return Text('erreur dans choix theme');
          },
        ),
      ),
    );

    /*if(creationQuestion == 0){
      return Text('coucou');
    }else{
      return Text('0');
    }*/
  }
}
