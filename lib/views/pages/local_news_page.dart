import 'package:flutter/material.dart';
import 'package:news_app/main.dart';
import 'package:news_app/models/local_news_model.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/navigation_utils.dart';
import 'package:news_app/view_models/local_news_view_model.dart';
import 'package:news_app/views/widgets/local_news_widget.dart';
import 'package:news_app/views/widgets/news_loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalNewsPage extends StatefulWidget {
  const LocalNewsPage({super.key});

  @override
  State<LocalNewsPage> createState() => _LocalNewsPageState();
}

class _LocalNewsPageState extends State<LocalNewsPage> {
  final scrollController = ScrollController();
  String _selectedLanguage = 'my';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Scroll controller
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        final localNewsProvider = Provider.of<LocalNewsViewModel>(context, listen: false);
        if (localNewsProvider.hasMore) {
          localNewsProvider.loadMore();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    LocalNewsViewModel localNewsViewModel = context.watch<LocalNewsViewModel>();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.localNews,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: mySoftTextColor,
                ),
              ),
              DropdownButton(
                hint: Text(
                  _selectedLanguage == 'my' ? "🇲🇲 မြန်မာ" : "🇻🇬 English",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                value: _selectedLanguage,
                items: const [
                  DropdownMenuItem(
                    value: "my",
                    child: Text(
                      "🇲🇲 မြန်မာ",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "en",
                    child: Text(
                      "🇻🇬 English",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value.toString(); // Update the selected language
                  });
                  AppMainWidget.setLocale(context, Locale(value.toString(), ''), value.toString());
                },
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        localNewsViewModel.loading
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
                    return localNewsViewModel.refresh();
                  },
                  child: ListView.builder(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: localNewsViewModel.localNewsList.length,
                    itemBuilder: (context, index) {
                      LocalNewsModelList localNews = localNewsViewModel.localNewsList[index];
                      return LocalNewsWidget(
                        localNews: localNews,
                        onTap: () {
                          localNewsViewModel.setSelectedLocalNews(localNews);
                          openLocalNewsDetails(context);
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
