import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaVitalSignsView extends StatefulWidget {
  const MhaVitalSignsView({super.key});

  @override
  State<MhaVitalSignsView> createState() => _MhaVitalSignsViewState();
}

class _MhaVitalSignsViewState extends State<MhaVitalSignsView> {
  String selectedPeriod = "7 Days";
  int selectedVitalIndex = 0;
  
  final periods = [
    {"label": "24 Hours", "value": "24 Hours"},
    {"label": "7 Days", "value": "7 Days"},
    {"label": "30 Days", "value": "30 Days"},
    {"label": "3 Months", "value": "3 Months"},
  ];

  final vitalSigns = [
    {
      "name": "Blood Pressure",
      "current_value": "120/80",
      "unit": "mmHg",
      "status": "Normal",
      "icon": Icons.favorite,
      "color": 0xFFE91E63,
      "trend": "stable",
      "last_updated": "2 hours ago",
      "normal_range": "90-140 / 60-90",
      "readings": [
        {"time": "06:00", "systolic": 118, "diastolic": 78},
        {"time": "12:00", "systolic": 122, "diastolic": 82},
        {"time": "18:00", "systolic": 120, "diastolic": 80},
        {"time": "00:00", "systolic": 116, "diastolic": 76},
      ]
    },
    {
      "name": "Heart Rate",
      "current_value": "72",
      "unit": "bpm",
      "status": "Normal",
      "icon": Icons.monitor_heart,
      "color": 0xFFF44336,
      "trend": "up",
      "last_updated": "1 hour ago",
      "normal_range": "60-100 bpm",
      "readings": [
        {"time": "06:00", "value": 68},
        {"time": "12:00", "value": 75},
        {"time": "18:00", "value": 72},
        {"time": "00:00", "value": 70},
      ]
    },
    {
      "name": "Body Temperature",
      "current_value": "98.6",
      "unit": "°F",
      "status": "Normal",
      "icon": Icons.thermostat,
      "color": 0xFF2196F3,
      "trend": "stable",
      "last_updated": "4 hours ago",
      "normal_range": "97.0-99.5 °F",
      "readings": [
        {"time": "06:00", "value": 98.4},
        {"time": "12:00", "value": 98.8},
        {"time": "18:00", "value": 98.6},
        {"time": "00:00", "value": 98.2},
      ]
    },
    {
      "name": "Blood Oxygen",
      "current_value": "98",
      "unit": "%",
      "status": "Excellent",
      "icon": Icons.air,
      "color": 0xFF4CAF50,
      "trend": "up",
      "last_updated": "30 minutes ago",
      "normal_range": "95-100%",
      "readings": [
        {"time": "06:00", "value": 97},
        {"time": "12:00", "value": 98},
        {"time": "18:00", "value": 98},
        {"time": "00:00", "value": 99},
      ]
    },
    {
      "name": "Weight",
      "current_value": "70.5",
      "unit": "kg",
      "status": "Healthy",
      "icon": Icons.monitor_weight,
      "color": 0xFF9C27B0,
      "trend": "down",
      "last_updated": "This morning",
      "normal_range": "BMI 18.5-24.9",
      "readings": [
        {"time": "Mon", "value": 71.2},
        {"time": "Tue", "value": 71.0},
        {"time": "Wed", "value": 70.8},
        {"time": "Thu", "value": 70.5},
      ]
    },
    {
      "name": "Sleep Quality",
      "current_value": "8.2",
      "unit": "hours",
      "status": "Good",
      "icon": Icons.bedtime,
      "color": 0xFF673AB7,
      "trend": "up",
      "last_updated": "Last night",
      "normal_range": "7-9 hours",
      "readings": [
        {"time": "Mon", "value": 7.5},
        {"time": "Tue", "value": 8.0},
        {"time": "Wed", "value": 8.2},
        {"time": "Thu", "value": 8.2},
      ]
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "excellent":
        return successColor;
      case "good":
      case "normal":
      case "healthy":
        return primaryColor;
      case "warning":
        return warningColor;
      case "critical":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "up":
        return Icons.trending_up;
      case "down":
        return Icons.trending_down;
      default:
        return Icons.trending_flat;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "up":
        return successColor;
      case "down":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vital Signs"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Period Selector
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Row(
              children: [
                Text(
                  "Period:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "",
                    items: periods,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Vital Signs Grid
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  // Overview Cards
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 160,
                    children: vitalSigns.take(4).map((vital) {
                      return GestureDetector(
                        onTap: () {
                          selectedVitalIndex = vitalSigns.indexOf(vital);
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                            border: selectedVitalIndex == vitalSigns.indexOf(vital)
                                ? Border.all(color: primaryColor, width: 2)
                                : null,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Color(vital["color"] as int).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Icon(
                                      vital["icon"] as IconData,
                                      size: 20,
                                      color: Color(vital["color"] as int),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    _getTrendIcon(vital["trend"] as String),
                                    size: 16,
                                    color: _getTrendColor(vital["trend"] as String),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${vital["current_value"]} ${vital["unit"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(vital["color"] as int),
                                ),
                              ),
                              Text(
                                "${vital["name"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(vital["status"] as String).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${vital["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(vital["status"] as String),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: spMd),

                  // Detailed Chart View
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
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Color(vitalSigns[selectedVitalIndex]["color"] as int).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                vitalSigns[selectedVitalIndex]["icon"] as IconData,
                                size: 20,
                                color: Color(vitalSigns[selectedVitalIndex]["color"] as int),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${vitalSigns[selectedVitalIndex]["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Last updated: ${vitalSigns[selectedVitalIndex]["last_updated"]}",
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
                        SizedBox(height: spMd),
                        
                        // Current Value Display
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "${vitalSigns[selectedVitalIndex]["current_value"]}",
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Color(vitalSigns[selectedVitalIndex]["color"] as int),
                                ),
                              ),
                              Text(
                                "${vitalSigns[selectedVitalIndex]["unit"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spMd,
                                  vertical: spSm,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(vitalSigns[selectedVitalIndex]["status"] as String).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${vitalSigns[selectedVitalIndex]["status"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(vitalSigns[selectedVitalIndex]["status"] as String),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: spMd),
                        
                        // Normal Range
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: infoColor.withAlpha(30)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline, size: 16, color: infoColor),
                              SizedBox(width: spXs),
                              Text(
                                "Normal Range: ${vitalSigns[selectedVitalIndex]["normal_range"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: spMd),

                        // Readings Chart (Simple Bar Chart)
                        Text(
                          "Recent Readings",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          height: 120,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: (vitalSigns[selectedVitalIndex]["readings"] as List).map((reading) {
                              double value = 0;
                              if (reading["value"] != null) {
                                value = (reading["value"] as num).toDouble();
                              } else if (reading["systolic"] != null) {
                                value = (reading["systolic"] as num).toDouble();
                              }
                              
                              return Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: (value / 150) * 80, // Normalized height
                                        decoration: BoxDecoration(
                                          color: Color(vitalSigns[selectedVitalIndex]["color"] as int),
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(radiusXs),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${reading["time"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${value.toInt()}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // All Vital Signs List
                  Text(
                    "All Vital Signs",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...vitalSigns.map((vital) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Color(vital["color"] as int).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              vital["icon"] as IconData,
                              size: 24,
                              color: Color(vital["color"] as int),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${vital["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${vital["current_value"]} ${vital["unit"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(vital["color"] as int),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Updated: ${vital["last_updated"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(vital["status"] as String).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${vital["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(vital["status"] as String),
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Icon(
                                _getTrendIcon(vital["trend"] as String),
                                size: 20,
                                color: _getTrendColor(vital["trend"] as String),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  SizedBox(height: spLg),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
