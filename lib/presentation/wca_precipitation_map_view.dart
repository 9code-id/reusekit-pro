import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaPrecipitationMapView extends StatefulWidget {
  const WcaPrecipitationMapView({super.key});

  @override
  State<WcaPrecipitationMapView> createState() => _WcaPrecipitationMapViewState();
}

class _WcaPrecipitationMapViewState extends State<WcaPrecipitationMapView> {
  String selectedIntensity = "all";
  String selectedType = "all";
  String selectedTimeframe = "current";
  String selectedRegion = "north_america";
  bool showRadarAnimation = false;

  List<Map<String, dynamic>> intensityFilters = [
    {"label": "All Intensities", "value": "all"},
    {"label": "Light", "value": "light"},
    {"label": "Moderate", "value": "moderate"},
    {"label": "Heavy", "value": "heavy"},
    {"label": "Severe", "value": "severe"},
  ];

  List<Map<String, dynamic>> precipitationTypes = [
    {"label": "All Types", "value": "all"},
    {"label": "Rain", "value": "rain"},
    {"label": "Snow", "value": "snow"},
    {"label": "Sleet", "value": "sleet"},
    {"label": "Hail", "value": "hail"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "Current", "value": "current"},
    {"label": "1 Hour", "value": "1h"},
    {"label": "3 Hours", "value": "3h"},
    {"label": "6 Hours", "value": "6h"},
    {"label": "12 Hours", "value": "12h"},
    {"label": "24 Hours", "value": "24h"},
  ];

  List<Map<String, dynamic>> regions = [
    {"label": "North America", "value": "north_america"},
    {"label": "Europe", "value": "europe"},
    {"label": "Asia", "value": "asia"},
    {"label": "Global", "value": "global"},
  ];

