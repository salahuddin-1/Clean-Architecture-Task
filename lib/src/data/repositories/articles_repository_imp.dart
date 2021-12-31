import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/resources/data_state.dart';
import '../../core/params/article_request.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/articles_repositories.dart';
import '../datasources/remote/news_api_service.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  const ArticlesRepositoryImpl(this._newsApiService);

  final NewsApiService _newsApiService;

  @override
  Future<DataState<List<Article>>> getBreakingNewsArticle(
    ArticleRequestParams params,
  ) async {
    try {
      final httpResponse = await _newsApiService.getBreakingNewsArticles(
        apiKey: params.apiKey,
        country: params.country,
        category: params.category,
        page: params.page,
        pageSize: params.pageSize,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.articles!);
      }

      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
