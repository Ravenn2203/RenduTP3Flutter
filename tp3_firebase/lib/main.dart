import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp2/business_logic/cubits/answer_cubit.dart';
import 'package:tp2/business_logic/cubits/creation_cubit.dart';
import 'package:tp2/presentation/widgets/creation_question_page.dart';
import 'package:tp2/presentation/widgets/home_page.dart';
import 'package:tp2/presentation/widgets/quizz_theme_page.dart';
import 'package:tp2/presentation/widgets/resultats_page.dart';
import 'presentation/widgets/quizz_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider<CreationCubit>(
      create: (context) => CreationCubit(),
    ),
    BlocProvider<QuizzCubit>(
      create: (context) => QuizzCubit(),
    ),
  ], child: MyTp2App()));
}


class MyTp2App extends StatelessWidget {
  const MyTp2App({Key? key}) : super(key: key);

  //Cette fonction build retourne un widget, un arbre de widget si besoin
  @override
  Widget build(BuildContext context) {
    //Application utilisant du material design
    return MaterialApp(
      title: 'Ma première application en Flutter !',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.green,
        ),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.purple)),
      ),
      //Le widget de la page d'accueil
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/themes' : (context) => QuizzThemePage(0),
        '/quizz': (context) => QuizzPage(),
        '/themesCreationQuestion' : (context) =>QuizzThemePage(1),
        '/resultats': (context) => ResultatsPage(),
        '/creationQuestion' : (context) => CreationQuestionPage(),
      },
    );
  }
}
