import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helpers/constants.dart';

import '../widgets/news_widget.dart';

class GlobalNewsPage extends StatefulWidget {
  const GlobalNewsPage({super.key});

  @override
  State<GlobalNewsPage> createState() => _GlobalNewsPageState();
}

class _GlobalNewsPageState extends State<GlobalNewsPage> {
  List localNewsList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Text(
            "Global News",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: mySoftTextColor,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: localNewsList.length,
            itemBuilder: (context, index) {
              return NewsWidget();
            },
          ),
        ),
      ],
    );
  }
}
