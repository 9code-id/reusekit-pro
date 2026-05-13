import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaLocationsListView extends StatefulWidget {
  const WcaLocationsListView({super.key});

  @override
  State<WcaLocationsListView> createState() => _WcaLocationsListViewState();
}

class _WcaLocationsListViewState extends State<WcaLocationsListView> {
  String searchQuery = "";
  String selectedFilter = "All";
  bool showFavoriteOnly = false;
  bool sortByName = true;

  List<Map<String, dynamic>> filterItems = [
    {"label": "All Locations", "value": "All"},
    {"label": "Favorites", "value": "Favorites"},
    {"label": "Recent", "value": "Recent"},
    {"label": "Major Cities", "value": "Major Cities"},
  ];

  List<Map<String, dynamic>> locationData = [
    {
      "name": "Sydney",
      "country": "Australia",
      "state": "New South Wales",
      "coordinates": {"lat": -33.8688, "lng": 151.2093},
      "timezone": "AEST",
      "population": "5.3M",
      "isFavorite": true,
      "isRecent": true,
      "isMajorCity": true,
      "currentWeather": {
        "temperature": 22,
        "condition": "Partly Cloudy",
        "humidity": 65,
        "windSpeed": 15,
      },
      "lastUpdated": "2024-03-20 14:30",
      "alerts": ["Strong Wind Warning"],
    },
    {
      "name": "Melbourne",
      "country": "Australia",
      "state": "Victoria",
      "coordinates": {"lat": -37.8136, "lng": 144.9631},
      "timezone": "AEST",
      "population": "5.1M",
      "isFavorite": true,
      "isRecent": false,
      "isMajorCity": true,
      "currentWeather": {
        "temperature": 18,
        "condition": "Overcast",
        "humidity": 78,
        "windSpeed": 12,
      },
      "lastUpdated": "2024-03-20 14:25",
      "alerts": [],
    },
    {
      "name": "Brisbane",
      "country": "Australia",
      "state": "Queensland",
      "coordinates": {"lat": -27.4698, "lng": 153.0251},
      "timezone": "AEST",
      "population": "2.6M",
      "isFavorite": false,
      "isRecent": true,
      "isMajorCity": true,
      "currentWeather": {
        "temperature": 28,
        "condition": "Sunny",
        "humidity": 55,
        "windSpeed": 8,
      },
      "lastUpdated": "2024-03-20 14:35",
      "alerts": ["Heat Advisory"],
    },
    {
      "name": "Perth",
      "country": "Australia",
      "state": "Western Australia",
      "coordinates": {"lat": -31.9505, "lng": 115.8605},
      "timezone": "AWST",
      "population": "2.1M",
      "isFavorite": false,
      "isRecent": false,
      "isMajorCity": true,
      "currentWeather": {
        "temperature": 25,
        "condition": "Clear",
        "humidity": 42,
        "windSpeed": 18,
      },
      "lastUpdated": "2024-03-20 14:20",
      "alerts": [],
    },
    {
      "name": "Adelaide",
      "country": "Australia",
      "state": "South Australia",
      "coordinates": {"lat": -34.9285, "lng": 138.6007},
      "timezone": "ACST",
      "population": "1.4M",
      "isFavorite": true,
      "isRecent": false,
      "isMajorCity": true,
      "currentWeather": {
        "temperature": 21,
        "condition": "Partly Cloudy",
        "humidity": 60,
        "windSpeed": 14,
      },
      "lastUpdated": "2024-03-20 14:28",
      "alerts": [],
    },
    {
      "name": "Darwin",
      "country": "Australia",
      "state": "Northern Territory",
      "coordinates": {"lat": -12.4634, "lng": 130.8456},
      "timezone": "ACST",
      "population": "148K",
      "isFavorite": false,
      "isRecent": true,
      "isMajorCity": false,
      "currentWeather": {
        "temperature": 32,
        "condition": "Thunderstorms",
        "humidity": 88,
        "windSpeed": 22,
      },
      "lastUpdated": "2024-03-20 14:40",
      "alerts": ["Severe Thunderstorm Warning", "Flood Watch"],
    },
  ];

  List<Map<String, dynamic>> get filteredLocations {
    var filtered = locationData.where((location) {
      // Search filter
      bool matchesSearch = searchQuery.isEmpty ||
          location["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          location["state"].toString().toLowerCase().contains(searchQuery.toLowerCase());

      // Category filter
      bool matchesFilter = selectedFilter == "All" ||
          (selectedFilter == "Favorites" && location["isFavorite"] == true) ||
          (selectedFilter == "Recent" && location["isRecent"] == true) ||
          (selectedFilter == "Major Cities" && location["isMajorCity"] == true);

      return matchesSearch && matchesFilter;
    }).toList();

    // Sort locations
    if (sortByName) {
      filtered.sort((a, b) => a["name"].toString().compareTo(b["name"].toString()));
    } else {
      filtered.sort((a, b) => b["lastUpdated"].toString().compareTo(a["lastUpdated"].toString()));
    }

    return filtered;
  }

  Color _getConditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case "sunny":
      case "clear":
        return Colors.orange;
      case "partly cloudy":
        return Colors.blue[300]!;
      case "overcast":
      case "cloudy":
        return Colors.grey[600]!;
      case "thunderstorms":
        return Colors.purple;
      case "rain":
        return Colors.blue[700]!;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getConditionIcon(String condition) {
    switch (condition.toLowerCase()) {
      case "sunny":
      case "clear":
        return Icons.wb_sunny;
      case "partly cloudy":
        return Icons.wb_cloudy;
      case "overcast":
      case "cloudy":
        return Icons.cloud;
      case "thunderstorms":
        return Icons.thunderstorm;
      case "rain":
        return Icons.water_drop;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Locations"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('AddLocationView')
            },
          ),
          IconButton(
            icon: Icon(sortByName ? Icons.sort_by_alpha : Icons.access_time),
            onPressed: () {
              sortByName = !sortByName;
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
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
                        label: "Search locations...",
                        value: searchQuery,
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
                      onPressed: () {
                        // navigateTo('SearchLocationView')
                      },
                    ),
                  ],
                ),
                
