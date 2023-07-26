import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:news_app/providers/locale_provider.dart';
import 'package:news_app/view_models/articles_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/utils/constants.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'views/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("e01cd7ba-c9bb-4bf0-8c74-9d51ca6cd98b");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission : $accepted");
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: AppMainWidget(),
    );
  }
}

class AppMainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ArticlesViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News',
        theme: ThemeData(
          primaryColor: myPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: myTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: localeProvider.locale,
        home: HomeScreen(),
      ),
    );
  }

  static void setLocale(BuildContext context, Locale newLocale, String languageString) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    localeProvider.setLocale(newLocale, languageString);
  }
}
