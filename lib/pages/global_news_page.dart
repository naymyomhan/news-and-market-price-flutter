import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helpers/constants.dart';
import 'package:news_app/service/api_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/news_loading_widget.dart';
import '../widgets/news_widget.dart';

class GlobalNewsPage extends StatefulWidget {
  const GlobalNewsPage({super.key});

  @override
  State<GlobalNewsPage> createState() => _GlobalNewsPageState();
}

class _GlobalNewsPageState extends State<GlobalNewsPage> {
  bool isLoading = true;
  bool isFetching = false;
  List globalNewsList = [];
  int page = 1;
  int limit = 5;
  bool hasMore = true;

  final scrollController = ScrollController();
  final apiService = ApiService(Dio(BaseOptions(contentType: "application/json")));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getGlobalNews();

    //Scroll controller
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        _getGlobalNews();
      }
    });
  }

  Future<void> _getGlobalNews() async {
    try {
      final globalNews = await apiService.getNews('global', page: page, limit: limit);
      setState(() {
        globalNewsList = List.from(globalNewsList)..addAll(globalNews.data);
        isLoading = false;
        page++;
        isFetching = false;
        if (globalNews.data.length < limit) {
          hasMore = false;
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  Future refersh() async {
    setState(() {
      isFetching = false;
      hasMore = true;
      page = 1;
      globalNewsList.clear();
      isLoading = true;
    });

    _getGlobalNews();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Text(
            AppLocalizations.of(context)!.globalNews,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: mySoftTextColor,
            ),
          ),
        ),
        const SizedBox(height: 20),
        isLoading
            ? Column(
                children: const [
                  NewsLoadingWidget(),
                  NewsLoadingWidget(),
                  NewsLoadingWidget(),
                ],
              )
            : Expanded(
                child: RefreshIndicator(
                  onRefresh: refersh,
                  child: ListView.builder(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: globalNewsList.length,
                    itemBuilder: (context, index) {
                      return NewsWidget(
                        title: globalNewsList[index].title,
                        description: globalNewsList[index].description,
                        newsDetails: globalNewsList[index].newsDetails,
                        imageUrl: globalNewsList[index].imageUrl,
                        newsType: globalNewsList[index].newsType,
                        createdAt: globalNewsList[index].createdAt,
                      );
                    },
                  ),
                ),
              ),
      ],
    );
  }
}
