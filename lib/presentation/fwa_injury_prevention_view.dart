import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaInjuryPreventionView extends StatefulWidget {
  const FwaInjuryPreventionView({super.key});

  @override
  State<FwaInjuryPreventionView> createState() => _FwaInjuryPreventionViewState();
}

class _FwaInjuryPreventionViewState extends State<FwaInjuryPreventionView> {
  String selectedCategory = "All";
  String selectedBodyPart = "All";
  
  List<String> categories = ["All", "Prevention Tips", "Recovery", "Strengthening", "Mobility"];
  List<String> bodyParts = ["All", "Knees", "Back", "Shoulders", "Ankles", "Wrists", "Hips"];
  
  List<Map<String, dynamic>> injuryPreventionData = [
    {
      "id": 1,
      "title": "Knee Injury Prevention",
      "category": "Prevention Tips",
      "bodyPart": "Knees",
      "duration": "5 min read",
      "level": "Beginner",
      "image": "https://picsum.photos/300/200?random=1&keyword=knee",
      "description": "Essential tips to protect your knees during workouts and daily activities",
      "keyPoints": [
        "Always warm up before exercise",
        "Use proper form during squats and lunges",
        "Strengthen quadriceps and hamstrings",
        "Avoid sudden direction changes"
      ],
      "exercises": ["Wall Sits", "Leg Raises", "Calf Raises"],
      "riskFactors": ["Previous injury", "Weak muscles", "Poor flexibility"]
    },
    {
      "id": 2,
      "title": "Lower Back Strengthening",
      "category": "Strengthening",
      "bodyPart": "Back",
      "duration": "15 min workout",
      "level": "Intermediate",
      "image": "https://picsum.photos/300/200?random=2&keyword=back",
      "description": "Exercises to build a strong, injury-resistant lower back",
      "keyPoints": [
        "Focus on core stability",
        "Maintain neutral spine alignment",
        "Progress gradually with weights",
        "Include both flexion and extension"
      ],
      "exercises": ["Bird Dog", "Dead Bug", "Glute Bridge", "Plank"],
      "riskFactors": ["Sedentary lifestyle", "Poor posture", "Weak core"]
    },
    {
      "id": 3,
      "title": "Shoulder Mobility Routine",
      "category": "Mobility",
      "bodyPart": "Shoulders",
      "duration": "10 min routine",
      "level": "Beginner",
      "image": "https://picsum.photos/300/200?random=3&keyword=shoulder",
      "description": "Daily mobility routine to prevent shoulder impingement and stiffness",
      "keyPoints": [
        "Perform gentle range of motion",
        "Focus on all planes of movement",
        "Hold stretches for 30 seconds",
        "Do twice daily for best results"
      ],
      "exercises": ["Arm Circles", "Cross Body Stretch", "Overhead Reach"],
      "riskFactors": ["Overhead activities", "Poor posture", "Muscle imbalances"]
    },
    {
      "id": 4,
      "title": "Ankle Sprain Recovery",
      "category": "Recovery",
      "bodyPart": "Ankles",
      "duration": "8 min read",
      "level": "Intermediate",
      "image": "https://picsum.photos/300/200?random=4&keyword=ankle",
      "description": "Complete guide to safely recovering from ankle sprains",
      "keyPoints": [
        "Follow R.I.C.E protocol initially",
        "Gradually restore range of motion",
        "Rebuild strength and stability",
        "Return to activity progressively"
      ],
      "exercises": ["Alphabet Draws", "Calf Raises", "Balance Training"],
      "riskFactors": ["Previous sprain", "Weak ankles", "Uneven surfaces"]
    },
    {
      "id": 5,
      "title": "Wrist Pain Prevention",
      "category": "Prevention Tips",
      "bodyPart": "Wrists",
      "duration": "6 min read",
      "level": "Beginner",
      "image": "https://picsum.photos/300/200?random=5&keyword=wrist",
      "description": "Protect your wrists from overuse injuries and strain",
      "keyPoints": [
        "Take regular breaks from typing",
        "Use proper wrist positioning",
        "Strengthen forearm muscles",
        "Stretch regularly throughout day"
      ],
      "exercises": ["Wrist Flexor Stretch", "Tendon Glides", "Grip Strengthening"],
      "riskFactors": ["Repetitive motions", "Poor ergonomics", "Weak forearms"]
    },
    {
      "id": 6,
      "title": "Hip Flexibility Program",
      "category": "Mobility",
      "bodyPart": "Hips",
      "duration": "12 min routine",
      "level": "Intermediate",
      "image": "https://picsum.photos/300/200?random=6&keyword=hip",
      "description": "Comprehensive program to improve hip mobility and prevent tightness",
      "keyPoints": [
        "Address all planes of hip motion",
        "Include both static and dynamic stretches",
        "Focus on hip flexors and glutes",
        "Practice daily for best results"
      ],
      "exercises": ["Hip Flexor Stretch", "90/90 Stretch", "Clamshells"],
      "riskFactors": ["Prolonged sitting", "Weak glutes", "Previous injury"]
    }
  ];

