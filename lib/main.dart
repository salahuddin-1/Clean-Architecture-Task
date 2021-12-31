import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/core/utils/constants.dart';
import 'src/injector.dart';
import 'src/presentation/blocs/remote_articles/remote_articles_bloc.dart';
import 'src/presentation/views/breaking_news_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (_) => injector()..add(const GetArticles()),
      child: MaterialApp(
        title: kMaterialAppTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BreakingNewsView(),
      ),
    );
  }
}
