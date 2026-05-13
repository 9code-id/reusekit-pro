import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaHealthTipsView extends StatefulWidget {
  const HcaHealthTipsView({super.key});

  @override
  State<HcaHealthTipsView> createState() => _HcaHealthTipsViewState();
}

class _HcaHealthTipsViewState extends State<HcaHealthTipsView> {
  String selectedCategory = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Nutrition", "value": "Nutrition"},
    {"label": "Exercise", "value": "Exercise"},
    {"label": "Mental Health", "value": "Mental Health"},
    {"label": "Chronic Care", "value": "Chronic Care"},
    {"label": "Preventive", "value": "Preventive"},
  ];

  List<Map<String, dynamic>> healthTips = [
    {
      "id": 1,
      "title": "5 Foods That Boost Heart Health",
      "category": "Nutrition",
      "readTime": "3 min read",
      "image": "https://picsum.photos/300/200?random=1&keyword=heart",
      "excerpt": "Discover the power foods that can significantly improve your cardiovascular health and reduce risk factors.",
      "author": "Dr. Sarah Johnson",
      "date": "2024-01-15",
      "likes": 245,
      "bookmarked": true,
      "difficulty": "Beginner",
      "tags": ["heart", "nutrition", "diet"]
    },
    {
      "id": 2,
      "title": "Managing Diabetes Through Daily Exercise",
      "category": "Chronic Care",
      "readTime": "5 min read",
      "image": "https://picsum.photos/300/200?random=2&keyword=exercise",
      "excerpt": "Learn effective exercise routines specifically designed for diabetes management and blood sugar control.",
      "author": "Dr. Michael Chen",
      "date": "2024-01-12",
      "likes": 189,
      "bookmarked": false,
      "difficulty": "Intermediate",
      "tags": ["diabetes", "exercise", "management"]
    },
    {
      "id": 3,
      "title": "Stress Management Techniques for Better Sleep",
      "category": "Mental Health",
      "readTime": "4 min read",
      "image": "https://picsum.photos/300/200?random=3&keyword=sleep",
      "excerpt": "Practical mindfulness and relaxation techniques to improve sleep quality and reduce anxiety.",
      "author": "Dr. Lisa Williams",
      "date": "2024-01-10",
      "likes": 312,
      "bookmarked": true,
      "difficulty": "Beginner",
      "tags": ["stress", "sleep", "mindfulness"]
    },
    {
      "id": 4,
      "title": "10-Minute Morning Workout Routine",
      "category": "Exercise",
      "readTime": "6 min read",
      "image": "https://picsum.photos/300/200?random=4&keyword=morning",
      "excerpt": "Start your day with this energizing workout routine that requires no equipment and fits any schedule.",
      "author": "Fitness Coach Alex",
      "date": "2024-01-08",
      "likes": 428,
      "bookmarked": false,
      "difficulty": "Beginner",
      "tags": ["morning", "workout", "quick"]
    },
    {
      "id": 5,
      "title": "Annual Health Screenings Checklist",
      "category": "Preventive",
      "readTime": "7 min read",
      "image": "https://picsum.photos/300/200?random=5&keyword=health",
      "excerpt": "Stay ahead of health issues with this comprehensive guide to essential annual health screenings by age group.",
      "author": "Dr. Robert Kim",
      "date": "2024-01-05",
      "likes": 156,
      "bookmarked": true,
      "difficulty": "Beginner",
      "tags": ["preventive", "screening", "health"]
    },
    {
      "id": 6,
      "title": "Healthy Meal Prep for Busy Professionals",
      "category": "Nutrition",
      "readTime": "8 min read",
      "image": "https://picsum.photos/300/200?random=6&keyword=meal",
      "excerpt": "Time-saving meal prep strategies with nutritious recipes perfect for maintaining health during busy work schedules.",
      "author": "Chef Maria Rodriguez",
      "date": "2024-01-03",
      "likes": 367,
      "bookmarked": false,
      "difficulty": "Intermediate",
      "tags": ["meal prep", "nutrition", "busy"]
    },
  ];

  List<Map<String, dynamic>> get filteredTips {
    var tips = healthTips;
    
    if (selectedCategory != "All") {
      tips = tips.where((tip) => tip["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      tips = tips.where((tip) => 
        "${tip["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${tip["excerpt"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        (tip["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()))
      ).toList();
    }
    
    return tips;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Tips"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // Show bookmarked tips
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share health tips
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search health tips...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {
                    // Perform search
                  },
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Category Filter
            QCategoryPicker(
              label: "Categories",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Featured Tip Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Featured Tip",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Daily Hydration Challenge",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Start your wellness journey with our 7-day hydration challenge. Track your daily water intake and feel the difference.",
                    style: TextStyle(
                      color: Colors.white.withAlpha(230),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Start Challenge",
                      color: Colors.white,
                      size: bs.sm,
                      onPressed: () {
                        // Start hydration challenge
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Tips Count and Filter Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredTips.length} Tips Available",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (selectedCategory != "All" || searchQuery.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      selectedCategory = "All";
                      searchQuery = "";
                      setState(() {});
                    },
                    child: Text(
                      "Clear Filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Health Tips List
            ...List.generate(filteredTips.length, (index) {
              final tip = filteredTips[index];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tip Image
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        topRight: Radius.circular(radiusLg),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            "${tip["image"]}",
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () {
                                tip["bookmarked"] = !(tip["bookmarked"] as bool);
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(230),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  tip["bookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                                  size: 20,
                                  color: tip["bookmarked"] ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getCategoryColor(tip["category"]),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${tip["category"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
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
                          // Title and Read Time
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${tip["readTime"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Excerpt
                          Text(
                            "${tip["excerpt"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Author and Date
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${tip["author"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${tip["date"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Tags and Difficulty
                          Row(
                            children: [
                              Expanded(
                                child: Wrap(
                                  spacing: spXs,
                                  children: ((tip["tags"] as List).take(3)).map<Widget>((tag) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(25),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "#$tag",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getDifficultyColor(tip["difficulty"]),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${tip["difficulty"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Read Article",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Read full article
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              GestureDetector(
                                onTap: () {
                                  tip["likes"] = (tip["likes"] as int) + 1;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: disabledColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        size: 16,
                                        color: dangerColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${tip["likes"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              GestureDetector(
                                onTap: () {
                                  // Share tip
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: disabledColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    Icons.share,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            
            if (filteredTips.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Health Tips Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search or category filter",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
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
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Nutrition":
        return successColor;
      case "Exercise":
        return infoColor;
      case "Mental Health":
        return warningColor;
      case "Chronic Care":
        return dangerColor;
      case "Preventive":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
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
