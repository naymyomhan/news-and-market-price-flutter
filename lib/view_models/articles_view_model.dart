import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/articles_model.dart';
import 'package:news_app/service/api_service.dart';

class ArticlesViewModel extends ChangeNotifier {
  bool _loading = false;
  List<ArticleModelList> _articleList = [];

  bool get loading => _loading;
  List<ArticleModelList> get articleList => _articleList;

  final apiService = ApiService(Dio(BaseOptions(contentType: "application/json")));

  ArticlesViewModel() {
    getUsers();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setArticleList(List<ArticleModelList> articleList) async {
    _articleList = articleList;
    //already notified in setLoading!
  }

  getUsers() async {
    setLoading(true);
    var response = await apiService.getArticles('local');

    print(response.toJson());

    //if response is success
    setArticleList(response.data as List<ArticleModelList>);

    //TODO: if response is failure

    setLoading(false);
  }
}
