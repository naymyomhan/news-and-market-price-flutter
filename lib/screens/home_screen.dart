import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:news_app/helpers/constants.dart';
import 'package:news_app/pages/global_news_page.dart';
import 'package:news_app/pages/global_prices_page.dart';
import 'package:news_app/pages/local_news_page.dart';
import 'package:news_app/pages/local_prices_page.dart';
import 'package:provider/provider.dart';

import '../widgets/MenuWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageController = PageController(initialPage: 0);

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
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  height: 250 - 60,
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
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 50,
                        width: size.width,
                        child: Marquee(
                          text: 'Placeholder Text for moving text message.              ',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        height: 150,
                        width: size.width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            MenuWidget(
                              menuName: "Local News",
                              iconName: "local_news",
                              menuIndex: 0,
                              changeCurrentPage: changePage,
                            ),
                            MenuWidget(
                              menuName: "Global News",
                              iconName: "global_news",
                              menuIndex: 1,
                              changeCurrentPage: changePage,
                            ),
                            MenuWidget(
                              menuName: "Local Prices",
                              iconName: "local_prices",
                              menuIndex: 2,
                              changeCurrentPage: changePage,
                            ),
                            MenuWidget(
                              menuName: "Global Prices",
                              iconName: "global_prices",
                              menuIndex: 3,
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
