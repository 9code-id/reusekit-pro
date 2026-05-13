import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaCropMonitoringView extends StatefulWidget {
  const AmaCropMonitoringView({super.key});

  @override
  State<AmaCropMonitoringView> createState() => _AmaCropMonitoringViewState();
}

class _AmaCropMonitoringViewState extends State<AmaCropMonitoringView> {
  String selectedField = "Main Field A";
  String monitoringPeriod = "Last 7 Days";
  
  List<Map<String, dynamic>> fieldOptions = [
    {"label": "Main Field A", "value": "Main Field A"},
    {"label": "South Pasture", "value": "South Pasture"},
    {"label": "East Garden", "value": "East Garden"},
    {"label": "North Field", "value": "North Field"},
    {"label": "West Orchard", "value": "West Orchard"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 24 Hours", "value": "Last 24 Hours"},
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Current Season", "value": "Current Season"},
  ];

  Map<String, dynamic> currentFieldData = {
    "name": "Main Field A",
    "crop": "Wheat",
    "variety": "Hard Red Winter",
    "stage": "Flowering",
    "plantingDate": "2024-03-15",
    "daysFromPlanting": 92,
    "expectedHarvest": "2024-07-20",
    "area": "25.5 hectares",
    "soilMoisture": 68,
    "temperature": 24,
    "humidity": 65,
    "lightExposure": 85,
    "healthScore": 95,
    "lastUpdate": "2 hours ago",
  };

  List<Map<String, dynamic>> healthMetrics = [
    {
      "metric": "Plant Height",
      "value": "45",
      "unit": "cm",
      "status": "Optimal",
      "trend": "up",
      "icon": Icons.height,
      "color": successColor,
    },
    {
      "metric": "Leaf Color",
      "value": "8.5",
      "unit": "/10",
      "status": "Excellent",
      "trend": "stable",
      "icon": Icons.eco,
      "color": successColor,
    },
    {
      "metric": "Pest Pressure",
      "value": "Low",
      "unit": "",
      "status": "Good",
      "trend": "down",
      "icon": Icons.bug_report,
      "color": primaryColor,
    },
    {
      "metric": "Disease Risk",
      "value": "2",
      "unit": "/10",
      "status": "Very Low",
      "trend": "stable",
      "icon": Icons.healing,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> environmentalData = [
    {
      "parameter": "Soil Moisture",
      "current": 68,
      "optimal": "60-75",
      "unit": "%",
      "status": "Good",
    },
    {
      "parameter": "Temperature",
      "current": 24,
      "optimal": "18-28",
      "unit": "°C",
      "status": "Optimal",
    },
    {
      "parameter": "Humidity",
      "current": 65,
      "optimal": "60-70",
      "unit": "%",
      "status": "Good",
    },
    {
      "parameter": "Light Exposure",
      "current": 85,
      "optimal": "80-95",
      "unit": "%",
      "status": "Optimal",
    },
  ];

  List<Map<String, dynamic>> recentObservations = [
    {
      "date": "Today",
      "time": "08:30",
      "observer": "John Smith",
      "type": "Growth",
      "notes": "Significant height increase observed. Plants showing healthy green color.",
      "images": 3,
      "priority": "normal",
    },
    {
      "date": "Yesterday",
      "time": "16:45",
      "observer": "Mary Johnson",
      "type": "Pest",
      "notes": "Minor aphid presence detected in southwest corner. Applied organic treatment.",
      "images": 2,
      "priority": "medium",
    },
    {
      "date": "2 days ago",
      "time": "09:15",
      "observer": "John Smith",
      "type": "Irrigation",
      "notes": "Irrigation system functioning normally. Soil moisture levels adequate.",
      "images": 1,
      "priority": "normal",
    },
    {
      "date": "3 days ago",
      "time": "14:20",
      "observer": "Dr. Anderson",
      "type": "Disease",
      "notes": "No signs of disease detected. Preventive fungicide application scheduled.",
      "images": 4,
      "priority": "low",
    },
  ];

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'optimal':
      case 'excellent':
      case 'very low':
        return successColor;
      case 'good':
        return primaryColor;
      case 'fair':
      case 'medium':
        return warningColor;
      case 'poor':
      case 'high':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
      case 'normal':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Icon getTrendIcon(String trend) {
    switch (trend.toLowerCase()) {
      case 'up':
        return Icon(Icons.trending_up, color: successColor, size: 16);
      case 'down':
        return Icon(Icons.trending_down, color: dangerColor, size: 16);
      case 'stable':
        return Icon(Icons.trending_flat, color: disabledBoldColor, size: 16);
      default:
        return Icon(Icons.help_outline, color: disabledBoldColor, size: 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crop Monitoring"),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              si("Take monitoring photos");
            },
          ),
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              si("Add new observation");
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
            // Field Selection and Monitoring Period
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
                    label: "Period",
                    items: periodOptions,
                    value: monitoringPeriod,
                    onChanged: (value, label) {
                      monitoringPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Current Field Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(180)],
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
                              "${currentFieldData["name"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${currentFieldData["crop"]} - ${currentFieldData["variety"]}",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Stage: ${currentFieldData["stage"]} • Day ${currentFieldData["daysFromPlanting"]}",
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
                              "${currentFieldData["healthScore"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Health Score",
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
                          "${currentFieldData["area"]}",
                          "Total Area",
                        ),
                      ),
                      Expanded(
                        child: _buildOverviewStat(
                          "${currentFieldData["soilMoisture"]}%",
                          "Soil Moisture",
                        ),
                      ),
                      Expanded(
                        child: _buildOverviewStat(
                          "${currentFieldData["temperature"]}°C",
                          "Temperature",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Health Metrics
            Text(
              "Health Metrics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: healthMetrics.map((metric) {
                return Container(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"],
                              color: metric["color"],
                              size: 20,
                            ),
                          ),
                          getTrendIcon(metric["trend"]),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${metric["value"]}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: metric["color"],
                            ),
                          ),
                          if (metric["unit"].isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(left: 2, bottom: 2),
                              child: Text(
                                "${metric["unit"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        "${metric["metric"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${metric["status"]}",
                        style: TextStyle(
                          color: metric["color"],
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Environmental Conditions
            Text(
              "Environmental Conditions",
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
                children: List.generate(environmentalData.length, (index) {
                  final data = environmentalData[index];
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
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${data["parameter"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${data["current"]}${data["unit"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${data["optimal"]}${data["unit"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: getStatusColor(data["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${data["status"]}",
                            style: TextStyle(
                              color: getStatusColor(data["status"]),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            // Recent Observations
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Observations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "Add Observation",
                  size: bs.sm,
                  onPressed: () {
                    si("Open observation form");
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
                children: List.generate(recentObservations.length.clamp(0, 4), (index) {
                  final observation = recentObservations[index];
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          margin: EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            color: getPriorityColor(observation["priority"]),
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
                                    "${observation["type"]} Observation",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${observation["date"]} ${observation["time"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${observation["notes"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "By ${observation["observer"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontStyle: FontStyle.italic,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if (observation["images"] > 0) ...[
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.photo_camera,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${observation["images"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ],
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

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Schedule Irrigation",
                          size: bs.sm,
                          onPressed: () {
                            si("Open irrigation scheduler");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Record Treatment",
                          size: bs.sm,
                          onPressed: () {
                            si("Open treatment log");
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Generate Report",
                          size: bs.sm,
                          onPressed: () {
                            si("Generate monitoring report");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Share Data",
                          size: bs.sm,
                          onPressed: () {
                            si("Share monitoring data");
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
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withAlpha(200),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
