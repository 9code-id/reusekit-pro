import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaFitnessGoalsView extends StatefulWidget {
  const HcaFitnessGoalsView({super.key});

  @override
  State<HcaFitnessGoalsView> createState() => _HcaFitnessGoalsViewState();
}

class _HcaFitnessGoalsViewState extends State<HcaFitnessGoalsView> {
  int currentTab = 0;
  String selectedGoalType = "Weight Loss";
  List<String> goalTypes = ["Weight Loss", "Muscle Gain", "Endurance", "Flexibility", "General Health"];

  List<Map<String, dynamic>> goals = [
    {
      "id": 1,
      "title": "Lose 15 pounds",
      "type": "Weight Loss",
      "targetValue": 15,
      "currentValue": 8,
      "unit": "lbs",
      "targetDate": "2024-08-15",
      "progress": 53,
      "status": "On Track",
      "icon": Icons.trending_down,
      "color": successColor,
      "isActive": true,
      "notes": "Great progress! Keep maintaining your diet and exercise routine."
    },
    {
      "id": 2,
      "title": "Build 5 lbs muscle",
      "type": "Muscle Gain",
      "targetValue": 5,
      "currentValue": 2,
      "unit": "lbs",
      "targetDate": "2024-09-30",
      "progress": 40,
      "status": "In Progress",
      "icon": Icons.fitness_center,
      "color": primaryColor,
      "isActive": true,
      "notes": "Increase protein intake and focus on compound exercises."
    },
    {
      "id": 3,
      "title": "Run 5K in 25 minutes",
      "type": "Endurance",
      "targetValue": 25,
      "currentValue": 28,
      "unit": "minutes",
      "targetDate": "2024-07-20",
      "progress": 75,
      "status": "Almost There",
      "icon": Icons.directions_run,
      "color": warningColor,
      "isActive": true,
      "notes": "3 minutes improvement needed. Focus on interval training."
    },
    {
      "id": 4,
      "title": "Daily 10K steps",
      "type": "General Health",
      "targetValue": 10000,
      "currentValue": 8500,
      "unit": "steps",
      "targetDate": "2024-12-31",
      "progress": 85,
      "status": "On Track",
      "icon": Icons.directions_walk,
      "color": infoColor,
      "isActive": true,
      "notes": "Excellent consistency! Try to reach 10K daily."
    },
    {
      "id": 5,
      "title": "Touch toes flexibility",
      "type": "Flexibility",
      "targetValue": 100,
      "currentValue": 60,
      "unit": "%",
      "targetDate": "2024-10-15",
      "progress": 60,
      "status": "Needs Attention",
      "icon": Icons.accessibility_new,
      "color": dangerColor,
      "isActive": false,
      "notes": "Dedicate more time to stretching and yoga sessions."
    }
  ];

  List<Map<String, dynamic>> weeklyStats = [
    {"day": "Mon", "completed": true, "progress": 90},
    {"day": "Tue", "completed": true, "progress": 85},
    {"day": "Wed", "completed": true, "progress": 95},
    {"day": "Thu", "completed": false, "progress": 70},
    {"day": "Fri", "completed": false, "progress": 0},
    {"day": "Sat", "completed": false, "progress": 0},
    {"day": "Sun", "completed": false, "progress": 0},
  ];

