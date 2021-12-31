import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/constants.dart';
import '../../models/breaking_news_response_model.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: kBaseURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio, {String baseUrl}) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<BreakingNewsResponseModel>> getBreakingNewsArticles({
    @Query("apiKey") required String apiKey,
    @Query("country") required String country,
    @Query("category") required String category,
    @Query("page") required int page,
    @Query("pageSize") required int pageSize,
  });
}
