import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaFavoriteLocationsView extends StatefulWidget {
  const WcaFavoriteLocationsView({super.key});

  @override
  State<WcaFavoriteLocationsView> createState() => _WcaFavoriteLocationsViewState();
}

class _WcaFavoriteLocationsViewState extends State<WcaFavoriteLocationsView> {
  String sortBy = "Name";
  String filterBy = "All";
  bool showWeatherData = true;
  bool isLoading = false;

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name (A-Z)", "value": "Name"},
    {"label": "Distance", "value": "Distance"},
    {"label": "Temperature", "value": "Temperature"},
    {"label": "Recently Added", "value": "Recent"},
    {"label": "Most Visited", "value": "Visits"},
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Locations", "value": "All"},
    {"label": "Cities", "value": "Cities"},
    {"label": "Countries", "value": "Countries"},
    {"label": "Airports", "value": "Airports"},
    {"label": "Landmarks", "value": "Landmarks"},
  ];

  List<Map<String, dynamic>> favoriteLocations = [
    {
      "id": "1",
      "name": "New York",
      "fullName": "New York, New York, United States",
      "type": "City",
      "country": "United States",
      "state": "New York",
      "latitude": 40.7128,
      "longitude": -74.0060,
      "distance": 0.0,
      "isDefault": true,
      "addedDate": "2025-01-15",
      "visitCount": 45,
      "weather": {
        "temperature": 22,
        "condition": "Sunny",
        "humidity": 65,
        "windSpeed": 8,
        "pressure": 1013,
        "uvIndex": 7,
        "icon": "sunny",
      },
      "alerts": [
        {"type": "UV", "level": "High"},
      ],
    },
    {
      "id": "2",
      "name": "London",
      "fullName": "London, England, United Kingdom",
      "type": "City",
      "country": "United Kingdom",
      "state": "England",
      "latitude": 51.5074,
      "longitude": -0.1278,
      "distance": 5570.2,
      "isDefault": false,
      "addedDate": "2025-02-10",
      "visitCount": 23,
      "weather": {
        "temperature": 12,
        "condition": "Rainy",
        "humidity": 82,
        "windSpeed": 15,
        "pressure": 995,
        "uvIndex": 2,
        "icon": "rainy",
      },
      "alerts": [
        {"type": "Rain", "level": "Moderate"},
      ],
    },
    {
      "id": "3",
      "name": "Tokyo",
      "fullName": "Tokyo, Japan",
      "type": "City",
      "country": "Japan",
      "state": "Tokyo",
      "latitude": 35.6762,
      "longitude": 139.6503,
      "distance": 10838.5,
      "isDefault": false,
      "addedDate": "2025-03-05",
      "visitCount": 18,
      "weather": {
        "temperature": 18,
        "condition": "Partly Cloudy",
        "humidity": 70,
        "windSpeed": 12,
        "pressure": 1018,
        "uvIndex": 5,
        "icon": "partly_cloudy",
      },
      "alerts": [],
    },
    {
      "id": "4",
      "name": "JFK Airport",
      "fullName": "John F. Kennedy International Airport, New York",
      "type": "Airport",
      "country": "United States",
      "state": "New York",
      "latitude": 40.6413,
      "longitude": -73.7781,
      "distance": 18.4,
      "isDefault": false,
      "addedDate": "2025-04-12",
      "visitCount": 12,
      "weather": {
        "temperature": 21,
        "condition": "Cloudy",
        "humidity": 68,
        "windSpeed": 10,
        "pressure": 1012,
        "uvIndex": 3,
        "icon": "cloudy",
      },
      "alerts": [
        {"type": "Wind", "level": "Advisory"},
      ],
    },
    {
      "id": "5",
      "name": "Sydney",
      "fullName": "Sydney, New South Wales, Australia",
      "type": "City",
      "country": "Australia",
      "state": "New South Wales",
      "latitude": -33.8688,
      "longitude": 151.2093,
      "distance": 15993.8,
      "isDefault": false,
      "addedDate": "2025-05-20",
      "visitCount": 8,
      "weather": {
        "temperature": 25,
        "condition": "Clear",
        "humidity": 55,
        "windSpeed": 14,
        "pressure": 1022,
        "uvIndex": 9,
        "icon": "sunny",
      },
      "alerts": [
        {"type": "UV", "level": "Very High"},
      ],
    },
  ];

  void _refreshWeatherData() {
    isLoading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      isLoading = false;
      setState(() {});
      ss("Weather data updated for all locations");
    });
  }

  void _removeFromFavorites(Map<String, dynamic> location) async {
    bool isConfirmed = await confirm("Remove ${location["name"]} from favorites?");
    if (isConfirmed) {
      favoriteLocations.removeWhere((loc) => loc["id"] == location["id"]);
      setState(() {});
      ss("Removed ${location["name"]} from favorites");
    }
  }

  void _setAsDefault(Map<String, dynamic> location) {
    // Reset all default flags
    for (var loc in favoriteLocations) {
      loc["isDefault"] = false;
    }
    // Set selected as default
    location["isDefault"] = true;
    setState(() {});
    ss("${location["name"]} set as default location");
  }

  IconData _getLocationTypeIcon(String type) {
    switch (type) {
      case "City":
        return Icons.location_city;
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

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case "sunny":
      case "clear":
        return Icons.wb_sunny;
      case "partly cloudy":
        return Icons.wb_cloudy;
      case "cloudy":
        return Icons.cloud;
      case "rainy":
        return Icons.grain;
      case "snow":
        return Icons.ac_unit;
      case "storm":
        return Icons.flash_on;
      default:
        return Icons.wb_cloudy;
    }
  }

  Color _getWeatherColor(String condition) {
    switch (condition.toLowerCase()) {
      case "sunny":
      case "clear":
        return warningColor;
      case "partly cloudy":
        return infoColor;
      case "cloudy":
        return disabledBoldColor;
      case "rainy":
        return primaryColor;
      case "snow":
        return Colors.lightBlue;
      case "storm":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getAlertColor(String type) {
    switch (type.toLowerCase()) {
      case "uv":
        return warningColor;
      case "rain":
        return primaryColor;
      case "wind":
        return infoColor;
      case "storm":
        return dangerColor;
      case "snow":
        return Colors.lightBlue;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Locations"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshWeatherData,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo ('WcaAddLocationView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filter and Sort Controls
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.tune, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Filter & Sort",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Sort By",
                          items: sortOptions,
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Filter",
                          items: filterOptions,
                          value: filterBy,
                          onChanged: (value, label) {
                            filterBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Show Weather Data",
                        "value": true,
                        "checked": showWeatherData,
                      }
                    ],
                    value: [
                      if (showWeatherData)
                        {
                          "label": "Show Weather Data",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showWeatherData = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Stats Summary
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
                  Text(
                    "Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Total Locations",
                          "${favoriteLocations.length}",
                          Icons.favorite,
                          dangerColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Countries",
                          "${favoriteLocations.map((e) => e["country"]).toSet().length}",
                          Icons.public,
                          infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Active Alerts",
                          "${favoriteLocations.where((loc) => (loc["alerts"] as List).isNotEmpty).length}",
                          Icons.warning,
                          warningColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Avg Temperature",
                          "${(favoriteLocations.map((e) => e["weather"]["temperature"] as int).reduce((a, b) => a + b) / favoriteLocations.length).toStringAsFixed(0)}°C",
                          Icons.device_thermostat,
                          primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Loading
            if (isLoading)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: spSm),
                    Text(
                      "Updating weather data...",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

            // Favorite Locations List
            if (!isLoading)
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
                        Icon(Icons.favorite, color: dangerColor),
                        SizedBox(width: spSm),
                        Text(
                          "Favorite Locations",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...favoriteLocations.map((location) {
                      Map<String, dynamic> weather = location["weather"] as Map<String, dynamic>;
                      List<dynamic> alerts = location["alerts"] as List<dynamic>;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (location["isDefault"] as bool) 
                            ? primaryColor.withAlpha(10) 
                            : Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: (location["isDefault"] as bool)
                              ? primaryColor.withAlpha(30)
                              : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Container(
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
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${location["name"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          if (location["isDefault"] as bool) ...[
                                            SizedBox(width: spXs),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: primaryColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "DEFAULT",
                                                style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      Text(
                                        "${location["country"]} • ${location["type"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (alerts.isNotEmpty)
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: _getAlertColor("${alerts[0]["type"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Icon(
                                      Icons.warning,
                                      color: _getAlertColor("${alerts[0]["type"]}"),
                                      size: 16,
                                    ),
                                  ),
                              ],
                            ),
                            
                            if (showWeatherData) ...[
                              Divider(height: 1),
                              Row(
                                children: [
                                  Icon(
                                    _getWeatherIcon("${weather["condition"]}"),
                                    color: _getWeatherColor("${weather["condition"]}"),
                                    size: 20,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "${weather["condition"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${weather["temperature"]}°C",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: _getWeatherColor("${weather["condition"]}"),
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.water_drop, size: 14, color: infoColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${weather["humidity"]}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(Icons.air, size: 14, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${weather["windSpeed"]} km/h",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(Icons.thermostat, size: 14, color: warningColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "UV: ${weather["uvIndex"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            
                            Row(
                              children: [
                                Text(
                                  "Added: ${location["addedDate"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Visits: ${location["visitCount"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${location["distance"]} km away",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo ('WcaLocationDetailsView')
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.home,
                                  size: bs.sm,
                                  onPressed: () => _setAsDefault(location),
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.compare,
                                  size: bs.sm,
                                  onPressed: () {
                                    //navigateTo ('WcaCompareLocationsView')
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.delete,
                                  size: bs.sm,
                                  onPressed: () => _removeFromFavorites(location),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

            // Quick Actions
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
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Add Location",
                          icon: Icons.add_location,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo ('WcaAddLocationView')
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Compare All",
                          icon: Icons.compare_arrows,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo ('WcaCompareLocationsView')
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
