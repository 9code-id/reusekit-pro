import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaMeditationView extends StatefulWidget {
  const FwaMeditationView({super.key});

  @override
  State<FwaMeditationView> createState() => _FwaMeditationViewState();
}

class _FwaMeditationViewState extends State<FwaMeditationView> {
  int selectedCategory = 0;
  int selectedDuration = 0;
  bool isPlaying = false;
  int currentSessionTime = 0;
  int totalSessionTime = 600; // 10 minutes default
  
  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all"},
    {"label": "Sleep", "value": "sleep"},
    {"label": "Focus", "value": "focus"},
    {"label": "Anxiety", "value": "anxiety"},
    {"label": "Mindfulness", "value": "mindfulness"},
  ];

  final List<Map<String, dynamic>> durations = [
    {"label": "5 min", "value": 5},
    {"label": "10 min", "value": 10},
    {"label": "15 min", "value": 15},
    {"label": "20 min", "value": 20},
    {"label": "30 min", "value": 30},
  ];

  final List<Map<String, dynamic>> sessions = [
    {
      "id": 1,
      "title": "Deep Sleep Meditation",
      "instructor": "Dr. Sarah Williams",
      "duration": 20,
      "category": "sleep",
      "image": "https://picsum.photos/300/200?random=1&keyword=meditation",
      "rating": 4.9,
      "listens": 45000,
      "description": "Gentle guided meditation to help you fall into deep, restful sleep",
      "benefits": ["Better sleep quality", "Reduces insomnia", "Calms mind"],
      "background": "Rain sounds",
    },
    {
      "id": 2,
      "title": "Focus & Concentration",
      "instructor": "Michael Chen",
      "duration": 15,
      "category": "focus",
      "image": "https://picsum.photos/300/200?random=2&keyword=meditation",
      "rating": 4.8,
      "listens": 32000,
      "description": "Enhance your concentration and mental clarity",
      "benefits": ["Improved focus", "Better productivity", "Mental clarity"],
      "background": "Forest sounds",
    },
    {
      "id": 3,
      "title": "Anxiety Relief",
      "instructor": "Emma Rodriguez",
      "duration": 12,
      "category": "anxiety",
      "image": "https://picsum.photos/300/200?random=3&keyword=meditation",
      "rating": 4.7,
      "listens": 38000,
      "description": "Calm your anxious thoughts and find inner peace",
      "benefits": ["Reduces anxiety", "Promotes calm", "Stress relief"],
      "background": "Ocean waves",
    },
    {
      "id": 4,
      "title": "Morning Mindfulness",
      "instructor": "James Park",
      "duration": 10,
      "category": "mindfulness",
      "image": "https://picsum.photos/300/200?random=4&keyword=meditation",
      "rating": 4.8,
      "listens": 28000,
      "description": "Start your day with mindful awareness and intention",
      "benefits": ["Mindful awareness", "Positive start", "Mental preparation"],
      "background": "Birds chirping",
    },
    {
      "id": 5,
      "title": "Body Scan Relaxation",
      "instructor": "Lisa Thompson",
      "duration": 25,
      "category": "mindfulness",
      "image": "https://picsum.photos/300/200?random=5&keyword=meditation",
      "rating": 4.9,
      "listens": 22000,
      "description": "Progressive relaxation through body awareness",
      "benefits": ["Deep relaxation", "Body awareness", "Tension release"],
      "background": "Soft music",
    },
    {
      "id": 6,
      "title": "Quick Stress Relief",
      "instructor": "David Kim",
      "duration": 5,
      "category": "anxiety",
      "image": "https://picsum.photos/300/200?random=6&keyword=meditation",
      "rating": 4.6,
      "listens": 41000,
      "description": "Fast and effective stress relief for busy moments",
      "benefits": ["Quick relief", "Stress reduction", "Instant calm"],
      "background": "White noise",
    },
  ];

  List<Map<String, dynamic>> get filteredSessions {
    return sessions.where((session) {
      bool matchesCategory = selectedCategory == 0 || 
        session["category"] == categories[selectedCategory]["value"];
      bool matchesDuration = selectedDuration == 0 ||
        session["duration"] <= durations[selectedDuration]["value"];
      return matchesCategory && matchesDuration;
    }).toList();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meditation"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to meditation history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daily Meditation Progress
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's Progress",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.self_improvement, color: Colors.white),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "12 minutes",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "meditated today",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Center(
                          child: Text(
                            "3",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: Colors.white.withAlpha(50),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  
                  SizedBox(height: spXs),
                  
                  Text(
                    "Goal: 20 minutes",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Quick Start Session
            Container(
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
                      Icon(Icons.play_circle_fill, color: primaryColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Quick Start",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Duration Selector
                  Text(
                    "Choose Duration",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: durations.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> duration = entry.value;
                      bool isSelected = selectedDuration == index;
                      
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            selectedDuration = index;
                            totalSessionTime = duration["value"] * 60;
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: index < durations.length - 1 ? spXs : 0),
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.grey[100],
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Center(
                              child: Text(
                                "${duration["label"]}",
                                style: TextStyle(
                                  color: isSelected ? Colors.white : disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QButton(
                    label: "Start Free Meditation",
                    icon: Icons.play_arrow,
                    size: bs.md,
                    onPressed: () {
                      // Start free meditation
                    },
                  ),
                ],
              ),
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
            
            // Guided Sessions Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Guided Sessions (${filteredSessions.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // View all sessions
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Guided Sessions List
            ...filteredSessions.map((session) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    // Session Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${session["image"]}",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                    SizedBox(width: spMd),
                    
                    // Session Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${session["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Text(
                            "${session["instructor"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${session["duration"]} min",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(Icons.headphones, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${((session["listens"] as int) / 1000).toStringAsFixed(0)}K",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Icon(Icons.star, color: warningColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "${session["rating"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Text(
                                  "${session["background"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(width: spSm),
                    
                    // Play Button
                    GestureDetector(
                      onTap: () {
                        // Play meditation session
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}
