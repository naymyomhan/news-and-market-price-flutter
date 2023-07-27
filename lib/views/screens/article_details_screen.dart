import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/service/ads_service.dart';
import 'package:news_app/view_models/articles_view_model.dart';
import 'package:provider/provider.dart';

class ArticleDetailsScreen extends StatefulWidget {
  const ArticleDetailsScreen({
    super.key,
  });

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AdsService.showRewardedInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    ArticlesViewModel articlesViewModel = context.watch<ArticlesViewModel>();
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            color: Colors.grey.shade200,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Center(
                  child: Text(
                    "News Detail",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: mySoftTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Text(
                  articlesViewModel.selectedArticle.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                CachedNetworkImage(
                  imageUrl: articlesViewModel.selectedArticle.imageUrl,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => Container(),
                  imageBuilder: (context, imageProvider) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 1.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    articlesViewModel.selectedArticle.createdAt,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  articlesViewModel.selectedArticle.description,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
