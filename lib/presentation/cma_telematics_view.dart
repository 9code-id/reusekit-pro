import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaTelematicsView extends StatefulWidget {
  const CmaTelematicsView({super.key});

  @override
  State<CmaTelematicsView> createState() => _CmaTelematicsViewState();
}

class _CmaTelematicsViewState extends State<CmaTelematicsView> {
  String selectedVehicle = "VH001";
  String selectedPeriod = "week";
  
  List<Map<String, dynamic>> vehicles = [
    {
      "id": "VH001",
      "label": "Honda Civic - ABC123",
      "value": "VH001",
    },
    {
      "id": "VH002", 
      "label": "Toyota Camry - XYZ789",
      "value": "VH002",
    },
    {
      "id": "VH003",
      "label": "BMW X5 - DEF456", 
      "value": "VH003",
    }
  ];

  List<Map<String, dynamic>> periods = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> telematicsData = [
    {
      "metric": "Total Distance",
      "value": "1,245",
      "unit": "miles",
      "change": 12.5,
      "trend": "up",
      "icon": Icons.straighten
    },
    {
      "metric": "Average Speed",
      "value": "35.2",
      "unit": "mph",
      "change": -2.1,
      "trend": "down",
      "icon": Icons.speed
    },
    {
      "metric": "Fuel Efficiency",
      "value": "28.5",
      "unit": "mpg",
      "change": 4.2,
      "trend": "up",
      "icon": Icons.local_gas_station
    },
    {
      "metric": "Drive Time",
      "value": "42.3",
      "unit": "hours",
      "change": 8.7,
      "trend": "up",
      "icon": Icons.timer
    },
    {
      "metric": "Idle Time",
      "value": "5.2",
      "unit": "hours",
      "change": -15.3,
      "trend": "down",
      "icon": Icons.pause_circle
    },
    {
      "metric": "Hard Braking",
      "value": "12",
      "unit": "events",
      "change": -25.0,
      "trend": "down",
      "icon": Icons.warning
    }
  ];

  List<Map<String, dynamic>> drivingBehavior = [
    {
      "behavior": "Smooth Acceleration",
      "score": 85,
      "description": "Good acceleration patterns",
      "status": "Good"
    },
    {
      "behavior": "Safe Cornering",
      "score": 78,
      "description": "Moderate cornering forces",
      "status": "Average"
    },
    {
      "behavior": "Speed Compliance",
      "score": 92,
      "description": "Excellent speed management",
      "status": "Excellent"
    },
    {
      "behavior": "Eco Driving",
      "score": 74,
      "description": "Room for fuel efficiency improvement",
      "status": "Average"
    }
  ];

  List<Map<String, dynamic>> tripHistory = [
    {
      "date": "2024-06-19",
      "time": "14:30 - 15:15",
      "from": "Home",
      "to": "Office",
      "distance": "15.2 miles",
      "duration": "45 min",
      "avgSpeed": "20.3 mph",
      "fuelUsed": "0.8 gal",
      "score": 88
    },
    {
      "date": "2024-06-19",
      "time": "08:00 - 08:35",
      "from": "Office",
      "to": "Client Meeting",
      "distance": "8.7 miles",
      "duration": "35 min",
      "avgSpeed": "14.9 mph",
      "fuelUsed": "0.5 gal",
      "score": 75
    },
    {
      "date": "2024-06-18",
      "time": "17:20 - 18:05",
      "from": "Shopping Mall",
      "to": "Home",
      "distance": "12.1 miles",
      "duration": "45 min",
      "avgSpeed": "16.1 mph",
      "fuelUsed": "0.7 gal",
      "score": 92
    },
    {
      "date": "2024-06-18",
      "time": "12:00 - 12:45",
      "from": "Home",
      "to": "Shopping Mall",
      "distance": "12.1 miles",
      "duration": "45 min",
      "avgSpeed": "16.1 mph",
      "fuelUsed": "0.6 gal",
      "score": 84
    }
  ];

  List<Map<String, dynamic>> maintenanceAlerts = [
    {
      "type": "Oil Change",
      "dueIn": "1,200 miles",
      "severity": "Medium",
      "nextDate": "2024-07-15"
    },
    {
      "type": "Tire Rotation",
      "dueIn": "3,500 miles",
      "severity": "Low",
      "nextDate": "2024-08-20"
    },
    {
      "type": "Brake Inspection",
      "dueIn": "800 miles",
      "severity": "High",
      "nextDate": "2024-07-01"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Telematics"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Vehicle & Period Selection
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
                      Icon(Icons.analytics, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Telematics Overview",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Select Vehicle",
                          items: vehicles,
                          value: selectedVehicle,
                          onChanged: (value, label) {
                            selectedVehicle = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Time Period",
                          items: periods,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Key Metrics Grid
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
                      Icon(Icons.dashboard, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Key Metrics",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: telematicsData.map((data) {
                      Color trendColor = successColor;
                      IconData trendIcon = Icons.trending_up;
                      
                      if (data["trend"] == "down") {
                        trendColor = data["metric"].contains("Hard Braking") || data["metric"].contains("Idle") 
                            ? successColor : dangerColor;
                        trendIcon = Icons.trending_down;
                      }
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: trendColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: trendColor.withAlpha(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  data["icon"] as IconData,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      trendIcon,
                                      color: trendColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${(data["change"] as num) > 0 ? '+' : ''}${(data["change"] as num).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        color: trendColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${data["value"]} ${data["unit"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${data["metric"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Driving Behavior Analysis
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
                    children: [
                      Icon(Icons.psychology, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Driving Behavior Analysis",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...drivingBehavior.map((behavior) {
                    Color scoreColor = successColor;
                    if ((behavior["score"] as int) < 80) scoreColor = warningColor;
                    if ((behavior["score"] as int) < 60) scoreColor = dangerColor;
                    
                    String statusText = behavior["status"];
                    Color statusColor = scoreColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: scoreColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: scoreColor.withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${behavior["behavior"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  statusText,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: disabledColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: (behavior["score"] as int) / 100,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: scoreColor,
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${behavior["score"]}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: scoreColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${behavior["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Trip History
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
                    children: [
                      Icon(Icons.history, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Recent Trips",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...tripHistory.take(3).map((trip) {
                    Color scoreColor = successColor;
                    if ((trip["score"] as int) < 80) scoreColor = warningColor;
                    if ((trip["score"] as int) < 60) scoreColor = dangerColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: scoreColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: scoreColor.withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${trip["from"]} → ${trip["to"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: scoreColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Score: ${trip["score"]}%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${trip["date"]} • ${trip["time"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Distance",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      "${trip["distance"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                        fontSize: 12,
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
                                      "Duration",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      "${trip["duration"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                        fontSize: 12,
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
                                      "Avg Speed",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      "${trip["avgSpeed"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                        fontSize: 12,
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
                                      "Fuel",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      "${trip["fuelUsed"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
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

            // Maintenance Alerts
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
                    children: [
                      Icon(Icons.build, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Maintenance Alerts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...maintenanceAlerts.map((alert) {
                    Color severityColor = successColor;
                    if (alert["severity"] == "Medium") severityColor = warningColor;
                    if (alert["severity"] == "High") severityColor = dangerColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: severityColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: severityColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: severityColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${alert["type"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: severityColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${alert["severity"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Due in: ${alert["dueIn"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "Next: ${alert["nextDate"]}",
                                      style: TextStyle(
                                        color: severityColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
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

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "View Details",
                    icon: Icons.analytics,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
