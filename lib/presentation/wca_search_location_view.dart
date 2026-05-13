import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaSearchLocationView extends StatefulWidget {
  const WcaSearchLocationView({super.key});

  @override
  State<WcaSearchLocationView> createState() => _WcaSearchLocationViewState();
}

class _WcaSearchLocationViewState extends State<WcaSearchLocationView> {
  String searchQuery = "";
  String selectedFilter = "All";
  bool isLoading = false;

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Cities", "value": "Cities"},
    {"label": "Countries", "value": "Countries"},
    {"label": "Coordinates", "value": "Coordinates"},
    {"label": "Airports", "value": "Airports"},
    {"label": "Landmarks", "value": "Landmarks"},
  ];

  List<String> recentSearches = [
    "New York, NY",
    "London, UK",
    "Tokyo, Japan",
    "Sydney, Australia",
    "Paris, France",
  ];

  List<Map<String, dynamic>> searchResults = [
    {
      "name": "New York",
      "fullName": "New York, New York, United States",
      "type": "City",
      "country": "United States",
      "state": "New York",
      "latitude": 40.7128,
      "longitude": -74.0060,
      "population": 8398748,
      "timezone": "UTC-5",
      "elevation": 10,
      "isCapital": false,
      "isSaved": false,
    },
    {
      "name": "New York State",
      "fullName": "New York, United States",
      "type": "State",
      "country": "United States",
      "state": "New York",
      "latitude": 42.9538,
      "longitude": -75.5268,
      "population": 19453561,
      "timezone": "UTC-5",
      "elevation": 304,
      "isCapital": false,
      "isSaved": true,
    },
    {
      "name": "JFK Airport",
      "fullName": "John F. Kennedy International Airport, New York",
      "type": "Airport",
      "country": "United States",
      "state": "New York",
      "latitude": 40.6413,
      "longitude": -73.7781,
      "population": 0,
      "timezone": "UTC-5",
      "elevation": 4,
      "isCapital": false,
      "isSaved": false,
    },
    {
      "name": "Central Park",
      "fullName": "Central Park, New York, NY",
      "type": "Landmark",
      "country": "United States",
      "state": "New York",
      "latitude": 40.7829,
      "longitude": -73.9654,
      "population": 0,
      "timezone": "UTC-5",
      "elevation": 37,
      "isCapital": false,
      "isSaved": false,
    },
  ];

  List<Map<String, dynamic>> popularLocations = [
    {
      "name": "London",
      "country": "United Kingdom",
      "type": "City",
      "isCapital": true,
    },
    {
      "name": "Paris",
      "country": "France",
      "type": "City",
      "isCapital": true,
    },
    {
      "name": "Tokyo",
      "country": "Japan",
      "type": "City",
      "isCapital": true,
    },
    {
      "name": "Sydney",
      "country": "Australia",
      "type": "City",
      "isCapital": false,
    },
    {
      "name": "Berlin",
      "country": "Germany",
      "type": "City",
      "isCapital": true,
    },
    {
      "name": "Rome",
      "country": "Italy",
      "type": "City",
      "isCapital": true,
    },
  ];

  void _performSearch() {
    if (searchQuery.trim().isEmpty) return;
    
    isLoading = true;
    setState(() {});
    
    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      isLoading = false;
      setState(() {});
      ss("Found ${searchResults.length} results");
    });
  }

  void _clearSearch() {
    searchQuery = "";
    setState(() {});
  }

  void _selectLocation(Map<String, dynamic> location) {
    ss("Selected: ${location["name"]}");
    back();
  }

  void _addToFavorites(Map<String, dynamic> location, int index) {
    searchResults[index]["isSaved"] = !(searchResults[index]["isSaved"] as bool);
    setState(() {});
    
    if (searchResults[index]["isSaved"] as bool) {
      ss("Added ${location["name"]} to favorites");
    } else {
      ss("Removed ${location["name"]} from favorites");
    }
  }

  IconData _getLocationTypeIcon(String type) {
    switch (type) {
      case "City":
        return Icons.location_city;
      case "State":
      case "Country":
        return Icons.public;
      case "Airport":
        return Icons.flight;
      case "Landmark":
        return Icons.terrain;
      default:
        return Icons.place;
    }
  }

  Color _getLocationTypeColor(String type) {
    switch (type) {
      case "City":
        return primaryColor;
      case "State":
      case "Country":
        return infoColor;
      case "Airport":
        return warningColor;
      case "Landmark":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Location"),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              ss("Using current location");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Header
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search for a location",
                        value: searchQuery,
                        hint: "City, country, coordinates, or landmark",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: _performSearch,
                    ),
                    if (searchQuery.isNotEmpty) ...[
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.clear,
                        size: bs.sm,
                        onPressed: _clearSearch,
                      ),
                    ],
                  ],
                ),
                QDropdownField(
                  label: "Filter Results",
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Loading
                  if (isLoading)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: spSm),
                          Text(
                            "Searching locations...",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Search Results
                  if (!isLoading && searchQuery.isNotEmpty) ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.search_off, color: primaryColor),
                              SizedBox(width: spSm),
                              Text(
                                "Search Results (${searchResults.length})",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          ...searchResults.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> location = entry.value;
                            
                            return Container(
                              margin: EdgeInsets.only(bottom: spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: disabledOutlineBorderColor,
                                ),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(spSm),
                                leading: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: _getLocationTypeColor("${location["type"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    _getLocationTypeIcon("${location["type"]}"),
                                    color: _getLocationTypeColor("${location["type"]}"),
                                    size: 20,
                                  ),
                                ),
                                title: Text(
                                  "${location["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${location["fullName"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getLocationTypeColor("${location["type"]}").withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${location["type"]}",
                                            style: TextStyle(
                                              color: _getLocationTypeColor("${location["type"]}"),
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${location["latitude"]}, ${location["longitude"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        (location["isSaved"] as bool) ? Icons.favorite : Icons.favorite_border,
                                        color: (location["isSaved"] as bool) ? dangerColor : disabledBoldColor,
                                        size: 20,
                                      ),
                                      onPressed: () => _addToFavorites(location, index),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: disabledBoldColor,
                                    ),
                                  ],
                                ),
                                onTap: () => _selectLocation(location),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],

                  // Recent Searches
                  if (searchQuery.isEmpty && recentSearches.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.history, color: primaryColor),
                              SizedBox(width: spSm),
                              Text(
                                "Recent Searches",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  recentSearches.clear();
                                  setState(() {});
                                  ss("Recent searches cleared");
                                },
                                child: Text(
                                  "Clear All",
                                  style: TextStyle(
                                    color: dangerColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          ...recentSearches.map((search) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spXs),
                              child: GestureDetector(
                                onTap: () {
                                  searchQuery = search;
                                  _performSearch();
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.history,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        search,
                                        style: TextStyle(
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),

                  // Popular Locations
                  if (searchQuery.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.trending_up, color: primaryColor),
                              SizedBox(width: spSm),
                              Text(
                                "Popular Locations",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          ...popularLocations.map((location) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spXs),
                              child: GestureDetector(
                                onTap: () {
                                  searchQuery = "${location["name"]}";
                                  _performSearch();
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      _getLocationTypeIcon("${location["type"]}"),
                                      size: 16,
                                      color: primaryColor,
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        "${location["name"]}, ${location["country"]}",
                                        style: TextStyle(
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    if (location["isCapital"] as bool)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: warningColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "CAPITAL",
                                          style: TextStyle(
                                            color: warningColor,
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    SizedBox(width: spXs),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
