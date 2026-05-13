import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaWaterIntakeView extends StatefulWidget {
  const FwaWaterIntakeView({super.key});

  @override
  State<FwaWaterIntakeView> createState() => _FwaWaterIntakeViewState();
}

class _FwaWaterIntakeViewState extends State<FwaWaterIntakeView> {
  DateTime selectedDate = DateTime.now();
  int dailyGoal = 8; // glasses
  int currentIntake = 5; // glasses consumed
  
  final List<Map<String, dynamic>> intakeHistory = [
    {"time": "07:30", "amount": 250, "type": "water", "icon": Icons.water_drop},
    {"time": "09:15", "amount": 350, "type": "green_tea", "icon": Icons.local_cafe},
    {"time": "11:00", "amount": 250, "type": "water", "icon": Icons.water_drop},
    {"time": "13:30", "amount": 300, "type": "sparkling", "icon": Icons.bubble_chart},
    {"time": "15:45", "amount": 250, "type": "water", "icon": Icons.water_drop},
  ];

  final List<Map<String, dynamic>> quickAddOptions = [
    {"label": "Small Glass", "amount": 200, "icon": Icons.local_bar},
    {"label": "Regular Glass", "amount": 250, "icon": Icons.water_drop},
    {"label": "Large Glass", "amount": 350, "icon": Icons.sports_bar},
    {"label": "Bottle", "amount": 500, "icon": Icons.local_drink},
    {"label": "Large Bottle", "amount": 750, "icon": Icons.local_drink},
    {"label": "Cup of Tea", "amount": 200, "icon": Icons.local_cafe},
  ];

  final List<Map<String, dynamic>> weeklyProgress = [
    {"day": "Mon", "glasses": 7, "goal": 8},
    {"day": "Tue", "glasses": 9, "goal": 8},
    {"day": "Wed", "glasses": 6, "goal": 8},
    {"day": "Thu", "glasses": 8, "goal": 8},
    {"day": "Fri", "glasses": 5, "goal": 8},
    {"day": "Sat", "glasses": 10, "goal": 8},
    {"day": "Today", "glasses": 5, "goal": 8},
  ];

  final List<Map<String, dynamic>> hydrationTips = [
    {
      "tip": "Start your day with a glass of water",
      "icon": Icons.wb_sunny,
      "time": "Morning"
    },
    {
      "tip": "Drink water before meals to aid digestion",
      "icon": Icons.restaurant,
      "time": "Before meals"
    },
    {
      "tip": "Keep a water bottle at your desk",
      "icon": Icons.work,
      "time": "During work"
    },
    {
      "tip": "Set hourly reminders to drink water",
      "icon": Icons.access_time,
      "time": "Throughout day"
    },
  ];

