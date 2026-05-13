import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaMoodTrackerView extends StatefulWidget {
  const MhaMoodTrackerView({super.key});

  @override
  State<MhaMoodTrackerView> createState() => _MhaMoodTrackerViewState();
}

class _MhaMoodTrackerViewState extends State<MhaMoodTrackerView> {
  int currentTab = 0;
  Map<String, dynamic> todayMood = {
    "currentMood": "Happy",
    "moodScore": 4,
    "energy": 3,
    "stress": 2,
    "anxiety": 1,
    "lastUpdated": "14:30",
  };

  List<Map<String, dynamic>> moodOptions = [
    {
      "name": "Joyful",
      "score": 5,
      "emoji": "😄",
      "color": Colors.yellow[700],
      "description": "Feeling amazing and energetic",
    },
    {
      "name": "Happy",
      "score": 4,
      "emoji": "😊",
      "color": successColor,
      "description": "Feeling good and positive",
    },
    {
      "name": "Neutral",
      "score": 3,
      "emoji": "😐",
      "color": infoColor,
      "description": "Feeling okay, nothing special",
    },
    {
      "name": "Sad",
      "score": 2,
      "emoji": "😢",
      "color": warningColor,
      "description": "Feeling down or upset",
    },
    {
      "name": "Depressed",
      "score": 1,
      "emoji": "😞",
      "color": dangerColor,
      "description": "Feeling very low or hopeless",
    },
  ];

  List<Map<String, dynamic>> weeklyMoods = [
    {
      "day": "Mon",
      "date": "Jan 8",
      "mood": "Happy",
      "score": 4,
      "energy": 3,
      "stress": 2,
      "note": "Good start to the week",
    },
    {
      "day": "Tue",
      "date": "Jan 9",
      "mood": "Neutral",
      "score": 3,
      "energy": 2,
      "stress": 3,
      "note": "Busy workday",
    },
    {
      "day": "Wed",
      "date": "Jan 10",
      "mood": "Sad",
      "score": 2,
      "energy": 2,
      "stress": 4,
      "note": "Stressful presentation",
    },
    {
      "day": "Thu",
      "date": "Jan 11",
      "mood": "Happy",
      "score": 4,
      "energy": 4,
      "stress": 2,
      "note": "Great meeting with team",
    },
    {
      "day": "Fri",
      "date": "Jan 12",
      "mood": "Joyful",
      "score": 5,
      "energy": 4,
      "stress": 1,
      "note": "Weekend approaching!",
    },
    {
      "day": "Sat",
      "date": "Jan 13",
      "mood": "Happy",
      "score": 4,
      "energy": 3,
      "stress": 1,
      "note": "Relaxing weekend",
    },
    {
      "day": "Sun",
      "date": "Jan 14",
      "mood": "Happy",
      "score": 4,
      "energy": 3,
      "stress": 2,
      "note": "Preparing for new week",
    },
  ];

  List<Map<String, dynamic>> moodFactors = [
    {
      "name": "Work Stress",
      "impact": "Negative",
      "frequency": 4,
      "icon": Icons.work,
      "color": dangerColor,
    },
    {
      "name": "Exercise",
      "impact": "Positive",
      "frequency": 3,
      "icon": Icons.fitness_center,
      "color": successColor,
    },
    {
      "name": "Social Time",
      "impact": "Positive",
      "frequency": 2,
      "icon": Icons.people,
      "color": primaryColor,
    },
    {
      "name": "Sleep Quality",
      "impact": "Positive",
      "frequency": 5,
      "icon": Icons.bedtime,
      "color": infoColor,
    },
    {
      "name": "Financial Worry",
      "impact": "Negative",
      "frequency": 2,
      "icon": Icons.attach_money,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> activities = [
    {
      "name": "Meditation",
      "type": "Mindfulness",
      "duration": "10 min",
      "moodBoost": "+1",
      "icon": Icons.self_improvement,
      "color": primaryColor,
    },
    {
      "name": "Walking",
      "type": "Exercise",
      "duration": "30 min",
      "moodBoost": "+2",
      "icon": Icons.directions_walk,
      "color": successColor,
    },
    {
      "name": "Journaling",
      "type": "Reflection",
      "duration": "15 min",
      "moodBoost": "+1",
      "icon": Icons.edit_note,
      "color": infoColor,
    },
    {
      "name": "Music",
      "type": "Entertainment",
      "duration": "20 min",
      "moodBoost": "+1",
      "icon": Icons.music_note,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Mood Tracker",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Today", icon: Icon(Icons.today)),
        Tab(text: "Trends", icon: Icon(Icons.trending_up)),
        Tab(text: "Insights", icon: Icon(Icons.psychology)),
      ],
      tabChildren: [
        _buildTodayTab(),
        _buildTrendsTab(),
        _buildInsightsTab(),
      ],
    );
  }

