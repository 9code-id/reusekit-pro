import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaSustainabilityView extends StatefulWidget {
  const AmaSustainabilityView({super.key});

  @override
  State<AmaSustainabilityView> createState() => _AmaSustainabilityViewState();
}

class _AmaSustainabilityViewState extends State<AmaSustainabilityView> {
  int selectedTab = 0;
  
  List<Map<String, dynamic>> sustainabilityMetrics = [
    {
      "title": "Carbon Footprint",
      "current": 2.4,
      "target": 1.5,
      "unit": "tons CO₂",
      "trend": -12.5,
      "color": successColor,
      "icon": Icons.eco,
    },
    {
      "title": "Water Usage",
      "current": 847,
      "target": 650,
      "unit": "liters/kg",
      "trend": -18.3,
      "color": infoColor,
      "icon": Icons.water_drop,
    },
    {
      "title": "Soil Health",
      "current": 78,
      "target": 85,
      "unit": "% quality",
      "trend": 5.2,
      "color": primaryColor,
      "icon": Icons.agriculture,
    },
    {
      "title": "Biodiversity",
      "current": 67,
      "target": 80,
      "unit": "species count",
      "trend": 8.7,
      "color": warningColor,
      "icon": Icons.pets,
    },
  ];
  
  List<Map<String, dynamic>> sustainablePractices = [
    {
      "id": "1",
      "title": "Crop Rotation System",
      "description": "Implementing 4-season crop rotation to improve soil health and reduce pest dependency",
      "impact": "Reduces soil depletion by 40%",
      "difficulty": "Beginner",
      "timeframe": "1 season",
      "cost": "Low",
      "image": "https://picsum.photos/300/200?random=1&keyword=crops",
      "benefits": ["Soil Health", "Pest Control", "Yield Increase"],
      "steps": 4,
      "adopted": true,
    },
    {
      "id": "2",
      "title": "Drip Irrigation System",
      "description": "Installing precision drip irrigation to minimize water waste and optimize plant hydration",
      "impact": "Saves 60% water usage",
      "difficulty": "Intermediate",
      "timeframe": "2 weeks",
      "cost": "Medium",
      "image": "https://picsum.photos/300/200?random=2&keyword=irrigation",
      "benefits": ["Water Conservation", "Cost Reduction", "Efficiency"],
      "steps": 6,
      "adopted": false,
    },
    {
      "id": "3",
      "title": "Composting Program",
      "description": "Creating organic compost from farm waste to reduce chemical fertilizer dependency",
      "impact": "Eliminates 80% chemical fertilizers",
      "difficulty": "Beginner",
      "timeframe": "3 months",
      "cost": "Low",
      "image": "https://picsum.photos/300/200?random=3&keyword=compost",
      "benefits": ["Soil Enrichment", "Waste Reduction", "Cost Savings"],
      "steps": 3,
      "adopted": true,
    },
    {
      "id": "4",
      "title": "Solar Power Integration",
      "description": "Installing solar panels to power irrigation systems and reduce carbon footprint",
      "impact": "100% renewable energy",
      "difficulty": "Advanced",
      "timeframe": "1 month",
      "cost": "High",
      "image": "https://picsum.photos/300/200?random=4&keyword=solar",
      "benefits": ["Clean Energy", "Cost Reduction", "Independence"],
      "steps": 8,
      "adopted": false,
    },
    {
      "id": "5",
      "title": "Integrated Pest Management",
      "description": "Using beneficial insects and natural methods to control pests without chemicals",
      "impact": "95% reduction in pesticides",
      "difficulty": "Intermediate",
      "timeframe": "6 months",
      "cost": "Medium",
      "image": "https://picsum.photos/300/200?random=5&keyword=nature",
      "benefits": ["Chemical Reduction", "Biodiversity", "Food Safety"],
      "steps": 5,
      "adopted": true,
    },
  ];
  