  List<Map<String, dynamic>> get filteredGoals {
    return goals.where((goal) => goal["type"] == selectedGoalType).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "On Track":
        return successColor;
      case "Almost There":
        return warningColor;
      case "In Progress":
        return primaryColor;
      case "Needs Attention":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Fitness Goals",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "My Goals", icon: Icon(Icons.flag)),
        Tab(text: "Progress", icon: Icon(Icons.analytics)),
        Tab(text: "Add Goal", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        // My Goals Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Goal Type Filter
              QCategoryPicker(
                items: goalTypes.map((type) => {
                  "label": type,
                  "value": type,
                }).toList(),
                value: selectedGoalType,
                onChanged: (index, label, value, item) {
                  selectedGoalType = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spLg),

              // Goals List
              ...filteredGoals.map((goal) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: goal["color"] as Color,
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
                              color: (goal["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              goal["icon"] as IconData,
                              color: goal["color"] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${goal["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${goal["type"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
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
                              color: _getStatusColor(goal["status"]).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${goal["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(goal["status"]),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Progress
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Progress",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${goal["progress"]}%",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: goal["color"] as Color,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                LinearProgressIndicator(
                                  value: (goal["progress"] as int) / 100,
                                  backgroundColor: disabledColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(goal["color"] as Color),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Current vs Target
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(goal["currentValue"] as num).toStringAsFixed(goal["currentValue"] is int ? 0 : 1)} ${goal["unit"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
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
                                  "Target",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(goal["targetValue"] as num).toStringAsFixed(goal["targetValue"] is int ? 0 : 1)} ${goal["unit"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: goal["color"] as Color,
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
                                  "Due Date",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${DateTime.parse(goal["targetDate"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Notes
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (goal["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${goal["notes"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),

                      SizedBox(height: spSm),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Update Progress",
                              size: bs.sm,
                              onPressed: () {
                                ss("Progress updated successfully!");
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: goal["isActive"] as bool ? Icons.pause : Icons.play_arrow,
                            size: bs.sm,
                            onPressed: () {
                              goal["isActive"] = !(goal["isActive"] as bool);
                              setState(() {});
                              ss(goal["isActive"] as bool ? "Goal activated" : "Goal paused");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),

        // Progress Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Weekly Overview
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "This Week's Progress",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: weeklyStats.map((day) {
                        return Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: day["completed"] as bool 
                                    ? Colors.white 
                                    : Colors.white.withAlpha(100),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Center(
                                child: day["completed"] as bool
                                    ? Icon(
                                        Icons.check,
                                        color: primaryColor,
                                        size: 20,
                                      )
                                    : Text(
                                        "${day["progress"]}%",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${day["day"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Statistics Cards
              Text(
                "Statistics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.flag,
                              color: successColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Active Goals",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "4",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Out of 5 total",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              "Avg Progress",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "62%",
                          style: TextStyle(
                            fontSize: fsH2,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Across all goals",
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
        ),

        // Add Goal Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create New Goal",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spLg),

              // Goal Templates
              Text(
                "Popular Goal Templates",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...goalTypes.map((type) {
                IconData typeIcon;
                Color typeColor;
                String description;

                switch (type) {
                  case "Weight Loss":
                    typeIcon = Icons.trending_down;
                    typeColor = successColor;
                    description = "Set weight loss targets with timeline";
                    break;
                  case "Muscle Gain":
                    typeIcon = Icons.fitness_center;
                    typeColor = primaryColor;
                    description = "Build muscle mass and strength";
                    break;
                  case "Endurance":
                    typeIcon = Icons.directions_run;
                    typeColor = warningColor;
                    description = "Improve cardiovascular endurance";
                    break;
                  case "Flexibility":
                    typeIcon = Icons.accessibility_new;
                    typeColor = infoColor;
                    description = "Enhance flexibility and mobility";
                    break;
                  default:
                    typeIcon = Icons.favorite;
                    typeColor = dangerColor;
                    description = "General health and wellness goals";
                }

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: typeColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        typeIcon,
                        color: typeColor,
                        size: 24,
                      ),
                    ),
                    title: Text(
                      type,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    subtitle: Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: disabledBoldColor,
                      size: 20,
                    ),
                    onTap: () {
                      ss("Goal template selected: $type");
                    },
                  ),
                );
              }).toList(),

              SizedBox(height: spLg),

              // Custom Goal Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Custom Goal",
                  icon: Icons.add,
                  size: bs.md,
                  onPressed: () {
                    ss("Custom goal creation started");
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
