import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaFieldMapView extends StatefulWidget {
  const AmaFieldMapView({super.key});

  @override
  State<AmaFieldMapView> createState() => _AmaFieldMapViewState();
}

class _AmaFieldMapViewState extends State<AmaFieldMapView> {
  String selectedLayer = "Satellite";
  String selectedField = "All Fields";
  bool showSoilData = true;
  bool showWeatherData = false;
  bool showIrrigationZones = true;
  bool showCropHealth = true;

  List<Map<String, dynamic>> mapLayers = [
    {"label": "Satellite", "value": "Satellite"},
    {"label": "Terrain", "value": "Terrain"},
    {"label": "Hybrid", "value": "Hybrid"},
    {"label": "Street", "value": "Street"},
  ];

  List<Map<String, dynamic>> fieldOptions = [
    {"label": "All Fields", "value": "All Fields"},
    {"label": "Main Field A", "value": "Main Field A"},
    {"label": "South Pasture", "value": "South Pasture"},
    {"label": "East Garden", "value": "East Garden"},
    {"label": "North Field", "value": "North Field"},
    {"label": "West Orchard", "value": "West Orchard"},
  ];

  List<Map<String, dynamic>> fieldMarkers = [
    {
      "id": 1,
      "name": "Main Field A",
      "crop": "Wheat",
      "area": "25.5 ha",
      "health": "Excellent",
      "coordinates": [40.7128, -74.0060],
      "status": "Active",
      "lastUpdate": "2 hours ago",
    },
    {
      "id": 2,
      "name": "South Pasture",
      "crop": "Corn",
      "area": "18.2 ha",
      "health": "Good",
      "coordinates": [40.7200, -74.0100],
      "status": "Active",
      "lastUpdate": "4 hours ago",
    },
    {
      "id": 3,
      "name": "East Garden",
      "crop": "Tomatoes",
      "area": "8.7 ha",
      "health": "Fair",
      "coordinates": [40.7150, -74.0200],
      "status": "Active",
      "lastUpdate": "1 hour ago",
    },
    {
      "id": 4,
      "name": "North Field",
      "crop": "Soybeans",
      "area": "15.3 ha",
      "health": "Excellent",
      "coordinates": [40.7300, -74.0050],
      "status": "Preparing",
      "lastUpdate": "3 days ago",
    },
    {
      "id": 5,
      "name": "West Orchard",
      "crop": "Apples",
      "area": "12.8 ha",
      "health": "Good",
      "coordinates": [40.7250, -74.0150],
      "status": "Harvesting",
      "lastUpdate": "Today",
    },
  ];

  List<Map<String, dynamic>> weatherStations = [
    {
      "id": 1,
      "name": "Station A",
      "temperature": "24°C",
      "humidity": "65%",
      "wind": "12 km/h",
      "coordinates": [40.7180, -74.0080],
    },
    {
      "id": 2,
      "name": "Station B",
      "temperature": "26°C",
      "humidity": "58%",
      "wind": "8 km/h",
      "coordinates": [40.7220, -74.0120],
    },
  ];

