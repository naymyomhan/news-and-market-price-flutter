import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/articles_model.dart';
import 'package:news_app/views/widgets/news_list_image_error_widget.dart';
import 'package:news_app/views/widgets/news_list_image_loading_widget.dart';

import '../../utils/constants.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleModelList article;
  final VoidCallback onTap;

  const ArticleWidget({
    super.key,
    required this.article,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 3,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: CachedNetworkImage(
                imageUrl: article.imageUrl,
                placeholder: (context, url) => const NewsListImageLoadingWidget(),
                errorWidget: (context, url, error) => const NewsListImageErrorWidget(),
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      article.newsType,
                      style: const TextStyle(
                        color: mySoftTextColor,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      article.title,
                      maxLines: 2,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: myTextColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      article.createdAt,
                      style: const TextStyle(
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
