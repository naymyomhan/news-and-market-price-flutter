import 'package:flutter/material.dart';
import 'package:news_app/models/global_news_model.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/navigation_utils.dart';
import 'package:news_app/view_models/global_news_view_model.dart';
import 'package:news_app/views/widgets/global_news_widget.dart';
import 'package:news_app/views/widgets/news_loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GlobalNewsPage extends StatefulWidget {
  const GlobalNewsPage({super.key});

  @override
  State<GlobalNewsPage> createState() => _GlobalNewsPageState();
}

class _GlobalNewsPageState extends State<GlobalNewsPage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Scroll controller
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        final globalNewsProvider = Provider.of<GlobalNewsViewModel>(context, listen: false);
        if (globalNewsProvider.hasMore) {
          globalNewsProvider.loadMore();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalNewsViewModel globalNewsViewModel = context.watch<GlobalNewsViewModel>();
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
        globalNewsViewModel.loading
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
                    return globalNewsViewModel.refresh();
                  },
                  child: ListView.builder(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: globalNewsViewModel.globalNewsList.length,
                    itemBuilder: (context, index) {
                      GlobalNewsModelList globalNews = globalNewsViewModel.globalNewsList[index];
                      return GlobalNewsWidget(
                        globalNews: globalNews,
                        onTap: () {
                          globalNewsViewModel.setSelectedGlobalNews(globalNews);
                          openGlobalNewsDetails(context);
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
