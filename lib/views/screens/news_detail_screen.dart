import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/service/ads_service.dart';

class NewsDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final String newsDetails;
  final String imageUrl;
  final String newsType;
  final String createdAt;

  const NewsDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.newsDetails,
    required this.imageUrl,
    required this.newsType,
    required this.createdAt,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("EELEK");
    AdsService.showRewardedInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
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
                  widget.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                CachedNetworkImage(
                  imageUrl: widget.imageUrl,
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
                    widget.createdAt,
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
                  widget.newsDetails,
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