                QDropdownField(
                  label: "Filter by",
                  items: filterItems,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          Expanded(
            child: filteredLocations.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_off,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No locations found",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Try adjusting your search or filters",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QButton(
                          label: "Add Location",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('AddLocationView')
                          },
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredLocations.length,
                    itemBuilder: (context, index) {
                      final location = filteredLocations[index];
                      final weather = location["currentWeather"] as Map<String, dynamic>;
                      final alerts = location["alerts"] as List;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: GestureDetector(
                          onTap: () {
                            // navigateTo('LocationDetailView', arguments: location)
                            si("Selected ${location["name"]}");
                          },
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                              border: Border.all(color: disabledOutlineBorderColor.withAlpha(50)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${location["name"]}",
                                                style: TextStyle(
                                                  fontSize: fsH6,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              if (location["isFavorite"] == true) ...[
                                                SizedBox(width: spXs),
                                                Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: Colors.amber,
                                                ),
                                              ],
                                            ],
                                          ),
                                          Text(
                                            "${location["state"]}, ${location["country"]}",
                                            style: TextStyle(
                                              color: disabledBoldColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              _getConditionIcon(weather["condition"]),
                                              color: _getConditionColor(weather["condition"]),
                                              size: 24,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${weather["temperature"]}°",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: _getConditionColor(weather["condition"]),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${weather["condition"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    
                                    SizedBox(width: spSm),
                                    
                                    IconButton(
                                      icon: Icon(Icons.more_vert),
                                      onPressed: () {
                                        _showLocationOptions(location);
                                      },
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spMd),
                                
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildWeatherInfo(
                                        Icons.water_drop,
                                        "Humidity",
                                        "${weather["humidity"]}%",
                                      ),
                                    ),
                                    Expanded(
                                      child: _buildWeatherInfo(
                                        Icons.air,
                                        "Wind",
                                        "${weather["windSpeed"]} km/h",
                                      ),
                                    ),
                                    Expanded(
                                      child: _buildWeatherInfo(
                                        Icons.schedule,
                                        "Updated",
                                        "${location["lastUpdated"]}".split(' ')[1],
                                      ),
                                    ),
                                  ],
                                ),
                                
                                if (alerts.isNotEmpty) ...[
                                  SizedBox(height: spMd),
                                  Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                      border: Border.all(color: warningColor.withAlpha(50)),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.warning,
                                          color: warningColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: spSm),
                                        Expanded(
                                          child: Text(
                                            alerts.length == 1
                                                ? "${alerts[0]}"
                                                : "${alerts.length} active alerts",
                                            style: TextStyle(
                                              color: warningColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo('AddLocationView')
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildWeatherInfo(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: disabledBoldColor,
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showLocationOptions(Map<String, dynamic> location) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
            SizedBox(height: spMd),
            
            Text(
              "${location["name"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Column(
              children: [
                _buildOptionItem(
                  Icons.star,
                  location["isFavorite"] == true ? "Remove from Favorites" : "Add to Favorites",
                  () {
                    Navigator.pop(context);
                    location["isFavorite"] = !(location["isFavorite"] == true);
                    setState(() {});
                    ss(location["isFavorite"] == true 
                        ? "Added to favorites"
                        : "Removed from favorites");
                  },
                ),
                _buildOptionItem(
                  Icons.edit,
                  "Edit Location",
                  () {
                    Navigator.pop(context);
                    // navigateTo('EditLocationView', arguments: location)
                  },
                ),
                _buildOptionItem(
                  Icons.share,
                  "Share Weather",
                  () {
                    Navigator.pop(context);
                    ss("Weather data shared");
                  },
                ),
                _buildOptionItem(
                  Icons.delete,
                  "Remove Location",
                  () async {
                    Navigator.pop(context);
                    bool isConfirmed = await confirm("Remove ${location["name"]} from your locations?");
                    if (isConfirmed) {
                      locationData.removeWhere((loc) => loc["name"] == location["name"]);
                      setState(() {});
                      ss("Location removed");
                    }
                  },
                  isDestructive: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spMd, horizontal: spSm),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? dangerColor : primaryColor,
              size: 20,
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isDestructive ? dangerColor : null,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: disabledBoldColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
