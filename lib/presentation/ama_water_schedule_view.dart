import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaWaterScheduleView extends StatefulWidget {
  const AmaWaterScheduleView({super.key});

  @override
  State<AmaWaterScheduleView> createState() => _AmaWaterScheduleViewState();
}

class _AmaWaterScheduleViewState extends State<AmaWaterScheduleView> {
  int selectedDay = 0;
  String selectedSystem = "all";
  bool showActiveOnly = false;
  
  List<String> weekDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  
  List<Map<String, dynamic>> wateringSystems = [
    {"label": "All Systems", "value": "all"},
    {"label": "Drip Irrigation", "value": "drip"},
    {"label": "Sprinkler System", "value": "sprinkler"},
    {"label": "Greenhouse", "value": "greenhouse"},
    {"label": "Flood Irrigation", "value": "flood"}
  ];

  List<Map<String, dynamic>> wateringSchedules = [
    {
      "id": "WS001",
      "systemName": "North Field Drip System",
      "systemType": "drip",
      "zone": "North Field Zone A",
      "crop": "Tomatoes",
      "time": "06:00",
      "duration": 45,
      "waterAmount": 850,
      "isActive": true,
      "priority": "High",
      "days": ["Monday", "Wednesday", "Friday"],
      "lastRun": "2024-06-14 06:00",
      "nextRun": "2024-06-17 06:00",
      "efficiency": 94,
      "costPerRun": 12.75,
      "sensorTriggered": false,
      "soilMoisture": 68,
      "weatherDependent": true
    },
    {
      "id": "WS002",
      "systemName": "North Field Drip System",
      "systemType": "drip",
      "zone": "North Field Zone A",
      "crop": "Tomatoes",
      "time": "18:00",
      "duration": 45,
      "waterAmount": 850,
      "isActive": true,
      "priority": "High",
      "days": ["Monday", "Wednesday", "Friday"],
      "lastRun": "2024-06-14 18:00",
      "nextRun": "2024-06-17 18:00",
      "efficiency": 94,
      "costPerRun": 12.75,
      "sensorTriggered": false,
      "soilMoisture": 68,
      "weatherDependent": true
    },
    {
      "id": "WS003",
      "systemName": "South Field Sprinklers",
      "systemType": "sprinkler",
      "zone": "South Field Zone B",
      "crop": "Bell Peppers",
      "time": "05:30",
      "duration": 30,
      "waterAmount": 1420,
      "isActive": true,
      "priority": "Medium",
      "days": ["Tuesday", "Thursday", "Saturday"],
      "lastRun": "2024-06-13 05:30",
      "nextRun": "2024-06-15 05:30",
      "efficiency": 78,
      "costPerRun": 18.50,
      "sensorTriggered": false,
      "soilMoisture": 55,
      "weatherDependent": true
    },
    {
      "id": "WS004",
      "systemName": "South Field Sprinklers",
      "systemType": "sprinkler",
      "zone": "South Field Zone B",
      "crop": "Bell Peppers",
      "time": "19:00",
      "duration": 30,
      "waterAmount": 1420,
      "isActive": true,
      "priority": "Medium",
      "days": ["Tuesday", "Thursday", "Saturday"],
      "lastRun": "2024-06-13 19:00",
      "nextRun": "2024-06-15 19:00",
      "efficiency": 78,
      "costPerRun": 18.50,
      "sensorTriggered": false,
      "soilMoisture": 55,
      "weatherDependent": true
    },
    {
      "id": "WS005",
      "systemName": "Greenhouse Misting",
      "systemType": "greenhouse",
      "zone": "Greenhouse A",
      "crop": "Cucumbers",
      "time": "08:00",
      "duration": 15,
      "waterAmount": 48,
      "isActive": true,
      "priority": "Low",
      "days": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
      "lastRun": "2024-06-14 20:00",
      "nextRun": "2024-06-15 08:00",
      "efficiency": 96,
      "costPerRun": 2.25,
      "sensorTriggered": true,
      "soilMoisture": 82,
      "weatherDependent": false
    },
    {
      "id": "WS006",
      "systemName": "Greenhouse Misting",
      "systemType": "greenhouse",
      "zone": "Greenhouse A",
      "crop": "Cucumbers",
      "time": "14:00",
      "duration": 15,
      "waterAmount": 48,
      "isActive": true,
      "priority": "Low",
      "days": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
      "lastRun": "2024-06-14 14:00",
      "nextRun": "2024-06-15 14:00",
      "efficiency": 96,
      "costPerRun": 2.25,
      "sensorTriggered": true,
      "soilMoisture": 82,
      "weatherDependent": false
    },
    {
      "id": "WS007",
      "systemName": "East Field Flood",
      "systemType": "flood",
      "zone": "East Field",
      "crop": "Rice",
      "time": "03:00",
      "duration": 360,
      "waterAmount": 16272,
      "isActive": false,
      "priority": "High",
      "days": ["Sunday"],
      "lastRun": "2024-06-09 03:00",
      "nextRun": "2024-06-16 03:00",
      "efficiency": 65,
      "costPerRun": 85.40,
      "sensorTriggered": false,
      "soilMoisture": 95,
      "weatherDependent": true
    }
  ];

