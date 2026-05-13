import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaNeighborhoodInfoView extends StatefulWidget {
  const RmaNeighborhoodInfoView({super.key});

  @override
  State<RmaNeighborhoodInfoView> createState() => _RmaNeighborhoodInfoViewState();
}

class _RmaNeighborhoodInfoViewState extends State<RmaNeighborhoodInfoView> {
  Map<String, dynamic> neighborhoodData = {
    "name": "Downtown District",
    "city": "Metropolitan City",
    "population": 15420,
    "median_age": 34.2,
    "median_income": 87500.0,
    "walkability_score": 88,
    "transit_score": 76,
    "bike_score": 82,
    "safety_rating": 8.2,
    "livability_score": 85,
  };

  List<Map<String, dynamic>> demographicsData = [
    {"category": "Age 25-34", "percentage": 28.5, "color": primaryColor},
    {"category": "Age 35-44", "percentage": 24.8, "color": successColor},
    {"category": "Age 45-54", "percentage": 18.2, "color": warningColor},
    {"category": "Age 55-64", "percentage": 14.7, "color": infoColor},
    {"category": "Age 65+", "percentage": 13.8, "color": dangerColor},
  ];

  List<Map<String, dynamic>> housingData = [
    {"type": "Single Family", "percentage": 45.2, "median_price": 825000.0},
    {"type": "Townhouse", "percentage": 28.6, "median_price": 675000.0},
    {"type": "Condo", "percentage": 18.3, "median_price": 485000.0},
    {"type": "Multi-Family", "percentage": 7.9, "median_price": 920000.0},
  ];

  List<Map<String, dynamic>> amenities = [
    {
      "category": "Shopping",
      "icon": Icons.shopping_cart,
      "items": [
        {"name": "Metro Mall", "distance": 0.3, "rating": 4.2},
        {"name": "Whole Foods Market", "distance": 0.5, "rating": 4.5},
        {"name": "Downtown Shopping Center", "distance": 0.8, "rating": 4.0},
      ],
    },
    {
      "category": "Dining",
      "icon": Icons.restaurant,
      "items": [
        {"name": "The Gourmet Bistro", "distance": 0.2, "rating": 4.7},
        {"name": "Pizza Corner", "distance": 0.4, "rating": 4.3},
        {"name": "Sushi Zen", "distance": 0.6, "rating": 4.6},
      ],
    },
    {
      "category": "Entertainment",
      "icon": Icons.movie,
      "items": [
        {"name": "City Cinema", "distance": 0.7, "rating": 4.1},
        {"name": "Central Park", "distance": 0.9, "rating": 4.8},
        {"name": "Art Gallery", "distance": 1.2, "rating": 4.4},
      ],
    },
    {
      "category": "Healthcare",
      "icon": Icons.local_hospital,
      "items": [
        {"name": "Metro General Hospital", "distance": 1.5, "rating": 4.3},
        {"name": "Family Health Clinic", "distance": 0.8, "rating": 4.5},
        {"name": "Emergency Care Center", "distance": 1.1, "rating": 4.2},
      ],
    },
  ];

  List<Map<String, dynamic>> transportationOptions = [
    {
      "type": "Metro Station",
      "name": "Downtown Central",
      "distance": 0.4,
      "lines": ["Red Line", "Blue Line"],
      "walk_time": 5,
    },
    {
      "type": "Bus Stop",
      "name": "Maple & Main",
      "distance": 0.1,
      "lines": ["Route 15", "Route 28", "Route 42"],
      "walk_time": 2,
    },
    {
      "type": "Bike Share",
      "name": "City Bikes Station",
      "distance": 0.2,
      "lines": ["24/7 Access"],
      "walk_time": 3,
    },
  ];

  List<Map<String, dynamic>> neighborhoodFeatures = [
    {
      "title": "Historic District",
      "description": "Charming historic area with preserved architecture",
      "icon": Icons.account_balance,
      "rating": 4.6,
    },
    {
      "title": "Tree-Lined Streets",
      "description": "Beautiful mature trees throughout the neighborhood",
      "icon": Icons.park,
      "rating": 4.8,
    },
    {
      "title": "Vibrant Nightlife",
      "description": "Numerous bars, clubs, and entertainment venues",
      "icon": Icons.nightlife,
      "rating": 4.2,
    },
    {
      "title": "Farmers Market",
      "description": "Weekly farmers market with local produce",
      "icon": Icons.local_grocery_store,
      "rating": 4.5,
    },
  ];

