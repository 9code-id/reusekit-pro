import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaBestPracticesView extends StatefulWidget {
  const AmaBestPracticesView({super.key});

  @override
  State<AmaBestPracticesView> createState() => _AmaBestPracticesViewState();
}

class _AmaBestPracticesViewState extends State<AmaBestPracticesView> {
  List practices = [
    {
      "id": 1,
      "title": "Sustainable Soil Management",
      "category": "Soil Health",
      "implementation_level": "Essential",
      "cost_impact": "Low",
      "time_to_implement": "1-2 weeks",
      "environmental_benefit": "High",
      "yield_impact": "15-25% increase",
      "description": "Comprehensive soil health practices for long-term productivity",
      "steps": [
        "Conduct annual soil testing",
        "Implement cover cropping",
        "Reduce tillage operations",
        "Apply organic amendments"
      ],
      "benefits": [
        "Improved water retention",
        "Enhanced nutrient cycling",
        "Reduced erosion risk",
        "Better soil structure"
      ],
      "resources_needed": ["Soil test kit", "Cover crop seeds", "Compost"],
      "success_metrics": ["Organic matter %", "Water infiltration rate", "Soil pH"],
      "color": successColor,
      "icon": Icons.landscape,
    },
    {
      "id": 2,
      "title": "Integrated Pest Management",
      "category": "Pest Control",
      "implementation_level": "Recommended",
      "cost_impact": "Medium",
      "time_to_implement": "3-4 weeks",
      "environmental_benefit": "Very High",
      "yield_impact": "10-20% increase",
      "description": "Holistic approach to pest control minimizing chemical inputs",
      "steps": [
        "Monitor pest populations weekly",
        "Establish beneficial insect habitats",
        "Use biological control agents",
        "Apply targeted treatments only when needed"
      ],
      "benefits": [
        "Reduced pesticide costs",
        "Protected beneficial insects",
        "Lower chemical residues",
        "Sustainable pest control"
      ],
      "resources_needed": ["Monitoring tools", "Beneficial insects", "Trap crops"],
      "success_metrics": ["Pest damage %", "Beneficial insect count", "Pesticide usage"],
      "color": warningColor,
      "icon": Icons.bug_report,
    },
    {
      "id": 3,
      "title": "Water Conservation Strategies",
      "category": "Water Management",
      "implementation_level": "Essential",
      "cost_impact": "High",
      "time_to_implement": "4-6 weeks",
      "environmental_benefit": "High",
      "yield_impact": "20-30% increase",
      "description": "Efficient water use practices for sustainable farming",
      "steps": [
        "Install drip irrigation systems",
        "Implement mulching practices",
        "Schedule irrigation based on soil moisture",
        "Collect and use rainwater"
      ],
      "benefits": [
        "30-50% water savings",
        "Reduced utility costs",
        "Better plant health",
        "Drought resilience"
      ],
      "resources_needed": ["Drip irrigation kit", "Mulch materials", "Soil moisture sensors"],
      "success_metrics": ["Water usage per acre", "Irrigation efficiency", "Crop yield"],
      "color": infoColor,
      "icon": Icons.water_drop,
    },
    {
      "id": 4,
      "title": "Crop Rotation Planning",
      "category": "Planning",
      "implementation_level": "Recommended",
      "cost_impact": "Low",
      "time_to_implement": "Planning phase",
      "environmental_benefit": "High",
      "yield_impact": "15-20% increase",
      "description": "Strategic crop rotation for soil health and pest management",
      "steps": [
        "Map current crop locations",
        "Plan 3-4 year rotation cycle",
        "Include nitrogen-fixing crops",
        "Monitor soil nutrients"
      ],
      "benefits": [
        "Improved soil fertility",
        "Natural pest control",
        "Reduced input costs",
        "Risk diversification"
      ],
      "resources_needed": ["Field mapping tools", "Crop planning software", "Soil tests"],
      "success_metrics": ["Soil nitrogen levels", "Pest pressure", "Overall yield"],
      "color": primaryColor,
      "icon": Icons.refresh,
    },
    {
      "id": 5,
      "title": "Organic Certification Process",
      "category": "Certification",
      "implementation_level": "Optional",
      "cost_impact": "High",
      "time_to_implement": "6-12 months",
      "environmental_benefit": "Very High",
      "yield_impact": "Variable",
      "description": "Complete guide to achieving organic certification",
      "steps": [
        "Review organic standards",
        "Implement 3-year transition period",
        "Document all farming practices",
        "Schedule certification inspection"
      ],
      "benefits": [
        "Premium market prices",
        "Environmental sustainability",
        "Consumer trust",
        "Brand differentiation"
      ],
      "resources_needed": ["Organic inputs", "Record keeping system", "Certification fees"],
      "success_metrics": ["Certification status", "Premium pricing", "Market access"],
      "color": secondaryColor,
      "icon": Icons.eco,
    },
  ];

