import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaBreathingExercisesView extends StatefulWidget {
  const FwaBreathingExercisesView({super.key});

  @override
  State<FwaBreathingExercisesView> createState() => _FwaBreathingExercisesViewState();
}

class _FwaBreathingExercisesViewState extends State<FwaBreathingExercisesView> with TickerProviderStateMixin {
  int selectedTechnique = 0;
  bool isActive = false;
  int currentCycle = 0;
  int totalCycles = 5;
  String currentPhase = "Inhale";
  int phaseTimeRemaining = 4;
  AnimationController? animationController;
  Animation<double>? scaleAnimation;
  
  final List<Map<String, dynamic>> techniques = [
    {
      "id": 1,
      "name": "4-7-8 Breathing",
      "description": "Inhale for 4, hold for 7, exhale for 8",
      "benefits": ["Reduces anxiety", "Promotes sleep", "Calms nervous system"],
      "inhale": 4,
      "hold": 7,
      "exhale": 8,
      "difficulty": "Beginner",
      "duration": "2-3 minutes",
      "icon": Icons.air,
    },
    {
      "id": 2,
      "name": "Box Breathing",
      "description": "Equal counts for all phases: 4-4-4-4",
      "benefits": ["Improves focus", "Reduces stress", "Enhances control"],
      "inhale": 4,
      "hold": 4,
      "exhale": 4,
      "holdEmpty": 4,
      "difficulty": "Beginner",
      "duration": "3-5 minutes",
      "icon": Icons.crop_square,
    },
    {
      "id": 3,
      "name": "Triangle Breathing",
      "description": "Three equal phases: inhale, hold, exhale",
      "benefits": ["Balances energy", "Improves concentration", "Stabilizes mood"],
      "inhale": 6,
      "hold": 6,
      "exhale": 6,
      "difficulty": "Intermediate",
      "duration": "4-6 minutes",
      "icon": Icons.change_history,
    },
    {
      "id": 4,
      "name": "Coherent Breathing",
      "description": "5 seconds in, 5 seconds out",
      "benefits": ["Heart rate variability", "Emotional balance", "Stress relief"],
      "inhale": 5,
      "exhale": 5,
      "difficulty": "Beginner",
      "duration": "5-10 minutes",
      "icon": Icons.favorite,
    },
    {
      "id": 5,
      "name": "Extended Exhale",
      "description": "Inhale for 4, exhale for 8",
      "benefits": ["Activates parasympathetic", "Deep relaxation", "Better sleep"],
      "inhale": 4,
      "exhale": 8,
      "difficulty": "Beginner",
      "duration": "3-5 minutes",
      "icon": Icons.trending_down,
    },
    {
      "id": 6,
      "name": "Wim Hof Method",
      "description": "30 rapid breaths, hold, exhale",
      "benefits": ["Boosts energy", "Improves immunity", "Cold tolerance"],
      "inhale": 2,
      "exhale": 2,
      "cycles": 3,
      "difficulty": "Advanced",
      "duration": "10-15 minutes",
      "icon": Icons.ac_unit,
    },
  ];

