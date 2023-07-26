import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/main.dart';

import '../../service/api_service.dart';
import '../widgets/news_loading_widget.dart';
import '../widgets/news_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalNewsPage extends StatefulWidget {
  const LocalNewsPage({super.key});

  @override
  State<LocalNewsPage> createState() => _LocalNewsPageState();
}

class _LocalNewsPageState extends State<LocalNewsPage> {
  bool isLoading = true;
  bool isFetching = false;
  List localNewsList = [];
  int page = 1;
  int limit = 5;
  bool hasMore = true;

  String _selectedLanguage = 'my';

  final scrollController = ScrollController();
  final apiService = ApiService(Dio(BaseOptions(contentType: "application/json")));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocalNews();

    //Scroll controller
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        _getLocalNews();
      }
    });
  }

  Future<void> _getLocalNews() async {
    try {
      final localNews = await apiService.getNews('local', page: page, limit: limit);
      setState(() {
        localNewsList = List.from(localNewsList)..addAll(localNews.data);
        isLoading = false;
        page++;
        isFetching = false;
        if (localNews.data.length < limit) {
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
      localNewsList.clear();
      isLoading = true;
    });

    _getLocalNews();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.localNews,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: mySoftTextColor,
                ),
              ),
              DropdownButton(
                hint: Text(
                  _selectedLanguage == 'my' ? "🇲🇲 မြန်မာ" : "🇻🇬 English",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                value: _selectedLanguage,
                items: const [
                  DropdownMenuItem(
                    value: "my",
                    child: Text(
                      "🇲🇲 မြန်မာ",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "en",
                    child: Text(
                      "🇻🇬 English",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value.toString(); // Update the selected language
                  });
                  AppMainWidget.setLocale(context, Locale(value.toString(), ''), value.toString());
                },
              )
            ],
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
                    itemCount: localNewsList.length,
                    itemBuilder: (context, index) {
                      return NewsWidget(
                        title: localNewsList[index].title,
                        description: localNewsList[index].description,
                        newsDetails: localNewsList[index].newsDetails,
                        imageUrl: localNewsList[index].imageUrl,
                        newsType: localNewsList[index].newsType,
                        createdAt: localNewsList[index].createdAt,
                      );
                    },
                  ),
                ),
              ),
      ],
    );
  }
}
