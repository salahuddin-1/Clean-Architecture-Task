import 'package:clean_architecture_flutter/src/data/models/article_model.dart';

class BreakingNewsResponseModel {
  BreakingNewsResponseModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory BreakingNewsResponseModel.fromJson(Map<String, dynamic> json) {
    return BreakingNewsResponseModel(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int,
      articles: List<ArticleModel>.from(
        (json['articles'] as List<dynamic>).map(
          (e) => ArticleModel.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );
  }

  final String? status;
  final int? totalResults;
  final List<ArticleModel>? articles;
}