  final List<Map<String, dynamic>> quickSessions = [
    {
      "name": "1 Minute Calm",
      "duration": 1,
      "technique": "Box Breathing",
      "description": "Quick stress relief for busy moments",
      "icon": Icons.timer,
    },
    {
      "name": "3 Minute Reset",
      "duration": 3,
      "technique": "4-7-8 Breathing",
      "description": "Perfect for short breaks",
      "icon": Icons.refresh,
    },
    {
      "name": "5 Minute Deep",
      "duration": 5,
      "technique": "Triangle Breathing",
      "description": "Deeper relaxation and focus",
      "icon": Icons.spa,
    },
    {
      "name": "10 Minute Energy",
      "duration": 10,
      "technique": "Wim Hof Method",
      "description": "Boost energy and alertness",
      "icon": Icons.flash_on,
    },
  ];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );
    scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: animationController!, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Map<String, dynamic> get currentTechnique => techniques[selectedTechnique];

  void startBreathingSession() {
    setState(() {
      isActive = true;
      currentCycle = 0;
      currentPhase = "Inhale";
      phaseTimeRemaining = currentTechnique["inhale"];
    });
    animationController?.repeat(reverse: true);
    // Start breathing timer logic here
  }

  void stopBreathingSession() {
    setState(() {
      isActive = false;
      currentCycle = 0;
    });
    animationController?.stop();
    animationController?.reset();
  }

  Color getPhaseColor() {
    switch (currentPhase) {
      case "Inhale":
        return primaryColor;
      case "Hold":
        return warningColor;
      case "Exhale":
        return successColor;
      default:
        return primaryColor;
    }
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
              // View breathing history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Today's Progress
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(180)],
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
                          "Today's Breathing",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "8 sessions",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "18 minutes total",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.air,
                    color: Colors.white,
                    size: 40,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Breathing Circle
            if (isActive) ...[
              Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Phase Indicator
                    Text(
                      currentPhase,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: getPhaseColor(),
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Breathing Circle
                    AnimatedBuilder(
                      animation: scaleAnimation!,
                      builder: (context, child) {
                        return Container(
                          width: 150 * scaleAnimation!.value,
                          height: 150 * scaleAnimation!.value,
                          decoration: BoxDecoration(
                            color: getPhaseColor().withAlpha(25),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: getPhaseColor(),
                              width: 3,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "$phaseTimeRemaining",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: getPhaseColor(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Cycle Counter
                    Text(
                      "Cycle ${currentCycle + 1} of $totalCycles",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Stop Button
                    QButton(
                      label: "Stop Session",
                      size: bs.md,
                      onPressed: stopBreathingSession,
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Quick Sessions
              Text(
                "Quick Sessions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: spMd),
              
              QHorizontalScroll(
                children: quickSessions.map((session) => Container(
                  width: 200,
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
                              session["icon"],
                              color: primaryColor,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${session["duration"]} min",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      Text(
                        "${session["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      SizedBox(height: spXs),
                      
                      Text(
                        "${session["technique"]}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      Text(
                        "${session["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      QButton(
                        label: "Start",
                        size: bs.sm,
                        onPressed: startBreathingSession,
                      ),
                    ],
                  ),
                )).toList(),
              ),
              
              SizedBox(height: spMd),
              
              // Technique Selection
              Text(
                "Breathing Techniques",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Technique Cards
              ...techniques.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> technique = entry.value;
                bool isSelected = selectedTechnique == index;
                
                return GestureDetector(
                  onTap: () {
                    selectedTechnique = index;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: isSelected
                          ? Border.all(color: primaryColor, width: 2)
                          : null,
                    ),
                    child: Row(
                      children: [
                        // Technique Icon
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? primaryColor
                                : primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            technique["icon"],
                            color: isSelected ? Colors.white : primaryColor,
                            size: 28,
                          ),
                        ),
                        
                        SizedBox(width: spMd),
                        
                        // Technique Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${technique["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: technique["difficulty"] == "Beginner"
                                          ? successColor.withAlpha(25)
                                          : technique["difficulty"] == "Intermediate"
                                              ? warningColor.withAlpha(25)
                                              : dangerColor.withAlpha(25),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Text(
                                      "${technique["difficulty"]}",
                                      style: TextStyle(
                                        color: technique["difficulty"] == "Beginner"
                                            ? successColor
                                            : technique["difficulty"] == "Intermediate"
                                                ? warningColor
                                                : dangerColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spXs),
                              
                              Text(
                                "${technique["description"]}",
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
                                    "${technique["duration"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spSm),
                              
                              // Benefits
                              Wrap(
                                spacing: spXs,
                                runSpacing: spXs,
                                children: (technique["benefits"] as List).take(2).map((benefit) => Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Text(
                                    "$benefit",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )).toList(),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        // Start Button
                        if (isSelected)
                          QButton(
                            label: "Start",
                            size: bs.sm,
                            onPressed: startBreathingSession,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ],
        ),
      ),
    );
  }
}
