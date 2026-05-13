import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaWeatherMapView extends StatefulWidget {
  const WcaWeatherMapView({super.key});

  @override
  State<WcaWeatherMapView> createState() => _WcaWeatherMapViewState();
}

class _WcaWeatherMapViewState extends State<WcaWeatherMapView> {
  String selectedLayer = "clouds";
  String selectedRegion = "world";
  double currentZoom = 1.0;
  bool isAnimating = false;
  DateTime selectedTime = DateTime.now();

  List<Map<String, dynamic>> mapLayers = [
    {
      "label": "Clouds",
      "value": "clouds",
      "icon": Icons.cloud,
      "color": infoColor,
      "description": "Cloud coverage and formations",
    },
    {
      "label": "Precipitation",
      "value": "precipitation",
      "icon": Icons.grain,
      "color": primaryColor,
      "description": "Rain, snow, and other precipitation",
    },
    {
      "label": "Temperature",
      "value": "temperature",
      "icon": Icons.thermostat,
      "color": dangerColor,
      "description": "Surface temperature variations",
    },
    {
      "label": "Wind",
      "value": "wind",
      "icon": Icons.air,
      "color": successColor,
      "description": "Wind speed and direction",
    },
    {
      "label": "Pressure",
      "value": "pressure",
      "icon": Icons.compress,
      "color": warningColor,
      "description": "Atmospheric pressure systems",
    },
    {
      "label": "Humidity",
      "value": "humidity",
      "icon": Icons.water_drop,
      "color": infoColor,
      "description": "Relative humidity levels",
    },
  ];

  List<Map<String, dynamic>> regions = [
    {"label": "World", "value": "world"},
    {"label": "North America", "value": "north_america"},
    {"label": "Europe", "value": "europe"},
    {"label": "Asia", "value": "asia"},
    {"label": "Africa", "value": "africa"},
    {"label": "South America", "value": "south_america"},
    {"label": "Oceania", "value": "oceania"},
  ];

  List<Map<String, dynamic>> weatherStations = [
    {
      "name": "New York",
      "lat": 40.7128,
      "lon": -74.0060,
      "temp": 22,
      "condition": "Partly Cloudy",
      "wind": 15,
      "humidity": 65,
    },
    {
      "name": "London",
      "lat": 51.5074,
      "lon": -0.1278,
      "temp": 18,
      "condition": "Rainy",
      "wind": 12,
      "humidity": 78,
    },
    {
      "name": "Tokyo",
      "lat": 35.6762,
      "lon": 139.6503,
      "temp": 26,
      "condition": "Clear",
      "wind": 8,
      "humidity": 55,
    },
    {
      "name": "Sydney",
      "lat": -33.8688,
      "lon": 151.2093,
      "temp": 24,
      "condition": "Sunny",
      "wind": 18,
      "humidity": 60,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentLayer = mapLayers.firstWhere((layer) => layer["value"] == selectedLayer);

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Map"),
        actions: [
          IconButton(
            icon: Icon(Icons.fullscreen),
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
                // Layer and Region Selection
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Map Layer",
                        items: mapLayers.map((layer) => {
                          "label": layer["label"],
                          "value": layer["value"],
                        }).toList(),
                        value: selectedLayer,
                        onChanged: (value, label) {
                          selectedLayer = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
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
                  ],
                ),

                // Animation Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectedTime = selectedTime.subtract(Duration(hours: 3));
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () {
                            isAnimating = !isAnimating;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isAnimating ? dangerColor : successColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              isAnimating ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () {
                            selectedTime = selectedTime.add(Duration(hours: 3));
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Zoom Controls
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (currentZoom > 0.5) {
                              currentZoom -= 0.25;
                              setState(() {});
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.zoom_out,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${(currentZoom * 100).toInt()}%",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () {
                            if (currentZoom < 3.0) {
                              currentZoom += 0.25;
                              setState(() {});
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.zoom_in,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Main Map Area
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Interactive Map Display
                  Container(
                    width: double.infinity,
                    height: 400,
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
                              image: NetworkImage("https://picsum.photos/600/400?random=map&keyword=world"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // Weather Layer Overlay
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusMd),
                            color: (currentLayer["color"] as Color).withAlpha(50),
                          ),
                        ),

                        // Weather Stations
                        ...weatherStations.map((station) {
                          return Positioned(
                            left: 50 + (weatherStations.indexOf(station) * 120).toDouble(),
                            top: 100 + (weatherStations.indexOf(station) * 60).toDouble(),
                            child: GestureDetector(
                              onTap: () => _showStationDetails(station),
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  boxShadow: [shadowSm],
                                  border: Border.all(
                                    color: primaryColor,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${station["name"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${station["temp"]}°C",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: dangerColor,
                                      ),
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
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      currentLayer["icon"] as IconData,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${currentLayer["label"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  selectedTime.dMMMykkss,
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Legend
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Legend",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: currentLayer["color"] as Color,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${currentLayer["label"]}",
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

                  // Current Layer Information
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
                        Row(
                          children: [
                            Icon(
                              currentLayer["icon"] as IconData,
                              color: currentLayer["color"] as Color,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${currentLayer["label"]} Layer",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${currentLayer["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Weather Stations Summary
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
                          children: weatherStations.map((station) {
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
                                    child: Text(
                                      "${station["name"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${station["temp"]}°C",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: dangerColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${station["wind"]} km/h",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: successColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${station["humidity"]}%",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: infoColor,
                                      ),
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

                  // Map Layers Grid
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
                          "Available Map Layers",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 150,
                          children: mapLayers.map((layer) {
                            final isSelected = layer["value"] == selectedLayer;
                            
                            return GestureDetector(
                              onTap: () {
                                selectedLayer = layer["value"] as String;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: isSelected ? (layer["color"] as Color).withAlpha(20) : Colors.grey[50],
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: isSelected ? layer["color"] as Color : Colors.grey[300]!,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: Column(
                                  spacing: spSm,
                                  children: [
                                    Icon(
                                      layer["icon"] as IconData,
                                      color: isSelected ? layer["color"] as Color : disabledBoldColor,
                                      size: 32,
                                    ),
                                    Text(
                                      "${layer["label"]}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? layer["color"] as Color : disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${layer["description"]}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
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
                  ),

                  // Map Controls Info
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: infoColor.withAlpha(100),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: infoColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Map Controls",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          spacing: spXs,
                          children: [
                            _buildControlTip("Tap weather stations for detailed information"),
                            _buildControlTip("Use playback controls to view weather evolution"),
                            _buildControlTip("Zoom in/out to see more or less detail"),
                            _buildControlTip("Switch layers to view different weather parameters"),
                            _buildControlTip("Select different regions for focused view"),
                          ],
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

  Widget _buildControlTip(String tip) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: EdgeInsets.only(top: 6, right: spSm),
          decoration: BoxDecoration(
            color: infoColor,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            tip,
            style: TextStyle(
              color: infoColor,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
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
            Text("Temperature: ${station["temp"]}°C"),
            Text("Condition: ${station["condition"]}"),
            Text("Wind Speed: ${station["wind"]} km/h"),
            Text("Humidity: ${station["humidity"]}%"),
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
