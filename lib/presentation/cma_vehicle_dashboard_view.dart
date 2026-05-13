import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaVehicleDashboardView extends StatefulWidget {
  const CmaVehicleDashboardView({super.key});

  @override
  State<CmaVehicleDashboardView> createState() => _CmaVehicleDashboardViewState();
}

class _CmaVehicleDashboardViewState extends State<CmaVehicleDashboardView> {
  int selectedPeriod = 0;
  
  List<String> periods = ["Today", "This Week", "This Month", "This Year"];
  
  List<Map<String, dynamic>> vehicleStats = [
    {
      "title": "Total Vehicles",
      "count": 145,
      "icon": Icons.directions_car,
      "color": primaryColor,
      "change": "+5.2%",
      "trend": "up"
    },
    {
      "title": "Active Vehicles",
      "count": 127,
      "icon": Icons.check_circle,
      "color": successColor,
      "change": "+2.8%",
      "trend": "up"
    },
    {
      "title": "In Maintenance",
      "count": 12,
      "icon": Icons.build,
      "color": warningColor,
      "change": "-1.5%",
      "trend": "down"
    },
    {
      "title": "Out of Service",
      "count": 6,
      "icon": Icons.warning,
      "color": dangerColor,
      "change": "+0.8%",
      "trend": "up"
    }
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "id": "act_001",
      "type": "Vehicle Added",
      "vehicle": "Honda Civic 2024",
      "description": "New vehicle registered to fleet",
      "timestamp": "2025-06-19T10:30:00Z",
      "user": "John Doe",
      "status": "completed"
    },
    {
      "id": "act_002",
      "type": "Maintenance Scheduled",
      "vehicle": "Toyota Camry 2023",
      "description": "Regular maintenance scheduled for next week",
      "timestamp": "2025-06-19T09:15:00Z",
      "user": "Jane Smith",
      "status": "pending"
    },
    {
      "id": "act_003",
      "type": "Insurance Updated",
      "vehicle": "Ford Focus 2022",
      "description": "Insurance policy renewed for 1 year",
      "timestamp": "2025-06-19T08:45:00Z",
      "user": "Bob Johnson",
      "status": "completed"
    },
    {
      "id": "act_004",
      "type": "Vehicle Inspection",
      "vehicle": "BMW X5 2023",
      "description": "Annual safety inspection completed",
      "timestamp": "2025-06-18T16:20:00Z",
      "user": "Alice Brown",
      "status": "completed"
    }
  ];

  List<Map<String, dynamic>> upcomingMaintenance = [
    {
      "id": "maint_001",
      "vehicle": "Honda Accord 2023",
      "type": "Oil Change",
      "dueDate": "2025-06-25",
      "mileage": 45000,
      "priority": "Medium",
      "estimatedCost": 150
    },
    {
      "id": "maint_002",
      "vehicle": "Toyota Prius 2022",
      "type": "Brake Inspection",
      "dueDate": "2025-06-22",
      "mileage": 38000,
      "priority": "High",
      "estimatedCost": 300
    },
    {
      "id": "maint_003",
      "vehicle": "Nissan Altima 2023",
      "type": "Tire Rotation",
      "dueDate": "2025-06-28",
      "mileage": 25000,
      "priority": "Low",
      "estimatedCost": 80
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('CmaAddVehicleView')
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Dashboard refreshed");
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
            // Period Selector
            QCategoryPicker(
              label: "Period",
              items: periods.asMap().entries.map((entry) {
                return {
                  "label": entry.value,
                  "value": entry.key.toString(),
                };
              }).toList(),
              value: selectedPeriod.toString(),
              onChanged: (index, label, value, item) {
                selectedPeriod = index;
                setState(() {});
              },
            ),

            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: vehicleStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spMd),
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
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"],
                              color: stat["color"],
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (stat["trend"] as String) == "up" 
                                  ? successColor.withAlpha(20) 
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 2,
                              children: [
                                Icon(
                                  (stat["trend"] as String) == "up" 
                                      ? Icons.trending_up 
                                      : Icons.trending_down,
                                  color: (stat["trend"] as String) == "up" 
                                      ? successColor 
                                      : dangerColor,
                                  size: 12,
                                ),
                                Text(
                                  "${stat["change"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: (stat["trend"] as String) == "up" 
                                        ? successColor 
                                        : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${stat["count"]}",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Quick Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Add Vehicle",
                          icon: Icons.add_circle,
                          onPressed: () {
                            // navigateTo('CmaAddVehicleView')
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "View All Vehicles",
                          icon: Icons.list,
                          onPressed: () {
                            // navigateTo('CmaVehicleListView')
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Schedule Maintenance",
                          icon: Icons.schedule,
                          onPressed: () {
                            ss("Maintenance scheduling opened");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Generate Report",
                          icon: Icons.assessment,
                          onPressed: () {
                            ss("Report generation started");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Recent Activities
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Text(
                        "Recent Activities",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          ss("All activities opened");
                        },
                      ),
                    ],
                  ),
                  ...recentActivities.map((activity) {
                    Color statusColor = (activity["status"] as String) == "completed" 
                        ? successColor 
                        : warningColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: statusColor,
                          ),
                        ),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${activity["type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${activity["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${activity["vehicle"]}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${activity["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "By: ${activity["user"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${DateTime.parse(activity["timestamp"] as String).dMMMykkss}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledColor,
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

            // Upcoming Maintenance
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Text(
                        "Upcoming Maintenance",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Schedule New",
                        size: bs.sm,
                        onPressed: () {
                          ss("New maintenance scheduling opened");
                        },
                      ),
                    ],
                  ),
                  ...upcomingMaintenance.map((maintenance) {
                    Color priorityColor;
                    switch (maintenance["priority"]) {
                      case "High":
                        priorityColor = dangerColor;
                        break;
                      case "Medium":
                        priorityColor = warningColor;
                        break;
                      default:
                        priorityColor = successColor;
                    }
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: priorityColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.build,
                              color: priorityColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              spacing: spXs,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${maintenance["vehicle"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: priorityColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${maintenance["priority"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${maintenance["type"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Due: ${DateTime.parse(maintenance["dueDate"] as String).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "Cost: \$${(maintenance["estimatedCost"] as int)}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.schedule,
                            size: bs.sm,
                            onPressed: () {
                              ss("Maintenance scheduled for ${maintenance["vehicle"]}");
                            },
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
    );
  }
}
