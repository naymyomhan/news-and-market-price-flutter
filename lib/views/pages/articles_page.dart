import 'package:flutter/material.dart';
import 'package:news_app/models/articles_model.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/navigation_utils.dart';
import 'package:news_app/view_models/articles_view_model.dart';
import 'package:news_app/views/widgets/article_widget.dart';
import 'package:news_app/views/widgets/news_loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Scroll controller
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        final articleProvider = Provider.of<ArticlesViewModel>(context, listen: false);
        if (articleProvider.hasMore) {
          articleProvider.loadMore();
        }
      }
    });
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
            AppLocalizations.of(context)!.articles,
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
                  onRefresh: () {
                    return articlesViewModel.refresh();
                  },
                  child: ListView.builder(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: articlesViewModel.articleList.length,
                    itemBuilder: (context, index) {
                      ArticleModelList article = articlesViewModel.articleList[index];
                      return ArticleWidget(
                        article: article,
                        onTap: () {
                          articlesViewModel.setSelectedArticle(article);
                          openArticleDetails(context);
                        },
                      );
                    },
                  ),
                ),
              ),
      ],
    );
  }
}
