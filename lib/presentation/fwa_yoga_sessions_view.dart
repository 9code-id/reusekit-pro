import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaYogaSessionsView extends StatefulWidget {
  const FwaYogaSessionsView({super.key});

  @override
  State<FwaYogaSessionsView> createState() => _FwaYogaSessionsViewState();
}

class _FwaYogaSessionsViewState extends State<FwaYogaSessionsView> {
  int selectedCategory = 0;
  String searchQuery = "";
  
  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all"},
    {"label": "Beginner", "value": "beginner"},
    {"label": "Intermediate", "value": "intermediate"},
    {"label": "Advanced", "value": "advanced"},
    {"label": "Relaxation", "value": "relaxation"},
  ];

  final List<Map<String, dynamic>> sessions = [
    {
      "id": 1,
      "title": "Morning Sun Salutation",
      "instructor": "Sarah Johnson",
      "duration": 20,
      "difficulty": "Beginner",
      "image": "https://picsum.photos/300/200?random=1&keyword=yoga",
      "rating": 4.8,
      "participants": 1250,
      "category": "beginner",
      "description": "Start your day with this energizing sun salutation sequence",
      "benefits": ["Increases flexibility", "Boosts energy", "Improves focus"],
      "equipment": ["Yoga mat"],
    },
    {
      "id": 2,
      "title": "Stress Relief Flow",
      "instructor": "Michael Chen",
      "duration": 30,
      "difficulty": "Intermediate",
      "image": "https://picsum.photos/300/200?random=2&keyword=yoga",
      "rating": 4.9,
      "participants": 980,
      "category": "relaxation",
      "description": "Gentle flow to release tension and calm your mind",
      "benefits": ["Reduces stress", "Improves sleep", "Enhances mindfulness"],
      "equipment": ["Yoga mat", "Bolster"],
    },
    {
      "id": 3,
      "title": "Power Vinyasa",
      "instructor": "Amanda Torres",
      "duration": 45,
      "difficulty": "Advanced",
      "image": "https://picsum.photos/300/200?random=3&keyword=yoga",
      "rating": 4.7,
      "participants": 750,
      "category": "advanced",
      "description": "Dynamic flow for strength and endurance building",
      "benefits": ["Builds strength", "Improves stamina", "Enhances balance"],
      "equipment": ["Yoga mat", "Blocks"],
    },
    {
      "id": 4,
      "title": "Gentle Evening Yoga",
      "instructor": "Emma Williams",
      "duration": 25,
      "difficulty": "Beginner",
      "image": "https://picsum.photos/300/200?random=4&keyword=yoga",
      "rating": 4.6,
      "participants": 1100,
      "category": "relaxation",
      "description": "Calming poses to prepare your body for rest",
      "benefits": ["Promotes relaxation", "Better sleep", "Stress relief"],
      "equipment": ["Yoga mat", "Blanket"],
    },
    {
      "id": 5,
      "title": "Core Strengthening Flow",
      "instructor": "David Kim",
      "duration": 35,
      "difficulty": "Intermediate",
      "image": "https://picsum.photos/300/200?random=5&keyword=yoga",
      "rating": 4.8,
      "participants": 890,
      "category": "intermediate",
      "description": "Focus on building core strength and stability",
      "benefits": ["Strengthens core", "Improves posture", "Enhances stability"],
      "equipment": ["Yoga mat", "Blocks"],
    },
    {
      "id": 6,
      "title": "Yin Yoga Deep Stretch",
      "instructor": "Lisa Martinez",
      "duration": 60,
      "difficulty": "All Levels",
      "image": "https://picsum.photos/300/200?random=6&keyword=yoga",
      "rating": 4.9,
      "participants": 650,
      "category": "relaxation",
      "description": "Long-held poses for deep stretching and meditation",
      "benefits": ["Deep stretching", "Mindfulness", "Flexibility"],
      "equipment": ["Yoga mat", "Bolster", "Blocks"],
    },
  ];

  List<Map<String, dynamic>> get filteredSessions {
    return sessions.where((session) {
      bool matchesCategory = selectedCategory == 0 || 
        session["category"] == categories[selectedCategory]["value"];
      bool matchesSearch = searchQuery.isEmpty ||
        session["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        session["instructor"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yoga Sessions"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // Navigate to favorites
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search yoga sessions...",
                        prefixIcon: Icon(Icons.search, color: disabledBoldColor),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      ),
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.white),
                    onPressed: () {
                      // Show filter options
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Category Filter
            Text(
              "Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QCategoryPicker(
              items: categories,
              value: categories[selectedCategory]["value"],
              onChanged: (index, label, value, item) {
                selectedCategory = index;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Sessions Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Available Sessions (${filteredSessions.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Show sort options
                  },
                  child: Row(
                    children: [
                      Icon(Icons.sort, size: 20, color: primaryColor),
                      SizedBox(width: spXs),
                      Text(
                        "Sort",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Sessions List
            ...filteredSessions.map((session) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Session Image
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    child: Stack(
                      children: [
                        Image.network(
                          "${session["image"]}",
                          width: double.infinity,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "${session["duration"]} min",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
                              color: session["difficulty"] == "Beginner"
                                  ? successColor
                                  : session["difficulty"] == "Intermediate"
                                      ? warningColor
                                      : dangerColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "${session["difficulty"]}",
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
                  
                  // Session Info
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${session["title"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        SizedBox(height: spXs),
                        
                        Text(
                          "with ${session["instructor"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        Text(
                          "${session["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        
                        SizedBox(height: spMd),
                        
                        // Rating and Participants
                        Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 18),
                            SizedBox(width: spXs),
                            Text(
                              "${session["rating"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Icon(Icons.people, color: disabledBoldColor, size: 18),
                            SizedBox(width: spXs),
                            Text(
                              "${session["participants"]} joined",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spMd),
                        
                        // Benefits
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (session["benefits"] as List).map((benefit) => Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(color: primaryColor.withAlpha(50)),
                            ),
                            child: Text(
                              "$benefit",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )).toList(),
                        ),
                        
                        SizedBox(height: spMd),
                        
                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: QButton(
                                label: "Start Session",
                                size: bs.sm,
                                onPressed: () {
                                  // Start yoga session
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.favorite_border,
                              size: bs.sm,
                              onPressed: () {
                                // Add to favorites
                              },
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.share,
                              size: bs.sm,
                              onPressed: () {
                                // Share session
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
            
            // Load More Button
            if (filteredSessions.length >= 6)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Sessions",
                  size: bs.md,
                  onPressed: () {
                    // Load more sessions
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
