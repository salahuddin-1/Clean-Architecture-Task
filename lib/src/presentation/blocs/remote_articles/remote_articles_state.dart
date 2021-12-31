part of 'remote_articles_bloc.dart';

abstract class RemoteArticlesState extends Equatable {
  const RemoteArticlesState({
    this.articles,
    this.noMoreData,
    this.error,
  });

  final List<Article>? articles;
  final bool? noMoreData;

  final DioError? error;

  @override
  List<Object> get props => [articles!, error!, noMoreData!];
}

class RemoteArticlesLoading extends RemoteArticlesState {
  const RemoteArticlesLoading();
}

class RemoteArticlesDone extends RemoteArticlesState {
  const RemoteArticlesDone(List<Article> articles, {bool? noMoreData})
      : super(
          articles: articles,
          noMoreData: noMoreData,
        );
}

class RemoteArticlesError extends RemoteArticlesState {
  const RemoteArticlesError(DioError error) : super(error: error);
}

class RemoteArticlesInitial extends RemoteArticlesState {}
