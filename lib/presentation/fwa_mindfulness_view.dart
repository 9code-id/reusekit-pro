import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaMindfulnessView extends StatefulWidget {
  const FwaMindfulnessView({super.key});

  @override
  State<FwaMindfulnessView> createState() => _FwaMindfulnessViewState();
}

class _FwaMindfulnessViewState extends State<FwaMindfulnessView> {
  int selectedPractice = 0;
  bool isTimerActive = false;
  int mindfulnessStreak = 7;
  
  final List<Map<String, dynamic>> practices = [
    {
      "id": 1,
      "title": "Mindful Breathing",
      "description": "Focus on your breath to anchor your attention",
      "duration": "5-20 min",
      "difficulty": "Beginner",
      "icon": Icons.air,
      "color": Colors.blue,
      "benefits": ["Reduces anxiety", "Improves focus", "Calms mind"],
    },
    {
      "id": 2,
      "title": "Body Scan",
      "description": "Progressive awareness of bodily sensations",
      "duration": "10-30 min",
      "difficulty": "Beginner",
      "icon": Icons.accessibility_new,
      "color": Colors.green,
      "benefits": ["Deep relaxation", "Body awareness", "Stress relief"],
    },
    {
      "id": 3,
      "title": "Walking Meditation",
      "description": "Mindful movement and awareness",
      "duration": "10-15 min",
      "difficulty": "Intermediate",
      "icon": Icons.directions_walk,
      "color": Colors.orange,
      "benefits": ["Grounding", "Present moment", "Physical awareness"],
    },
    {
      "id": 4,
      "title": "Loving Kindness",
      "description": "Cultivate compassion for self and others",
      "duration": "15-25 min",
      "difficulty": "Intermediate",
      "icon": Icons.favorite,
      "color": Colors.pink,
      "benefits": ["Increases compassion", "Emotional balance", "Self-love"],
    },
    {
      "id": 5,
      "title": "Mindful Eating",
      "description": "Bring awareness to the eating experience",
      "duration": "15-30 min",
      "difficulty": "Beginner",
      "icon": Icons.restaurant,
      "color": Colors.purple,
      "benefits": ["Better digestion", "Mindful habits", "Appreciation"],
    },
    {
      "id": 6,
      "title": "Thought Observation",
      "description": "Watch thoughts without judgment",
      "duration": "10-20 min",
      "difficulty": "Advanced",
      "icon": Icons.psychology,
      "color": Colors.teal,
      "benefits": ["Mental clarity", "Emotional regulation", "Self-awareness"],
    },
  ];

  final List<Map<String, dynamic>> dailyPrompts = [
    {
      "title": "Morning Intention",
      "prompt": "What intention do you want to set for today?",
      "time": "Morning",
      "icon": Icons.wb_sunny,
    },
    {
      "title": "Midday Check-in",
      "prompt": "How are you feeling right now? Notice without judgment.",
      "time": "Afternoon",
      "icon": Icons.self_improvement,
    },
    {
      "title": "Evening Reflection",
      "prompt": "What are you grateful for today?",
      "time": "Evening",
      "icon": Icons.nights_stay,
    },
  ];

  final List<Map<String, dynamic>> mindfulnessTips = [
    {
      "title": "Start Small",
      "description": "Begin with just 2-3 minutes of daily practice",
      "icon": Icons.timer,
    },
    {
      "title": "Be Consistent",
      "description": "Regular short sessions are better than occasional long ones",
      "icon": Icons.repeat,
    },
    {
      "title": "No Judgment",
      "description": "Notice when your mind wanders and gently return to focus",
      "icon": Icons.psychology,
    },
    {
      "title": "Use Anchors",
      "description": "Return to breath, body, or sounds when distracted",
      "icon": Icons.anchor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mindfulness"),
        actions: [
          IconButton(
            icon: Icon(Icons.insights),
            onPressed: () {
              // View mindfulness insights
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mindfulness Streak
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mindfulness Streak",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Text(
                              "$mindfulnessStreak",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "days",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Keep it going! You're building a great habit.",
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
                    child: Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Today's Progress
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
                      Icon(Icons.today, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Today's Practice",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "practiced today",
                              style: TextStyle(
                                color: disabledBoldColor,
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
                              "3 sessions",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "completed",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                  
                  SizedBox(height: spXs),
                  
                  Text(
                    "Goal: 20 minutes daily",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Daily Prompts
            Text(
              "Daily Mindful Moments",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spMd),
            
            QHorizontalScroll(
              children: dailyPrompts.map((prompt) => Container(
                width: 280,
                margin: EdgeInsets.only(right: spMd),
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            prompt["icon"],
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${prompt["time"]}",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Text(
                      "${prompt["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      "${prompt["prompt"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    QButton(
                      label: "Reflect",
                      size: bs.sm,
                      onPressed: () {
                        // Open reflection prompt
                      },
                    ),
                  ],
                ),
              )).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Mindfulness Practices
            Text(
              "Mindfulness Practices",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: practices.map((practice) => Container(
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (practice["color"] as Color).withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            practice["icon"],
                            color: practice["color"],
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: practice["difficulty"] == "Beginner"
                                ? successColor.withAlpha(25)
                                : practice["difficulty"] == "Intermediate"
                                    ? warningColor.withAlpha(25)
                                    : dangerColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${practice["difficulty"]}",
                            style: TextStyle(
                              color: practice["difficulty"] == "Beginner"
                                  ? successColor
                                  : practice["difficulty"] == "Intermediate"
                                      ? warningColor
                                      : dangerColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Text(
                      "${practice["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Text(
                      "${practice["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${practice["duration"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Benefits
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (practice["benefits"] as List).take(2).map((benefit) => Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: (practice["color"] as Color).withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "$benefit",
                          style: TextStyle(
                            color: practice["color"],
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )).toList(),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    QButton(
                      label: "Start Practice",
                      size: bs.sm,
                      onPressed: () {
                        // Start mindfulness practice
                      },
                    ),
                  ],
                ),
              )).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Mindfulness Tips
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
                      Icon(Icons.lightbulb, color: warningColor),
                      SizedBox(width: spSm),
                      Text(
                        "Mindfulness Tips",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  ...mindfulnessTips.map((tip) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            tip["icon"],
                            color: warningColor,
                            size: 20,
                          ),
                        ),
                        
                        SizedBox(width: spMd),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${tip["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${tip["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
