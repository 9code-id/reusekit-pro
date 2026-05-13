import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaMoodTrackerView extends StatefulWidget {
  const FwaMoodTrackerView({super.key});

  @override
  State<FwaMoodTrackerView> createState() => _FwaMoodTrackerViewState();
}

class _FwaMoodTrackerViewState extends State<FwaMoodTrackerView> {
  int selectedMood = 3; // 1-5 scale
  int selectedEnergy = 3;
  int selectedStress = 3;
  int selectedSleep = 3;
  String moodNote = "";
  
  final List<Map<String, dynamic>> moods = [
    {"emoji": "😭", "label": "Terrible", "value": 1, "color": dangerColor},
    {"emoji": "😢", "label": "Bad", "value": 2, "color": Colors.orange},
    {"emoji": "😐", "label": "Okay", "value": 3, "color": warningColor},
    {"emoji": "😊", "label": "Good", "value": 4, "color": successColor},
    {"emoji": "😄", "label": "Great", "value": 5, "color": primaryColor},
  ];

  final List<Map<String, dynamic>> weeklyMoods = [
    {"day": "Mon", "mood": 3, "energy": 2, "stress": 4, "sleep": 3},
    {"day": "Tue", "mood": 4, "energy": 4, "stress": 2, "sleep": 4},
    {"day": "Wed", "mood": 2, "energy": 2, "stress": 5, "sleep": 2},
    {"day": "Thu", "mood": 4, "energy": 3, "stress": 3, "sleep": 4},
    {"day": "Fri", "mood": 5, "energy": 5, "stress": 1, "sleep": 4},
    {"day": "Sat", "mood": 5, "energy": 4, "stress": 1, "sleep": 5},
    {"day": "Sun", "mood": 4, "energy": 3, "stress": 2, "sleep": 4},
  ];

  final List<Map<String, dynamic>> moodEntries = [
    {
      "date": "Today, 2:30 PM",
      "mood": 4,
      "energy": 3,
      "stress": 2,
      "sleep": 4,
      "note": "Had a great workout this morning. Feeling energized and positive!",
      "tags": ["exercise", "positive", "energized"],
    },
    {
      "date": "Yesterday, 8:45 PM",
      "mood": 3,
      "energy": 2,
      "stress": 4,
      "sleep": 3,
      "note": "Long day at work. Feeling a bit overwhelmed but trying to stay positive.",
      "tags": ["work", "tired", "overwhelmed"],
    },
    {
      "date": "2 days ago, 10:15 AM",
      "mood": 5,
      "energy": 5,
      "stress": 1,
      "sleep": 5,
      "note": "Excellent sleep last night! Woke up refreshed and ready for the day.",
      "tags": ["sleep", "refreshed", "excellent"],
    },
    {
      "date": "3 days ago, 6:20 PM",
      "mood": 2,
      "energy": 2,
      "stress": 5,
      "sleep": 2,
      "note": "Difficult day. Had an argument with a friend and couldn't sleep well.",
      "tags": ["conflict", "sleepless", "difficult"],
    },
  ];

  final List<String> moodTags = [
    "happy", "sad", "anxious", "excited", "calm", "stressed", "energized", 
    "tired", "motivated", "frustrated", "grateful", "overwhelmed", "peaceful", 
    "angry", "content", "worried", "optimistic", "lonely", "confident", "relaxed"
  ];

  Color getMoodColor(int moodValue) {
    return moods.firstWhere((mood) => mood["value"] == moodValue)["color"];
  }

  String getMoodEmoji(int moodValue) {
    return moods.firstWhere((mood) => mood["value"] == moodValue)["emoji"];
  }

