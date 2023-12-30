import 'package:flutter/material.dart';
import 'package:news_app/views/screens/article_details_screen.dart';
import 'package:news_app/views/screens/global_news_details_screen.dart';
import 'package:news_app/views/screens/local_news_details_screen.dart';

void openArticleDetails(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ArticleDetailsScreen(),
    ),
  );
}

void openLocalNewsDetails(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const LocalNewsDetailsScreen(),
    ),
  );
}

void openGlobalNewsDetails(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const GlobalNewsDetailsScreen(),
    ),
  );
}
