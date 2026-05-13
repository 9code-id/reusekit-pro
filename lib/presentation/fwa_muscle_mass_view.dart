import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaMuscleMassView extends StatefulWidget {
  const FwaMuscleMassView({Key? key}) : super(key: key);

  @override
  State<FwaMuscleMassView> createState() => _FwaMuscleMassViewState();
}

class _FwaMuscleMassViewState extends State<FwaMuscleMassView> {
  String currentMuscleMass = "42.8";
  String targetMuscleMass = "45.0";
  String selectedPeriod = "This Month";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "3 Months", "value": "3 Months"},
    {"label": "6 Months", "value": "6 Months"},
  ];

  List<Map<String, dynamic>> muscleMassHistory = [
    {
      "date": "2024-12-01",
      "muscleMass": 41.5,
      "change": 0.0,
      "note": "Starting measurement"
    },
    {
      "date": "2024-12-08",
      "muscleMass": 41.8,
      "change": 0.3,
      "note": "First week of training"
    },
    {
      "date": "2024-12-15",
      "muscleMass": 42.1,
      "change": 0.3,
      "note": "Strength training focus"
    },
    {
      "date": "2024-12-22",
      "muscleMass": 42.5,
      "change": 0.4,
      "note": "Increased protein intake"
    },
    {
      "date": "2024-12-29",
      "muscleMass": 42.8,
      "change": 0.3,
      "note": "End of month progress"
    },
  ];

  Map<String, dynamic> muscleMassStats = {
    "totalGain": 1.3,
    "weeklyAverage": 0.3,
    "measurementsTaken": 15,
    "streakDays": 21,
  };

  List<Map<String, dynamic>> muscleGroups = [
    {
      "name": "Chest",
      "currentMass": 8.2,
      "targetMass": 9.0,
      "percentage": 19.2,
      "color": Colors.red,
      "icon": Icons.fitness_center
    },
    {
      "name": "Back",
      "currentMass": 9.1,
      "targetMass": 9.5,
      "percentage": 21.3,
      "color": Colors.blue,
      "icon": Icons.accessibility
    },
    {
      "name": "Arms",
      "currentMass": 6.8,
      "targetMass": 7.2,
      "percentage": 15.9,
      "color": Colors.green,
      "icon": Icons.sports_martial_arts
    },
    {
      "name": "Legs",
      "currentMass": 18.7,
      "targetMass": 19.3,
      "percentage": 43.7,
      "color": Colors.orange,
      "icon": Icons.directions_run
    },
  ];

  List<Map<String, dynamic>> workoutEffectiveness = [
    {
      "exercise": "Bench Press",
      "muscleGrowth": 0.8,
      "lastPerformed": "2 days ago",
      "sets": 4,
      "reps": 8
    },
    {
      "exercise": "Deadlift",
      "muscleGrowth": 1.2,
      "lastPerformed": "1 day ago",
      "sets": 5,
      "reps": 5
    },
    {
      "exercise": "Squats",
      "muscleGrowth": 1.0,
      "lastPerformed": "Today",
      "sets": 4,
      "reps": 10
    },
  ];

  @override
  Widget build(BuildContext context) {
    double currentMuscleMassValue = double.tryParse(currentMuscleMass) ?? 0.0;
    double targetMuscleMassValue = double.tryParse(targetMuscleMass) ?? 0.0;
    double remainingGain = targetMuscleMassValue - currentMuscleMassValue;
    double progressPercentage = ((currentMuscleMassValue - 41.5) / (targetMuscleMassValue - 41.5) * 100).clamp(0, 100);

    return Scaffold(
      appBar: AppBar(
        title: Text("Muscle Mass Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddMuscleMassDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _showMuscleMassInfoDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Muscle Mass Display
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.fitness_center,
                    color: Colors.white,
                    size: 48,
                  ),
                  Text(
                    "Current Muscle Mass",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        currentMuscleMass,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "kg",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${remainingGain.toStringAsFixed(1)} kg to goal",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),

            // Progress to Goal
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Progress to Goal",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${progressPercentage.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                      Container(
                        height: 12,
                        width: MediaQuery.of(context).size.width * (progressPercentage / 100) * 0.8,
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Start: 41.5 kg",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Goal: $targetMuscleMass kg",
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

            // Muscle Mass Statistics
            Text(
              "Statistics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard("Total Gain", "${muscleMassStats["totalGain"]}", "kg", Icons.trending_up, successColor),
                _buildStatCard("Weekly Avg", "${muscleMassStats["weeklyAverage"]}", "kg/week", Icons.insights, primaryColor),
                _buildStatCard("Measurements", "${muscleMassStats["measurementsTaken"]}", "taken", Icons.rule, infoColor),
                _buildStatCard("Streak", "${muscleMassStats["streakDays"]}", "days", Icons.local_fire_department, warningColor),
              ],
            ),

            // Muscle Group Distribution
            Text(
              "Muscle Group Distribution",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: muscleGroups.map((group) {
                double progress = ((group["currentMass"] as double) / (group["targetMass"] as double));
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Icon(
                        group["icon"] as IconData,
                        color: group["color"] as Color,
                        size: 32,
                      ),
                      Text(
                        "${group["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          ),
                          Container(
                            height: 8,
                            width: 100 * progress,
                            decoration: BoxDecoration(
                              color: group["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${(group["currentMass"] as double).toStringAsFixed(1)} kg",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${(group["percentage"] as double).toStringAsFixed(1)}% of total",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Period Filter
            QDropdownField(
              label: "Time Period",
              items: periodOptions,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),

            // Muscle Mass Chart
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Muscle Mass Trend",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildMuscleMassPoint("W1", 41.5),
                        _buildMuscleMassPoint("W2", 41.8),
                        _buildMuscleMassPoint("W3", 42.1),
                        _buildMuscleMassPoint("W4", 42.5),
                        _buildMuscleMassPoint("W5", 42.8),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Workout Effectiveness
            Text(
              "Most Effective Exercises",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: workoutEffectiveness.map((exercise) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.fitness_center,
                          color: successColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${exercise["exercise"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${exercise["sets"]} sets × ${exercise["reps"]} reps • ${exercise["lastPerformed"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "+${(exercise["muscleGrowth"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "muscle growth",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Muscle Mass History
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Measurement History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to all history
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            Column(
              spacing: spSm,
              children: muscleMassHistory.reversed.take(3).map((entry) {
                double muscleMass = (entry["muscleMass"] as num).toDouble();
                double change = (entry["change"] as num).toDouble();
                Color changeColor = change > 0 ? successColor : change < 0 ? dangerColor : disabledBoldColor;
                String changeText = change == 0 ? "No change" : "${change > 0 ? '+' : ''}${change.toStringAsFixed(1)} kg";
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.fitness_center,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${DateTime.parse(entry["date"] as String).dMMMy}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${entry["note"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${muscleMass.toStringAsFixed(1)} kg",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            changeText,
                            style: TextStyle(
                              fontSize: 12,
                              color: changeColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Add Measurement Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Log New Measurement",
                size: bs.md,
                onPressed: () {
                  _showAddMuscleMassDialog();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String unit, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMuscleMassPoint(String label, double muscleMass) {
    double normalizedHeight = ((muscleMass - 40) / 6 * 120).clamp(20, 120);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: normalizedHeight,
          width: 3,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  void _showAddMuscleMassDialog() {
    String newMuscleMass = currentMuscleMass;
    String note = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Log Muscle Mass"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QNumberField(
              label: "Muscle Mass (kg)",
              value: newMuscleMass,
              onChanged: (value) {
                newMuscleMass = value;
              },
            ),
            QTextField(
              label: "Note (optional)",
              value: note,
              hint: "Add measurement details",
              onChanged: (value) {
                note = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              currentMuscleMass = newMuscleMass;
              setState(() {});
              Navigator.pop(context);
              ss("Muscle mass measurement logged!");
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showMuscleMassInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Muscle Mass Information"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Muscle mass is the amount of muscle tissue in your body. It's an important component of overall health and fitness.",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: spSm),
              Text(
                "Tips for Building Muscle:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("• Progressive resistance training\n• Adequate protein intake (1.6-2.2g/kg bodyweight)\n• Sufficient sleep (7-9 hours)\n• Proper recovery between workouts\n• Consistent nutrition"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
