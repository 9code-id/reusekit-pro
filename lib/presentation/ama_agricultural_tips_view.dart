import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaAgriculturalTipsView extends StatefulWidget {
  const AmaAgriculturalTipsView({super.key});

  @override
  State<AmaAgriculturalTipsView> createState() => _AmaAgriculturalTipsViewState();
}

class _AmaAgriculturalTipsViewState extends State<AmaAgriculturalTipsView> {
  List tips = [
    {
      "id": 1,
      "title": "Optimal Planting Times for Spring Crops",
      "category": "Planting",
      "difficulty": "Beginner",
      "reading_time": "3 min",
      "author": "Dr. Sarah Johnson",
      "date": "2024-01-20",
      "likes": 45,
      "views": 234,
      "summary": "Learn the best timing for planting spring vegetables based on soil temperature and frost dates.",
      "tips": [
        "Check soil temperature reaches 50°F consistently",
        "Wait 2 weeks after last frost date for warm-season crops",
        "Start seeds indoors 6-8 weeks before transplanting"
      ],
      "image": "https://picsum.photos/300/200?random=1&keyword=planting",
      "color": successColor,
      "icon": Icons.grass,
    },
    {
      "id": 2,
      "title": "Natural Pest Control Methods",
      "category": "Pest Management",
      "difficulty": "Intermediate",
      "reading_time": "5 min",
      "author": "Prof. Michael Chen",
      "date": "2024-01-18",
      "likes": 67,
      "views": 189,
      "summary": "Effective organic pest control strategies that protect crops without harmful chemicals.",
      "tips": [
        "Use companion planting to deter pests naturally",
        "Encourage beneficial insects with flower borders",
        "Apply neem oil spray during early morning or evening"
      ],
      "image": "https://picsum.photos/300/200?random=2&keyword=pest",
      "color": warningColor,
      "icon": Icons.bug_report,
    },
    {
      "id": 3,
      "title": "Water-Efficient Irrigation Techniques",
      "category": "Water Management",
      "difficulty": "Advanced",
      "reading_time": "7 min",
      "author": "Dr. Emma Rodriguez",
      "date": "2024-01-15",
      "likes": 52,
      "views": 156,
      "summary": "Maximize water efficiency and reduce costs with smart irrigation practices.",
      "tips": [
        "Install drip irrigation for 30% water savings",
        "Mulch around plants to retain soil moisture",
        "Water early morning to reduce evaporation"
      ],
      "image": "https://picsum.photos/300/200?random=3&keyword=irrigation",
      "color": infoColor,
      "icon": Icons.water_drop,
    },
    {
      "id": 4,
      "title": "Soil Health Improvement Strategies",
      "category": "Soil Management",
      "difficulty": "Intermediate",
      "reading_time": "6 min",
      "author": "Dr. Lisa Park",
      "date": "2024-01-12",
      "likes": 38,
      "views": 201,
      "summary": "Build healthy soil foundation for better crop yields and long-term sustainability.",
      "tips": [
        "Add compost regularly to improve soil structure",
        "Practice crop rotation to prevent nutrient depletion",
        "Test soil pH annually and adjust as needed"
      ],
      "image": "https://picsum.photos/300/200?random=4&keyword=soil",
      "color": primaryColor,
      "icon": Icons.landscape,
    },
    {
      "id": 5,
      "title": "Organic Fertilizer Application Guide",
      "category": "Fertilization",
      "difficulty": "Beginner",
      "reading_time": "4 min",
      "author": "James Mitchell",
      "date": "2024-01-10",
      "likes": 29,
      "views": 143,
      "summary": "Learn proper organic fertilizer timing and application methods for optimal results.",
      "tips": [
        "Apply compost in early spring before planting",
        "Use liquid fertilizer every 2-3 weeks during growing season",
        "Avoid over-fertilizing which can harm plants"
      ],
      "image": "https://picsum.photos/300/200?random=5&keyword=fertilizer",
      "color": secondaryColor,
      "icon": Icons.eco,
    },
    {
      "id": 6,
      "title": "Seasonal Crop Rotation Planning",
      "category": "Planning",
      "difficulty": "Advanced",
      "reading_time": "8 min",
      "author": "Dr. Sarah Johnson",
      "date": "2024-01-08",
      "likes": 41,
      "views": 178,
      "summary": "Maximize soil health and crop yields through strategic crop rotation planning.",
      "tips": [
        "Follow legumes with heavy feeders like corn",
        "Include cover crops in rotation cycle",
        "Keep detailed records of planted crops and locations"
      ],
      "image": "https://picsum.photos/300/200?random=6&keyword=rotation",
      "color": warningColor,
      "icon": Icons.refresh,
    },
  ];

  String selectedCategory = "All";
  String selectedDifficulty = "All";
  List<String> categories = ["All", "Planting", "Pest Management", "Water Management", "Soil Management", "Fertilization", "Planning"];
  List<String> difficulties = ["All", "Beginner", "Intermediate", "Advanced"];

  @override
  Widget build(BuildContext context) {
    List filteredTips = tips.where((tip) {
      bool categoryMatch = selectedCategory == "All" || tip["category"] == selectedCategory;
      bool difficultyMatch = selectedDifficulty == "All" || tip["difficulty"] == selectedDifficulty;
      return categoryMatch && difficultyMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Agricultural Tips"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // View bookmarked tips
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tips Overview
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
                        Icons.lightbulb,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Expert Agricultural Tips",
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
                              "${tips.length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Tips Available",
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
                              "${tips.fold(0, (sum, tip) => sum + (tip["views"] as int))}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Views",
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
                    label: "Submit Tip",
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {
                      // Submit new tip
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "My Bookmarks",
                    icon: Icons.bookmark,
                    size: bs.sm,
                    onPressed: () {
                      // View bookmarked tips
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
                    label: "Difficulty",
                    items: difficulties.map((diff) => {
                      "label": diff,
                      "value": diff,
                    }).toList(),
                    value: selectedDifficulty,
                    onChanged: (value, label) {
                      selectedDifficulty = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Tips List
            Text(
              "Agricultural Tips (${filteredTips.length})",
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
              itemCount: filteredTips.length,
              itemBuilder: (context, index) {
                final tip = filteredTips[index];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tip Image
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                        child: Stack(
                          children: [
                            Image.network(
                              "${tip["image"]}",
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withAlpha(100),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getDifficultyColor(tip["difficulty"]),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${tip["difficulty"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: (tip["color"] as Color).withAlpha(180),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  tip["icon"] as IconData,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Tip Content
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${tip["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: (tip["color"] as Color).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${tip["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: tip["color"] as Color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Summary
                            Text(
                              "${tip["summary"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Key Tips
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Key Tips:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                ...(tip["tips"] as List).map((tipText) => 
                                  Padding(
                                    padding: EdgeInsets.only(bottom: spXs),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 6),
                                          width: 4,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: tip["color"] as Color,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Expanded(
                                          child: Text(
                                            "$tipText",
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
                            
                            // Meta Information
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Icons.person, size: 14, color: disabledBoldColor),
                                        SizedBox(width: spXs),
                                        Expanded(
                                          child: Text(
                                            "${tip["author"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${tip["reading_time"]}",
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
                            
                            SizedBox(height: spSm),
                            
                            // Engagement Stats
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.favorite, size: 16, color: dangerColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${tip["likes"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: spSm),
                                Row(
                                  children: [
                                    Icon(Icons.visibility, size: 16, color: infoColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${tip["views"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  "${tip["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Actions
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Read More",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Read full tip
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.bookmark_border,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Bookmark tip
                                  },
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Share tip
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
