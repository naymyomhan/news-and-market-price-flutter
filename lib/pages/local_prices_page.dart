import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:news_app/service/geo_api_service.dart';

import '../helpers/constants.dart';
import '../service/api_service.dart';
import '../widgets/price_list_chart.dart';
import '../widgets/selectable_list_loading_widget.dart';

class LocalPricesPage extends StatefulWidget {
  const LocalPricesPage({super.key});

  @override
  State<LocalPricesPage> createState() => _LocalPricesPageState();
}

class _LocalPricesPageState extends State<LocalPricesPage> {
  //Controllers
  final scrollController = ScrollController();

  //Page Status
  bool isLoading = false;
  int currentPageIndex = 0;

  //Selected Data
  String selectedState = "";
  String selectedCity = "";
  String selectedItem = "";

  //INITIAL LISTS
  List localPriceList = [];
  List stateList = [
    'Ayeyarwady Region',
    'Bago',
    'Chin State',
    'Kachin State',
    'Kayah State',
    'Kayin State',
    'Magway Region',
    'Mandalay Region',
    'Mon State',
    'Naypyidaw Union Territory',
    'Rakhine State',
    'Sagaing Region',
    'Shan State',
    'Tanintharyi Region',
    'Yangon Region',
  ];
  List cityList = [];
  List itemList = [];

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
  }

  Future<void> _getItems() async {
    try {
      final items = await apiService.getItems();
      setState(() {
        itemList = items.data;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _getCitiesOfState(String state) async {
    try {
      final cities = await geoApiService.getCities(country: 'myanmar', state: state);
      setState(() {
        cityList = cities.data;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _getLocalPrices(String state, String city, String itemName) async {
    print(itemName);
    if (selectedState != "" || selectedCity != "") {
      try {
        final localPrices = await apiService.getLocalPrices(state, city, itemName);
        setState(() {
          localPriceList = localPrices.data;
          isLoading = false;
        });
        // print(localPrices.toJson());
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  // Future<void> _getCountries() async {
  //   try {
  //     final countries = await geoApiService.getCountries();

  //     setState(() {
  //       countryList = countries.data;
  //     });
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: const Text(
            "Local Prices",
            style: TextStyle(
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
              ListView.builder(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: stateList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _getCitiesOfState(stateList[index]);
                      setState(() {
                        isLoading = true;
                        currentPageIndex = 1;
                        selectedState = stateList[index];
                      });
                    },
                    child: Container(
                      color: Colors.grey.shade300,
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(stateList[index]),
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
                          selectedState,
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
                          "$selectedState / $selectedCity",
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
                                  _getLocalPrices(selectedState, selectedCity, itemList[index]);
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
                          "$selectedState / $selectedCity / $selectedItem",
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
                          localPriceList: localPriceList,
                          isLocal: true,
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
