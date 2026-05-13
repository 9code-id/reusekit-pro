import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaPlantingScheduleView extends StatefulWidget {
  const AmaPlantingScheduleView({super.key});

  @override
  State<AmaPlantingScheduleView> createState() => _AmaPlantingScheduleViewState();
}

class _AmaPlantingScheduleViewState extends State<AmaPlantingScheduleView> {
  List<Map<String, dynamic>> scheduleItems = [
    {
      "id": 1,
      "crop": "Corn",
      "variety": "Golden Harvest",
      "field": "North Field A",
      "plantingDate": "2024-04-15",
      "expectedHarvest": "2024-07-20",
      "area": 25.5,
      "seedRate": "32,000 seeds/acre",
      "status": "Scheduled",
      "priority": "High",
      "weather": "Favorable",
      "soilTemp": 55,
      "moisture": 75,
      "notes": "Wait for soil temperature to reach 50°F consistently",
      "tasks": [
        {"task": "Soil preparation", "date": "2024-04-10", "completed": true},
        {"task": "Seed purchase", "date": "2024-04-12", "completed": true},
        {"task": "Equipment check", "date": "2024-04-14", "completed": false},
        {"task": "Planting", "date": "2024-04-15", "completed": false}
      ]
    },
    {
      "id": 2,
      "crop": "Soybean",
      "variety": "Emerald",
      "field": "South Field B",
      "plantingDate": "2024-05-01",
      "expectedHarvest": "2024-09-15",
      "area": 18.3,
      "seedRate": "140,000 seeds/acre",
      "status": "Planted",
      "priority": "Medium",
      "weather": "Good",
      "soilTemp": 62,
      "moisture": 82,
      "notes": "Monitor for emergence in 7-10 days",
      "tasks": [
        {"task": "Soil preparation", "date": "2024-04-25", "completed": true},
        {"task": "Seed purchase", "date": "2024-04-28", "completed": true},
        {"task": "Equipment check", "date": "2024-04-30", "completed": true},
        {"task": "Planting", "date": "2024-05-01", "completed": true}
      ]
    },
    {
      "id": 3,
      "crop": "Wheat",
      "variety": "Premium Elite",
      "field": "East Field C",
      "plantingDate": "2024-09-20",
      "expectedHarvest": "2025-07-15",
      "area": 42.1,
      "seedRate": "90 lbs/acre",
      "status": "Planning",
      "priority": "High",
      "weather": "Monitoring",
      "soilTemp": 45,
      "moisture": 68,
      "notes": "Fall planting for winter wheat variety",
      "tasks": [
        {"task": "Soil preparation", "date": "2024-09-15", "completed": false},
        {"task": "Seed purchase", "date": "2024-09-18", "completed": false},
        {"task": "Equipment check", "date": "2024-09-19", "completed": false},
        {"task": "Planting", "date": "2024-09-20", "completed": false}
      ]
    },
    {
      "id": 4,
      "crop": "Tomato",
      "variety": "Victory",
      "field": "Greenhouse 1",
      "plantingDate": "2024-03-15",
      "expectedHarvest": "2024-06-30",
      "area": 5.2,
      "seedRate": "2,500 plants/acre",
      "status": "Harvesting",
      "priority": "Low",
      "weather": "Controlled",
      "soilTemp": 70,
      "moisture": 85,
      "notes": "Greenhouse controlled environment",
      "tasks": [
        {"task": "Soil preparation", "date": "2024-03-10", "completed": true},
        {"task": "Seed purchase", "date": "2024-03-12", "completed": true},
        {"task": "Equipment check", "date": "2024-03-14", "completed": true},
        {"task": "Planting", "date": "2024-03-15", "completed": true}
      ]
    }
  ];

  List<Map<String, dynamic>> filteredSchedule = [];
  String selectedStatus = "All";
  String selectedCrop = "All";
  String selectedPriority = "All";
  DateTime selectedMonth = DateTime.now();

