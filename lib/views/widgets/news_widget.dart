import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/views/screens/home_screen.dart';
import 'package:news_app/views/screens/news_detail_screen.dart';
import 'package:news_app/views/widgets/news_list_image_error_widget.dart';
import 'package:news_app/views/widgets/news_list_image_loading_widget.dart';

import '../../utils/constants.dart';

class NewsWidget extends StatelessWidget {
  final String title;
  final String description;
  final String newsDetails;
  final String imageUrl;
  final String newsType;
  final String createdAt;

  const NewsWidget({
    super.key,
    required this.title,
    required this.description,
    required this.newsDetails,
    required this.imageUrl,
    required this.newsType,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return NewsDetailScreen(
            title: title,
            description: description,
            newsDetails: newsDetails,
            imageUrl: imageUrl,
            newsType: newsType,
            createdAt: createdAt,
          );
        }));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 140,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => const NewsListImageLoadingWidget(),
              errorWidget: (context, url, error) => const NewsListImageErrorWidget(),
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
                      newsType,
                      style: TextStyle(
                        color: mySoftTextColor,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      title,
                      maxLines: 4,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: myTextColor,
                      ),
                    ),
                    Text(
                      createdAt,
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
