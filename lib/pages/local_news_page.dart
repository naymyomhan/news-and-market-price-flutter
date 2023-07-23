import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helpers/constants.dart';

import '../service/api_service.dart';
import '../widgets/news_widget.dart';

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
    return isLoading
        ? Container(
            child: Text("LOading"),
          )
        : Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Global News",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: mySoftTextColor,
                      ),
                    ),
                    DropdownButton(
                      hint: Text(
                        "🇲🇲 မြန်မာ",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          child: Text(
                            "🇲🇲 မြန်မာ",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "🇻🇬 English",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          value: 2,
                        ),
                      ],
                      onChanged: (value) {
                        print(value);
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
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