  List<String> statusOptions = ["All", "Planning", "Scheduled", "Planted", "Harvesting"];
  List<String> cropOptions = ["All", "Corn", "Soybean", "Wheat", "Tomato"];
  List<String> priorityOptions = ["All", "Low", "Medium", "High"];

  @override
  void initState() {
    super.initState();
    filteredSchedule = scheduleItems;
  }

  void _filterSchedule() {
    filteredSchedule = scheduleItems.where((item) {
      bool matchesStatus = selectedStatus == "All" || item["status"] == selectedStatus;
      bool matchesCrop = selectedCrop == "All" || item["crop"] == selectedCrop;
      bool matchesPriority = selectedPriority == "All" || item["priority"] == selectedPriority;
      
      return matchesStatus && matchesCrop && matchesPriority;
    }).toList();
    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Planning":
        return infoColor;
      case "Scheduled":
        return warningColor;
      case "Planted":
        return successColor;
      case "Harvesting":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Planting Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add schedule
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () {
              // Show calendar view
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.filter_list, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusOptions.map((status) => {
                            "label": status,
                            "value": status,
                          }).toList(),
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            _filterSchedule();
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Crop",
                          items: cropOptions.map((crop) => {
                            "label": crop,
                            "value": crop,
                          }).toList(),
                          value: selectedCrop,
                          onChanged: (value, label) {
                            selectedCrop = value;
                            _filterSchedule();
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Priority",
                    items: priorityOptions.map((priority) => {
                      "label": priority,
                      "value": priority,
                    }).toList(),
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
                      _filterSchedule();
                    },
                  ),
                ],
              ),
            ),

            // Summary Cards
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${scheduleItems.length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Items",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${scheduleItems.where((item) => item["status"] == "Scheduled").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Scheduled",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${((scheduleItems.map((item) => (item["area"] as num)).reduce((a, b) => a + b))).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Acres",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Schedule Items
            ...List.generate(filteredSchedule.length, (index) {
              final item = filteredSchedule[index];
              final completedTasks = (item["tasks"] as List).where((task) => task["completed"] == true).length;
              final totalTasks = (item["tasks"] as List).length;
              final progress = completedTasks / totalTasks;

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
                      color: _getStatusColor("${item["status"]}"),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${item["crop"]} - ${item["variety"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${item["field"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          spacing: spXs,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor("${item["status"]}"),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${item["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getPriorityColor("${item["priority"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(
                                  color: _getPriorityColor("${item["priority"]}"),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                "${item["priority"]} Priority",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getPriorityColor("${item["priority"]}"),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 2,
                              children: [
                                Text(
                                  "Planting Date",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${DateTime.parse(item["plantingDate"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: primaryColor.withAlpha(30),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 2,
                              children: [
                                Text(
                                  "Expected Harvest",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${DateTime.parse(item["expectedHarvest"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: primaryColor.withAlpha(30),
                          ),
                          SizedBox(width: spSm),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            spacing: 2,
                            children: [
                              Text(
                                "${(item["area"] as num).toStringAsFixed(1)} acres",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${item["seedRate"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Environmental Conditions
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.thermostat, size: 16, color: successColor),
                                SizedBox(width: 4),
                                Text(
                                  "${item["soilTemp"]}°F",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.water_drop, size: 16, color: infoColor),
                                SizedBox(width: 4),
                                Text(
                                  "${item["moisture"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.wb_sunny, size: 16, color: warningColor),
                                SizedBox(width: 4),
                                Text(
                                  "${item["weather"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Progress Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Task Progress",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "$completedTasks/$totalTasks tasks",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: progress,
                            child: Container(
                              decoration: BoxDecoration(
                                color: progress == 1.0 ? successColor : primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    if (item["notes"].toString().isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(color: warningColor.withAlpha(30)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline, size: 16, color: warningColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${item["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Tasks",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to task details
                            },
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "Edit Schedule",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to edit
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),

            if (filteredSchedule.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No schedule items found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
