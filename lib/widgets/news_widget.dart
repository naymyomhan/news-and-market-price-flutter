import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/news_detail_screen.dart';
import 'package:news_app/widgets/news_list_image_error_widget.dart';
import 'package:news_app/widgets/news_list_image_loading_widget.dart';

import '../helpers/constants.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return NewsDetailScreen();
        }));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 140,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://www.gamespot.com/a/uploads/square_medium/1601/16018044/4158211-gotg-vol-3-square.jpg",
              placeholder: (context, url) => const NewsListImageLoadingWidget(),
              errorWidget: (context, url, error) =>
                  const NewsListImageErrorWidget(),
              imageBuilder: (context, imageProvider) => Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Movies",
                      style: TextStyle(
                        color: mySoftTextColor,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "This is the new title and it may be long or short, I don't know so wtf",
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: myTextColor,
                      ),
                    ),
                    Text(
                      "May 22,2023",
                      style: TextStyle(
                        color: mySoftTextColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
