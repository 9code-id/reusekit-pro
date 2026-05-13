import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaMoodTrackerView extends StatefulWidget {
  const HcaMoodTrackerView({super.key});

  @override
  State<HcaMoodTrackerView> createState() => _HcaMoodTrackerViewState();
}

class _HcaMoodTrackerViewState extends State<HcaMoodTrackerView> {
  int selectedMood = 3;
  String selectedEmotion = "";
  List<String> selectedFactors = [];
  String moodNotes = "";
  bool showQuickEntry = false;

  List<Map<String, dynamic>> moodHistory = [
    {
      "id": "1",
      "date": "2024-06-19",
      "time": "18:30",
      "mood": 4,
      "emotion": "Optimistic",
      "factors": ["Good weather", "Completed tasks", "Social interaction"],
      "notes": "Had a productive day at work and enjoyed lunch with colleagues",
      "energy": 7,
      "stress": 3,
    },
    {
      "id": "2",
      "date": "2024-06-18",
      "time": "21:15",
      "mood": 2,
      "emotion": "Anxious",
      "factors": ["Work pressure", "Financial concerns", "Poor sleep"],
      "notes": "Feeling overwhelmed with upcoming deadlines and bills",
      "energy": 4,
      "stress": 8,
    },
    {
      "id": "3",
      "date": "2024-06-17",
      "time": "14:45",
      "mood": 4,
      "emotion": "Content",
      "factors": ["Exercise", "Good meal", "Family time"],
      "notes": "Went for a morning run and had brunch with family",
      "energy": 8,
      "stress": 2,
    },
    {
      "id": "4",
      "date": "2024-06-16",
      "time": "10:20",
      "mood": 1,
      "emotion": "Frustrated",
      "factors": ["Technology issues", "Traffic", "Lack of sleep"],
      "notes": "Computer crashed and lost work, then stuck in traffic for an hour",
      "energy": 3,
      "stress": 9,
    },
    {
      "id": "5",
      "date": "2024-06-15",
      "time": "16:00",
      "mood": 5,
      "emotion": "Joyful",
      "factors": ["Achievement", "Social support", "Beautiful weather"],
      "notes": "Got promoted at work and celebrated with friends",
      "energy": 9,
      "stress": 1,
    },
  ];

  List<Map<String, dynamic>> moodOptions = [
    {
      "level": 1,
      "label": "Very Low",
      "emoji": "😢",
      "color": dangerColor,
      "description": "Feeling very down, sad, or depressed",
    },
    {
      "level": 2,
      "label": "Low",
      "emoji": "😔",
      "color": warningColor,
      "description": "Feeling somewhat down or melancholy",
    },
    {
      "level": 3,
      "label": "Neutral",
      "emoji": "😐",
      "color": infoColor,
      "description": "Feeling okay, neither good nor bad",
    },
    {
      "level": 4,
      "label": "Good",
      "emoji": "😊",
      "color": successColor,
      "description": "Feeling positive and upbeat",
    },
    {
      "level": 5,
      "label": "Excellent",
      "emoji": "😄",
      "color": primaryColor,
      "description": "Feeling fantastic, energetic, and very happy",
    },
  ];

  List<Map<String, dynamic>> emotionOptions = [
    {"label": "Happy", "value": "Happy", "icon": Icons.sentiment_very_satisfied, "category": "Positive"},
    {"label": "Excited", "value": "Excited", "icon": Icons.celebration, "category": "Positive"},
    {"label": "Content", "value": "Content", "icon": Icons.sentiment_satisfied, "category": "Positive"},
    {"label": "Grateful", "value": "Grateful", "icon": Icons.favorite, "category": "Positive"},
    {"label": "Optimistic", "value": "Optimistic", "icon": Icons.lightbulb, "category": "Positive"},
    {"label": "Calm", "value": "Calm", "icon": Icons.self_improvement, "category": "Neutral"},
    {"label": "Focused", "value": "Focused", "icon": Icons.center_focus_strong, "category": "Neutral"},
    {"label": "Tired", "value": "Tired", "icon": Icons.bedtime, "category": "Neutral"},
    {"label": "Sad", "value": "Sad", "icon": Icons.sentiment_very_dissatisfied, "category": "Negative"},
    {"label": "Anxious", "value": "Anxious", "icon": Icons.psychology, "category": "Negative"},
    {"label": "Frustrated", "value": "Frustrated", "icon": Icons.warning, "category": "Negative"},
    {"label": "Angry", "value": "Angry", "icon": Icons.sentiment_dissatisfied, "category": "Negative"},
    {"label": "Overwhelmed", "value": "Overwhelmed", "icon": Icons.storm, "category": "Negative"},
    {"label": "Lonely", "value": "Lonely", "icon": Icons.person_outline, "category": "Negative"},
  ];