  List<Map<String, dynamic>> certifications = [
    {
      "name": "Organic Certified",
      "status": "Certified",
      "validUntil": "2025-12-31", 
      "icon": Icons.verified,
      "color": successColor,
      "description": "USDA Organic certification for chemical-free farming practices",
    },
    {
      "name": "Carbon Neutral",
      "status": "In Progress",
      "validUntil": "2025-06-30",
      "icon": Icons.eco,
      "color": warningColor,
      "description": "Working towards carbon neutral certification through sustainable practices",
    },
    {
      "name": "Water Steward",
      "status": "Pending",
      "validUntil": "2024-12-31",
      "icon": Icons.water_drop,
      "color": infoColor,
      "description": "Application submitted for water conservation stewardship program",
    },
  ];

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getCostColor(String cost) {
    switch (cost) {
      case "Low":
        return successColor;
      case "Medium":
        return warningColor;
      case "High":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sustainability"),
        actions: [
          QButton(
            icon: Icons.track_changes,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Sustainability Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, primaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.eco,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Sustainable Agriculture",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Building a greener future through responsible farming",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "87%",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Sustainability Score",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "12",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Practices Adopted",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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
            
            // Sustainability Metrics
            Text(
              "Key Metrics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: sustainabilityMetrics.map((metric) {
                return Container(
                  padding: EdgeInsets.all(spMd),
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
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"] as IconData,
                              size: 24,
                              color: metric["color"] as Color,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${metric["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Text(
                            "${(metric["current"] as num).toString()}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: metric["color"] as Color,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${metric["unit"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      
                      Text(
                        "Target: ${(metric["target"] as num).toString()} ${metric["unit"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      Row(
                        children: [
                          Icon(
                            (metric["trend"] as num) > 0 ? Icons.trending_up : Icons.trending_down,
                            size: 16,
                            color: (metric["trend"] as num) > 0 ? successColor : dangerColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${(metric["trend"] as num) > 0 ? '+' : ''}${(metric["trend"] as num).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: (metric["trend"] as num) > 0 ? successColor : dangerColor,
                            ),
                          ),
                          Text(
                            " vs last month",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      
                      LinearProgressIndicator(
                        value: ((metric["current"] as num) / (metric["target"] as num)).clamp(0.0, 1.0),
                        backgroundColor: disabledOutlineBorderColor,
                        valueColor: AlwaysStoppedAnimation<Color>(metric["color"] as Color),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            // Sustainable Practices
            Row(
              children: [
                Text(
                  "Sustainable Practices",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "View All",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            
            ...List.generate(sustainablePractices.take(3).length, (index) {
              final practice = sustainablePractices[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Practice Image
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                      child: Stack(
                        children: [
                          Image.network(
                            "${practice["image"]}",
                            width: double.infinity,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                          if (practice["adopted"] as bool)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Adopted",
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
                        ],
                      ),
                    ),
                    
                    // Practice Content
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          // Title
                          Text(
                            "${practice["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          
                          // Description
                          Text(
                            "${practice["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),
                          
                          // Impact
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: successColor.withAlpha(30)),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.eco,
                                  size: 16,
                                  color: successColor,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${practice["impact"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Practice Details
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getDifficultyColor(practice["difficulty"] as String).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${practice["difficulty"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getDifficultyColor(practice["difficulty"] as String),
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getCostColor(practice["cost"] as String).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${practice["cost"]} Cost",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getCostColor(practice["cost"] as String),
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "⏱ ${practice["timeframe"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          // Benefits
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (practice["benefits"] as List<String>).map((benefit) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(color: primaryColor.withAlpha(30)),
                                ),
                                child: Text(
                                  benefit,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          
                          // Action Button
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: (practice["adopted"] as bool) ? "View Details" : "Start Implementation",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            
            // Certifications
            Text(
              "Certifications & Awards",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ...List.generate(certifications.length, (index) {
              final cert = certifications[index];
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (cert["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        cert["icon"] as IconData,
                        size: 32,
                        color: cert["color"] as Color,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${cert["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: (cert["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${cert["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: cert["color"] as Color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${cert["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Valid until: ${cert["validUntil"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      icon: Icons.open_in_new,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