  String getMoodLabel(int moodValue) {
    return moods.firstWhere((mood) => mood["value"] == moodValue)["label"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mood Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // View mood analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Today's Mood Summary
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
                        "How are you feeling today?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        getMoodEmoji(selectedMood),
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Current mood: ${getMoodLabel(selectedMood)}",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 16,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QButton(
                    label: "Update Mood",
                    size: bs.sm,
                    onPressed: () {
                      // Show mood selector
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Quick Mood Selector
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
                  Text(
                    "Quick Mood Check",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Mood Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: moods.map((mood) {
                      bool isSelected = selectedMood == mood["value"];
                      return GestureDetector(
                        onTap: () {
                          selectedMood = mood["value"];
                          setState(() {});
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? mood["color"].withAlpha(25)
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: isSelected
                                ? Border.all(color: mood["color"], width: 2)
                                : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${mood["emoji"]}",
                                style: TextStyle(fontSize: 24),
                              ),
                              Text(
                                "${mood["label"]}",
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? mood["color"] : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Additional Metrics
                  Column(
                    children: [
                      // Energy Level
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Energy Level",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: List.generate(5, (index) {
                                bool isActive = index < selectedEnergy;
                                return GestureDetector(
                                  onTap: () {
                                    selectedEnergy = index + 1;
                                    setState(() {});
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: spXs),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: isActive ? warningColor : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: isActive
                                        ? Icon(Icons.bolt, color: Colors.white, size: 12)
                                        : null,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Stress Level
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Stress Level",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: List.generate(5, (index) {
                                bool isActive = index < selectedStress;
                                return GestureDetector(
                                  onTap: () {
                                    selectedStress = index + 1;
                                    setState(() {});
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: spXs),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: isActive ? dangerColor : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: isActive
                                        ? Icon(Icons.warning, color: Colors.white, size: 12)
                                        : null,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Sleep Quality
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Sleep Quality",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: List.generate(5, (index) {
                                bool isActive = index < selectedSleep;
                                return GestureDetector(
                                  onTap: () {
                                    selectedSleep = index + 1;
                                    setState(() {});
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: spXs),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: isActive ? primaryColor : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: isActive
                                        ? Icon(Icons.bedtime, color: Colors.white, size: 12)
                                        : null,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Notes Section
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Add a note about your mood...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(radiusSm),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      contentPadding: EdgeInsets.all(spMd),
                    ),
                    maxLines: 3,
                    onChanged: (value) {
                      moodNote = value;
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QButton(
                    label: "Save Mood Entry",
                    size: bs.md,
                    onPressed: () {
                      // Save mood entry
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Weekly Mood Chart
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "This Week's Mood",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // View detailed analytics
                        },
                        child: Text(
                          "View Details",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: weeklyMoods.map((dayData) => Column(
                      children: [
                        Text(
                          "${dayData["day"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: getMoodColor(dayData["mood"]).withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: getMoodColor(dayData["mood"]),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              getMoodEmoji(dayData["mood"]),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${dayData["mood"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: getMoodColor(dayData["mood"]),
                          ),
                        ),
                      ],
                    )).toList(),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Weekly Summary
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "3.7",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Avg Mood",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "5",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Good Days",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "↑ 15%",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "vs Last Week",
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
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Recent Entries
            Text(
              "Recent Mood Entries",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...moodEntries.map((entry) => Container(
              margin: EdgeInsets.only(bottom: spMd),
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
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: getMoodColor(entry["mood"]).withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Center(
                          child: Text(
                            getMoodEmoji(entry["mood"]),
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      
                      SizedBox(width: spMd),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${entry["date"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                _buildMetricChip("😊", entry["mood"], getMoodColor(entry["mood"])),
                                SizedBox(width: spXs),
                                _buildMetricChip("⚡", entry["energy"], warningColor),
                                SizedBox(width: spXs),
                                _buildMetricChip("😰", entry["stress"], dangerColor),
                                SizedBox(width: spXs),
                                _buildMetricChip("😴", entry["sleep"], primaryColor),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  if (entry["note"].isNotEmpty) ...[
                    SizedBox(height: spMd),
                    Text(
                      "${entry["note"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                  
                  if ((entry["tags"] as List).isNotEmpty) ...[
                    SizedBox(height: spMd),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (entry["tags"] as List).map((tag) => Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "#$tag",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricChip(String emoji, int value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: TextStyle(fontSize: 12)),
          SizedBox(width: spXs),
          Text(
            "$value",
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