  List<Map<String, dynamic>> precipitationAreas = [
    {
      "name": "Pacific Storm System",
      "type": "rain",
      "intensity": "heavy",
      "coverage": "850 km²",
      "movement": "Northeast at 25 km/h",
      "rainfall": "15-25 mm/h",
      "lat": 45.5152,
      "lon": -122.6784,
      "color": primaryColor,
    },
    {
      "name": "Rocky Mountain Snow",
      "type": "snow",
      "intensity": "moderate",
      "coverage": "1200 km²",
      "movement": "East at 15 km/h",
      "rainfall": "2-5 cm/h",
      "lat": 39.7392,
      "lon": -104.9903,
      "color": infoColor,
    },
    {
      "name": "Gulf Coast Showers",
      "type": "rain",
      "intensity": "light",
      "coverage": "650 km²",
      "movement": "North at 18 km/h",
      "rainfall": "2-8 mm/h",
      "lat": 29.7604,
      "lon": -95.3698,
      "color": successColor,
    },
    {
      "name": "Great Lakes Effect",
      "type": "snow",
      "intensity": "heavy",
      "coverage": "400 km²",
      "movement": "Southeast at 12 km/h",
      "rainfall": "3-8 cm/h",
      "lat": 42.3314,
      "lon": -83.0458,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> radarStations = [
    {
      "name": "Seattle NEXRAD",
      "location": "Seattle, WA",
      "range": "250 km",
      "status": "Active",
      "lat": 47.6062,
      "lon": -122.3321,
    },
    {
      "name": "Denver NEXRAD",
      "location": "Denver, CO",
      "range": "250 km",
      "status": "Active",
      "lat": 39.7392,
      "lon": -104.9903,
    },
    {
      "name": "Houston NEXRAD",
      "location": "Houston, TX",
      "range": "250 km",
      "status": "Active",
      "lat": 29.7604,
      "lon": -95.3698,
    },
    {
      "name": "Detroit NEXRAD",
      "location": "Detroit, MI",
      "range": "250 km",
      "status": "Maintenance",
      "lat": 42.3314,
      "lon": -83.0458,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Precipitation Radar"),
        actions: [
          IconButton(
            icon: Icon(Icons.radar),
            onPressed: () {
              showRadarAnimation = !showRadarAnimation;
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
                        label: "Timeframe",
                        items: timeframes,
                        value: selectedTimeframe,
                        onChanged: (value, label) {
                          selectedTimeframe = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                // Secondary Filters
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Type",
                        items: precipitationTypes,
                        value: selectedType,
                        onChanged: (value, label) {
                          selectedType = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Intensity",
                        items: intensityFilters,
                        value: selectedIntensity,
                        onChanged: (value, label) {
                          selectedIntensity = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                // Animation Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showRadarAnimation = !showRadarAnimation;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: showRadarAnimation ? successColor : primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              showRadarAnimation ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              showRadarAnimation ? "Pause Animation" : "Start Animation",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
                  // Radar Map Display
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
                              image: NetworkImage("https://picsum.photos/600/350?random=radar&keyword=map"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // Precipitation Overlays
                        ...precipitationAreas.map((area) {
                          final index = precipitationAreas.indexOf(area);
                          return Positioned(
                            left: 50 + (index * 120).toDouble(),
                            top: 80 + (index * 60).toDouble(),
                            child: GestureDetector(
                              onTap: () => _showPrecipitationDetails(area),
                              child: Container(
                                width: 80,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: (area["color"] as Color).withAlpha(100),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: area["color"] as Color,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        _getPrecipitationIcon(area["type"] as String),
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      Text(
                                        "${area["type"]}".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),

                        // Radar Stations
                        ...radarStations.map((station) {
                          final index = radarStations.indexOf(station);
                          final isActive = station["status"] == "Active";
                          
                          return Positioned(
                            right: 30 + (index * 50).toDouble(),
                            bottom: 50 + (index * 40).toDouble(),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: isActive ? successColor : dangerColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: showRadarAnimation && isActive
                                  ? Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            successColor.withAlpha(200),
                                            successColor.withAlpha(50),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    )
                                  : null,
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
                                  "Precipitation Radar",
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
                                  "Intensity",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                _buildLegendItem("Light", successColor),
                                _buildLegendItem("Moderate", warningColor),
                                _buildLegendItem("Heavy", dangerColor),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Current Precipitation Summary
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
                          "Current Precipitation Areas",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Column(
                          spacing: spSm,
                          children: precipitationAreas.map((area) {
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (area["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: (area["color"] as Color).withAlpha(100),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        _getPrecipitationIcon(area["type"] as String),
                                        color: area["color"] as Color,
                                        size: 20,
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Text(
                                          "${area["name"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getIntensityColor(area["intensity"] as String),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${area["intensity"]}".toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildInfoItem("Type", "${area["type"]}"),
                                      ),
                                      Expanded(
                                        child: _buildInfoItem("Coverage", "${area["coverage"]}"),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildInfoItem("Rate", "${area["rainfall"]}"),
                                      ),
                                      Expanded(
                                        child: _buildInfoItem("Movement", "${area["movement"]}"),
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

                  // Radar Stations Status
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
                          "Radar Stations",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Column(
                          spacing: spSm,
                          children: radarStations.map((station) {
                            final isActive = station["status"] == "Active";
                            
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: isActive ? successColor : dangerColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
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
                                        Text(
                                          "${station["location"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${station["range"]}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isActive ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${station["status"]}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: isActive ? successColor : dangerColor,
                                        ),
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

                  // Precipitation Statistics
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
                          "Regional Statistics",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                "Active Areas",
                                "${precipitationAreas.length}",
                                Icons.location_on,
                                primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: _buildStatCard(
                                "Avg Intensity",
                                "Moderate",
                                Icons.speed,
                                warningColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                "Coverage",
                                "3,100 km²",
                                Icons.area_chart,
                                infoColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: _buildStatCard(
                                "Peak Rate",
                                "25 mm/h",
                                Icons.water_drop,
                                dangerColor,
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
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
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

  IconData _getPrecipitationIcon(String type) {
    switch (type) {
      case "rain":
        return Icons.water_drop;
      case "snow":
        return Icons.ac_unit;
      case "sleet":
        return Icons.grain;
      case "hail":
        return Icons.scatter_plot;
      default:
        return Icons.cloud;
    }
  }

  Color _getIntensityColor(String intensity) {
    switch (intensity) {
      case "light":
        return successColor;
      case "moderate":
        return warningColor;
      case "heavy":
        return dangerColor;
      case "severe":
        return Color(0xFF8B0000);
      default:
        return disabledBoldColor;
    }
  }

  void _showPrecipitationDetails(Map<String, dynamic> area) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${area["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Type: ${area["type"]}"),
            Text("Intensity: ${area["intensity"]}"),
            Text("Coverage: ${area["coverage"]}"),
            Text("Rate: ${area["rainfall"]}"),
            Text("Movement: ${area["movement"]}"),
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
