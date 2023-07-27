import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/local_news_model.dart';
import 'package:news_app/service/api_service.dart';

class LocalNewsViewModel extends ChangeNotifier {
  bool _loading = false;
  bool _hasMore = true;
  List<LocalNewsModelList> _localNewsList = [];
  final apiService = ApiService(Dio(BaseOptions(contentType: "application/json")));
  late LocalNewsModelList _selectedLocalNews;

  //request parms
  int currentPage = 1;
  int limit = 5;

  //Getters
  bool get loading => _loading;
  bool get hasMore => _hasMore;
  List<LocalNewsModelList> get localNewsList => _localNewsList;
  LocalNewsModelList get selectedLocalNews => _selectedLocalNews;

  LocalNewsViewModel() {
    getUsers(currentPage, limit);
  }

  refresh() async {
    currentPage = 1;
    getUsers(currentPage, limit);
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setLocalNewsList(List<LocalNewsModelList> localNewsList) async {
    _localNewsList = localNewsList;
  }

  addLocalNewsList(List<LocalNewsModelList> localNewsList) async {
    _localNewsList.addAll(localNewsList);
    notifyListeners();
  }

  getUsers(int page, int limit) async {
    setLoading(true);
    try {
      var response = await apiService.getLocalNews('local', page: page, limit: limit);
      setLocalNewsList(response.data);
    } catch (e) {
      print('Error: $e');
    }
    setLoading(false);
  }

  loadMore() async {
    if (_hasMore) {
      // setLoading(true);
      try {
        var response = await apiService.getLocalNews('local', page: currentPage + 1, limit: limit);
        addLocalNewsList(response.data);
      } catch (e) {
        print('Error: $e');
      }
      // setLoading(false);
      currentPage++;
    }
  }

  setSelectedLocalNews(LocalNewsModelList localNews) {
    _selectedLocalNews = localNews;
  }
}
