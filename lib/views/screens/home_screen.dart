import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/views/pages/articles_page.dart';
import 'package:news_app/views/pages/global_news_page.dart';
import 'package:news_app/views/pages/global_prices_page.dart';
import 'package:news_app/views/pages/local_news_page.dart';
import 'package:news_app/views/pages/local_prices_page.dart';
import 'package:news_app/service/ads_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../service/api_service.dart';
import '../widgets/MenuWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageController = PageController(initialPage: 0);

  final apiService = ApiService(Dio(BaseOptions(contentType: "application/json")));

  String marqueeText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMarqueeText();
    AdsService.loadRewardedInterstitialAd();
  }

  Future<void> _getMarqueeText() async {
    try {
      final marquee = await apiService.getMarqueeText();

      print(marquee);
      setState(() {
        marqueeText = marquee.data.toString();
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void changePage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  height: 230 - 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: myPrimaryColor,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 160,
                        width: size.width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            MenuWidget(
                              menuName: AppLocalizations.of(context)!.localNews,
                              iconName: "local_news",
                              menuIndex: 0,
                              changeCurrentPage: changePage,
                            ),
                            MenuWidget(
                              menuName: AppLocalizations.of(context)!.globalNews,
                              iconName: "global_news",
                              menuIndex: 1,
                              changeCurrentPage: changePage,
                            ),
                            MenuWidget(
                              menuName: AppLocalizations.of(context)!.articles,
                              iconName: "articles",
                              menuIndex: 2,
                              changeCurrentPage: changePage,
                            ),
                            MenuWidget(
                              menuName: AppLocalizations.of(context)!.localPrices,
                              iconName: "local_prices",
                              menuIndex: 3,
                              changeCurrentPage: changePage,
                            ),
                            MenuWidget(
                              menuName: AppLocalizations.of(context)!.globalPrices,
                              iconName: "global_prices",
                              menuIndex: 4,
                              changeCurrentPage: changePage,
                            ),
                            const SizedBox(width: 30),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: size.width,
              // color: Colors.white,
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => {
                  print("Current Page" + index.toString()),
                },
                children: [
                  LocalNewsPage(),
                  GlobalNewsPage(),
                  ArticlePage(),
                  LocalPricesPage(),
                  GlobalPricesPage(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
