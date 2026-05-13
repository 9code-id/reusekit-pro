import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaNearbyLocationsView extends StatefulWidget {
  const WcaNearbyLocationsView({super.key});

  @override
  State<WcaNearbyLocationsView> createState() => _WcaNearbyLocationsViewState();
}

class _WcaNearbyLocationsViewState extends State<WcaNearbyLocationsView> {
  String searchRadius = "25";
  String sortBy = "Distance";
  bool showWeatherData = true;
  bool isLoading = false;

  List<Map<String, dynamic>> radiusOptions = [
    {"label": "5 km", "value": "5"},
    {"label": "10 km", "value": "10"},
    {"label": "25 km", "value": "25"},
    {"label": "50 km", "value": "50"},
    {"label": "100 km", "value": "100"},
    {"label": "200 km", "value": "200"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Distance", "value": "Distance"},
    {"label": "Name (A-Z)", "value": "Name"},
    {"label": "Population", "value": "Population"},
    {"label": "Temperature", "value": "Temperature"},
  ];

  Map<String, dynamic> currentLocation = {
    "name": "New York",
    "latitude": 40.7128,
    "longitude": -74.0060,
    "temperature": 22,
    "condition": "Sunny",
    "humidity": 65,
    "windSpeed": 8,
  };

  List<Map<String, dynamic>> nearbyLocations = [
    {
      "name": "Jersey City",
      "state": "New Jersey",
      "distance": 3.2,
      "direction": "W",
      "latitude": 40.7282,
      "longitude": -74.0776,
      "population": 292449,
      "elevation": 5,
      "type": "City",
      "weather": {
        "temperature": 21,
        "condition": "Partly Cloudy",
        "humidity": 68,
        "windSpeed": 9,
        "icon": "partly_cloudy",
      },
    },
    {
      "name": "Brooklyn",
      "state": "New York",
      "distance": 8.1,
      "direction": "SE",
      "latitude": 40.6782,
      "longitude": -73.9442,
      "population": 2736074,
      "elevation": 19,
      "type": "Borough",
      "weather": {
        "temperature": 23,
        "condition": "Sunny",
        "humidity": 62,
        "windSpeed": 7,
        "icon": "sunny",
      },
    },
    {
      "name": "Newark",
      "state": "New Jersey",
      "distance": 12.4,
      "direction": "W",
      "latitude": 40.7357,
      "longitude": -74.1724,
      "population": 311549,
      "elevation": 4,
      "type": "City",
      "weather": {
        "temperature": 20,
        "condition": "Cloudy",
        "humidity": 72,
        "windSpeed": 11,
        "icon": "cloudy",
      },
    },
    {
      "name": "Yonkers",
      "state": "New York",
      "distance": 16.8,
      "direction": "N",
      "latitude": 40.9312,
      "longitude": -73.8988,
      "population": 211569,
      "elevation": 59,
      "type": "City",
      "weather": {
        "temperature": 19,
        "condition": "Light Rain",
        "humidity": 78,
        "windSpeed": 6,
        "icon": "rainy",
      },
    },
    {
      "name": "Stamford",
      "state": "Connecticut",
      "distance": 22.5,
      "direction": "NE",
      "latitude": 41.0534,
      "longitude": -73.5387,
      "population": 135470,
      "elevation": 17,
      "type": "City",
      "weather": {
        "temperature": 18,
        "condition": "Overcast",
        "humidity": 75,
        "windSpeed": 10,
        "icon": "overcast",
      },
    },
  ];

  void _refreshNearbyLocations() {
    isLoading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      isLoading = false;
      setState(() {});
      ss("Nearby locations updated");
    });
  }

  void _addToWatchlist(Map<String, dynamic> location, int index) {
    ss("Added ${location["name"]} to watchlist");
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case "sunny":
        return Icons.wb_sunny;
      case "partly cloudy":
        return Icons.wb_cloudy;
      case "cloudy":
      case "overcast":
        return Icons.cloud;
      case "light rain":
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
        return warningColor;
      case "partly cloudy":
        return infoColor;
      case "cloudy":
      case "overcast":
        return disabledBoldColor;
      case "light rain":
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

  String _getDirectionIcon(String direction) {
    switch (direction.toUpperCase()) {
      case "N":
        return "↑";
      case "NE":
        return "↗";
      case "E":
        return "→";
      case "SE":
        return "↘";
      case "S":
        return "↓";
      case "SW":
        return "↙";
      case "W":
        return "←";
      case "NW":
        return "↖";
      default:
        return "•";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Locations"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshNearbyLocations,
          ),
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              ss("Location updated");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Current Location
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.my_location, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Current Location",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentLocation["name"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${currentLocation["latitude"]}, ${currentLocation["longitude"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (showWeatherData)
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _getWeatherIcon("${currentLocation["condition"]}"),
                                color: _getWeatherColor("${currentLocation["condition"]}"),
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${currentLocation["temperature"]}°C",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Search Filters
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
                        "Search Options",
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
                          label: "Search Radius",
                          items: radiusOptions,
                          value: searchRadius,
                          onChanged: (value, label) {
                            searchRadius = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
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

            // Loading
            if (isLoading)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: spSm),
                    Text(
                      "Finding nearby locations...",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

            // Nearby Locations List
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
                        Icon(Icons.near_me, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Nearby Locations (${nearbyLocations.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Within ${searchRadius} km",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...nearbyLocations.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> location = entry.value;
                      Map<String, dynamic> weather = location["weather"] as Map<String, dynamic>;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
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
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    _getDirectionIcon("${location["direction"]}"),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${location["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${location["state"]} • ${location["type"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${location["distance"]} km",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Pop: ${((location["population"] as int) / 1000).toStringAsFixed(0)}K",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
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
                                      fontSize: 16,
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
                                  Spacer(),
                                  Text(
                                    "${location["elevation"]}m elevation",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            
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
                                  icon: Icons.add,
                                  size: bs.sm,
                                  onPressed: () => _addToWatchlist(location, index),
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.compare,
                                  size: bs.sm,
                                  onPressed: () {
                                    //navigateTo ('WcaCompareLocationsView')
                                  },
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
                          label: "Add New Location",
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
}
