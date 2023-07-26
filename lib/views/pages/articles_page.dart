import 'package:flutter/material.dart';
import 'package:news_app/models/articles_model.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/view_models/articles_view_model.dart';
import 'package:news_app/views/widgets/news_loading_widget.dart';
import 'package:news_app/views/widgets/news_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final scrollController = ScrollController();
  Future refersh() async {
    print("Refresh");
  }

  @override
  Widget build(BuildContext context) {
    ArticlesViewModel articlesViewModel = context.watch<ArticlesViewModel>();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Text(
            AppLocalizations.of(context)!.globalNews,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: mySoftTextColor,
            ),
          ),
        ),
        const SizedBox(height: 20),
        articlesViewModel.loading
            ? Column(
                children: const [
                  NewsLoadingWidget(),
                  NewsLoadingWidget(),
                  NewsLoadingWidget(),
                ],
              )
            : Expanded(
                child: RefreshIndicator(
                  onRefresh: refersh,
                  child: ListView.builder(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: articlesViewModel.articleList.length,
                    itemBuilder: (context, index) {
                      return NewsWidget(
                        title: articlesViewModel.articleList[index].title,
                        description: articlesViewModel.articleList[index].description,
                        newsDetails: articlesViewModel.articleList[index].newsDetails,
                        imageUrl: articlesViewModel.articleList[index].imageUrl,
                        newsType: articlesViewModel.articleList[index].newsType,
                        createdAt: articlesViewModel.articleList[index].createdAt,
                      );
                    },
                  ),
                ),
              ),
      ],
    );
  }

  // _ui(ArticlesViewModel articlesViewModel) {
  //   // if (articlesViewModel.loading) {
  //   //   return Container(
  //   //     width: double.infinity,
  //   //     height: 200,
  //   //     color: Colors.blue,
  //   //   );
  //   // }
  //   //TODO::error handeling

  //   return Expanded(
  //     child: ListView.separated(
  //       itemBuilder: ((context, index) {
  //         ArticlesModel articleModel = articlesViewModel.articleList[index];
  //         return Container(
  //           color: Colors.red,
  //           height: 100,
  //           width: double.infinity,
  //           child: Column(children: [
  //             Text(
  //               articleModel.message,
  //               style: TextStyle(
  //                 color: Colors.black,
  //               ),
  //             ),
  //           ]),
  //         );
  //       }),
  //       separatorBuilder: (context, index) => Divider(),
  //       itemCount: articlesViewModel.articleList.length,
  //     ),
  //   );
  // }
}
