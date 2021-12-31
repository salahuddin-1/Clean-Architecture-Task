import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../core/bloc/bloc_with_state.dart';
import '../../../core/params/article_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../domain/entities/article.dart';
import '../../../domain/usecases/get_articles_usecase.dart';

part 'remote_articles_event.dart';
part 'remote_articles_state.dart';

class RemoteArticlesBloc
    extends BlocWithState<RemoteArticlesEvent, RemoteArticlesState> {
  RemoteArticlesBloc(this._getArticlesUsecase)
      : super(const RemoteArticlesLoading()) {
    on<GetArticles>(_getBreakingNewsArticle);
  }

  final GetArticlesUsecase _getArticlesUsecase;

  final List<Article> _articles = [];
  int _page = 1;
  static const int _pageSize = 20;

  Future<void> _getBreakingNewsArticle(
    GetArticles event,
    Emitter<RemoteArticlesState> emit,
  ) async {
    final dataState = await _getArticlesUsecase(
      params: ArticleRequestParams(page: _page),
    );

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      final articles = dataState.data;
      final noMoreData = articles!.length < _pageSize;
      _articles.addAll(articles);
      _page++;

      emit(RemoteArticlesDone(_articles, noMoreData: noMoreData));
    }

    if (dataState is DataFailed) {
      emit(RemoteArticlesError(dataState.error!));
    }
  }
}