  Color getHealthColor(String health) {
    switch (health.toLowerCase()) {
      case 'excellent':
        return successColor;
      case 'good':
        return primaryColor;
      case 'fair':
        return warningColor;
      case 'poor':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'harvesting':
        return primaryColor;
      case 'preparing':
        return warningColor;
      case 'maintenance':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Field Map"),
        actions: [
          IconButton(
            icon: Icon(Icons.layers),
            onPressed: () {
              _showLayerDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showMapSettings();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Map Controls
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Map Layer",
                        items: mapLayers,
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
                        label: "Focus Field",
                        items: fieldOptions,
                        value: selectedField,
                        onChanged: (value, label) {
                          selectedField = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QHorizontalScroll(
                  children: [
                    _buildToggleChip("Soil Data", showSoilData, () {
                      showSoilData = !showSoilData;
                      setState(() {});
                    }),
                    _buildToggleChip("Weather", showWeatherData, () {
                      showWeatherData = !showWeatherData;
                      setState(() {});
                    }),
                    _buildToggleChip("Irrigation", showIrrigationZones, () {
                      showIrrigationZones = !showIrrigationZones;
                      setState(() {});
                    }),
                    _buildToggleChip("Crop Health", showCropHealth, () {
                      showCropHealth = !showCropHealth;
                      setState(() {});
                    }),
                  ],
                ),
              ],
            ),
          ),

          // Map View
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Stack(
                children: [
                  // Background Map
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://picsum.photos/800/600?random=100&keyword=aerial"
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.grey.withAlpha(50),
                          BlendMode.overlay,
                        ),
                      ),
                    ),
                  ),

                  // Field Markers
                  ...fieldMarkers.map((field) {
                    final coordinates = field["coordinates"] as List;
                    return Positioned(
                      left: ((coordinates[1] + 74.0060) * 800) % 600,
                      top: ((40.7300 - coordinates[0]) * 600) % 400,
                      child: GestureDetector(
                        onTap: () {
                          _showFieldInfo(field);
                        },
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: getHealthColor(field["health"]),
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.agriculture,
                                color: Colors.white,
                                size: 16,
                              ),
                              if (showCropHealth)
                                Container(
                                  margin: EdgeInsets.only(top: 2),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(200),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${field["name"]}",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w600,
                                      color: getHealthColor(field["health"]),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  // Weather Stations
                  if (showWeatherData)
                    ...weatherStations.map((station) {
                      final coordinates = station["coordinates"] as List;
                      return Positioned(
                        left: ((coordinates[1] + 74.0060) * 800) % 600,
                        top: ((40.7300 - coordinates[0]) * 600) % 400,
                        child: GestureDetector(
                          onTap: () {
                            _showWeatherInfo(station);
                          },
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: infoColor,
                              shape: BoxShape.circle,
                              boxShadow: [shadowSm],
                            ),
                            child: Icon(
                              Icons.wb_sunny,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      );
                    }).toList(),

                  // Map Legend
                  Positioned(
                    bottom: spMd,
                    left: spMd,
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(240),
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Legend",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          _buildLegendItem(successColor, "Excellent Health"),
                          _buildLegendItem(primaryColor, "Good Health"),
                          _buildLegendItem(warningColor, "Fair Health"),
                          _buildLegendItem(dangerColor, "Poor Health"),
                          if (showWeatherData)
                            _buildLegendItem(infoColor, "Weather Station"),
                        ],
                      ),
                    ),
                  ),

                  // Map Scale
                  Positioned(
                    bottom: spMd,
                    right: spMd,
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(240),
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Scale",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            height: 2,
                            width: 60,
                            color: primaryColor,
                          ),
                          SizedBox(height: 2),
                          Text(
                            "1 km",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Field Summary Bar
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${fieldMarkers.length}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Fields",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${fieldMarkers.fold(0.0, (sum, field) => sum + double.parse(field["area"].split(" ")[0])).toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Hectares",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${fieldMarkers.where((f) => f["status"] == "Active").length}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Active",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.fullscreen,
                  size: bs.sm,
                  onPressed: () {
                    si("Enter fullscreen map mode");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleChip(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: spXs),
        padding: EdgeInsets.symmetric(
          horizontal: spSm,
          vertical: spXs,
        ),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.transparent,
          border: Border.all(
            color: isActive ? primaryColor : disabledOutlineBorderColor,
          ),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : disabledBoldColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  void _showFieldInfo(Map<String, dynamic> field) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${field["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Crop: ${field["crop"]}"),
            Text("Area: ${field["area"]}"),
            Text("Health: ${field["health"]}"),
            Text("Status: ${field["status"]}"),
            Text("Last Update: ${field["lastUpdate"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              si("Navigate to field details");
            },
            child: Text("View Details"),
          ),
        ],
      ),
    );
  }

  void _showWeatherInfo(Map<String, dynamic> station) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${station["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Temperature: ${station["temperature"]}"),
            Text("Humidity: ${station["humidity"]}"),
            Text("Wind Speed: ${station["wind"]}"),
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

  void _showLayerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Map Layers"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: mapLayers.map((layer) {
            return RadioListTile<String>(
              title: Text("${layer["label"]}"),
              value: layer["value"],
              groupValue: selectedLayer,
              onChanged: (value) {
                selectedLayer = value!;
                setState(() {});
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showMapSettings() {
    si("Open advanced map settings");
  }
}
