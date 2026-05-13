import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaMeditationView extends StatefulWidget {
  const HcaMeditationView({super.key});

  @override
  State<HcaMeditationView> createState() => _HcaMeditationViewState();
}

class _HcaMeditationViewState extends State<HcaMeditationView> {
  int selectedCategory = 0;
  String searchQuery = "";
  bool isPlaying = false;
  int currentSessionIndex = 0;
  double currentProgress = 0.0;
  
  final List<String> categories = [
    "All",
    "Beginner",
    "Sleep",
    "Stress",
    "Focus",
    "Anxiety",
    "Mindfulness",
    "Body Scan"
  ];

  final List<Map<String, dynamic>> meditationSessions = [
    {
      "id": "1",
      "title": "Peaceful Morning",
      "instructor": "Sarah Chen",
      "duration": 600,
      "category": "Beginner",
      "difficulty": "Easy",
      "description": "Start your day with calm and clarity through gentle breathing exercises",
      "rating": 4.8,
      "totalRatings": 1234,
      "image": "https://picsum.photos/300/200?random=1&keyword=meditation",
      "isPlaying": false,
      "completed": true,
      "type": "Guided",
      "benefits": ["Reduce stress", "Improve focus", "Better sleep"],
      "downloadSize": "15 MB"
    },
    {
      "id": "2",
      "title": "Deep Sleep Journey",
      "instructor": "Michael Torres",
      "duration": 1800,
      "category": "Sleep",
      "difficulty": "Beginner",
      "description": "Drift into peaceful sleep with this relaxing meditation session",
      "rating": 4.9,
      "totalRatings": 2156,
      "image": "https://picsum.photos/300/200?random=2&keyword=sleep",
      "isPlaying": false,
      "completed": false,
      "type": "Sleep",
      "benefits": ["Better sleep quality", "Reduce insomnia", "Deep relaxation"],
      "downloadSize": "45 MB"
    },
    {
      "id": "3",
      "title": "Stress Relief Express",
      "instructor": "Dr. Emma Wilson",
      "duration": 300,
      "category": "Stress",
      "difficulty": "Easy",
      "description": "Quick 5-minute session to release tension and stress",
      "rating": 4.7,
      "totalRatings": 856,
      "image": "https://picsum.photos/300/200?random=3&keyword=stress",
      "isPlaying": false,
      "completed": true,
      "type": "Quick",
      "benefits": ["Instant stress relief", "Calm mind", "Muscle relaxation"],
      "downloadSize": "8 MB"
    },
    {
      "id": "4",
      "title": "Focus & Concentration",
      "instructor": "James Rodriguez",
      "duration": 900,
      "category": "Focus",
      "difficulty": "Intermediate",
      "description": "Enhance your mental clarity and concentration abilities",
      "rating": 4.6,
      "totalRatings": 432,
      "image": "https://picsum.photos/300/200?random=4&keyword=focus",
      "isPlaying": false,
      "completed": false,
      "type": "Guided",
      "benefits": ["Better focus", "Mental clarity", "Productivity boost"],
      "downloadSize": "22 MB"
    },
    {
      "id": "5",
      "title": "Anxiety Relief",
      "instructor": "Dr. Lisa Park",
      "duration": 720,
      "category": "Anxiety",
      "difficulty": "Beginner",
      "description": "Gentle techniques to calm anxious thoughts and feelings",
      "rating": 4.9,
      "totalRatings": 1876,
      "image": "https://picsum.photos/300/200?random=5&keyword=anxiety",
      "isPlaying": false,
      "completed": true,
      "type": "Therapeutic",
      "benefits": ["Reduce anxiety", "Calm thoughts", "Emotional balance"],
      "downloadSize": "18 MB"
    },
    {
      "id": "6",
      "title": "Body Scan Relaxation",
      "instructor": "Maya Patel",
      "duration": 1200,
      "category": "Body Scan",
      "difficulty": "Intermediate",
      "description": "Progressive relaxation through mindful body awareness",
      "rating": 4.5,
      "totalRatings": 723,
      "image": "https://picsum.photos/300/200?random=6&keyword=body",
      "isPlaying": false,
      "completed": false,
      "type": "Body Work",
      "benefits": ["Body awareness", "Muscle relaxation", "Tension release"],
      "downloadSize": "28 MB"
    }
  ];

