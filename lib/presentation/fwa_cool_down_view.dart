import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaCoolDownView extends StatefulWidget {
  const FwaCoolDownView({super.key});

  @override
  State<FwaCoolDownView> createState() => _FwaCoolDownViewState();
}

class _FwaCoolDownViewState extends State<FwaCoolDownView> {
  int currentStretchIndex = 0;
  bool isPlaying = false;
  bool isPaused = false;
  int currentTime = 45;
  int totalTime = 45;
  
  final List<Map<String, dynamic>> coolDownStretches = [
    {
      "name": "Standing Forward Fold",
      "duration": 45,
      "description": "Stand with feet hip-width apart. Slowly hinge at your hips and fold forward, letting your arms hang naturally.",
      "image": "https://picsum.photos/400/300?random=1&keyword=stretch",
      "tips": "Keep a slight bend in your knees and breathe deeply",
      "targetMuscles": ["Hamstrings", "Calves", "Lower Back"],
      "difficulty": "Easy",
    },
    {
      "name": "Child's Pose",
      "duration": 60,
      "description": "Kneel on the floor, touch your big toes together and sit back on your heels. Fold forward and extend your arms in front.",
      "image": "https://picsum.photos/400/300?random=2&keyword=yoga",
      "tips": "Relax your shoulders and focus on deep breathing",
      "targetMuscles": ["Hips", "Thighs", "Ankles"],
      "difficulty": "Easy",
    },
    {
      "name": "Seated Spinal Twist",
      "duration": 30,
      "description": "Sit with legs extended. Cross one leg over, place opposite hand behind you for support, and gently twist your spine.",
      "image": "https://picsum.photos/400/300?random=3&keyword=twist",
      "tips": "Keep your spine tall and twist from your core",
      "targetMuscles": ["Spine", "Obliques", "Hips"],
      "difficulty": "Medium",
    },
    {
      "name": "Pigeon Pose",
      "duration": 45,
      "description": "From downward dog, bring one knee forward and extend the other leg back. Lower your hips toward the ground.",
      "image": "https://picsum.photos/400/300?random=4&keyword=pigeon",
      "tips": "Use props under your hip if needed for support",
      "targetMuscles": ["Hip Flexors", "Glutes", "IT Band"],
      "difficulty": "Medium",
    },
    {
      "name": "Hamstring Stretch",
      "duration": 30,
      "description": "Lie on your back, lift one leg up and hold behind your thigh. Keep the other leg straight on the ground.",
      "image": "https://picsum.photos/400/300?random=5&keyword=hamstring",
      "tips": "Keep your lower back pressed to the floor",
      "targetMuscles": ["Hamstrings", "Calves"],
      "difficulty": "Easy",
    },
    {
      "name": "Chest Stretch",
      "duration": 30,
      "description": "Stand in a doorway with arms on the frame. Step forward gently to stretch your chest and shoulders.",
      "image": "https://picsum.photos/400/300?random=6&keyword=chest",
      "tips": "Keep your core engaged and step slowly",
      "targetMuscles": ["Chest", "Shoulders", "Biceps"],
      "difficulty": "Easy",
    },
    {
      "name": "Cat-Cow Stretch",
      "duration": 40,
      "description": "Start on hands and knees. Arch your back (cow), then round your spine (cat). Flow slowly between positions.",
      "image": "https://picsum.photos/400/300?random=7&keyword=cat",
      "tips": "Move with your breath - inhale for cow, exhale for cat",
      "targetMuscles": ["Spine", "Core", "Neck"],
      "difficulty": "Easy",
    },
    {
      "name": "Savasana",
      "duration": 120,
      "description": "Lie flat on your back with arms at your sides, palms up. Close your eyes and focus on relaxing every muscle.",
      "image": "https://picsum.photos/400/300?random=8&keyword=relaxation",
      "tips": "Let go of all tension and breathe naturally",
      "targetMuscles": ["Full Body Relaxation"],
      "difficulty": "Easy",
    },
  ];

  Map<String, dynamic> get currentStretch => coolDownStretches[currentStretchIndex];
  
  int get totalDuration {
    return coolDownStretches.fold(0, (sum, stretch) => sum + (stretch["duration"] as int));
  }
  
  int get completedDuration {
    int completed = 0;
    for (int i = 0; i < currentStretchIndex; i++) {
      completed += coolDownStretches[i]["duration"] as int;
    }
    return completed + (totalTime - currentTime);
  }

  double get overallProgress {
    return completedDuration / totalDuration;
  }

  Color getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy": return successColor;
      case "Medium": return warningColor;
      case "Hard": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  void startTimer() {
    if (!isPlaying) {
      isPlaying = true;
      isPaused = false;
      setState(() {});
      
      // Simulate timer countdown
      Future.delayed(Duration(seconds: 1), () {
        if (isPlaying && !isPaused && currentTime > 0) {
          currentTime--;
          setState(() {});
          startTimer();
        } else if (currentTime == 0) {
          moveToNextStretch();
        }
      });
    }
  }

  void pauseTimer() {
    isPaused = true;
    setState(() {});
  }

  void resumeTimer() {
    isPaused = false;
    startTimer();
  }

  void stopTimer() {
    isPlaying = false;
    isPaused = false;
    currentTime = currentStretch["duration"];
    setState(() {});
  }

