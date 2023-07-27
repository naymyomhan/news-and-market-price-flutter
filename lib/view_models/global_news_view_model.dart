import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/global_news_model.dart';
import 'package:news_app/service/api_service.dart';

class GlobalNewsViewModel extends ChangeNotifier {
  bool _loading = false;
  bool _hasMore = true;
  List<GlobalNewsModelList> _globalNewsList = [];
  final apiService = ApiService(Dio(BaseOptions(contentType: "application/json")));
  late GlobalNewsModelList _selectedGlobalNews;

  //request parms
  int currentPage = 1;
  int limit = 5;

  //Getters
  bool get loading => _loading;
  bool get hasMore => _hasMore;
  List<GlobalNewsModelList> get globalNewsList => _globalNewsList;
  GlobalNewsModelList get selectedGlobalNews => _selectedGlobalNews;

  GlobalNewsViewModel() {
    getGlobalNews(currentPage, limit);
  }

  refresh() async {
    currentPage = 1;
    getGlobalNews(currentPage, limit);
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setGlobalNewsList(List<GlobalNewsModelList> globalNewsList) async {
    _globalNewsList = globalNewsList;
  }

  addGlobalNewsList(List<GlobalNewsModelList> globalNewsList) async {
    _globalNewsList.addAll(globalNewsList);
    notifyListeners();
  }

  getGlobalNews(int page, int limit) async {
    setLoading(true);
    try {
      var response = await apiService.getGlobalNews('global', page: page, limit: limit);
      setGlobalNewsList(response.data);
    } catch (e) {
      print('Error: $e');
    }
    setLoading(false);
  }

  loadMore() async {
    if (_hasMore) {
      // setLoading(true);
      try {
        var response = await apiService.getGlobalNews('global', page: currentPage + 1, limit: limit);
        addGlobalNewsList(response.data);
      } catch (e) {
        print('Error: $e');
      }
      // setLoading(false);
      currentPage++;
    }
  }

  setSelectedGlobalNews(GlobalNewsModelList globalNews) {
    _selectedGlobalNews = globalNews;
  }
}
