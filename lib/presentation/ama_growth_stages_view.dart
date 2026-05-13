import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaGrowthStagesView extends StatefulWidget {
  const AmaGrowthStagesView({super.key});

  @override
  State<AmaGrowthStagesView> createState() => _AmaGrowthStagesViewState();
}

class _AmaGrowthStagesViewState extends State<AmaGrowthStagesView> {
  String selectedField = "Main Field A";
  String selectedCrop = "Wheat";
  
  List<Map<String, dynamic>> fieldOptions = [
    {"label": "Main Field A", "value": "Main Field A"},
    {"label": "South Pasture", "value": "South Pasture"},
    {"label": "East Garden", "value": "East Garden"},
    {"label": "North Field", "value": "North Field"},
    {"label": "West Orchard", "value": "West Orchard"},
  ];

  List<Map<String, dynamic>> cropOptions = [
    {"label": "Wheat", "value": "Wheat"},
    {"label": "Corn", "value": "Corn"},
    {"label": "Tomatoes", "value": "Tomatoes"},
    {"label": "Soybeans", "value": "Soybeans"},
    {"label": "Apples", "value": "Apples"},
  ];

  Map<String, dynamic> currentCropInfo = {
    "name": "Wheat",
    "variety": "Hard Red Winter",
    "plantingDate": "2024-03-15",
    "currentStage": 3,
    "daysFromPlanting": 92,
    "estimatedHarvest": "2024-07-20",
    "daysToHarvest": 28,
  };

  List<Map<String, dynamic>> growthStages = [
    {
      "id": 1,
      "stage": "Germination",
      "description": "Seed sprouting and initial root development",
      "duration": "7-14 days",
      "keyActivities": [
        "Monitor soil moisture",
        "Check for uniform emergence",
        "Protect from birds and pests"
      ],
      "completed": true,
      "completedDate": "2024-03-22",
      "icon": Icons.grass,
      "color": successColor,
      "progress": 100,
    },
    {
      "id": 2,
      "stage": "Tillering",
      "description": "Development of multiple shoots from the main stem",
      "duration": "20-30 days",
      "keyActivities": [
        "Apply nitrogen fertilizer",
        "Control weeds",
        "Monitor plant density"
      ],
      "completed": true,
      "completedDate": "2024-04-15",
      "icon": Icons.eco,
      "color": successColor,
      "progress": 100,
    },
    {
      "id": 3,
      "stage": "Stem Extension",
      "description": "Rapid vertical growth and stem elongation",
      "duration": "25-35 days",
      "keyActivities": [
        "Monitor for disease",
        "Apply fungicide if needed",
        "Continue weed management"
      ],
      "completed": true,
      "completedDate": "2024-05-10",
      "icon": Icons.height,
      "color": successColor,
      "progress": 100,
    },
    {
      "id": 4,
      "stage": "Flowering",
      "description": "Flower development and pollination phase",
      "duration": "15-20 days",
      "keyActivities": [
        "Monitor weather conditions",
        "Ensure adequate water",
        "Watch for pest activity"
      ],
      "completed": false,
      "completedDate": null,
      "icon": Icons.local_florist,
      "color": primaryColor,
      "progress": 75,
    },
    {
      "id": 5,
      "stage": "Grain Filling",
      "description": "Grain development and weight accumulation",
      "duration": "20-25 days",
      "keyActivities": [
        "Maintain soil moisture",
        "Monitor for late-season diseases",
        "Prepare harvest equipment"
      ],
      "completed": false,
      "completedDate": null,
      "icon": Icons.agriculture,
      "color": warningColor,
      "progress": 0,
    },
    {
      "id": 6,
      "stage": "Maturity",
      "description": "Crop ready for harvest",
      "duration": "7-14 days",
      "keyActivities": [
        "Monitor grain moisture",
        "Schedule harvest",
        "Prepare storage facilities"
      ],
      "completed": false,
      "completedDate": null,
      "icon": Icons.storage,
      "color": disabledBoldColor,
      "progress": 0,
    },
  ];

  List<Map<String, dynamic>> stageActivities = [
    {
      "activity": "Disease monitoring",
      "stage": "Flowering",
      "date": "2024-06-10",
      "status": "Completed",
      "notes": "No signs of fungal infection detected",
      "priority": "High",
    },
    {
      "activity": "Pollination check",
      "stage": "Flowering",
      "date": "2024-06-12",
      "status": "In Progress",
      "notes": "Good pollen release observed",
      "priority": "Medium",
    },
    {
      "activity": "Water management",
      "stage": "Flowering",
      "date": "2024-06-14",
      "status": "Scheduled",
      "notes": "Irrigation scheduled for tomorrow morning",
      "priority": "High",
    },
  ];

