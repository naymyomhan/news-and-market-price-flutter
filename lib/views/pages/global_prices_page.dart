import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/service/geo_api_service.dart';

import '../../utils/constants.dart';
import '../../service/api_service.dart';
import '../widgets/price_list_chart.dart';
import '../widgets/selectable_list_loading_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GlobalPricesPage extends StatefulWidget {
  const GlobalPricesPage({super.key});

  @override
  State<GlobalPricesPage> createState() => _GlobalPricesPageState();
}

class _GlobalPricesPageState extends State<GlobalPricesPage> {
  //Controllers
  final scrollController = ScrollController();

  //Page Status
  bool isLoading = true;
  int currentPageIndex = 0;

  //Selected Data
  String selectedCountry = "";
  String selectedCity = "";
  String selectedItem = "";

  //INITIAL LISTS
  List globalPriceList = [];
  List itemList = [];

  List countryList = [];
  List cityList = [];

  //API SERVICES
  final apiService = ApiService(Dio(BaseOptions(contentType: "application/json")));
  final geoApiService = GeoApiService(
    Dio(
      BaseOptions(
        contentType: "application/json",
        headers: {
          "Accept": "application/json",
        },
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _getItems();
    _getCountries();
  }

  Future<void> _getCountries() async {
    try {
      final countries = await geoApiService.getCountries();

      setState(() {
        countryList = countries.data;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _getItems() async {
    try {
      final items = await apiService.getItems();
      setState(() {
        itemList = items.data;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _getGlobalPrices(String country, String city, String itemName) async {
    if (selectedCountry != "" || selectedCity != "") {
      try {
        final globalPrices = await apiService.getGlobalPrices(country, city, itemName);
        setState(() {
          globalPriceList = globalPrices.data;
          isLoading = false;
        });
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Text(
            AppLocalizations.of(context)!.globalPrices,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: mySoftTextColor,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: IndexedStack(
            index: currentPageIndex,
            children: [
              isLoading
                  ? Column(
                      children: const [
                        SelectableListLoadingWidget(),
                        SelectableListLoadingWidget(),
                        SelectableListLoadingWidget(),
                        SelectableListLoadingWidget(),
                        SelectableListLoadingWidget(),
                      ],
                    )
                  : ListView.builder(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: countryList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentPageIndex = 1;
                              selectedCountry = countryList[index].country;
                              cityList = countryList[index].cities;
                            });
                          },
                          child: Container(
                            color: Colors.grey.shade300,
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            child: Text(countryList[index].country),
                          ),
                        );
                      },
                    ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              currentPageIndex = 0;
                              setState(() {
                                cityList = [];
                              });
                            });
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        Text(
                          selectedCountry,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: mySoftTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: isLoading
                        ? Column(
                            children: const [
                              SelectableListLoadingWidget(),
                              SelectableListLoadingWidget(),
                              SelectableListLoadingWidget(),
                              SelectableListLoadingWidget(),
                            ],
                          )
                        : ListView.builder(
                            controller: scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: cityList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentPageIndex = 2;
                                    selectedCity = cityList[index];
                                  });
                                },
                                child: Container(
                                  color: Colors.grey.shade300,
                                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                  child: Text(cityList[index]),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              currentPageIndex = 1;
                            });
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        Text(
                          "$selectedCountry / $selectedCity",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: mySoftTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: isLoading
                        ? Column(
                            children: const [
                              SelectableListLoadingWidget(),
                              SelectableListLoadingWidget(),
                              SelectableListLoadingWidget(),
                              SelectableListLoadingWidget(),
                            ],
                          )
                        : ListView.builder(
                            controller: scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: itemList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  _getGlobalPrices(selectedCountry, selectedCity, itemList[index]);
                                  setState(() {
                                    currentPageIndex = 3;
                                    isLoading = true;
                                    selectedItem = itemList[index];
                                  });
                                },
                                child: Container(
                                  color: Colors.grey.shade300,
                                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                  child: Text(itemList[index]),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              currentPageIndex = 2;
                              isLoading = false;
                            });
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        Text(
                          "$selectedCountry / $selectedCity / $selectedItem",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: mySoftTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  isLoading
                      ? Container(
                          color: Colors.grey.shade200,
                          height: MediaQuery.of(context).size.width - 60,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                        )
                      : PriceListChart(
                          localPriceList: globalPriceList,
                          isLocal: false,
                        ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