  List<Map<String, dynamic>> get filteredData {
    return injuryPreventionData.where((item) {
      bool categoryMatch = selectedCategory == "All" || (item["category"] as String) == selectedCategory;
      bool bodyPartMatch = selectedBodyPart == "All" || (item["bodyPart"] as String) == selectedBodyPart;
      
      return categoryMatch && bodyPartMatch;
    }).toList();
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case "Beginner": return successColor;
      case "Intermediate": return warningColor;
      case "Advanced": return dangerColor;
      default: return primaryColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Prevention Tips": return infoColor;
      case "Recovery": return warningColor;
      case "Strengthening": return primaryColor;
      case "Mobility": return successColor;
      default: return disabledBoldColor;
    }
  }

  Widget _buildStatsOverview() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Injury Prevention Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.shield, color: successColor, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "85%",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Preventable",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.trending_down, color: infoColor, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "60%",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Reduced Risk",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
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
    );
  }

  Widget _buildQuickTips() {
    List<Map<String, dynamic>> quickTips = [
      {
        "icon": Icons.fitness_center,
        "title": "Warm Up Always",
        "description": "5-10 minutes before exercise",
        "color": warningColor,
      },
      {
        "icon": Icons.self_improvement,
        "title": "Listen to Your Body",
        "description": "Stop if you feel pain",
        "color": dangerColor,
      },
      {
        "icon": Icons.schedule,
        "title": "Rest & Recovery",
        "description": "Allow 48 hours between intense sessions",
        "color": successColor,
      },
    ];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Prevention Tips",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          ...quickTips.map((tip) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (tip["color"] as Color).withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    tip["icon"] as IconData,
                    color: tip["color"] as Color,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${tip["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: tip["color"] as Color,
                          ),
                        ),
                        Text(
                          "${tip["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: tip["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Injury Prevention"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // View saved articles
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats overview
            _buildStatsOverview(),
            
            SizedBox(height: spMd),
            
            // Quick tips
            _buildQuickTips(),
            
            SizedBox(height: spMd),
            
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
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
                    label: "Body Part",
                    items: bodyParts.map((part) => {
                      "label": part,
                      "value": part,
                    }).toList(),
                    value: selectedBodyPart,
                    onChanged: (value, label) {
                      selectedBodyPart = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Content list
            Text(
              "Prevention Guides (${filteredData.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            ...filteredData.map((item) {
              Color levelColor = _getLevelColor(item["level"] as String);
              Color categoryColor = _getCategoryColor(item["category"] as String);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image and badges
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${item["image"]}",
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: spXs,
                          left: spXs,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: categoryColor.withAlpha(200),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${item["category"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: spXs,
                          right: spXs,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: levelColor.withAlpha(200),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${item["level"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Title and details
                    Text(
                      "${item["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Text(
                      "${item["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Meta information
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${item["duration"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${item["bodyPart"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.bookmark_border, size: 16, color: disabledBoldColor),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Action button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Read Guide",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to detailed guide
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
