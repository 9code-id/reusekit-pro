import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaInterviewPreparationView extends StatefulWidget {
  const RhaInterviewPreparationView({super.key});

  @override
  State<RhaInterviewPreparationView> createState() => _RhaInterviewPreparationViewState();
}

class _RhaInterviewPreparationViewState extends State<RhaInterviewPreparationView> {
  String selectedCategory = "all";
  String searchQuery = "";
  int currentTab = 0;

  List<Map<String, dynamic>> preparationMaterials = [
    {
      "id": "PM001",
      "title": "JavaScript Interview Questions",
      "description": "Comprehensive collection of JavaScript technical questions and answers",
      "category": "technical",
      "difficulty": "intermediate",
      "duration": "45 min",
      "questions": 25,
      "completed": 18,
      "lastUpdated": "2024-06-15",
      "tags": ["JavaScript", "Programming", "Frontend"],
      "image": "https://picsum.photos/300/200?random=1&keyword=coding",
      "rating": 4.8,
      "reviews": 124,
    },
    {
      "id": "PM002",
      "title": "System Design Fundamentals",
      "description": "Learn the basics of system design for technical interviews",
      "category": "technical",
      "difficulty": "advanced",
      "duration": "90 min",
      "questions": 15,
      "completed": 8,
      "lastUpdated": "2024-06-14",
      "tags": ["System Design", "Architecture", "Scalability"],
      "image": "https://picsum.photos/300/200?random=2&keyword=architecture",
      "rating": 4.9,
      "reviews": 89,
    },
    {
      "id": "PM003",
      "title": "Behavioral Interview Preparation",
      "description": "Master behavioral questions using the STAR method",
      "category": "behavioral",
      "difficulty": "beginner",
      "duration": "30 min",
      "questions": 20,
      "completed": 20,
      "lastUpdated": "2024-06-13",
      "tags": ["Behavioral", "STAR Method", "Communication"],
      "image": "https://picsum.photos/300/200?random=3&keyword=meeting",
      "rating": 4.7,
      "reviews": 156,
    },
    {
      "id": "PM004",
      "title": "Company Culture & Values",
      "description": "Understanding our company culture and core values",
      "category": "company",
      "difficulty": "beginner",
      "duration": "20 min",
      "questions": 12,
      "completed": 12,
      "lastUpdated": "2024-06-12",
      "tags": ["Culture", "Values", "Company"],
      "image": "https://picsum.photos/300/200?random=4&keyword=office",
      "rating": 4.6,
      "reviews": 78,
    },
    {
      "id": "PM005",
      "title": "React Advanced Concepts",
      "description": "Deep dive into React hooks, context, and performance optimization",
      "category": "technical",
      "difficulty": "advanced",
      "duration": "60 min",
      "questions": 18,
      "completed": 5,
      "lastUpdated": "2024-06-11",
      "tags": ["React", "Hooks", "Performance"],
      "image": "https://picsum.photos/300/200?random=5&keyword=computer",
      "rating": 4.8,
      "reviews": 95,
    },
    {
      "id": "PM006",
      "title": "Leadership Interview Questions",
      "description": "Prepare for leadership and management role questions",
      "category": "behavioral",
      "difficulty": "intermediate",
      "duration": "40 min",
      "questions": 16,
      "completed": 0,
      "lastUpdated": "2024-06-10",
      "tags": ["Leadership", "Management", "Team"],
      "image": "https://picsum.photos/300/200?random=6&keyword=team",
      "rating": 4.5,
      "reviews": 67,
    },
  ];

  List<Map<String, dynamic>> quickTips = [
    {
      "title": "Research the Company",
      "description": "Learn about company history, mission, and recent news",
      "icon": Icons.business,
      "color": primaryColor,
    },
    {
      "title": "Prepare Your Stories",
      "description": "Use the STAR method for behavioral questions",
      "icon": Icons.auto_stories,
      "color": successColor,
    },
    {
      "title": "Practice Technical Skills",
      "description": "Review coding concepts and practice problems",
      "icon": Icons.code,
      "color": infoColor,
    },
    {
      "title": "Prepare Questions",
      "description": "Have thoughtful questions ready to ask the interviewer",
      "icon": Icons.help,
      "color": warningColor,
    },
    {
      "title": "Mock Interview",
      "description": "Practice with friends or use online platforms",
      "icon": Icons.record_voice_over,
      "color": dangerColor,
    },
    {
      "title": "Plan Your Outfit",
      "description": "Choose professional attire that makes you confident",
      "icon": Icons.checkroom,
      "color": secondaryColor,
    },
  ];

