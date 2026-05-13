import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaStretchingGuideView extends StatefulWidget {
  const FwaStretchingGuideView({super.key});

  @override
  State<FwaStretchingGuideView> createState() => _FwaStretchingGuideViewState();
}

class _FwaStretchingGuideViewState extends State<FwaStretchingGuideView> {
  String selectedCategory = "All";
  String selectedDuration = "All";
  String selectedLevel = "All";
  
  List<String> categories = ["All", "Morning", "Post-Workout", "Desk Breaks", "Evening", "Sport-Specific"];
  List<String> durations = ["All", "5 min", "10 min", "15 min", "20+ min"];
  List<String> levels = ["All", "Beginner", "Intermediate", "Advanced"];
  
  List<Map<String, dynamic>> stretchingRoutines = [
    {
      "id": 1,
      "title": "Morning Energy Stretches",
      "category": "Morning",
      "duration": "10 min",
      "level": "Beginner",
      "targetAreas": ["Full Body", "Spine", "Hips"],
      "image": "https://picsum.photos/300/200?random=1&keyword=morning",
      "description": "Gentle stretches to wake up your body and start the day with energy",
      "benefits": ["Improved circulation", "Reduced stiffness", "Better posture"],
      "stretches": [
        {
          "name": "Cat-Cow Stretch",
          "duration": "1 min",
          "instructions": "Start on hands and knees, alternate between arching and rounding your back",
          "targetMuscles": ["Spine", "Core"]
        },
        {
          "name": "Child's Pose",
          "duration": "2 min",
          "instructions": "Kneel and sit back on heels, extend arms forward and lower forehead to ground",
          "targetMuscles": ["Back", "Shoulders", "Hips"]
        },
        {
          "name": "Standing Forward Fold",
          "duration": "1 min",
          "instructions": "Stand tall, hinge at hips and let arms hang toward floor",
          "targetMuscles": ["Hamstrings", "Calves", "Lower Back"]
        }
      ]
    },
    {
      "id": 2,
      "title": "Post-Workout Recovery",
      "category": "Post-Workout",
      "duration": "15 min",
      "level": "Intermediate",
      "targetAreas": ["Legs", "Back", "Shoulders"],
      "image": "https://picsum.photos/300/200?random=2&keyword=stretch",
      "description": "Essential stretches to aid recovery and prevent muscle tightness",
      "benefits": ["Faster recovery", "Reduced soreness", "Improved flexibility"],
      "stretches": [
        {
          "name": "Pigeon Pose",
          "duration": "2 min each side",
          "instructions": "From downward dog, bring one knee forward, extend other leg back",
          "targetMuscles": ["Hip Flexors", "Glutes", "IT Band"]
        },
        {
          "name": "Seated Spinal Twist",
          "duration": "1 min each side",
          "instructions": "Sit with one leg extended, cross other leg over, twist toward bent knee",
          "targetMuscles": ["Spine", "Obliques", "Hips"]
        },
        {
          "name": "Hamstring Stretch",
          "duration": "1.5 min each leg",
          "instructions": "Lie on back, pull one leg toward chest with strap or hands",
          "targetMuscles": ["Hamstrings", "Calves"]
        }
      ]
    },
    {
      "id": 3,
      "title": "Desk Worker Relief",
      "category": "Desk Breaks",
      "duration": "5 min",
      "level": "Beginner",
      "targetAreas": ["Neck", "Shoulders", "Wrists"],
      "image": "https://picsum.photos/300/200?random=3&keyword=office",
      "description": "Quick stretches to counter the effects of prolonged sitting",
      "benefits": ["Reduced tension", "Better posture", "Increased energy"],
      "stretches": [
        {
          "name": "Neck Rolls",
          "duration": "30 sec",
          "instructions": "Slowly roll head in circles, then reverse direction",
          "targetMuscles": ["Neck", "Upper Traps"]
        },
        {
          "name": "Shoulder Shrugs",
          "duration": "30 sec",
          "instructions": "Lift shoulders to ears, hold briefly, then release",
          "targetMuscles": ["Shoulders", "Upper Traps"]
        },
        {
          "name": "Wrist Flexor Stretch",
          "duration": "30 sec each arm",
          "instructions": "Extend arm, pull hand back with other hand",
          "targetMuscles": ["Forearms", "Wrists"]
        }
      ]
    },
    {
      "id": 4,
      "title": "Evening Wind Down",
      "category": "Evening",
      "duration": "20 min",
      "level": "Beginner",
      "targetAreas": ["Full Body", "Spine", "Legs"],
      "image": "https://picsum.photos/300/200?random=4&keyword=relax",
      "description": "Calming stretches to help you relax and prepare for better sleep",
      "benefits": ["Better sleep", "Stress relief", "Muscle relaxation"],
      "stretches": [
        {
          "name": "Legs Up the Wall",
          "duration": "5 min",
          "instructions": "Lie on back near wall, extend legs up against wall",
          "targetMuscles": ["Hamstrings", "Lower Back", "Circulation"]
        },
        {
          "name": "Gentle Spinal Twist",
          "duration": "2 min each side",
          "instructions": "Lie on back, drop knees to one side while keeping shoulders down",
          "targetMuscles": ["Spine", "Lower Back", "Hips"]
        },
        {
          "name": "Happy Baby Pose",
          "duration": "3 min",
          "instructions": "Lie on back, grab feet and gently rock side to side",
          "targetMuscles": ["Hips", "Lower Back", "Inner Thighs"]
        }
      ]
    },
    {
      "id": 5,
      "title": "Runner's Flexibility",
      "category": "Sport-Specific",
      "duration": "15 min",
      "level": "Intermediate",
      "targetAreas": ["Legs", "Hips", "Calves"],
      "image": "https://picsum.photos/300/200?random=5&keyword=running",
      "description": "Targeted stretches for runners to improve performance and prevent injury",
      "benefits": ["Better running form", "Injury prevention", "Improved range of motion"],
      "stretches": [
        {
          "name": "IT Band Stretch",
          "duration": "2 min each side",
          "instructions": "Cross one leg behind other, lean toward wall",
          "targetMuscles": ["IT Band", "Outer Hip", "Glutes"]
        },
        {
          "name": "Calf Stretch",
          "duration": "1.5 min each leg",
          "instructions": "Step one foot back, keep heel down and lean forward",
          "targetMuscles": ["Calves", "Achilles Tendon"]
        },
        {
          "name": "Hip Flexor Stretch",
          "duration": "2 min each side",
          "instructions": "Lunge position, sink hips forward and down",
          "targetMuscles": ["Hip Flexors", "Quads"]
        }
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredRoutines {
    return stretchingRoutines.where((routine) {
      bool categoryMatch = selectedCategory == "All" || (routine["category"] as String) == selectedCategory;
      bool durationMatch = selectedDuration == "All" || (routine["duration"] as String) == selectedDuration;
      bool levelMatch = selectedLevel == "All" || (routine["level"] as String) == selectedLevel;
      
      return categoryMatch && durationMatch && levelMatch;
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
      case "Morning": return warningColor;
      case "Post-Workout": return primaryColor;
      case "Desk Breaks": return infoColor;
      case "Evening": return secondaryColor;
      case "Sport-Specific": return successColor;
      default: return disabledBoldColor;
    }
  }

  Widget _buildQuickStats() {
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
            child: Column(
              children: [
                Icon(Icons.schedule, color: primaryColor, size: 24),
                SizedBox(height: spXs),
                Text(
                  "10 min",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Daily Goal",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
          ),
          Expanded(
            child: Column(
              children: [
                Icon(Icons.trending_up, color: successColor, size: 24),
                SizedBox(height: spXs),
                Text(
                  "35%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Flexibility Gain",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
          ),
          Expanded(
            child: Column(
              children: [
                Icon(Icons.self_improvement, color: infoColor, size: 24),
                SizedBox(height: spXs),
                Text(
                  "15",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Routines",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutineCard(Map<String, dynamic> routine) {
    Color levelColor = _getLevelColor(routine["level"] as String);
    Color categoryColor = _getCategoryColor(routine["category"] as String);
    List<dynamic> targetAreas = routine["targetAreas"] as List;
    List<dynamic> stretches = routine["stretches"] as List;
    
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
          // Image with overlay badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${routine["image"]}",
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
                    "${routine["category"]}",
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
                    "${routine["level"]}",
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
          
          // Title and duration
          Row(
            children: [
              Expanded(
                child: Text(
                  "${routine["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.schedule, size: 12, color: primaryColor),
                    SizedBox(width: 4),
                    Text(
                      "${routine["duration"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spXs),
          
          // Description
          Text(
            "${routine["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Target areas
          Wrap(
            spacing: spXs,
            children: targetAreas.map((area) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: infoColor.withAlpha(30)),
                ),
                child: Text(
                  "$area",
                  style: TextStyle(
                    fontSize: 10,
                    color: infoColor,
                  ),
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spSm),
          
          // Exercise count and benefits
          Row(
            children: [
              Icon(Icons.format_list_numbered, size: 16, color: disabledBoldColor),
              SizedBox(width: 4),
              Text(
                "${stretches.length} stretches",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.favorite_border, size: 16, color: disabledBoldColor),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Start Routine",
                  size: bs.sm,
                  onPressed: () {
                    // Start stretching routine
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.play_circle_outline,
                size: bs.sm,
                onPressed: () {
                  // Preview routine
                },
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
        title: Text("Stretching Guide"),
        actions: [
          IconButton(
            icon: Icon(Icons.timer),
            onPressed: () {
              // Start quick stretch timer
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick stats
            _buildQuickStats(),
            
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
                    label: "Duration",
                    items: durations.map((duration) => {
                      "label": duration,
                      "value": duration,
                    }).toList(),
                    value: selectedDuration,
                    onChanged: (value, label) {
                      selectedDuration = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            QDropdownField(
              label: "Level",
              items: levels.map((level) => {
                "label": level,
                "value": level,
              }).toList(),
              value: selectedLevel,
              onChanged: (value, label) {
                selectedLevel = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Routines header
            Text(
              "Stretching Routines (${filteredRoutines.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Routines list
            ...filteredRoutines.map((routine) => _buildRoutineCard(routine)).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Quick 2-minute stretch
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.self_improvement,
          color: Colors.white,
        ),
      ),
    );
  }
}
