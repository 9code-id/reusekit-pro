import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaAllergenForecastView extends StatefulWidget {
  const WcaAllergenForecastView({super.key});

  @override
  State<WcaAllergenForecastView> createState() => _WcaAllergenForecastViewState();
}

class _WcaAllergenForecastViewState extends State<WcaAllergenForecastView> {
  int selectedTabIndex = 0;
  String selectedLocation = "current";
  
  List<Map<String, dynamic>> locations = [
    {"label": "Current Location", "value": "current"},
    {"label": "Downtown", "value": "downtown"},
    {"label": "Suburbs", "value": "suburbs"},
    {"label": "Coastal Area", "value": "coastal"},
  ];

  List<Map<String, dynamic>> allergenCategories = [
    {
      "name": "Tree Pollen",
      "icon": Icons.park,
      "current": "High",
      "level": 4,
      "color": dangerColor,
      "peak": "March - May",
      "types": ["Oak", "Birch", "Maple", "Cedar", "Pine"],
      "forecast": [
        {"day": "Today", "level": 4, "condition": "High"},
        {"day": "Tomorrow", "level": 5, "condition": "Very High"},
        {"day": "Wed", "level": 3, "condition": "Moderate"},
        {"day": "Thu", "level": 2, "condition": "Low"},
        {"day": "Fri", "level": 3, "condition": "Moderate"},
      ],
    },
    {
      "name": "Grass Pollen",
      "icon": Icons.grass,
      "current": "Moderate",
      "level": 3,
      "color": warningColor,
      "peak": "May - July",
      "types": ["Timothy", "Bermuda", "Kentucky Blue", "Ryegrass"],
      "forecast": [
        {"day": "Today", "level": 3, "condition": "Moderate"},
        {"day": "Tomorrow", "level": 4, "condition": "High"},
        {"day": "Wed", "level": 3, "condition": "Moderate"},
        {"day": "Thu", "level": 2, "condition": "Low"},
        {"day": "Fri", "level": 3, "condition": "Moderate"},
      ],
    },
    {
      "name": "Weed Pollen",
      "icon": Icons.local_florist,
      "current": "Low",
      "level": 2,
      "color": successColor,
      "peak": "August - October",
      "types": ["Ragweed", "Sagebrush", "Pigweed", "Lamb's Quarters"],
      "forecast": [
        {"day": "Today", "level": 2, "condition": "Low"},
        {"day": "Tomorrow", "level": 2, "condition": "Low"},
        {"day": "Wed", "level": 1, "condition": "Very Low"},
        {"day": "Thu", "level": 1, "condition": "Very Low"},
        {"day": "Fri", "level": 2, "condition": "Low"},
      ],
    },
    {
      "name": "Mold Spores",
      "icon": Icons.cloud,
      "current": "Moderate",
      "level": 3,
      "color": warningColor,
      "peak": "Fall & Spring",
      "types": ["Alternaria", "Cladosporium", "Aspergillus", "Penicillium"],
      "forecast": [
        {"day": "Today", "level": 3, "condition": "Moderate"},
        {"day": "Tomorrow", "level": 2, "condition": "Low"},
        {"day": "Wed", "level": 3, "condition": "Moderate"},
        {"day": "Thu", "level": 4, "condition": "High"},
        {"day": "Fri", "level": 2, "condition": "Low"},
      ],
    },
  ];

  List<Map<String, dynamic>> hourlyForecast = [
    {"time": "06:00", "tree": 2, "grass": 2, "weed": 1, "mold": 2},
    {"time": "08:00", "tree": 3, "grass": 3, "weed": 1, "mold": 2},
    {"time": "10:00", "tree": 4, "grass": 3, "weed": 2, "mold": 3},
    {"time": "12:00", "tree": 5, "grass": 4, "weed": 2, "mold": 3},
    {"time": "14:00", "tree": 4, "grass": 4, "weed": 2, "mold": 3},
    {"time": "16:00", "tree": 3, "grass": 3, "weed": 2, "mold": 2},
    {"time": "18:00", "tree": 2, "grass": 2, "weed": 1, "mold": 2},
    {"time": "20:00", "tree": 1, "grass": 1, "weed": 1, "mold": 2},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Allergen Forecast"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Location Selector
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: QDropdownField(
              label: "Location",
              items: locations,
              value: selectedLocation,
              onChanged: (value, label) {
                selectedLocation = value;
                setState(() {});
              },
            ),
          ),
          
