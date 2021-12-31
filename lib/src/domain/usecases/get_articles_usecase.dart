import '../../core/params/article_request.dart';
import '../../core/resources/data_state.dart';
import '../../core/usecases/usecase.dart';
import '../entities/article.dart';
import '../repositories/articles_repositories.dart';

class GetArticlesUsecase
    implements UseCase<DataState<List<Article>>, ArticleRequestParams> {
  // CONSTRUCTOR
  const GetArticlesUsecase(this._articlesRepository);

  final ArticlesRepository _articlesRepository;

  @override
  Future<DataState<List<Article>>> call({ArticleRequestParams? params}) {
    return _articlesRepository.getBreakingNewsArticle(params!);
  }
}
