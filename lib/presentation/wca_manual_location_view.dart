import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaManualLocationView extends StatefulWidget {
  const WcaManualLocationView({super.key});

  @override
  State<WcaManualLocationView> createState() => _WcaManualLocationViewState();
}

class _WcaManualLocationViewState extends State<WcaManualLocationView> {
  String searchQuery = "";
  bool isSearching = false;
  List<Map<String, dynamic>> searchResults = [];

  final List<Map<String, dynamic>> popularCities = [
    {
      "name": "New York",
      "country": "United States",
      "state": "New York",
      "coordinates": "40.7128°N, 74.0060°W",
      "population": "8.3M",
      "icon": Icons.location_city,
    },
    {
      "name": "London", 
      "country": "United Kingdom",
      "state": "England",
      "coordinates": "51.5074°N, 0.1278°W",
      "population": "9.0M",
      "icon": Icons.location_city,
    },
    {
      "name": "Tokyo",
      "country": "Japan",
      "state": "Kanto",
      "coordinates": "35.6762°N, 139.6503°E",
      "population": "13.9M",
      "icon": Icons.location_city,
    },
    {
      "name": "Paris",
      "country": "France",
      "state": "Île-de-France",
      "coordinates": "48.8566°N, 2.3522°E",
      "population": "2.1M",
      "icon": Icons.location_city,
    },
    {
      "name": "Sydney",
      "country": "Australia",
      "state": "New South Wales",
      "coordinates": "33.8688°S, 151.2093°E",
      "population": "5.3M",
      "icon": Icons.location_city,
    },
  ];

  Future<void> _performSearch() async {
    if (searchQuery.trim().isEmpty) return;

    isSearching = true;
    setState(() {});

    // Simulate search API call
    await Future.delayed(Duration(seconds: 2));

    searchResults = popularCities
        .where((city) => 
            city["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
            city["country"].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    isSearching = false;
    setState(() {});
  }

  void _selectLocation(Map<String, dynamic> location) {
    // Navigate back with selected location
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Location"),
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search for a city or location",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        prefixIcon: Icon(Icons.search, color: disabledBoldColor),
                      ),
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                      onSubmitted: (value) => _performSearch(),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: _performSearch,
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isSearching) ...[
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: spXl),
                          CircularProgressIndicator(),
                          SizedBox(height: spMd),
                          Text(
                            "Searching locations...",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else if (searchQuery.isNotEmpty && searchResults.isNotEmpty) ...[
                    Text(
                      "Search Results",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    ...List.generate(searchResults.length, (index) {
                      final location = searchResults[index];
                      return _buildLocationItem(location);
                    }),
                  ] else if (searchQuery.isNotEmpty && searchResults.isEmpty && !isSearching) ...[
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: spXl),
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No locations found",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Try searching with a different term",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    Text(
                      "Popular Cities",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    ...List.generate(popularCities.length, (index) {
                      final location = popularCities[index];
                      return _buildLocationItem(location);
                    }),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationItem(Map<String, dynamic> location) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: GestureDetector(
        onTap: () => _selectLocation(location),
        child: Container(
          padding: EdgeInsets.all(spMd),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  location["icon"],
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${location["name"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${location["state"]}, ${location["country"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 14,
                          color: disabledColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${location["population"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: disabledColor,
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "${location["coordinates"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: disabledBoldColor,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
