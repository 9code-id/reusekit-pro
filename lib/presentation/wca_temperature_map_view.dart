import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaTemperatureMapView extends StatefulWidget {
  const WcaTemperatureMapView({super.key});

  @override
  State<WcaTemperatureMapView> createState() => _WcaTemperatureMapViewState();
}

class _WcaTemperatureMapViewState extends State<WcaTemperatureMapView> {
  String selectedScale = "celsius";
  String selectedLayer = "current";
  String selectedRegion = "north_america";
  double minTemperature = -10;
  double maxTemperature = 35;

  List<Map<String, dynamic>> temperatureScales = [
    {"label": "Celsius (°C)", "value": "celsius"},
    {"label": "Fahrenheit (°F)", "value": "fahrenheit"},
    {"label": "Kelvin (K)", "value": "kelvin"},
  ];

  List<Map<String, dynamic>> temperatureLayers = [
    {"label": "Current Temperature", "value": "current"},
    {"label": "Feels Like", "value": "feels_like"},
    {"label": "Heat Index", "value": "heat_index"},
    {"label": "Wind Chill", "value": "wind_chill"},
    {"label": "Dew Point", "value": "dew_point"},
  ];

  List<Map<String, dynamic>> regions = [
    {"label": "North America", "value": "north_america"},
    {"label": "Europe", "value": "europe"},
    {"label": "Asia", "value": "asia"},
    {"label": "Global", "value": "global"},
  ];

  List<Map<String, dynamic>> temperatureZones = [
    {
      "name": "Arctic Front",
      "temperature": -8,
      "area": "Northern Canada",
      "trend": "falling",
      "color": Color(0xFF0066CC),
      "description": "Extremely cold air mass",
      "coverage": "1,200,000 km²",
    },
    {
      "name": "Continental Cool",
      "temperature": 5,
      "area": "Great Lakes Region",
      "trend": "stable",
      "color": Color(0xFF3399FF),
      "description": "Cool continental air",
      "coverage": "800,000 km²",
    },
    {
      "name": "Moderate Zone",
      "temperature": 18,
      "area": "Mid-Atlantic States",
      "trend": "rising",
      "color": Color(0xFF66FF66),
      "description": "Comfortable temperatures",
      "coverage": "650,000 km²",
    },
    {
      "name": "Warm Subtropical",
      "temperature": 28,
      "area": "Gulf States",
      "trend": "rising",
      "color": Color(0xFFFFCC00),
      "description": "Warm and humid conditions",
      "coverage": "500,000 km²",
    },
    {
      "name": "Desert Heat",
      "temperature": 42,
      "area": "Southwest Desert",
      "trend": "stable",
      "color": Color(0xFFFF6600),
      "description": "Extreme heat conditions",
      "coverage": "300,000 km²",
    },
  ];