  String selectedCategory = "All";
  String selectedLevel = "All";
  List<String> categories = ["All", "Soil Health", "Pest Control", "Water Management", "Planning", "Certification"];
  List<String> levels = ["All", "Essential", "Recommended", "Optional"];

  @override
  Widget build(BuildContext context) {
    List filteredPractices = practices.where((practice) {
      bool categoryMatch = selectedCategory == "All" || practice["category"] == selectedCategory;
      bool levelMatch = selectedLevel == "All" || practice["implementation_level"] == selectedLevel;
      return categoryMatch && levelMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Best Practices"),
        actions: [
          IconButton(
            icon: Icon(Icons.checklist),
            onPressed: () {
              // View implementation checklist
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Best Practices Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Best Practices Guide",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                              "${practices.length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Practices Available",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${practices.where((p) => p["implementation_level"] == "Essential").length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Essential Practices",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
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
            
            SizedBox(height: spLg),
            
            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Implementation Plan",
                    icon: Icons.assignment,
                    size: bs.sm,
                    onPressed: () {
                      // Create implementation plan
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Success Tracker",
                    icon: Icons.track_changes,
                    size: bs.sm,
                    onPressed: () {
                      // Track implementation success
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories.map((cat) => {
                      "label": cat,
                      "value": cat,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Implementation Level",
                    items: levels.map((level) => {
                      "label": level,
                      "value": level,
                    }).toList(),
                    value: selectedLevel,
                    onChanged: (value, label) {
                      selectedLevel = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Best Practices List
            Text(
              "Best Practices (${filteredPractices.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredPractices.length,
              itemBuilder: (context, index) {
                final practice = filteredPractices[index];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: practice["color"] as Color,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (practice["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                practice["icon"] as IconData,
                                color: practice["color"] as Color,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${practice["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getLevelColor(practice["implementation_level"]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${practice["implementation_level"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: _getLevelColor(practice["implementation_level"]),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${practice["category"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Description
                        Text(
                          "${practice["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Impact Metrics
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Icons.trending_up, size: 14, color: successColor),
                                        SizedBox(width: spXs),
                                        Text("${practice["yield_impact"]}", 
                                             style: TextStyle(fontSize: 12, color: disabledBoldColor, fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                                        SizedBox(width: spXs),
                                        Text("${practice["time_to_implement"]}", 
                                             style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Icons.monetization_on, size: 14, color: warningColor),
                                        SizedBox(width: spXs),
                                        Text("${practice["cost_impact"]} cost", 
                                             style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Icons.eco, size: 14, color: successColor),
                                        SizedBox(width: spXs),
                                        Text("${practice["environmental_benefit"]} benefit", 
                                             style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Implementation Steps
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Implementation Steps:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(practice["steps"] as List).asMap().entries.map((entry) => 
                              Padding(
                                padding: EdgeInsets.only(bottom: spXs),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: practice["color"] as Color,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        "${entry.key + 1}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        entry.value,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                          height: 1.3,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Benefits
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Key Benefits:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (practice["benefits"] as List).map((benefit) => 
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$benefit",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ).toList(),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Actions
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Start Implementation",
                                size: bs.sm,
                                onPressed: () {
                                  // Start implementing practice
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Details",
                              icon: Icons.info,
                              size: bs.sm,
                              onPressed: () {
                                // View detailed guide
                              },
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.bookmark_border,
                              size: bs.sm,
                              onPressed: () {
                                // Bookmark practice
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case "Essential":
        return dangerColor;
      case "Recommended":
        return warningColor;
      case "Optional":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