  int get totalIntakeML => intakeHistory.fold(0, (sum, intake) => sum + (intake["amount"] as int));
  int get targetIntakeML => dailyGoal * 250; // assuming 250ml per glass
  double get progressPercentage => (currentIntake / dailyGoal).clamp(0.0, 1.0);
  int get remainingGlasses => (dailyGoal - currentIntake).clamp(0, dailyGoal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Water Intake"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                selectedDate = date;
                setState(() {});
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              ss("Settings opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${selectedDate.dMMMy}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: remainingGlasses == 0 ? successColor.withAlpha(20) : infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      remainingGlasses == 0 ? "Goal achieved!" : "$remainingGlasses glasses left",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: remainingGlasses == 0 ? successColor : infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Water Progress Display
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Water bottle visualization
                  Container(
                    width: 120,
                    height: 200,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // Bottle outline
                        Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(color: infoColor, width: 3),
                          ),
                        ),
                        // Water fill
                        Container(
                          width: 114,
                          height: (194 * progressPercentage).clamp(0.0, 194.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                infoColor.withAlpha(100),
                                infoColor.withAlpha(200),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                        ),
                        // Progress text overlay
                        Container(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$currentIntake",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(1, 1),
                                      blurRadius: 3,
                                      color: Colors.black.withAlpha(100),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "of $dailyGoal glasses",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(1, 1),
                                      blurRadius: 3,
                                      color: Colors.black.withAlpha(100),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${(progressPercentage * 100).toStringAsFixed(0)}%",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(1, 1),
                                      blurRadius: 3,
                                      color: Colors.black.withAlpha(100),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.water_drop,
                              color: infoColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${totalIntakeML}ml",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Consumed",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.flag,
                              color: successColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${targetIntakeML}ml",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Goal",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (remainingGlasses == 0 ? successColor : warningColor).withAlpha(20),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              remainingGlasses == 0 ? Icons.check_circle : Icons.schedule,
                              color: remainingGlasses == 0 ? successColor : warningColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "$remainingGlasses",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Remaining",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Quick Add Options
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
                    "Quick Add",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: spSm,
                      mainAxisSpacing: spSm,
                    ),
                    itemCount: quickAddOptions.length,
                    itemBuilder: (context, index) {
                      final option = quickAddOptions[index];
                      return GestureDetector(
                        onTap: () async {
                          bool isConfirmed = await confirm("Add ${option["label"]} (${option["amount"]}ml)?");
                          if (isConfirmed) {
                            intakeHistory.insert(0, {
                              "time": "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}",
                              "amount": option["amount"],
                              "type": "water",
                              "icon": option["icon"],
                            });
                            currentIntake = ((totalIntakeML + (option["amount"] as int)) / 250).ceil().clamp(0, dailyGoal + 5);
                            setState(() {});
                            ss("${option["label"]} added!");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: infoColor.withAlpha(50)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                option["icon"] as IconData,
                                color: infoColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${option["label"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${option["amount"]}ml",
                                style: TextStyle(
                                  fontSize: 9,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Today's Intake History
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's Intake",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ss("Custom amount opened");
                        },
                        child: Text(
                          "Custom Amount",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  if (intakeHistory.isEmpty) ...[
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.water_drop_outlined,
                            size: 48,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No water logged today",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Start tracking your hydration!",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    ...intakeHistory.map((intake) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledColor),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                intake["icon"] as IconData,
                                color: infoColor,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${intake["amount"]}ml ${_getTypeLabel(intake["type"])}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${intake["time"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                bool isConfirmed = await confirm("Remove this intake entry?");
                                if (isConfirmed) {
                                  intakeHistory.remove(intake);
                                  currentIntake = ((totalIntakeML) / 250).ceil().clamp(0, dailyGoal + 5);
                                  setState(() {});
                                  ss("Entry removed");
                                }
                              },
                              child: Icon(
                                Icons.remove_circle_outline,
                                color: dangerColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Weekly Progress
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
                    "Weekly Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: weeklyProgress.map((day) {
                      final progress = ((day["glasses"] as int) / (day["goal"] as int)).clamp(0.0, 1.0);
                      final isToday = day["day"] == "Today";
                      final isGoalAchieved = (day["glasses"] as int) >= (day["goal"] as int);
                      
                      return Column(
                        children: [
                          Container(
                            width: 35,
                            height: 80,
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  width: 35,
                                  height: 80 * progress,
                                  decoration: BoxDecoration(
                                    color: isToday ? infoColor : 
                                           isGoalAchieved ? successColor : warningColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${day["day"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                              color: isToday ? primaryColor : disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${day["glasses"]} / ${day["goal"]}",
                            style: TextStyle(
                              fontSize: 9,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Hydration Tips
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
                    "Hydration Tips",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  ...hydrationTips.map((tip) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              tip["icon"] as IconData,
                              color: infoColor,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${tip["tip"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${tip["time"]}",
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
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            intakeHistory.insert(0, {
              "time": "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}",
              "amount": 250,
              "type": "water",
              "icon": Icons.water_drop,
            });
            currentIntake = ((totalIntakeML + 250) / 250).ceil().clamp(0, dailyGoal + 5);
          });
          ss("Water glass added!");
        },
        backgroundColor: infoColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case "green_tea":
        return "(Green Tea)";
      case "sparkling":
        return "(Sparkling)";
      case "water":
      default:
        return "";
    }
  }
}