  List<Map<String, dynamic>> get filteredSessions {
    List<Map<String, dynamic>> filtered = meditationSessions;

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((session) {
        return "${session["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${session["instructor"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${session["category"]}".toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by category
    if (selectedCategory != 0) {
      String categoryFilter = categories[selectedCategory];
      filtered = filtered.where((session) {
        return "${session["category"]}" == categoryFilter;
      }).toList();
    }

    return filtered;
  }

  String formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    if (minutes < 60) {
      return "${minutes}m";
    } else {
      int hours = minutes ~/ 60;
      int remainingMinutes = minutes % 60;
      return "${hours}h ${remainingMinutes}m";
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return successColor;
      case 'beginner':
        return infoColor;
      case 'intermediate':
        return warningColor;
      case 'advanced':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'beginner':
        return infoColor;
      case 'sleep':
        return Colors.indigo;
      case 'stress':
        return dangerColor;
      case 'focus':
        return warningColor;
      case 'anxiety':
        return Colors.purple;
      case 'mindfulness':
        return successColor;
      case 'body scan':
        return Colors.teal;
      default:
        return primaryColor;
    }
  }

  Widget _buildSessionCard(Map<String, dynamic> session) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Session Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${session["image"]}",
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: _getCategoryColor("${session["category"]}"),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${session["category"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (session["completed"] as bool) ...[
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    formatDuration(session["duration"] as int),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Session Info
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${session["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor("${session["difficulty"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${session["difficulty"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getDifficultyColor("${session["difficulty"]}"),
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spXs),
                
                Text(
                  "by ${session["instructor"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Text(
                  "${session["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${session["rating"]} (${session["totalRatings"]})",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.headphones,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${session["type"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Benefits
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (session["benefits"] as List).map((benefit) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: primaryColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "$benefit",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: session["completed"] as bool ? "Play Again" : "Start Session",
                        size: bs.sm,
                        onPressed: () {
                          si("Starting meditation session: ${session["title"]}");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: () {
                        si("Downloading session (${session["downloadSize"]})");
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.favorite_border,
                      size: bs.sm,
                      onPressed: () {
                        si("Added to favorites");
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
  }

  Widget _buildQuickStats() {
    int totalSessions = meditationSessions.length;
    int completedSessions = meditationSessions.where((s) => s["completed"] as bool).length;
    double completionRate = totalSessions > 0 ? (completedSessions / totalSessions) * 100 : 0;
    int totalMinutes = meditationSessions
        .where((s) => s["completed"] as bool)
        .fold(0, (sum, session) => sum + (session["duration"] as int)) ~/ 60;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Text(
            "Your Progress",
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
                child: Column(
                  children: [
                    Text(
                      "$completedSessions",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Completed",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${totalMinutes}m",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Meditated",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${completionRate.toStringAsFixed(0)}%",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meditation"),
        actions: [
          IconButton(
            icon: Icon(Icons.library_music),
            onPressed: () {
              si("View music library");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Stats
            _buildQuickStats(),
            
            SizedBox(height: spMd),
            
            // Search
            QTextField(
              label: "Search meditation sessions...",
              value: searchQuery,
              hint: "Search by title, instructor, or category",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spSm),
            
            // Category Filter
            QCategoryPicker(
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: categories[selectedCategory],
              onChanged: (index, label, value, item) {
                selectedCategory = index;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Sessions Header
            Row(
              children: [
                Text(
                  "Meditation Sessions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredSessions.length} sessions",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Sessions List
            if (filteredSessions.isEmpty) ...[
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.self_improvement,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No sessions found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or category filter",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              ...filteredSessions.map((session) => _buildSessionCard(session)),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          si("Quick meditation start");
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }
}