  List<Map<String, dynamic>> temperatureStations = [
    {
      "name": "Fairbanks, AK",
      "current": -15,
      "high": -8,
      "low": -22,
      "trend": "falling",
      "lat": 64.8378,
      "lon": -147.7164,
    },
    {
      "name": "Chicago, IL",
      "current": 8,
      "high": 12,
      "low": 3,
      "trend": "stable",
      "lat": 41.8781,
      "lon": -87.6298,
    },
    {
      "name": "Miami, FL",
      "current": 29,
      "high": 32,
      "low": 25,
      "trend": "rising",
      "lat": 25.7617,
      "lon": -80.1918,
    },
    {
      "name": "Phoenix, AZ",
      "current": 38,
      "high": 43,
      "low": 32,
      "trend": "stable",
      "lat": 33.4484,
      "lon": -112.0740,
    },
    {
      "name": "Seattle, WA",
      "current": 15,
      "high": 18,
      "low": 11,
      "trend": "rising",
      "lat": 47.6062,
      "lon": -122.3321,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentLayer = temperatureLayers.firstWhere((layer) => layer["value"] == selectedLayer);

    return Scaffold(
      appBar: AppBar(
        title: Text("Temperature Map"),
        actions: [
          IconButton(
            icon: Icon(Icons.thermostat),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Controls Panel
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                // Primary Controls
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Region",
                        items: regions,
                        value: selectedRegion,
                        onChanged: (value, label) {
                          selectedRegion = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Temperature Scale",
                        items: temperatureScales,
                        value: selectedScale,
                        onChanged: (value, label) {
                          selectedScale = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                // Layer Selection
                QDropdownField(
                  label: "Temperature Layer",
                  items: temperatureLayers,
                  value: selectedLayer,
                  onChanged: (value, label) {
                    selectedLayer = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Temperature Map Display
                  Container(
                    width: double.infinity,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowMd],
                    ),
                    child: Stack(
                      children: [
                        // Base Map
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusMd),
                            image: DecorationImage(
                              image: NetworkImage("https://picsum.photos/600/350?random=tempmap&keyword=earth"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // Temperature Gradient Overlay
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusMd),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF0066CC).withAlpha(100), // Cold
                                Color(0xFF3399FF).withAlpha(80),
                                Color(0xFF66FF66).withAlpha(60),
                                Color(0xFFFFCC00).withAlpha(80),
                                Color(0xFFFF6600).withAlpha(100), // Hot
                              ],
                            ),
                          ),
                        ),

                        // Temperature Stations
                        ...temperatureStations.map((station) {
                          final index = temperatureStations.indexOf(station);
                          final temp = station["current"] as int;
                          final color = _getTemperatureColor(temp);
                          
                          return Positioned(
                            left: 50 + (index * 100).toDouble(),
                            top: 80 + (index * 40).toDouble(),
                            child: GestureDetector(
                              onTap: () => _showStationDetails(station),
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  boxShadow: [shadowSm],
                                  border: Border.all(
                                    color: color,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      station["name"].toString().split(',')[0],
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${_convertTemperature(temp)}°${_getScaleSymbol()}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: color,
                                      ),
                                    ),
                                    Icon(
                                      _getTrendIcon(station["trend"] as String),
                                      size: 12,
                                      color: _getTrendColor(station["trend"] as String),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),

                        // Map Info
                        Positioned(
                          top: spSm,
                          left: spSm,
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${currentLayer["label"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Updated: ${DateTime.now().kkmm}",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Temperature Scale Legend
                        Positioned(
                          bottom: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(200),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Temperature",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  width: 20,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF0066CC), // Cold
                                        Color(0xFF3399FF),
                                        Color(0xFF66FF66),
                                        Color(0xFFFFCC00),
                                        Color(0xFFFF6600), // Hot
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Column(
                                  children: [
                                    Text(
                                      "${_convertTemperature(maxTemperature.toInt())}°",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${_convertTemperature(minTemperature.toInt())}°",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Temperature Statistics
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Temperature Overview",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTempStatCard(
                                "Highest",
                                "${_convertTemperature(42)}°${_getScaleSymbol()}",
                                Icons.keyboard_arrow_up,
                                dangerColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: _buildTempStatCard(
                                "Average",
                                "${_convertTemperature(18)}°${_getScaleSymbol()}",
                                Icons.thermostat,
                                primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTempStatCard(
                                "Lowest",
                                "${_convertTemperature(-15)}°${_getScaleSymbol()}",
                                Icons.keyboard_arrow_down,
                                infoColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: _buildTempStatCard(
                                "Range",
                                "${_convertTemperature(57)}°${_getScaleSymbol()}",
                                Icons.linear_scale,
                                warningColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Temperature Zones
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Temperature Zones",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Column(
                          spacing: spSm,
                          children: temperatureZones.map((zone) {
                            final temp = zone["temperature"] as int;
                            
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (zone["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: (zone["color"] as Color).withAlpha(100),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: zone["color"] as Color,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Text(
                                          "${zone["name"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${_convertTemperature(temp)}°${_getScaleSymbol()}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: zone["color"] as Color,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(
                                        _getTrendIcon(zone["trend"] as String),
                                        color: _getTrendColor(zone["trend"] as String),
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${zone["description"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Area: ${zone["area"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Coverage: ${zone["coverage"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Temperature Stations List
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Weather Stations",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Column(
                          spacing: spSm,
                          children: temperatureStations.map((station) {
                            final current = station["current"] as int;
                            final high = station["high"] as int;
                            final low = station["low"] as int;
                            
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${station["name"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              _getTrendIcon(station["trend"] as String),
                                              size: 16,
                                              color: _getTrendColor(station["trend"] as String),
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${station["trend"]}".toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: _getTrendColor(station["trend"] as String),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Current",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${_convertTemperature(current)}°",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: _getTemperatureColor(current),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "High",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${_convertTemperature(high)}°",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: dangerColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Low",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${_convertTemperature(low)}°",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: infoColor,
                                          ),
                                        ),
                                      ],
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTempStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(100),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  int _convertTemperature(int celsius) {
    switch (selectedScale) {
      case "fahrenheit":
        return ((celsius * 9 / 5) + 32).round();
      case "kelvin":
        return (celsius + 273.15).round();
      default:
        return celsius;
    }
  }

  String _getScaleSymbol() {
    switch (selectedScale) {
      case "fahrenheit":
        return "F";
      case "kelvin":
        return "K";
      default:
        return "C";
    }
  }

  Color _getTemperatureColor(int celsius) {
    if (celsius <= -10) return Color(0xFF0066CC);
    if (celsius <= 0) return Color(0xFF3399FF);
    if (celsius <= 15) return Color(0xFF66FF66);
    if (celsius <= 25) return Color(0xFFFFCC00);
    return Color(0xFFFF6600);
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "rising":
        return Icons.trending_up;
      case "falling":
        return Icons.trending_down;
      default:
        return Icons.trending_flat;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "rising":
        return dangerColor;
      case "falling":
        return infoColor;
      default:
        return successColor;
    }
  }

  void _showStationDetails(Map<String, dynamic> station) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${station["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Current: ${_convertTemperature(station["current"] as int)}°${_getScaleSymbol()}"),
            Text("High: ${_convertTemperature(station["high"] as int)}°${_getScaleSymbol()}"),
            Text("Low: ${_convertTemperature(station["low"] as int)}°${_getScaleSymbol()}"),
            Text("Trend: ${station["trend"]}"),
            Text("Coordinates: ${station["lat"]}, ${station["lon"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
