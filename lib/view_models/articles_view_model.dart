import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/articles_model.dart';
import 'package:news_app/service/api_service.dart';

class ArticlesViewModel extends ChangeNotifier {
  bool _loading = false;
  bool _hasMore = true;
  List<ArticleModelList> _articleList = [];
  final apiService = ApiService(Dio(BaseOptions(contentType: "application/json")));
  late ArticleModelList _selectedArticle;

  //request parms
  int currentPage = 1;
  int limit = 5;

  //Getters
  bool get loading => _loading;
  bool get hasMore => _hasMore;
  List<ArticleModelList> get articleList => _articleList;
  ArticleModelList get selectedArticle => _selectedArticle;

  ArticlesViewModel() {
    getArticles(currentPage, limit);
  }

  refresh() async {
    currentPage = 1;
    getArticles(currentPage, limit);
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setArticleList(List<ArticleModelList> articleList) async {
    _articleList = articleList;
  }

  addArticleList(List<ArticleModelList> articleList) async {
    _articleList.addAll(articleList);
    notifyListeners();
  }

  getArticles(int page, int limit) async {
    setLoading(true);
    try {
      var response = await apiService.getArticles('local', page: page, limit: limit);
      setArticleList(response.data);
    } catch (e) {
      print('Error: $e');
    }
    setLoading(false);
  }

  loadMore() async {
    if (_hasMore) {
      // setLoading(true);
      try {
        var response = await apiService.getArticles('local', page: currentPage + 1, limit: limit);
        addArticleList(response.data);
      } catch (e) {
        print('Error: $e');
      }
      // setLoading(false);
      currentPage++;
    }
  }

  setSelectedArticle(ArticleModelList article) {
    _selectedArticle = article;
  }
}