  List<Map<String, dynamic>> getFilteredSchedules() {
    List<Map<String, dynamic>> filtered = wateringSchedules;
    
    // Filter by system type
    if (selectedSystem != "all") {
      filtered = filtered.where((schedule) => schedule["systemType"] == selectedSystem).toList();
    }
    
    // Filter by day
    String currentDay = weekDays[selectedDay];
    filtered = filtered.where((schedule) => 
      (schedule["days"] as List).contains(currentDay)).toList();
    
    // Filter by active status
    if (showActiveOnly) {
      filtered = filtered.where((schedule) => schedule["isActive"] as bool).toList();
    }
    
    // Sort by time
    filtered.sort((a, b) => a["time"].compareTo(b["time"]));
    
    return filtered;
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  Color getSensorStatusColor(int moisture) {
    if (moisture > 70) return successColor;
    if (moisture > 40) return warningColor;
    return dangerColor;
  }

  IconData getSystemIcon(String systemType) {
    switch (systemType) {
      case "drip":
        return Icons.water_drop;
      case "sprinkler":
        return Icons.shower;
      case "greenhouse":
        return Icons.grain;
      case "flood":
        return Icons.waves;
      default:
        return Icons.water;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredSchedules = getFilteredSchedules();
    String currentDay = weekDays[selectedDay];
    int activeToday = wateringSchedules.where((s) => 
      (s["days"] as List).contains(currentDay) && (s["isActive"] as bool)).length;
    double totalWaterToday = filteredSchedules.where((s) => s["isActive"] as bool)
      .map((s) => s["waterAmount"] as int).fold(0.0, (a, b) => a + b);
    double totalCostToday = filteredSchedules.where((s) => s["isActive"] as bool)
      .map((s) => s["costPerRun"] as double).fold(0.0, (a, b) => a + b);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Water Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_alarm),
            onPressed: () {
              // Add new schedule
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Schedule analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daily Overview Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$activeToday",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Active Today",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.water_drop,
                          color: infoColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(totalWaterToday / 1000).toStringAsFixed(1)}K L",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Water Today",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${totalCostToday.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Cost Today",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Day Selection
            Text(
              "Select Day",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            QCategoryPicker(
              items: weekDays.map((day) => {
                "label": day,
                "value": weekDays.indexOf(day),
              }).toList(),
              value: selectedDay,
              onChanged: (index, label, value, item) {
                selectedDay = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Filters
            Text(
              "Filters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "System Type",
                    items: wateringSystems,
                    value: selectedSystem,
                    onChanged: (value, label) {
                      selectedSystem = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Active Only",
                        "value": true,
                        "checked": showActiveOnly,
                      }
                    ],
                    value: [
                      if (showActiveOnly)
                        {
                          "label": "Active Only",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showActiveOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Schedule List
            Text(
              "$currentDay Schedule (${filteredSchedules.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            if (filteredSchedules.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_available,
                      color: disabledBoldColor,
                      size: 48,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No watering scheduled",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "No irrigation activities are planned for $currentDay with the current filters",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredSchedules.map((schedule) {
                Color priorityColor = getPriorityColor("${schedule["priority"]}");
                Color moistureColor = getSensorStatusColor(schedule["soilMoisture"] as int);
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: priorityColor,
                      ),
                    ),
                  ),
                  child: ExpansionTile(
                    leading: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        getSystemIcon("${schedule["systemType"]}"),
                        color: priorityColor,
                        size: 24,
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${schedule["time"]} - ${schedule["systemName"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${schedule["zone"]} • ${schedule["crop"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: priorityColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${schedule["priority"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: priorityColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: (schedule["isActive"] as bool) ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                (schedule["isActive"] as bool) ? "Active" : "Disabled",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: (schedule["isActive"] as bool) ? successColor : disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${schedule["duration"]} min",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(
                              Icons.water_drop,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${schedule["waterAmount"]} L",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${schedule["costPerRun"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Schedule Details
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Schedule Details",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Days",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${(schedule["days"] as List).join(", ")}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
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
                                              "Efficiency",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${schedule["efficiency"]}%",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: (schedule["efficiency"] as int) > 80 ? successColor : warningColor,
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
                            
                            SizedBox(height: spSm),
                            
                            // Sensor & Weather Info
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: moistureColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.grass,
                                          color: moistureColor,
                                          size: 16,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "${schedule["soilMoisture"]}%",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: moistureColor,
                                          ),
                                        ),
                                        Text(
                                          "Soil Moisture",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: (schedule["sensorTriggered"] as bool) ? successColor.withAlpha(10) : disabledColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.sensors,
                                          color: (schedule["sensorTriggered"] as bool) ? successColor : disabledBoldColor,
                                          size: 16,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          (schedule["sensorTriggered"] as bool) ? "Auto" : "Manual",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: (schedule["sensorTriggered"] as bool) ? successColor : disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "Trigger",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: (schedule["weatherDependent"] as bool) ? infoColor.withAlpha(10) : disabledColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.cloud,
                                          color: (schedule["weatherDependent"] as bool) ? infoColor : disabledBoldColor,
                                          size: 16,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          (schedule["weatherDependent"] as bool) ? "Yes" : "No",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: (schedule["weatherDependent"] as bool) ? infoColor : disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "Weather",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Last & Next Run
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Last Run",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${schedule["lastRun"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
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
                                        "Next Run",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${schedule["nextRun"]}",
                                        style: TextStyle(
                                          fontSize: 12,
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
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Run Now",
                                    size: bs.sm,
                                    onPressed: (schedule["isActive"] as bool) ? () {
                                      // Run immediately
                                    } : null,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: QButton(
                                    label: "Edit",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Edit schedule
                                    },
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: QButton(
                                    label: (schedule["isActive"] as bool) ? "Disable" : "Enable",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Toggle schedule
                                    },
                                  ),
                                ),
                              ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new watering schedule
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
