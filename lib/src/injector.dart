import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/remote/news_api_service.dart';
import 'data/repositories/articles_repository_imp.dart';
import 'domain/repositories/articles_repositories.dart';
import 'domain/usecases/get_articles_usecase.dart';
import 'presentation/blocs/remote_articles/remote_articles_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio client
  injector.registerSingleton<Dio>(Dio());

  // Dependencies
  injector.registerSingleton<NewsApiService>(NewsApiService(injector()));
  injector.registerSingleton<ArticlesRepository>(
    ArticlesRepositoryImpl(injector()),
  );

  // UseCases
  injector.registerSingleton<GetArticlesUsecase>(
    GetArticlesUsecase(injector()),
  );

  // Blocs
  injector.registerFactory<RemoteArticlesBloc>(
    () => RemoteArticlesBloc(injector()),
  );
}
