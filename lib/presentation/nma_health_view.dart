import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaHealthView extends StatefulWidget {
  const NmaHealthView({super.key});

  @override
  State<NmaHealthView> createState() => _NmaHealthViewState();
}

class _NmaHealthViewState extends State<NmaHealthView> {
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Medical", "value": "Medical"},
    {"label": "Nutrition", "value": "Nutrition"},
    {"label": "Fitness", "value": "Fitness"},
    {"label": "Mental Health", "value": "Mental Health"},
    {"label": "Wellness", "value": "Wellness"},
    {"label": "Prevention", "value": "Prevention"},
  ];

  List<Map<String, dynamic>> breakingHealthNews = [
    {
      "id": 1,
      "title": "FDA Approves Revolutionary Cancer Treatment",
      "summary": "New immunotherapy drug shows 85% success rate in clinical trials, offering hope for stage 4 patients",
      "category": "Medical",
      "author": "Dr. Sarah Mitchell",
      "publishedAt": "2024-12-15T16:30:00Z",
      "imageUrl": "https://picsum.photos/400/250?random=1&keyword=medical",
      "readTime": "5 min read",
      "isBreaking": true,
      "urgency": "high",
    },
    {
      "id": 2,
      "title": "Mediterranean Diet Reduces Heart Disease Risk by 40%",
      "summary": "Long-term study of 50,000 participants confirms significant cardiovascular benefits",
      "category": "Nutrition",
      "author": "Dr. Maria Rodriguez",
      "publishedAt": "2024-12-15T14:15:00Z",
      "imageUrl": "https://picsum.photos/400/250?random=2&keyword=nutrition",
      "readTime": "4 min read",
      "isBreaking": false,
      "urgency": "medium",
    },
  ];

  List<Map<String, dynamic>> healthTips = [
    {
      "id": 3,
      "title": "10 Simple Ways to Boost Your Immune System",
      "category": "Wellness",
      "tips": [
        "Get 7-9 hours of quality sleep",
        "Eat colorful fruits and vegetables",
        "Exercise regularly for 30 minutes",
        "Manage stress through meditation",
        "Stay hydrated with 8 glasses of water",
      ],
      "author": "Dr. James Wilson",
      "publishedAt": "2024-12-15T12:00:00Z",
      "imageUrl": "https://picsum.photos/300/200?random=3&keyword=wellness",
    },
    {
      "id": 4,
      "title": "Mental Health: Recognizing Signs of Depression",
      "category": "Mental Health",
      "tips": [
        "Persistent sadness or emptiness",
        "Loss of interest in activities",
        "Changes in appetite or sleep",
        "Difficulty concentrating",
        "Feelings of worthlessness",
      ],
      "author": "Dr. Emily Chen",
      "publishedAt": "2024-12-15T10:30:00Z",
      "imageUrl": "https://picsum.photos/300/200?random=4&keyword=mental",
    },
  ];

  List<Map<String, dynamic>> medicalBreakthroughs = [
    {
      "title": "Gene Therapy Restores Vision in Blind Patients",
      "description": "Clinical trial shows remarkable success in treating inherited blindness",
      "category": "Medical",
      "impact": "High",
      "publishedAt": "2024-12-15T11:45:00Z",
    },
    {
      "title": "AI Detects Early Alzheimer's with 95% Accuracy",
      "description": "Machine learning algorithm analyzes brain scans to predict disease onset",
      "category": "Medical",
      "impact": "High",
      "publishedAt": "2024-12-15T09:20:00Z",
    },
    {
      "title": "New Diabetes Drug Reduces Blood Sugar by 60%",
      "description": "Revolutionary treatment offers hope for Type 2 diabetes patients",
      "category": "Medical",
      "impact": "Medium",
      "publishedAt": "2024-12-15T08:15:00Z",
    },
  ];

  List<Map<String, dynamic>> nutritionNews = [
    {
      "title": "Plant-Based Proteins: Complete Guide for Athletes",
      "summary": "Comprehensive analysis of protein sources for optimal performance",
      "category": "Nutrition",
      "readTime": "6 min read",
      "author": "Nutritionist Lisa Park",
      "publishedAt": "2024-12-15T13:30:00Z",
      "imageUrl": "https://picsum.photos/250/150?random=5&keyword=protein",
    },
    {
      "title": "Intermittent Fasting: Benefits and Risks Explained",
      "summary": "Latest research on popular diet trend reveals surprising findings",
      "category": "Nutrition",
      "readTime": "4 min read",
      "author": "Dr. Robert Kim",
      "publishedAt": "2024-12-15T11:00:00Z",
      "imageUrl": "https://picsum.photos/250/150?random=6&keyword=fasting",
    },
  ];

  List<Map<String, dynamic>> fitnessUpdates = [
    {
      "title": "High-Intensity Interval Training (HIIT) Best Practices",
      "duration": "20 min workout",
      "difficulty": "Intermediate",
      "equipment": "None required",
      "calories": 300,
      "description": "Effective full-body workout that maximizes fat burning in minimal time",
      "publishedAt": "2024-12-15T15:00:00Z",
    },
    {
      "title": "Yoga for Beginners: 30-Day Challenge",
      "duration": "15 min daily",
      "difficulty": "Beginner",
      "equipment": "Yoga mat",
      "calories": 150,
      "description": "Gentle introduction to yoga poses focusing on flexibility and mindfulness",
      "publishedAt": "2024-12-15T14:20:00Z",
    },
  ];

  List<Map<String, dynamic>> healthAlerts = [
    {
      "type": "warning",
      "title": "Seasonal Flu Activity Increases",
      "message": "Health officials recommend getting vaccinated as flu cases rise by 35%",
      "action": "Get Vaccinated",
      "urgency": "medium",
    },
    {
      "type": "info",
      "title": "New CDC Guidelines for Heart Health",
      "message": "Updated recommendations for cholesterol management and exercise",
      "action": "Read Guidelines",
      "urgency": "low",
    },
  ];

  List<Map<String, dynamic>> expertInterviews = [
    {
      "expert": "Dr. Amanda Foster",
      "title": "Leading Cardiologist",
      "topic": "Heart Disease Prevention in Young Adults",
      "duration": "12 min",
      "publishedAt": "2024-12-15T16:00:00Z",
      "imageUrl": "https://picsum.photos/100/100?random=7&keyword=doctor",
      "keyPoints": [
        "Exercise regularly from early age",
        "Monitor blood pressure annually",
        "Maintain healthy diet and weight",
      ],
    },
    {
      "expert": "Dr. Michael Thompson",
      "title": "Infectious Disease Specialist",
      "topic": "Antibiotic Resistance: What You Need to Know",
      "duration": "15 min",
      "publishedAt": "2024-12-15T13:45:00Z",
      "imageUrl": "https://picsum.photos/100/100?random=8&keyword=scientist",
      "keyPoints": [
        "Complete full antibiotic courses",
        "Don't share antibiotics",
        "Proper hygiene prevents infections",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health News"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // Bookmarks
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Category Filter
            QCategoryPicker(
              label: "Health Categories",
              items: categoryItems,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Health Alerts Section
            Container(
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
                        Icons.warning_amber,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Health Alerts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: healthAlerts.map((alert) {
                      Color alertColor = alert["type"] == "warning" ? warningColor : infoColor;
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: alertColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: alertColor.withAlpha(30)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              alert["type"] == "warning" ? Icons.warning : Icons.info,
                              color: alertColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${alert["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: alertColor,
                                    ),
                                  ),
                                  Text(
                                    "${alert["message"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "${alert["action"]}",
                              size: bs.sm,
                              onPressed: () {
                                // Handle alert action
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Breaking Health News
            Container(
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
                        Icons.flash_on,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Breaking Health News",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: breakingHealthNews.map((news) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to full article
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusSm),
                                    topRight: Radius.circular(radiusSm),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage("${news["imageUrl"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    if (news["isBreaking"])
                                      Positioned(
                                        top: spSm,
                                        left: spSm,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: dangerColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "BREAKING",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Positioned(
                                      top: spSm,
                                      right: spSm,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getUrgencyColor(news["urgency"]),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${news["urgency"]}".toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(spSm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${news["category"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${news["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${news["summary"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "By ${news["author"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "${news["readTime"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${DateTime.parse(news["publishedAt"]).dMMMy}",
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
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Medical Breakthroughs
            Container(
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
                        Icons.science,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Medical Breakthroughs",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: medicalBreakthroughs.map((breakthrough) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getImpactColor(breakthrough["impact"]),
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${breakthrough["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getImpactColor(breakthrough["impact"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${breakthrough["impact"]} Impact",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getImpactColor(breakthrough["impact"]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${breakthrough["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${breakthrough["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${DateTime.parse(breakthrough["publishedAt"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 10,
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

            // Health Tips Section
            Container(
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
                        Icons.lightbulb,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Health Tips & Guides",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: healthTips.map((tip) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    image: DecorationImage(
                                      image: NetworkImage("${tip["imageUrl"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: successColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${tip["category"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${tip["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "By ${tip["author"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: (tip["tips"] as List).map((tipItem) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 6),
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "$tipItem",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
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
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Nutrition & Fitness News
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                // Nutrition News
                Container(
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
                            Icons.restaurant,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Nutrition News",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: spXs,
                        children: nutritionNews.map((news) {
                          return GestureDetector(
                            onTap: () {
                              // Navigate to nutrition article
                            },
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(radiusSm),
                                      image: DecorationImage(
                                        image: NetworkImage("${news["imageUrl"]}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: 2,
                                      children: [
                                        Text(
                                          "${news["title"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "${news["readTime"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
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

                // Fitness Updates
                Container(
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
                            Icons.fitness_center,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Fitness Updates",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: spXs,
                        children: fitnessUpdates.map((fitness) {
                          return Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${fitness["title"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: warningColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: Text(
                                        "${fitness["difficulty"]}",
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                          color: warningColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${fitness["duration"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${fitness["description"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.local_fire_department,
                                      color: dangerColor,
                                      size: 12,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${fitness["calories"]} cal",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: dangerColor,
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
              ],
            ),

            // Expert Interviews
            Container(
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
                        Icons.record_voice_over,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Expert Interviews",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: expertInterviews.map((interview) {
                      return GestureDetector(
                        onTap: () {
                          // Play interview
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage("${interview["imageUrl"]}"),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "${interview["expert"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${interview["title"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${interview["topic"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "Duration: ${interview["duration"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.play_circle_filled,
                                color: primaryColor,
                                size: 32,
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
    );
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getImpactColor(String impact) {
    switch (impact) {
      case "High":
        return successColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