  Widget _buildTodayTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCurrentMood(),
          _buildMoodSelector(),
          _buildMoodFactorsToday(),
          _buildSuggestedActivities(),
        ],
      ),
    );
  }

  Widget _buildCurrentMood() {
    String currentMood = todayMood["currentMood"] as String;
    int moodScore = todayMood["moodScore"] as int;
    int energy = todayMood["energy"] as int;
    int stress = todayMood["stress"] as int;
    int anxiety = todayMood["anxiety"] as int;
    
    Map<String, dynamic>? selectedMood = moodOptions.firstWhere((mood) => mood["name"] == currentMood);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.mood,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Current Mood",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (selectedMood["color"] as Color).withAlpha(20),
                    border: Border.all(
                      color: selectedMood["color"] as Color,
                      width: 3,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      selectedMood["emoji"] as String,
                      style: TextStyle(fontSize: 60),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      currentMood,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      selectedMood["description"] as String,
                      textAlign: TextAlign.center,
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
          Row(
            children: [
              _buildMoodMetric("Energy", energy, 5, successColor),
              SizedBox(width: spSm),
              _buildMoodMetric("Stress", stress, 5, dangerColor),
              SizedBox(width: spSm),
              _buildMoodMetric("Anxiety", anxiety, 5, warningColor),
            ],
          ),
          Text(
            "Last updated: ${todayMood["lastUpdated"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodMetric(String title, int value, int maxValue, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(maxValue, (index) {
                return Icon(
                  index < value ? Icons.circle : Icons.circle_outlined,
                  color: color,
                  size: 12,
                );
              }),
            ),
            Text(
              "$value/$maxValue",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodSelector() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.psychology,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "How are you feeling?",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            minItemWidth: 120,
            children: moodOptions.map((mood) {
              bool isSelected = mood["name"] == todayMood["currentMood"];
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    todayMood["currentMood"] = mood["name"];
                    todayMood["moodScore"] = mood["score"];
                    todayMood["lastUpdated"] = TimeOfDay.now().format(context);
                  });
                  ss("Mood updated to ${mood["name"]}");
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? (mood["color"] as Color).withAlpha(30) : (mood["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: mood["color"] as Color,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Text(
                        mood["emoji"] as String,
                        style: TextStyle(fontSize: 32),
                      ),
                      Text(
                        mood["name"] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: mood["color"] as Color,
                          size: 16,
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodFactorsToday() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.insights,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "What's affecting your mood?",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...moodFactors.take(3).map((factor) => _buildFactorTile(factor)).toList(),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add Note",
              icon: Icons.edit_note,
              size: bs.sm,
              onPressed: () {
                //navigateTo('AddMoodNoteView')
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFactorTile(Map<String, dynamic> factor) {
    Color factorColor = factor["color"] as Color;
    String impact = factor["impact"] as String;
    bool isPositive = impact == "Positive";
    
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: factorColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: factorColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            factor["icon"] as IconData,
            color: factorColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              factor["name"] as String,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Icon(
            isPositive ? Icons.trending_up : Icons.trending_down,
            color: isPositive ? successColor : dangerColor,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedActivities() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Mood Boosting Activities",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            minItemWidth: 140,
            children: activities.map((activity) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (activity["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: activity["color"] as Color,
                    width: 1,
                  ),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Icon(
                      activity["icon"] as IconData,
                      color: activity["color"] as Color,
                      size: 24,
                    ),
                    Text(
                      activity["name"] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      activity["type"] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      activity["duration"] as String,
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        activity["moodBoost"] as String,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildWeeklyMoodChart(),
          _buildMoodDistribution(),
        ],
      ),
    );
  }

  Widget _buildWeeklyMoodChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Weekly Mood Trend",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            height: 250,
            child: Column(
              spacing: spXs,
              children: weeklyMoods.map((day) {
                int score = day["score"] as int;
                String mood = day["mood"] as String;
                Map<String, dynamic>? moodData = moodOptions.firstWhere((m) => m["name"] == mood);
                Color moodColor = moodData["color"] as Color;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: moodColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: moodColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Column(
                          children: [
                            Text(
                              day["day"] as String,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              day["date"] as String,
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        moodData["emoji"] as String,
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              mood,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            if (day["note"] != null && (day["note"] as String).isNotEmpty)
                              Text(
                                day["note"] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < score ? Icons.star : Icons.star_border,
                            color: warningColor,
                            size: 12,
                          );
                        }),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodDistribution() {
    Map<String, int> moodCounts = {};
    for (var day in weeklyMoods) {
      String mood = day["mood"] as String;
      moodCounts[mood] = (moodCounts[mood] ?? 0) + 1;
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.pie_chart,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Mood Distribution",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...moodCounts.entries.map((entry) {
            String moodName = entry.key;
            int count = entry.value;
            double percentage = (count / weeklyMoods.length) * 100;
            
            Map<String, dynamic>? moodData = moodOptions.firstWhere((m) => m["name"] == moodName);
            Color moodColor = moodData["color"] as Color;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Row(
                children: [
                  Text(
                    moodData["emoji"] as String,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: spSm),
                  SizedBox(
                    width: 60,
                    child: Text(
                      moodName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: percentage / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: moodColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  SizedBox(
                    width: 40,
                    child: Text(
                      "${percentage.toInt()}%",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: moodColor,
                      ),
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

  Widget _buildInsightsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildMoodInsights(),
          _buildMoodFactorsAnalysis(),
        ],
      ),
    );
  }

  Widget _buildMoodInsights() {
    double avgScore = weeklyMoods.fold(0.0, (sum, day) => sum + (day["score"] as int)) / weeklyMoods.length;
    String mostCommonMood = weeklyMoods
        .fold<Map<String, int>>({}, (map, day) {
          String mood = day["mood"] as String;
          map[mood] = (map[mood] ?? 0) + 1;
          return map;
        })
        .entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.psychology,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Mood Insights",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildInsightCard("Average Mood", "${avgScore.toStringAsFixed(1)}/5", Icons.analytics, primaryColor),
              SizedBox(width: spSm),
              _buildInsightCard("Most Common", mostCommonMood, Icons.mood, successColor),
              SizedBox(width: spSm),
              _buildInsightCard("Streak", "3 days", Icons.local_fire_department, warningColor),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Personal Insight",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Your mood tends to be higher on weekends and after exercise. Consider scheduling more physical activities during weekdays.",
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
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodFactorsAnalysis() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.assessment,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Factors Analysis",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...moodFactors.map((factor) => _buildFactorAnalysisCard(factor)).toList(),
        ],
      ),
    );
  }

  Widget _buildFactorAnalysisCard(Map<String, dynamic> factor) {
    Color factorColor = factor["color"] as Color;
    String impact = factor["impact"] as String;
    int frequency = factor["frequency"] as int;
    bool isPositive = impact == "Positive";
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: factorColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: factorColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: factorColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              factor["icon"] as IconData,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      factor["name"] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: isPositive ? successColor : dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        impact,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Frequency:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    ...List.generate(5, (index) {
                      return Icon(
                        index < frequency ? Icons.circle : Icons.circle_outlined,
                        color: factorColor,
                        size: 10,
                      );
                    }),
                    Spacer(),
                    Text(
                      "$frequency/5",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: factorColor,
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
  }
}
