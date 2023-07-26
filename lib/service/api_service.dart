import 'package:dio/dio.dart';
import 'package:news_app/models/articles_model.dart';
import 'package:news_app/models/global_price_model.dart';
import 'package:news_app/models/items_model.dart';
import 'package:news_app/models/local_price_model.dart';
import 'package:news_app/models/news_model.dart';
import 'package:retrofit/http.dart';

import '../utils/constants.dart';
import '../models/marquee_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('news/{type}')
  Future<NewsModel> getNews(
    @Path('type') String type, {
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  @GET('news/{type}')
  Future<ArticlesModel> getArticles(
    @Path('type') String type, {
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  @GET('prices/local/{state}/{city}/{item_name}')
  Future<LocalPriceModel> getLocalPrices(
    @Path('state') String state,
    @Path('city') String city,
    @Path('item_name') String type,
    // {
    // @Query('page') int? page,
    // @Query('limit') int? limit,
    // }
  );

  @GET('prices/global/{country}/{city}/{item_name}')
  Future<GlobalPriceModel> getGlobalPrices(
    @Path('country') String country,
    @Path('city') String city,
    @Path('item_name') String type,
    // {
    // @Query('page') int? page,
    // @Query('limit') int? limit,
    // }
  );

  @GET('items')
  Future<ItemsModel> getItems();

  @GET('marquee_text')
  Future<MarqueeModel> getMarqueeText();
}
