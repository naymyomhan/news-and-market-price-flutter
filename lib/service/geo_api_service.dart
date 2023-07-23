import 'package:dio/dio.dart';
import 'package:news_app/models/cities_model.dart';
import 'package:news_app/models/countries_model.dart';
import 'package:retrofit/http.dart';

part 'geo_api_service.g.dart';

@RestApi(baseUrl: 'https://countriesnow.space/api/v0.1/')
abstract class GeoApiService {
  factory GeoApiService(Dio dio, {String baseUrl}) = _GeoApiService;

  @GET('countries')
  Future<CountriesModel> getCountries();

  @GET('countries/state/cities/q')
  Future<CitiesModel> getCities({
    @Query('country') String? country,
    @Query('state') String? state,
  });
}
