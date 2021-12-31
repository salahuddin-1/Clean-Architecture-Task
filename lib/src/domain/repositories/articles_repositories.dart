import '../../core/params/article_request.dart';
import '../../core/resources/data_state.dart';
import '../entities/article.dart';

abstract class ArticlesRepository {
  Future<DataState<List<Article>>> getBreakingNewsArticle(
    ArticleRequestParams params,
  );
}
