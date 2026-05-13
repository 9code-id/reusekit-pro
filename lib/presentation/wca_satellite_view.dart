import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaSatelliteView extends StatefulWidget {
  const WcaSatelliteView({super.key});

  @override
  State<WcaSatelliteView> createState() => _WcaSatelliteViewState();
}

class _WcaSatelliteViewState extends State<WcaSatelliteView> {
  int selectedRegionIndex = 0;
  String selectedImageType = "visible";
  DateTime selectedTime = DateTime.now();
  bool isPlaying = false;

  List<Map<String, dynamic>> regions = [
    {
      "name": "North America",
      "value": "north_america",
      "lat": 39.8283,
      "lon": -98.5795,
      "zoom": 4,
    },
    {
      "name": "Europe",
      "value": "europe",
      "lat": 54.5260,
      "lon": 15.2551,
      "zoom": 4,
    },
    {
      "name": "Asia Pacific",
      "value": "asia_pacific",
      "lat": 35.8617,
      "lon": 104.1954,
      "zoom": 3,
    },
    {
      "name": "Global",
      "value": "global",
      "lat": 0.0,
      "lon": 0.0,
      "zoom": 2,
    },
  ];

  List<Map<String, dynamic>> imageTypes = [
    {
      "label": "Visible Light",
      "value": "visible",
      "description": "Natural color satellite imagery",
      "icon": Icons.wb_sunny,
    },
    {
      "label": "Infrared",
      "value": "infrared",
      "description": "Temperature-based imagery",
      "icon": Icons.thermostat,
    },
    {
      "label": "Water Vapor",
      "value": "water_vapor",
      "description": "Atmospheric moisture content",
      "icon": Icons.water_drop,
    },
    {
      "label": "Enhanced",
      "value": "enhanced",
      "description": "Color-enhanced for weather features",
      "icon": Icons.palette,
    },
  ];

  List<Map<String, dynamic>> weatherFeatures = [
    {
      "name": "Hurricane System",
      "type": "storm",
      "intensity": "Category 3",
      "location": "Atlantic Ocean",
      "lat": 25.7617,
      "lon": -80.1918,
      "status": "Active",
      "color": dangerColor,
    },
    {
      "name": "Cloud Formation",
      "type": "clouds",
      "intensity": "Heavy",
      "location": "Pacific Northwest",
      "lat": 47.6062,
      "lon": -122.3321,
      "status": "Developing",
      "color": infoColor,
    },
    {
      "name": "Snow Cover",
      "type": "snow",
      "intensity": "Moderate",
      "location": "Rocky Mountains",
      "lat": 39.7392,
      "lon": -104.9903,
      "status": "Stable",
      "color": Colors.white,
    },
    {
      "name": "Dust Storm",
      "type": "dust",
      "intensity": "Severe",
      "location": "Sahara Desert",
      "lat": 23.8859,
      "lon": 15.3333,
      "status": "Moving",
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentRegion = regions[selectedRegionIndex];
    final currentImageType = imageTypes.firstWhere((type) => type["value"] == selectedImageType);

    return Scaffold(
      appBar: AppBar(
        title: Text("Satellite Imagery"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
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
                // Region and Image Type Selectors
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Region",
                        items: regions.map((region) => {
                          "label": region["name"],
                          "value": region["value"],
                        }).toList(),
                        value: regions[selectedRegionIndex]["value"],
                        onChanged: (value, label) {
                          selectedRegionIndex = regions.indexWhere((region) => region["value"] == value);
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Image Type",
                        items: imageTypes.map((type) => {
                          "label": type["label"],
                          "value": type["value"],
                        }).toList(),
                        value: selectedImageType,
                        onChanged: (value, label) {
                          selectedImageType = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                // Playback Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        selectedTime = selectedTime.subtract(Duration(hours: 1));
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
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        isPlaying = !isPlaying;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isPlaying ? dangerColor : successColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        selectedTime = selectedTime.add(Duration(hours: 1));
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
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      selectedTime.dMMMykkss,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
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
                  // Satellite Image Display
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Stack(
                      children: [
                        // Placeholder satellite image
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusMd),
                            image: DecorationImage(
                              image: NetworkImage("https://picsum.photos/400/300?random=satellite&keyword=earth"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        
                        // Overlay information
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
                                  "${currentRegion["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "${currentImageType["label"]}",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Weather feature markers
                        ...weatherFeatures.map((feature) {
                          return Positioned(
                            left: 50 + (weatherFeatures.indexOf(feature) * 60).toDouble(),
                            top: 100 + (weatherFeatures.indexOf(feature) * 40).toDouble(),
                            child: GestureDetector(
                              onTap: () {
                                _showFeatureDetails(feature);
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: feature["color"] as Color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),

                        // Legend
                        Positioned(
                          bottom: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Tap markers for details",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Image Type Info
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
                              currentImageType["icon"] as IconData,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${currentImageType["label"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${currentImageType["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Weather Features List
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
                          "Current Weather Features",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Column(
                          spacing: spSm,
                          children: weatherFeatures.map((feature) {
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (feature["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: (feature["color"] as Color).withAlpha(100),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: feature["color"] as Color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${feature["name"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "${feature["location"]} - ${feature["intensity"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(feature["status"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${feature["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: _getStatusColor(feature["status"] as String),
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

                  // Satellite Information
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
                          "Satellite Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoCard(
                                "Resolution",
                                "1 km",
                                Icons.zoom_in,
                                primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: _buildInfoCard(
                                "Update Freq",
                                "15 min",
                                Icons.update,
                                infoColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoCard(
                                "Coverage",
                                "Global",
                                Icons.public,
                                successColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: _buildInfoCard(
                                "Altitude",
                                "35,786 km",
                                Icons.flight_takeoff,
                                warningColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Image Type Selection Grid
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
                          "Available Image Types",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 150,
                          children: imageTypes.map((type) {
                            final isSelected = type["value"] == selectedImageType;
                            
                            return GestureDetector(
                              onTap: () {
                                selectedImageType = type["value"] as String;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: isSelected ? primaryColor : Colors.grey[300]!,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: Column(
                                  spacing: spSm,
                                  children: [
                                    Icon(
                                      type["icon"] as IconData,
                                      color: isSelected ? primaryColor : disabledBoldColor,
                                      size: 32,
                                    ),
                                    Text(
                                      "${type["label"]}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? primaryColor : disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${type["description"]}",
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon, Color color) {
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return dangerColor;
      case "developing":
        return warningColor;
      case "stable":
        return successColor;
      case "moving":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showFeatureDetails(Map<String, dynamic> feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${feature["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Type: ${feature["type"]}"),
            Text("Location: ${feature["location"]}"),
            Text("Intensity: ${feature["intensity"]}"),
            Text("Status: ${feature["status"]}"),
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