          // Tab Content
          Expanded(
            child: QTabBar(
              withoutAppBar: true,
              selectedIndex: selectedTabIndex,
              tabs: [
                Tab(text: "Overview", icon: Icon(Icons.dashboard)),
                Tab(text: "Detailed", icon: Icon(Icons.analytics)),
                Tab(text: "Hourly", icon: Icon(Icons.schedule)),
                Tab(text: "Tips", icon: Icon(Icons.lightbulb)),
              ],
              tabChildren: [
                _buildOverviewTab(),
                _buildDetailedTab(),
                _buildHourlyTab(),
                _buildTipsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Current Status Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: allergenCategories.map((category) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      category["icon"] as IconData,
                      color: category["color"] as Color,
                      size: 32,
                    ),
                    Text(
                      "${category["name"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (category["color"] as Color).withAlpha(20),
                        border: Border.all(
                          color: category["color"] as Color,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${category["level"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: category["color"] as Color,
                            ),
                          ),
                          Text(
                            "Level",
                            style: TextStyle(
                              fontSize: 10,
                              color: category["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${category["current"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: category["color"] as Color,
                      ),
                    ),
                    Text(
                      "Peak: ${category["peak"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Weekly Forecast
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
                  "5-Day Forecast",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spXs,
                  children: allergenCategories.map((category) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                category["icon"] as IconData,
                                color: category["color"] as Color,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${category["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: (category["forecast"] as List<Map<String, dynamic>>)
                                .map((day) {
                              final level = day["level"] as int;
                              final color = _getLevelColor(level);
                              
                              return Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: spXs),
                                  child: Column(
                                    children: [
                                      Text(
                                        "${day["day"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: color,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "$level",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${day["condition"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: color,
                                          fontWeight: FontWeight.w600,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: allergenCategories.map((category) {
          return Container(
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
                      category["icon"] as IconData,
                      color: category["color"] as Color,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${category["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Current Level: ${category["current"]}",
                            style: TextStyle(
                              color: category["color"] as Color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (category["color"] as Color).withAlpha(20),
                        border: Border.all(
                          color: category["color"] as Color,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "${category["level"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: category["color"] as Color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Peak Season
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (category["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: category["color"] as Color,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Peak Season: ${category["peak"]}",
                        style: TextStyle(
                          color: category["color"] as Color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Common Types
                Text(
                  "Common Types:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (category["types"] as List<String>).map((type) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: Colors.grey[300]!,
                        ),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // 5-Day Forecast Bar
                Text(
                  "5-Day Forecast:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 80,
                  child: Row(
                    children: (category["forecast"] as List<Map<String, dynamic>>)
                        .map((day) {
                      final level = day["level"] as int;
                      final height = (level / 5.0) * 50;
                      final color = _getLevelColor(level);
                      
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "$level",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                width: double.infinity,
                                height: height,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${day["day"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHourlyTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
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
                  "Today's Hourly Forecast",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 250,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: hourlyForecast.map((hour) {
                        return Container(
                          width: 80,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${hour["time"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              
                              // Tree
                              _buildHourlyBar("Tree", hour["tree"] as int, dangerColor),
                              SizedBox(height: spXs),
                              
                              // Grass
                              _buildHourlyBar("Grass", hour["grass"] as int, warningColor),
                              SizedBox(height: spXs),
                              
                              // Weed
                              _buildHourlyBar("Weed", hour["weed"] as int, successColor),
                              SizedBox(height: spXs),
                              
                              // Mold
                              _buildHourlyBar("Mold", hour["mold"] as int, infoColor),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                
                // Legend
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLegend("Tree", dangerColor),
                    _buildLegend("Grass", warningColor),
                    _buildLegend("Weed", successColor),
                    _buildLegend("Mold", infoColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTipsSection(
            "General Prevention",
            Icons.shield,
            primaryColor,
            [
              "Check daily pollen forecasts before planning outdoor activities",
              "Keep windows closed during high pollen periods",
              "Use air conditioning with clean HEPA filters",
              "Shower and change clothes after spending time outdoors",
              "Dry laundry indoors to avoid collecting pollen",
            ],
          ),
          
          _buildTipsSection(
            "Medication Tips",
            Icons.medication,
            dangerColor,
            [
              "Take antihistamines before allergy season starts",
              "Use nasal corticosteroid sprays for severe symptoms",
              "Consider allergy shots for long-term relief",
              "Keep rescue medications readily available",
              "Consult with allergist for personalized treatment plan",
            ],
          ),
          
          _buildTipsSection(
            "Outdoor Activities",
            Icons.sports,
            successColor,
            [
              "Exercise indoors on high pollen days",
              "Plan outdoor activities for late evening or after rain",
              "Wear wraparound sunglasses to protect eyes",
              "Use a pollen mask when gardening or mowing",
              "Avoid peak pollen times (usually 10 AM - 4 PM)",
            ],
          ),
          
          _buildTipsSection(
            "Home Environment",
            Icons.home,
            infoColor,
            [
              "Install HEPA air purifiers in bedrooms",
              "Vacuum regularly with HEPA filter vacuum",
              "Keep indoor humidity between 30-50%",
              "Remove shoes at entrance to avoid tracking pollen",
              "Consider hypoallergenic bedding and pillow covers",
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyBar(String label, int level, Color color) {
    final height = (level / 5.0) * 30;
    
    return Column(
      children: [
        Container(
          width: 20,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(height: 2),
        Text(
          "$level",
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildLegend(String label, Color color) {
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
            fontSize: 12,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTipsSection(String title, IconData icon, Color color, List<String> tips) {
    return Container(
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
                icon,
                color: color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: tips.map((tip) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: EdgeInsets.only(top: 6, right: spSm),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      tip,
                      style: TextStyle(
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getLevelColor(int level) {
    switch (level) {
      case 1:
        return successColor;
      case 2:
        return successColor;
      case 3:
        return warningColor;
      case 4:
        return dangerColor;
      case 5:
        return Color(0xFF8B0000);
      default:
        return successColor;
    }
  }
}