  void moveToNextStretch() {
    if (currentStretchIndex < coolDownStretches.length - 1) {
      currentStretchIndex++;
      currentTime = currentStretch["duration"];
      totalTime = currentStretch["duration"];
      setState(() {});
      
      if (isPlaying) {
        startTimer();
      }
    } else {
      // Cool-down completed
      isPlaying = false;
      ss("Cool-down completed! Excellent work on your recovery!");
    }
  }

  void moveToPreviousStretch() {
    if (currentStretchIndex > 0) {
      currentStretchIndex--;
      currentTime = currentStretch["duration"];
      totalTime = currentStretch["duration"];
      stopTimer();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    currentTime = currentStretch["duration"];
    totalTime = currentStretch["duration"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cool-Down Stretches"),
        actions: [
          IconButton(
            icon: Icon(Icons.music_note),
            onPressed: () {
              // Toggle relaxing music
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Overall Progress
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.self_improvement, color: infoColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Cool-Down Progress",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${currentStretchIndex + 1} of ${coolDownStretches.length}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: overallProgress,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "${(overallProgress * 100).toInt()}% Complete",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${((totalDuration - completedDuration) / 60).toInt()}:${((totalDuration - completedDuration) % 60).toString().padLeft(2, '0')} remaining",
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
            
            SizedBox(height: spLg),
            
            // Current Stretch Card
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  // Stretch Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusXs),
                    child: Image.network(
                      "${currentStretch["image"]}",
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Stretch Info Header
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentStretch["name"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXxs),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: getDifficultyColor(currentStretch["difficulty"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXxs),
                                  ),
                                  child: Text(
                                    "${currentStretch["difficulty"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: getDifficultyColor(currentStretch["difficulty"]),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Icon(Icons.access_time, color: disabledBoldColor, size: 14),
                                SizedBox(width: spXxs),
                                Text(
                                  "${currentStretch["duration"]}s",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Timer Circle
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          shape: BoxShape.circle,
                          border: Border.all(color: infoColor, width: 4),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$currentTime",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "seconds",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Target Muscles
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(color: successColor.withAlpha(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.fitness_center, color: successColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "Target Muscles:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (currentStretch["targetMuscles"] as List<String>).map((muscle) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXxs),
                              ),
                              child: Text(
                                muscle,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Stretch Instructions
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.description, color: primaryColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "Instructions:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${currentStretch["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(Icons.lightbulb, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "Pro Tip:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXxs),
                        Text(
                          "${currentStretch["tips"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Control Buttons
            Row(
              children: [
                // Previous Button
                if (currentStretchIndex > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      icon: Icons.skip_previous,
                      color: disabledBoldColor,
                      size: bs.md,
                      onPressed: moveToPreviousStretch,
                    ),
                  ),
                
                if (currentStretchIndex > 0) SizedBox(width: spSm),
                
                // Play/Pause Button
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: !isPlaying 
                      ? "Start Stretch" 
                      : (isPaused ? "Resume" : "Pause"),
                    icon: !isPlaying 
                      ? Icons.play_arrow 
                      : (isPaused ? Icons.play_arrow : Icons.pause),
                    color: !isPlaying 
                      ? infoColor
                      : (isPaused ? infoColor : warningColor),
                    size: bs.md,
                    onPressed: () {
                      if (!isPlaying) {
                        startTimer();
                      } else if (isPaused) {
                        resumeTimer();
                      } else {
                        pauseTimer();
                      }
                    },
                  ),
                ),
                
                SizedBox(width: spSm),
                
                // Next/Finish Button
                Expanded(
                  child: QButton(
                    label: currentStretchIndex < coolDownStretches.length - 1 
                      ? "Next" 
                      : "Finish",
                    icon: currentStretchIndex < coolDownStretches.length - 1 
                      ? Icons.skip_next 
                      : Icons.spa,
                    color: successColor,
                    size: bs.md,
                    onPressed: moveToNextStretch,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Breathing Guide
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.air, color: infoColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Breathing Guide",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(color: infoColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Deep, slow breathing enhances the benefits of stretching and promotes relaxation.",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(Icons.keyboard_arrow_down, color: infoColor, size: 16),
                                  Text(
                                    "Inhale: 4 seconds",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(Icons.keyboard_arrow_up, color: warningColor, size: 16),
                                  Text(
                                    "Exhale: 6 seconds",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
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
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Stretch Sequence
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Stretch Sequence",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  ...coolDownStretches.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> stretch = entry.value;
                    bool isCompleted = index < currentStretchIndex;
                    bool isCurrent = index == currentStretchIndex;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isCurrent 
                          ? infoColor.withAlpha(10)
                          : (isCompleted ? successColor.withAlpha(10) : Colors.transparent),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(
                          color: isCurrent 
                            ? infoColor
                            : (isCompleted ? successColor : disabledColor),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Status Icon
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: isCompleted 
                                ? successColor
                                : (isCurrent ? infoColor : disabledColor),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isCompleted 
                                ? Icons.check
                                : (isCurrent ? Icons.self_improvement : Icons.schedule),
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          
                          SizedBox(width: spSm),
                          
                          // Stretch Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${stretch["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isCurrent 
                                      ? infoColor
                                      : (isCompleted ? successColor : disabledBoldColor),
                                  ),
                                ),
                                Text(
                                  "${((stretch["duration"] as int) / 60).toInt()}:${((stretch["duration"] as int) % 60).toString().padLeft(2, '0')} • ${stretch["difficulty"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Target muscles
                          Text(
                            "${(stretch["targetMuscles"] as List).first}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
