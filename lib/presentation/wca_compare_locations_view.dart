import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaCompareLocationsView extends StatefulWidget {
  const WcaCompareLocationsView({super.key});

  @override
  State<WcaCompareLocationsView> createState() => _WcaCompareLocationsViewState();
}

class _WcaCompareLocationsViewState extends State<WcaCompareLocationsView> {
  List<String> selectedLocations = ["New York", "London"];
  String comparisonType = "Current Weather";
  bool showDetails = true;

  List<Map<String, dynamic>> availableLocations = [
    {"label": "New York", "value": "New York"},
    {"label": "London", "value": "London"},
    {"label": "Tokyo", "value": "Tokyo"},
    {"label": "Sydney", "value": "Sydney"},
    {"label": "Paris", "value": "Paris"},
    {"label": "Berlin", "value": "Berlin"},
    {"label": "Mumbai", "value": "Mumbai"},
    {"label": "Dubai", "value": "Dubai"},
  ];

  List<Map<String, dynamic>> comparisonTypes = [
    {"label": "Current Weather", "value": "Current Weather"},
    {"label": "Daily Forecast", "value": "Daily Forecast"},
    {"label": "Weekly Forecast", "value": "Weekly Forecast"},
    {"label": "Historical Data", "value": "Historical Data"},
    {"label": "Climate Averages", "value": "Climate Averages"},
  ];

  Map<String, Map<String, dynamic>> locationData = {
    "New York": {
      "country": "United States",
      "timezone": "UTC-5",
      "coordinates": "40.7128, -74.0060",
      "elevation": 10,
      "population": 8398748,
      "weather": {
        "temperature": 22,
        "condition": "Sunny",
        "humidity": 65,
        "windSpeed": 8,
        "pressure": 1013,
        "uvIndex": 7,
        "visibility": 16,
        "feelsLike": 24,
      },
      "forecast": [
        {"day": "Today", "high": 24, "low": 16, "condition": "Sunny"},
        {"day": "Tomorrow", "high": 26, "low": 18, "condition": "Partly Cloudy"},
        {"day": "Wednesday", "high": 23, "low": 15, "condition": "Rainy"},
      ],
      "historical": {
        "avgTemp": 13,
        "avgPrecipitation": 1268,
        "highestTemp": 42,
        "lowestTemp": -26,
      },
    },
    "London": {
      "country": "United Kingdom",
      "timezone": "UTC+0",
      "coordinates": "51.5074, -0.1278",
      "elevation": 35,
      "population": 9648110,
      "weather": {
        "temperature": 12,
        "condition": "Rainy",
        "humidity": 82,
        "windSpeed": 15,
        "pressure": 995,
        "uvIndex": 2,
        "visibility": 8,
        "feelsLike": 10,
      },
      "forecast": [
        {"day": "Today", "high": 15, "low": 8, "condition": "Rainy"},
        {"day": "Tomorrow", "high": 17, "low": 10, "condition": "Cloudy"},
        {"day": "Wednesday", "high": 19, "low": 12, "condition": "Partly Cloudy"},
      ],
      "historical": {
        "avgTemp": 11,
        "avgPrecipitation": 615,
        "highestTemp": 38,
        "lowestTemp": -16,
      },
    },
    "Tokyo": {
      "country": "Japan",
      "timezone": "UTC+9",
      "coordinates": "35.6762, 139.6503",
      "elevation": 40,
      "population": 37977000,
      "weather": {
        "temperature": 18,
        "condition": "Partly Cloudy",
        "humidity": 70,
        "windSpeed": 12,
        "pressure": 1018,
        "uvIndex": 5,
        "visibility": 12,
        "feelsLike": 20,
      },
      "forecast": [
        {"day": "Today", "high": 21, "low": 14, "condition": "Partly Cloudy"},
        {"day": "Tomorrow", "high": 23, "low": 16, "condition": "Sunny"},
        {"day": "Wednesday", "high": 25, "low": 18, "condition": "Sunny"},
      ],
      "historical": {
        "avgTemp": 16,
        "avgPrecipitation": 1520,
        "highestTemp": 39,
        "lowestTemp": -9,
      },
    },
    "Sydney": {
      "country": "Australia",
      "timezone": "UTC+10",
      "coordinates": "-33.8688, 151.2093",
      "elevation": 58,
      "population": 5312163,
      "weather": {
        "temperature": 25,
        "condition": "Clear",
        "humidity": 55,
        "windSpeed": 14,
        "pressure": 1022,
        "uvIndex": 9,
        "visibility": 20,
        "feelsLike": 27,
      },
      "forecast": [
        {"day": "Today", "high": 28, "low": 19, "condition": "Clear"},
        {"day": "Tomorrow", "high": 30, "low": 21, "condition": "Sunny"},
        {"day": "Wednesday", "high": 26, "low": 18, "condition": "Partly Cloudy"},
      ],
      "historical": {
        "avgTemp": 18,
        "avgPrecipitation": 1213,
        "highestTemp": 47,
        "lowestTemp": 2,
      },
    },
  };