  List<Map<String, dynamic>> upcomingInterviews = [
    {
      "candidate": "Sarah Wilson",
      "position": "Senior Software Engineer",
      "date": "2024-06-20",
      "time": "10:00 AM",
      "round": "Technical Round 1",
      "preparationScore": 85,
    },
    {
      "candidate": "Michael Chen",
      "position": "Product Manager",
      "date": "2024-06-21",
      "time": "2:00 PM",
      "round": "Panel Interview",
      "preparationScore": 92,
    },
  ];

  List<Map<String, dynamic>> get filteredMaterials {
    return preparationMaterials.where((material) {
      bool matchesCategory = selectedCategory == "all" || material["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty ||
          (material["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (material["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "beginner":
        return successColor;
      case "intermediate":
        return warningColor;
      case "advanced":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String _getDifficultyLabel(String difficulty) {
    switch (difficulty) {
      case "beginner":
        return "Beginner";
      case "intermediate":
        return "Intermediate";
      case "advanced":
        return "Advanced";
      default:
        return "Unknown";
    }
  }

  Widget _buildMaterialCard(Map<String, dynamic> material) {
    double progress = (material["completed"] as int) / (material["questions"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and basic info
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
              image: DecorationImage(
                image: NetworkImage("${material["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusMd),
                      topRight: Radius.circular(radiusMd),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(128),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(material["difficulty"]),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      _getDifficultyLabel(material["difficulty"]),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: spSm,
                  left: spSm,
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${(material["rating"] as double).toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "(${material["reviews"]})",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${material["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${material["description"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                
                // Stats
                Row(
                  children: [
                    Icon(
                      Icons.timer,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${material["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.quiz,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${material["questions"]} questions",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Progress
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Progress",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${(progress * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress,
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Tags
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (material["tags"] as List).take(3).map((tag) => 
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "$tag",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ).toList(),
                ),
                SizedBox(height: spSm),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: progress == 1.0 ? "Review" : progress > 0 ? "Continue" : "Start",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.bookmark_border,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard(Map<String, dynamic> tip) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: (tip["color"] as Color).withAlpha(51),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              tip["icon"],
              color: tip["color"],
              size: 24,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${tip["title"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${tip["description"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingInterviewCard(Map<String, dynamic> interview) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${interview["candidate"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${interview["position"]} - ${interview["round"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: interview["preparationScore"] >= 80 ? 
                    successColor.withAlpha(51) : 
                    interview["preparationScore"] >= 60 ?
                      warningColor.withAlpha(51) :
                      dangerColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${interview["preparationScore"]}% Ready",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: interview["preparationScore"] >= 80 ? 
                      successColor : 
                      interview["preparationScore"] >= 60 ?
                        warningColor :
                        dangerColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spSm),
              Text(
                "${interview["date"]} at ${interview["time"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Preparation",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interview Preparation"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upcoming Interviews
            if (upcomingInterviews.isNotEmpty) ...[
              Text(
                "Upcoming Interviews",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ...upcomingInterviews.map((interview) => _buildUpcomingInterviewCard(interview)).toList(),
              SizedBox(height: spLg),
            ],
            
            // Quick Tips
            Text(
              "Quick Preparation Tips",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: quickTips.map((tip) => _buildTipCard(tip)).toList(),
            ),
            SizedBox(height: spLg),
            
            // Search and Filter
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search preparation materials",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            // Category Filter
            QCategoryPicker(
              items: [
                {"label": "All Categories", "value": "all"},
                {"label": "Technical", "value": "technical"},
                {"label": "Behavioral", "value": "behavioral"},
                {"label": "Company", "value": "company"},
              ],
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),
            
            // Preparation Materials
            Text(
              "Preparation Materials (${filteredMaterials.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 280,
              children: filteredMaterials.map((material) => _buildMaterialCard(material)).toList(),
            ),
            
            if (filteredMaterials.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.school,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No preparation materials found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
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
          ],
        ),
      ),
    );
  }
}
