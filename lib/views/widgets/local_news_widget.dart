import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/articles_model.dart';
import 'package:news_app/models/local_news_model.dart';
import 'package:news_app/utils/navigation_utils.dart';
import 'package:news_app/views/screens/home_screen.dart';
import 'package:news_app/views/screens/news_detail_screen.dart';
import 'package:news_app/views/widgets/news_list_image_error_widget.dart';
import 'package:news_app/views/widgets/news_list_image_loading_widget.dart';

import '../../utils/constants.dart';

class LocalNewsWidget extends StatelessWidget {
  final LocalNewsModelList localNews;
  final VoidCallback onTap;

  const LocalNewsWidget({
    super.key,
    required this.localNews,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 140,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: localNews.imageUrl,
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
                      localNews.newsType,
                      style: TextStyle(
                        color: mySoftTextColor,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      localNews.title,
                      maxLines: 4,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: myTextColor,
                      ),
                    ),
                    Text(
                      localNews.createdAt,
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
