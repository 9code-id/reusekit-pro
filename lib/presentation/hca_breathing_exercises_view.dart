import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaBreathingExercisesView extends StatefulWidget {
  const HcaBreathingExercisesView({super.key});

  @override
  State<HcaBreathingExercisesView> createState() => _HcaBreathingExercisesViewState();
}

class _HcaBreathingExercisesViewState extends State<HcaBreathingExercisesView>
    with TickerProviderStateMixin {
  int selectedCategory = 0;
  bool isExerciseActive = false;
  int currentExerciseIndex = 0;
  int currentCycle = 0;
  int totalCycles = 5;
  String currentPhase = "inhale";
  int phaseTimeRemaining = 4;
  
  AnimationController? _breathingController;
  Animation<double>? _breathingAnimation;
  
  final List<String> categories = [
    "All",
    "Beginner",
    "Anxiety Relief",
    "Sleep",
    "Energy",
    "Focus",
    "Stress Relief"
  ];

  final List<Map<String, dynamic>> breathingExercises = [
    {
      "id": "1",
      "name": "4-7-8 Breathing",
      "category": "Sleep",
      "difficulty": "Beginner",
      "description": "Promotes relaxation and better sleep quality",
      "instructions": "Inhale for 4, hold for 7, exhale for 8",
      "inhaleTime": 4,
      "holdTime": 7,
      "exhaleTime": 8,
      "cycles": 4,
      "totalDuration": 460,
      "benefits": ["Better sleep", "Reduced anxiety", "Deep relaxation"],
      "color": Colors.indigo,
      "icon": Icons.bedtime,
      "completed": true,
      "lastUsed": "2024-01-12"
    },
    {
      "id": "2",
      "name": "Box Breathing",
      "category": "Focus",
      "difficulty": "Beginner",
      "description": "Enhances concentration and mental clarity",
      "instructions": "Inhale 4, hold 4, exhale 4, hold 4",
      "inhaleTime": 4,
      "holdTime": 4,
      "exhaleTime": 4,
      "holdAfterExhale": 4,
      "cycles": 6,
      "totalDuration": 576,
      "benefits": ["Better focus", "Stress reduction", "Mental clarity"],
      "color": successColor,
      "icon": Icons.crop_square,
      "completed": false,
      "lastUsed": null
    },
    {
      "id": "3",
      "name": "Belly Breathing",
      "category": "Stress Relief",
      "difficulty": "Beginner",
      "description": "Deep diaphragmatic breathing for stress relief",
      "instructions": "Slow, deep breaths using your diaphragm",
      "inhaleTime": 6,
      "holdTime": 2,
      "exhaleTime": 8,
      "cycles": 8,
      "totalDuration": 768,
      "benefits": ["Stress relief", "Lower blood pressure", "Calming effect"],
      "color": infoColor,
      "icon": Icons.favorite,
      "completed": true,
      "lastUsed": "2024-01-14"
    },
    {
      "id": "4",
      "name": "Energizing Breath",
      "category": "Energy",
      "difficulty": "Intermediate",
      "description": "Quick breathing technique to boost energy",
      "instructions": "Rapid, controlled breathing to energize",
      "inhaleTime": 2,
      "holdTime": 1,
      "exhaleTime": 2,
      "cycles": 12,
      "totalDuration": 360,
      "benefits": ["Increased energy", "Mental alertness", "Improved circulation"],
      "color": warningColor,
      "icon": Icons.flash_on,
      "completed": false,
      "lastUsed": null
    },
    {
      "id": "5",
      "name": "Calming Breath",
      "category": "Anxiety Relief",
      "difficulty": "Beginner",
      "description": "Gentle breathing to reduce anxiety and panic",
      "instructions": "Slow, controlled breathing for immediate calm",
      "inhaleTime": 5,
      "holdTime": 3,
      "exhaleTime": 7,
      "cycles": 6,
      "totalDuration": 540,
      "benefits": ["Reduced anxiety", "Panic control", "Emotional balance"],
      "color": Colors.purple,
      "icon": Icons.spa,
      "completed": true,
      "lastUsed": "2024-01-13"
    },
    {
      "id": "6",
      "name": "Triangle Breathing",
      "category": "Focus",
      "difficulty": "Intermediate",
      "description": "Three-phase breathing for sustained focus",
      "instructions": "Inhale, hold, exhale in equal parts",
      "inhaleTime": 6,
      "holdTime": 6,
      "exhaleTime": 6,
      "cycles": 5,
      "totalDuration": 540,
      "benefits": ["Sustained focus", "Mind-body connection", "Balance"],
      "color": primaryColor,
      "icon": Icons.change_history,
      "completed": false,
      "lastUsed": null
    }
  ];

  List<Map<String, dynamic>> get filteredExercises {
    List<Map<String, dynamic>> filtered = breathingExercises;

    if (selectedCategory != 0) {
      String categoryFilter = categories[selectedCategory];
      filtered = filtered.where((exercise) {
        return "${exercise["category"]}" == categoryFilter;
      }).toList();
    }

    return filtered;
  }

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );
    _breathingAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _breathingController!,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _breathingController?.dispose();
    super.dispose();
  }

  String formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return successColor;
      case 'intermediate':
        return warningColor;
      case 'advanced':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  void startExercise(Map<String, dynamic> exercise) {
    setState(() {
      isExerciseActive = true;
      currentExerciseIndex = breathingExercises.indexOf(exercise);
      currentCycle = 0;
      totalCycles = exercise["cycles"] as int;
      currentPhase = "inhale";
      phaseTimeRemaining = exercise["inhaleTime"] as int;
    });
    
    _breathingController?.repeat(reverse: true);
    si("Started ${exercise["name"]} breathing exercise");
  }

  void stopExercise() {
    setState(() {
      isExerciseActive = false;
    });
    _breathingController?.stop();
    si("Breathing exercise stopped");
  }

  Widget _buildExerciseCard(Map<String, dynamic> exercise) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: exercise["color"] as Color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (exercise["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  exercise["icon"] as IconData,
                  color: exercise["color"] as Color,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${exercise["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${exercise["category"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: _getDifficultyColor("${exercise["difficulty"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${exercise["difficulty"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _getDifficultyColor("${exercise["difficulty"]}"),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "${exercise["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Instructions",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${exercise["instructions"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Icon(
                Icons.timer,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${formatDuration(exercise["totalDuration"] as int)}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.repeat,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${exercise["cycles"]} cycles",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (exercise["completed"] as bool) ...[
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: successColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Completed",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Benefits
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (exercise["benefits"] as List).map((benefit) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: (exercise["color"] as Color).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: (exercise["color"] as Color).withAlpha(30),
                    width: 1,
                  ),
                ),
                child: Text(
                  "$benefit",
                  style: TextStyle(
                    fontSize: 12,
                    color: exercise["color"] as Color,
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
                  label: isExerciseActive && currentExerciseIndex == breathingExercises.indexOf(exercise)
                      ? "Stop Exercise"
                      : "Start Exercise",
                  size: bs.sm,
                  onPressed: () {
                    if (isExerciseActive && currentExerciseIndex == breathingExercises.indexOf(exercise)) {
                      stopExercise();
                    } else {
                      startExercise(exercise);
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.info_outline,
                size: bs.sm,
                onPressed: () {
                  si("View exercise details");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveExerciseOverlay() {
    if (!isExerciseActive) return SizedBox.shrink();
    
    final exercise = breathingExercises[currentExerciseIndex];
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            (exercise["color"] as Color).withAlpha(20),
            (exercise["color"] as Color).withAlpha(10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: exercise["color"] as Color,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            "${exercise["name"]}",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "Cycle ${currentCycle + 1} of $totalCycles",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spLg),
          
          // Breathing Circle
          AnimatedBuilder(
            animation: _breathingAnimation!,
            builder: (context, child) {
              return Container(
                width: 150 * _breathingAnimation!.value,
                height: 150 * _breathingAnimation!.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (exercise["color"] as Color).withAlpha(30),
                  border: Border.all(
                    color: exercise["color"] as Color,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentPhase.toUpperCase(),
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: exercise["color"] as Color,
                        ),
                      ),
                      Text(
                        "$phaseTimeRemaining",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          
          SizedBox(height: spLg),
          
          // Progress Bar
          LinearProgressIndicator(
            value: (currentCycle + 1) / totalCycles,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(exercise["color"] as Color),
          ),
          
          SizedBox(height: spSm),
          
          QButton(
            label: "Stop Exercise",
            size: bs.sm,
            onPressed: stopExercise,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    int completedExercises = breathingExercises.where((e) => e["completed"] as bool).length;
    int totalMinutes = breathingExercises
        .where((e) => e["completed"] as bool)
        .fold(0, (sum, exercise) => sum + (exercise["totalDuration"] as int)) ~/ 60;

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
                      "$completedExercises",
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
                      "Practiced",
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
                      "${breathingExercises.length - completedExercises}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "To Try",
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
        title: Text("Breathing Exercises"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              si("View breathing history");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Active Exercise Overlay
            _buildActiveExerciseOverlay(),
            
            // Progress Stats
            _buildStatsCard(),
            
            SizedBox(height: spMd),
            
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
            
            // Exercises Header
            Row(
              children: [
                Text(
                  "Breathing Exercises",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredExercises.length} exercises",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Exercises List
            if (filteredExercises.isEmpty) ...[
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.air,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No exercises found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your category filter",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              ...filteredExercises.map((exercise) => _buildExerciseCard(exercise)),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isExerciseActive) {
            stopExercise();
          } else {
            // Start quick breathing exercise
            startExercise(breathingExercises[0]);
          }
        },
        backgroundColor: primaryColor,
        child: Icon(
          isExerciseActive ? Icons.stop : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }
}