  String selectedTab = "overview";
  List<String> tabs = ["overview", "demographics", "amenities", "transport"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Neighborhood Info"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () => _viewMap(),
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _shareNeighborhoodInfo(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildTabContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: tabs.map((tab) {
          bool isSelected = selectedTab == tab;
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: spXs),
              child: QButton(
                label: tab.toUpperCase(),
                size: bs.sm,
                color: isSelected ? primaryColor : disabledColor,
                onPressed: () {
                  selectedTab = tab;
                  setState(() {});
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case "overview":
        return _buildOverviewTab();
      case "demographics":
        return _buildDemographicsTab();
      case "amenities":
        return _buildAmenitiesTab();
      case "transport":
        return _buildTransportTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNeighborhoodHeader(),
        SizedBox(height: spLg),
        _buildScoreCards(),
        SizedBox(height: spLg),
        _buildHousingOverview(),
        SizedBox(height: spLg),
        _buildNeighborhoodFeatures(),
      ],
    );
  }

  Widget _buildNeighborhoodHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(204)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${neighborhoodData["name"]}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${neighborhoodData["city"]}",
            style: TextStyle(
              color: Colors.white.withAlpha(230),
              fontSize: 16,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${(neighborhoodData["population"] / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Population",
                      style: TextStyle(
                        color: Colors.white.withAlpha(179),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${(neighborhoodData["median_age"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Median Age",
                      style: TextStyle(
                        color: Colors.white.withAlpha(179),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${((neighborhoodData["median_income"] as double) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Median Income",
                      style: TextStyle(
                        color: Colors.white.withAlpha(179),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCards() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Neighborhood Scores",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 130,
            children: [
              _buildScoreCard("Walkability", neighborhoodData["walkability_score"], Icons.directions_walk, successColor),
              _buildScoreCard("Transit", neighborhoodData["transit_score"], Icons.train, infoColor),
              _buildScoreCard("Bike Score", neighborhoodData["bike_score"], Icons.directions_bike, warningColor),
              _buildScoreCard("Safety", ((neighborhoodData["safety_rating"] as double) * 10).toInt(), Icons.security, dangerColor),
              _buildScoreCard("Livability", neighborhoodData["livability_score"], Icons.home, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard(String title, int score, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(51)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          SizedBox(height: spSm),
          Text(
            "$score",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHousingOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Housing Types",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: housingData.map((housing) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${housing["type"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${(housing["percentage"] as double).toStringAsFixed(1)}% of housing",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${((housing["median_price"] as double) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNeighborhoodFeatures() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Neighborhood Features",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: neighborhoodFeatures.map((feature) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(feature["icon"], size: 24, color: primaryColor),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${feature["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: warningColor),
                            Text(
                              "${(feature["rating"] as double).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${feature["description"]}",
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
        ],
      ),
    );
  }

  Widget _buildDemographicsTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Age Demographics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(13),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pie_chart, size: 64, color: primaryColor),
                  SizedBox(height: spSm),
                  Text(
                    "Demographics Chart",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: demographicsData.map((demo) {
              return Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: demo["color"],
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${demo["category"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    "${(demo["percentage"] as double).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
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

  Widget _buildAmenitiesTab() {
    return Column(
      spacing: spLg,
      children: amenities.map((category) {
        return Container(
          padding: EdgeInsets.all(spMd),
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
                  Icon(category["icon"], size: 24, color: primaryColor),
                  SizedBox(width: spSm),
                  Text(
                    "${category["category"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Column(
                spacing: spSm,
                children: (category["items"] as List<dynamic>).map((item) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${(item["distance"] as double).toStringAsFixed(1)} mi away",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: warningColor),
                            SizedBox(width: spXs),
                            Text(
                              "${(item["rating"] as double).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).cast<Widget>().toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTransportTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transportation Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spMd,
            children: transportationOptions.map((transport) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          transport["type"] == "Metro Station" 
                              ? Icons.train
                              : transport["type"] == "Bus Stop"
                                  ? Icons.directions_bus
                                  : Icons.directions_bike,
                          size: 24,
                          color: primaryColor,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${transport["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${transport["type"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${(transport["distance"] as double).toStringAsFixed(1)} mi",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "${transport["walk_time"]} min walk",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spXs,
                      children: (transport["lines"] as List<dynamic>).map((line) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$line",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                            ),
                          ),
                        );
                      }).cast<Widget>().toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _viewMap() {
    ss("Opening neighborhood map view");
  }

  void _shareNeighborhoodInfo() {
    ss("Sharing neighborhood information");
  }
}