  void _addLocation() {
    if (selectedLocations.length < 4) {
      //navigateTo ('WcaSelectLocationView')
    } else {
      sw("Maximum 4 locations can be compared");
    }
  }

  void _removeLocation(String location) {
    if (selectedLocations.length > 2) {
      selectedLocations.remove(location);
      setState(() {});
      ss("Removed $location from comparison");
    } else {
      sw("At least 2 locations are required for comparison");
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
      case "thunderstorm":
        return Icons.flash_on;
      case "snow":
        return Icons.ac_unit;
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
      case "thunderstorm":
        return dangerColor;
      case "snow":
        return Colors.lightBlue;
      default:
        return disabledBoldColor;
    }
  }

  Color _getComparisonColor(double value, List<double> allValues) {
    double max = allValues.reduce((a, b) => a > b ? a : b);
    double min = allValues.reduce((a, b) => a < b ? a : b);
    
    if (value == max) return successColor;
    if (value == min) return dangerColor;
    return warningColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compare Locations"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addLocation,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Comparison shared");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Comparison Settings
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
                        "Comparison Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Comparison Type",
                    items: comparisonTypes,
                    value: comparisonType,
                    onChanged: (value, label) {
                      comparisonType = value;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Show Detailed Information",
                        "value": true,
                        "checked": showDetails,
                      }
                    ],
                    value: [
                      if (showDetails)
                        {
                          "label": "Show Detailed Information",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showDetails = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Selected Locations
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
                      Icon(Icons.compare, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Comparing ${selectedLocations.length} Locations",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: selectedLocations.map((location) {
                      Map<String, dynamic>? data = locationData[location];
                      if (data == null) return SizedBox.shrink();
                      
                      return Container(
                        width: 150,
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: primaryColor.withAlpha(30)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    location,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _removeLocation(location),
                                  child: Icon(
                                    Icons.close,
                                    size: 16,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${data["country"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${data["timezone"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Comparison Results
            if (comparisonType == "Current Weather")
              _buildCurrentWeatherComparison(),
            if (comparisonType == "Daily Forecast")
              _buildForecastComparison(),
            if (comparisonType == "Historical Data")
              _buildHistoricalComparison(),

            // Quick Statistics
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
                      Icon(Icons.bar_chart, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Quick Statistics",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  _buildQuickStats(),
                ],
              ),
            ),

            // Actions
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
                    "Actions",
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
                          label: "Export Data",
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {
                            ss("Comparison data exported");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Save Comparison",
                          icon: Icons.bookmark,
                          size: bs.sm,
                          onPressed: () {
                            ss("Comparison saved");
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

  Widget _buildCurrentWeatherComparison() {
    return Container(
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
              Icon(Icons.thermostat, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Current Weather Comparison",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          // Temperature Comparison
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Temperature",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: selectedLocations.map((location) {
                    Map<String, dynamic>? data = locationData[location];
                    if (data == null) return SizedBox.shrink();
                    
                    Map<String, dynamic> weather = data["weather"] as Map<String, dynamic>;
                    List<double> allTemps = selectedLocations
                        .map((loc) => (locationData[loc]?["weather"]["temperature"] as int).toDouble())
                        .toList();
                    
                    return Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        margin: EdgeInsets.only(right: spXs),
                        decoration: BoxDecoration(
                          color: _getComparisonColor((weather["temperature"] as int).toDouble(), allTemps).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          children: [
                            Text(
                              location,
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${weather["temperature"]}°C",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _getComparisonColor((weather["temperature"] as int).toDouble(), allTemps),
                              ),
                            ),
                            Icon(
                              _getWeatherIcon("${weather["condition"]}"),
                              size: 16,
                              color: _getWeatherColor("${weather["condition"]}"),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          
          if (showDetails) ...[
            SizedBox(height: spSm),
            // Other Weather Parameters
            ...["humidity", "windSpeed", "pressure", "uvIndex"].map((parameter) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getParameterLabel(parameter),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: selectedLocations.map((location) {
                        Map<String, dynamic>? data = locationData[location];
                        if (data == null) return SizedBox.shrink();
                        
                        Map<String, dynamic> weather = data["weather"] as Map<String, dynamic>;
                        dynamic value = weather[parameter];
                        List<double> allValues = selectedLocations
                            .map((loc) => (locationData[loc]?["weather"][parameter] as num).toDouble())
                            .toList();
                        
                        return Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            margin: EdgeInsets.only(right: spXs),
                            decoration: BoxDecoration(
                              color: _getComparisonColor(value.toDouble(), allValues).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  location,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "$value${_getParameterUnit(parameter)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _getComparisonColor(value.toDouble(), allValues),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildForecastComparison() {
    return Container(
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
              Icon(Icons.calendar_today, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "3-Day Forecast Comparison",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          ...List.generate(3, (dayIndex) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ["Today", "Tomorrow", "Wednesday"][dayIndex],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: selectedLocations.map((location) {
                      Map<String, dynamic>? data = locationData[location];
                      if (data == null) return SizedBox.shrink();
                      
                      List<dynamic> forecast = data["forecast"] as List<dynamic>;
                      if (dayIndex >= forecast.length) return SizedBox.shrink();
                      
                      Map<String, dynamic> dayForecast = forecast[dayIndex] as Map<String, dynamic>;
                      
                      return Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          margin: EdgeInsets.only(right: spXs),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                location,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Icon(
                                _getWeatherIcon("${dayForecast["condition"]}"),
                                size: 20,
                                color: _getWeatherColor("${dayForecast["condition"]}"),
                              ),
                              Text(
                                "${dayForecast["high"]}°/${dayForecast["low"]}°",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildHistoricalComparison() {
    return Container(
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
                "Historical Data Comparison",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          ...["avgTemp", "avgPrecipitation", "highestTemp", "lowestTemp"].map((parameter) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getHistoricalLabel(parameter),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: selectedLocations.map((location) {
                      Map<String, dynamic>? data = locationData[location];
                      if (data == null) return SizedBox.shrink();
                      
                      Map<String, dynamic> historical = data["historical"] as Map<String, dynamic>;
                      dynamic value = historical[parameter];
                      List<double> allValues = selectedLocations
                          .map((loc) => (locationData[loc]?["historical"][parameter] as num).toDouble())
                          .toList();
                      
                      return Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          margin: EdgeInsets.only(right: spXs),
                          decoration: BoxDecoration(
                            color: _getComparisonColor(value.toDouble(), allValues).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                location,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "$value${_getHistoricalUnit(parameter)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _getComparisonColor(value.toDouble(), allValues),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    List<double> temperatures = selectedLocations
        .map((loc) => (locationData[loc]?["weather"]["temperature"] as int).toDouble())
        .toList();
    
    double avgTemp = temperatures.reduce((a, b) => a + b) / temperatures.length;
    double maxTemp = temperatures.reduce((a, b) => a > b ? a : b);
    double minTemp = temperatures.reduce((a, b) => a < b ? a : b);
    double tempRange = maxTemp - minTemp;
    
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            "Average",
            "${avgTemp.toStringAsFixed(1)}°C",
            Icons.thermostat,
            primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Highest",
            "${maxTemp.toStringAsFixed(0)}°C",
            Icons.keyboard_arrow_up,
            dangerColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Lowest",
            "${minTemp.toStringAsFixed(0)}°C",
            Icons.keyboard_arrow_down,
            Colors.lightBlue,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Range",
            "${tempRange.toStringAsFixed(1)}°C",
            Icons.compare_arrows,
            warningColor,
          ),
        ),
      ],
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
          Icon(icon, color: color, size: 16),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  String _getParameterLabel(String parameter) {
    switch (parameter) {
      case "humidity":
        return "Humidity";
      case "windSpeed":
        return "Wind Speed";
      case "pressure":
        return "Pressure";
      case "uvIndex":
        return "UV Index";
      default:
        return parameter;
    }
  }

  String _getParameterUnit(String parameter) {
    switch (parameter) {
      case "humidity":
        return "%";
      case "windSpeed":
        return " km/h";
      case "pressure":
        return " mb";
      case "uvIndex":
        return "";
      default:
        return "";
    }
  }

  String _getHistoricalLabel(String parameter) {
    switch (parameter) {
      case "avgTemp":
        return "Average Temperature";
      case "avgPrecipitation":
        return "Average Precipitation";
      case "highestTemp":
        return "Record High";
      case "lowestTemp":
        return "Record Low";
      default:
        return parameter;
    }
  }

  String _getHistoricalUnit(String parameter) {
    switch (parameter) {
      case "avgTemp":
      case "highestTemp":
      case "lowestTemp":
        return "°C";
      case "avgPrecipitation":
        return "mm";
      default:
        return "";
    }
  }
}