  List<Map<String, dynamic>> milestones = [
    {
      "milestone": "50% Emergence",
      "date": "2024-03-20",
      "achieved": true,
      "target": "2024-03-22",
      "variance": "-2 days",
    },
    {
      "milestone": "Tillering Complete",
      "date": "2024-04-15",
      "achieved": true,
      "target": "2024-04-18",
      "variance": "-3 days",
    },
    {
      "milestone": "Flowering Start",
      "date": "2024-05-25",
      "achieved": true,
      "target": "2024-05-28",
      "variance": "-3 days",
    },
    {
      "milestone": "Grain Filling Start",
      "date": "Expected: 2024-06-20",
      "achieved": false,
      "target": "2024-06-22",
      "variance": "On track",
    },
  ];

  int get currentStageIndex => currentCropInfo["currentStage"] - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Growth Stages"),
        actions: [
          IconButton(
            icon: Icon(Icons.timeline),
            onPressed: () {
              si("View growth timeline");
            },
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              si("View stage information guide");
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
            // Field and Crop Selection
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Select Field",
                    items: fieldOptions,
                    value: selectedField,
                    onChanged: (value, label) {
                      selectedField = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Crop Type",
                    items: cropOptions,
                    value: selectedCrop,
                    onChanged: (value, label) {
                      selectedCrop = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Current Crop Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentCropInfo["name"]} - ${currentCropInfo["variety"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Planted: ${currentCropInfo["plantingDate"]}",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Current Stage: ${growthStages[currentStageIndex]["stage"]}",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${currentCropInfo["daysFromPlanting"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Days Old",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildOverviewStat(
                          "${currentCropInfo["daysToHarvest"]} days",
                          "To Harvest",
                        ),
                      ),
                      Expanded(
                        child: _buildOverviewStat(
                          "${((currentStageIndex + 1) / growthStages.length * 100).toInt()}%",
                          "Completion",
                        ),
                      ),
                      Expanded(
                        child: _buildOverviewStat(
                          "${currentCropInfo["estimatedHarvest"]}",
                          "Target Harvest",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Growth Stages Timeline
            Text(
              "Growth Timeline",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate(growthStages.length, (index) {
                  final stage = growthStages[index];
                  final isActive = index == currentStageIndex;
                  final isCompleted = stage["completed"] == true;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: index > 0 ? Border(
                        top: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ) : null,
                      color: isActive ? primaryColor.withAlpha(20) : null,
                    ),
                    child: Row(
                      children: [
                        // Stage indicator
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isCompleted 
                                ? successColor 
                                : isActive 
                                    ? primaryColor 
                                    : disabledColor.withAlpha(50),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isCompleted ? Icons.check : stage["icon"],
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        // Stage content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${stage["stage"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: isActive ? primaryColor : null,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${stage["duration"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              
                              Text(
                                "${stage["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                              
                              if (isCompleted && stage["completedDate"] != null)
                                Text(
                                  "Completed: ${stage["completedDate"]}",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              
                              if (isActive) ...[
                                SizedBox(height: spXs),
                                LinearProgressIndicator(
                                  value: (stage["progress"] as int) / 100,
                                  backgroundColor: disabledColor.withAlpha(50),
                                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${stage["progress"]}% Complete",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                              
                              SizedBox(height: spXs),
                              
                              // Key activities
                              Text(
                                "Key Activities:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              
                              ...List.generate(
                                (stage["keyActivities"] as List).length.clamp(0, 2),
                                (actIndex) {
                                  final activity = (stage["keyActivities"] as List)[actIndex];
                                  return Padding(
                                    padding: EdgeInsets.only(left: spSm, top: 2),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 4,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: disabledBoldColor,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Expanded(
                                          child: Text(
                                            "$activity",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        
                        if (isActive)
                          QButton(
                            label: "Update",
                            size: bs.sm,
                            onPressed: () {
                              si("Update stage progress");
                            },
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            // Current Stage Activities
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Stage Activities",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "Add Activity",
                  size: bs.sm,
                  onPressed: () {
                    si("Add new stage activity");
                  },
                ),
              ],
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate(stageActivities.length, (index) {
                  final activity = stageActivities[index];
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: index > 0 ? Border(
                        top: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ) : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: activity["priority"] == "High" ? dangerColor :
                                   activity["priority"] == "Medium" ? warningColor : successColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${activity["activity"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: activity["status"] == "Completed" ? successColor.withAlpha(20) :
                                             activity["status"] == "In Progress" ? warningColor.withAlpha(20) :
                                             disabledColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${activity["status"]}",
                                      style: TextStyle(
                                        color: activity["status"] == "Completed" ? successColor :
                                               activity["status"] == "In Progress" ? warningColor :
                                               disabledBoldColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${activity["notes"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Due: ${activity["date"]} • ${activity["priority"]} Priority",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            // Growth Milestones
            Text(
              "Growth Milestones",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate(milestones.length, (index) {
                  final milestone = milestones[index];
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: index > 0 ? Border(
                        top: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ) : null,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          milestone["achieved"] ? Icons.check_circle : Icons.schedule,
                          color: milestone["achieved"] ? successColor : warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${milestone["milestone"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${milestone["date"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Target: ${milestone["target"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${milestone["variance"]}",
                          style: TextStyle(
                            color: milestone["variance"].contains("-") ? successColor :
                                   milestone["variance"].contains("+") ? dangerColor :
                                   disabledBoldColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withAlpha(200),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
