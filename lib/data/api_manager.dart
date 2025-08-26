import 'package:dio/dio.dart';
import 'package:news_app/data/model/articles.dart';
import 'package:news_app/data/model/articles_response.dart';
import 'package:news_app/data/model/sources_dm.dart';
import 'package:news_app/data/model/source_response.dart';

class ApiManager {
  final String _apiKey = '27817f9a16504b1683eed5baf0c904fb';
  final String _baseUrl = "https://newsapi.org/v2";
  late Dio dio;
  ApiManager() {
    dio = Dio(
      BaseOptions(queryParameters: {"apiKey": _apiKey}, baseUrl: _baseUrl),
    );
  }
  Future<List<SourceDm>?> loadSource(String category) async {
    Response response = await dio.get(
      "$_baseUrl/top-headlines/sources",
      queryParameters: {"category": category},
    );
    try {
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        SourceResponse myResponse = SourceResponse.fromJson(response.data);
        return myResponse.sources;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<List<Article>?> loadArticles(String sourceId) async {
    Response articles = await dio.get(
      "$_baseUrl/everything",
      queryParameters: {"sources": sourceId},
    );
    try {
      if (articles.statusCode! >= 200 && articles.statusCode! < 300) {
        ArticlesResponse myResponse = ArticlesResponse.fromJson(articles.data);
        return myResponse.articles;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<List<Article>?> searchArticles({String query = ""}) async {
    final searchQuery = query.isEmpty ? "news" : query;
    Response articles = await dio.get(
      "$_baseUrl/everything",
      queryParameters: {"q": searchQuery},
    );

    try {
      if (articles.statusCode! >= 200 && articles.statusCode! < 300) {
        ArticlesResponse myResponse = ArticlesResponse.fromJson(articles.data);
        return myResponse.articles;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