  List<Map<String, dynamic>> moodFactors = [
    {"label": "Work/Career", "value": "Work", "icon": Icons.work},
    {"label": "Relationships", "value": "Relationships", "icon": Icons.people},
    {"label": "Health", "value": "Health", "icon": Icons.health_and_safety},
    {"label": "Sleep", "value": "Sleep", "icon": Icons.bedtime},
    {"label": "Exercise", "value": "Exercise", "icon": Icons.fitness_center},
    {"label": "Weather", "value": "Weather", "icon": Icons.wb_sunny},
    {"label": "Finance", "value": "Finance", "icon": Icons.attach_money},
    {"label": "Family", "value": "Family", "icon": Icons.family_restroom},
    {"label": "Social Life", "value": "Social", "icon": Icons.group},
    {"label": "Hobbies", "value": "Hobbies", "icon": Icons.palette},
  ];

  int energyLevel = 5;
  int stressLevel = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mood Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              _showAnalytics();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildCurrentMoodDisplay(),
            _buildMoodSelector(),
            _buildEmotionSelector(),
            _buildEnergyAndStress(),
            _buildMoodFactors(),
            _buildNotesSection(),
            _buildActionButtons(),
            _buildRecentMoods(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentMoodDisplay() {
    Map<String, dynamic> currentMoodData = moodOptions.firstWhere(
      (mood) => mood["level"] == selectedMood,
      orElse: () => moodOptions[2],
    );
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (currentMoodData["color"] as Color).withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: currentMoodData["color"] as Color,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            currentMoodData["emoji"] as String,
            style: TextStyle(fontSize: 48),
          ),
          SizedBox(height: spSm),
          Text(
            "Current Mood",
            style: TextStyle(
              fontSize: 14,
              color: currentMoodData["color"] as Color,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            currentMoodData["label"] as String,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: currentMoodData["color"] as Color,
            ),
          ),
          Text(
            currentMoodData["description"] as String,
            style: TextStyle(
              fontSize: 12,
              color: currentMoodData["color"] as Color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMoodSelector() {
    return Container(
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
          Text(
            "How are you feeling today?",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: moodOptions.map((mood) {
              bool isSelected = selectedMood == mood["level"];
              
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedMood = mood["level"] as int;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? (mood["color"] as Color).withAlpha(30)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected 
                            ? mood["color"] as Color
                            : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          mood["emoji"] as String,
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          mood["label"] as String,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected 
                                ? mood["color"] as Color
                                : disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionSelector() {
    return Container(
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
          Text(
            "What specific emotion describes you best?",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildEmotionCategory("Positive"),
          _buildEmotionCategory("Neutral"),
          _buildEmotionCategory("Negative"),
        ],
      ),
    );
  }

  Widget _buildEmotionCategory(String category) {
    List<Map<String, dynamic>> categoryEmotions = emotionOptions
        .where((emotion) => emotion["category"] == category)
        .toList();
    
    Color categoryColor = category == "Positive" ? successColor :
                         category == "Neutral" ? infoColor : dangerColor;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Text(
          category,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: categoryColor,
          ),
        ),
        Wrap(
          spacing: spXs,
          runSpacing: spXs,
          children: categoryEmotions.map((emotion) {
            bool isSelected = selectedEmotion == emotion["value"];
            
            return GestureDetector(
              onTap: () {
                selectedEmotion = emotion["value"] as String;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? categoryColor.withAlpha(20)
                      : disabledColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? categoryColor : disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      emotion["icon"] as IconData,
                      color: isSelected ? categoryColor : disabledBoldColor,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      emotion["label"] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: isSelected ? categoryColor : disabledBoldColor,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildEnergyAndStress() {
    return Container(
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
          Text(
            "Energy & Stress Levels",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.battery_charging_full,
                    color: successColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Energy Level: $energyLevel/10",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                ],
              ),
              Slider(
                value: energyLevel.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                activeColor: successColor,
                onChanged: (value) {
                  energyLevel = value.toInt();
                  setState(() {});
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.psychology,
                    color: warningColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Stress Level: $stressLevel/10",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
              Slider(
                value: stressLevel.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                activeColor: warningColor,
                onChanged: (value) {
                  stressLevel = value.toInt();
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoodFactors() {
    return Container(
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
          Text(
            "What's influencing your mood today?",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: moodFactors.map((factor) {
              bool isSelected = selectedFactors.contains(factor["value"]);
              
              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                    selectedFactors.remove(factor["value"]);
                  } else {
                    selectedFactors.add(factor["value"] as String);
                  }
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? primaryColor.withAlpha(20)
                        : disabledColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        factor["icon"] as IconData,
                        color: isSelected ? primaryColor : disabledBoldColor,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        factor["label"] as String,
                        style: TextStyle(
                          fontSize: 11,
                          color: isSelected ? primaryColor : disabledBoldColor,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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
    );
  }

  Widget _buildNotesSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: QMemoField(
        label: "Additional notes",
        value: moodNotes,
        hint: "How was your day? What made you feel this way?",
        onChanged: (value) {
          moodNotes = value;
          setState(() {});
        },
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Save Entry",
              icon: Icons.save,
              size: bs.sm,
              onPressed: () => _saveMoodEntry(),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Quick Mood",
              icon: Icons.flash_on,
              size: bs.sm,
              onPressed: () => _showQuickMoodEntry(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentMoods() {
    List<Map<String, dynamic>> recentEntries = moodHistory.take(3).toList();
    
    return Container(
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
              Text(
                "Recent Mood Entries",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _showMoodHistory(),
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...recentEntries.map((entry) => _buildMoodHistoryEntry(entry)),
        ],
      ),
    );
  }

  Widget _buildMoodHistoryEntry(Map<String, dynamic> entry) {
    DateTime entryDate = DateTime.parse(entry["date"] as String);
    Map<String, dynamic> moodData = moodOptions.firstWhere(
      (mood) => mood["level"] == entry["mood"],
      orElse: () => moodOptions[2],
    );
    
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: (moodData["color"] as Color).withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 3,
            color: moodData["color"] as Color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Text(
                moodData["emoji"] as String,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: spXs),
              Text(
                "${entryDate.dMMMy} at ${entry["time"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 1,
                ),
                decoration: BoxDecoration(
                  color: moodData["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  moodData["label"] as String,
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if ((entry["emotion"] as String).isNotEmpty)
            Text(
              "Feeling ${entry["emotion"]}",
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          if ((entry["factors"] as List).isNotEmpty)
            Text(
              "Influenced by: ${(entry["factors"] as List).join(", ")}",
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          if ((entry["notes"] as String).isNotEmpty)
            Text(
              "${entry["notes"]}",
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }

  void _saveMoodEntry() {
    moodHistory.insert(0, {
      "id": "${moodHistory.length + 1}",
      "date": DateTime.now().toIso8601String(),
      "time": TimeOfDay.now().kkmm,
      "mood": selectedMood,
      "emotion": selectedEmotion,
      "factors": List.from(selectedFactors),
      "notes": moodNotes,
      "energy": energyLevel,
      "stress": stressLevel,
    });

    // Reset form
    selectedMood = 3;
    selectedEmotion = "";
    selectedFactors.clear();
    moodNotes = "";
    energyLevel = 5;
    stressLevel = 5;
    
    setState(() {});
    ss("Mood entry saved successfully");
  }

  void _showQuickMoodEntry() {
    showQuickEntry = !showQuickEntry;
    setState(() {});
  }

  void _showMoodHistory() {
    si("Showing complete mood history");
  }

  void _showAnalytics() {
    si("Showing mood analytics and patterns");
  }
}
