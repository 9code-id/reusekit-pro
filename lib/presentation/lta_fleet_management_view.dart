import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaFleetManagementView extends StatefulWidget {
  const LtaFleetManagementView({super.key});

  @override
  State<LtaFleetManagementView> createState() => _LtaFleetManagementViewState();
}

class _LtaFleetManagementViewState extends State<LtaFleetManagementView> {
  int currentTab = 0;

  List<Map<String, dynamic>> fleetOverview = [
    {
      "title": "Total Vehicles",
      "value": 42,
      "change": "+5",
      "percentage": 13.5,
      "icon": Icons.directions_car,
      "color": primaryColor,
    },
    {
      "title": "Active Vehicles",
      "value": 38,
      "change": "+2",
      "percentage": 5.6,
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "In Maintenance",
      "value": 4,
      "change": "+3",
      "percentage": 300.0,
      "icon": Icons.build,
      "color": warningColor,
    },
    {
      "title": "Out of Service",
      "value": 0,
      "change": "-2",
      "percentage": -100.0,
      "icon": Icons.cancel,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> vehicles = [
    {
      "id": "VH001",
      "type": "Truck",
      "model": "Ford Transit",
      "year": 2020,
      "plate": "B 1234 ABC",
      "status": "active",
      "driver": "John Smith",
      "lastMaintenance": "2024-05-15",
      "nextMaintenance": "2024-07-15",
      "mileage": 15420,
      "fuelEfficiency": 12.5,
      "monthlyDistance": 2800,
      "maintenanceCost": 1500000,
    },
    {
      "id": "VH002",
      "type": "Van", 
      "model": "Toyota Hiace",
      "year": 2019,
      "plate": "B 5678 DEF",
      "status": "maintenance",
      "driver": "Mike Johnson",
      "lastMaintenance": "2024-06-01",
      "nextMaintenance": "2024-08-01",
      "mileage": 22150,
      "fuelEfficiency": 10.8,
      "monthlyDistance": 3200,
      "maintenanceCost": 2200000,
    },
    {
      "id": "VH003",
      "type": "Motorcycle",
      "model": "Honda Beat",
      "year": 2021,
      "plate": "B 9012 GHI", 
      "status": "active",
      "driver": "Sarah Wilson",
      "lastMaintenance": "2024-05-20",
      "nextMaintenance": "2024-07-20",
      "mileage": 8750,
      "fuelEfficiency": 45.2,
      "monthlyDistance": 1500,
      "maintenanceCost": 500000,
    },
  ];

  List<Map<String, dynamic>> maintenanceSchedule = [
    {
      "vehicleId": "VH002",
      "type": "Scheduled Maintenance",
      "date": "2024-06-20",
      "description": "Oil change, brake inspection",
      "estimatedCost": 800000,
      "status": "pending",
      "workshop": "Auto Service Center",
    },
    {
      "vehicleId": "VH001",
      "type": "Preventive Maintenance",
      "date": "2024-06-25",
      "description": "Tire rotation, battery check",
      "estimatedCost": 600000,
      "status": "scheduled",
      "workshop": "Fleet Maintenance",
    },
    {
      "vehicleId": "VH003",
      "type": "Repair",
      "date": "2024-06-22",
      "description": "Brake pad replacement",
      "estimatedCost": 400000,
      "status": "in_progress",
      "workshop": "Quick Fix Garage",
    },
  ];

  List<Map<String, dynamic>> fuelConsumption = [
    {
      "month": "Jan",
      "consumption": 2400,
      "cost": 36000000,
    },
    {
      "month": "Feb", 
      "consumption": 2200,
      "cost": 33000000,
    },
    {
      "month": "Mar",
      "consumption": 2600,
      "cost": 39000000,
    },
    {
      "month": "Apr",
      "consumption": 2500,
      "cost": 37500000,
    },
    {
      "month": "May",
      "consumption": 2700,
      "cost": 40500000,
    },
    {
      "month": "Jun",
      "consumption": 2300,
      "cost": 34500000,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "maintenance":
        return warningColor;
      case "out_of_service":
        return dangerColor;
      case "pending":
        return infoColor;
      case "scheduled":
        return primaryColor;
      case "in_progress":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Fleet Statistics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: fleetOverview.map((stat) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
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
                            color: (stat["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            stat["icon"] as IconData,
                            color: stat["color"] as Color,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(
                              (stat["percentage"] as double) >= 0 
                                ? Icons.trending_up 
                                : Icons.trending_down,
                              size: 16,
                              color: (stat["percentage"] as double) >= 0 
                                ? successColor 
                                : dangerColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${(stat["percentage"] as double).abs().toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: (stat["percentage"] as double) >= 0 
                                  ? successColor 
                                  : dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${stat["value"]}",
                      style: TextStyle(
                        fontSize: fsH3,
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
                    Text(
                      "${stat["change"]} this month",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spSm),
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
                SizedBox(height: spSm),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildQuickActionCard(
                      "Add Vehicle",
                      Icons.add_circle,
                      primaryColor,
                      () {},
                    ),
                    _buildQuickActionCard(
                      "Schedule Maintenance",
                      Icons.schedule,
                      warningColor,
                      () {},
                    ),
                    _buildQuickActionCard(
                      "Generate Report",
                      Icons.bar_chart,
                      infoColor,
                      () {},
                    ),
                    _buildQuickActionCard(
                      "Track Location",
                      Icons.location_on,
                      successColor,
                      () {},
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Recent Activities
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
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
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Column(
                  children: [
                    _buildActivityItem(
                      "VH001 completed delivery to Jakarta Utara",
                      "2 minutes ago",
                      Icons.check_circle,
                      successColor,
                    ),
                    _buildActivityItem(
                      "VH002 entered maintenance schedule",
                      "15 minutes ago",
                      Icons.build,
                      warningColor,
                    ),
                    _buildActivityItem(
                      "New driver Sarah Wilson assigned to VH003",
                      "1 hour ago",
                      Icons.person_add,
                      infoColor,
                    ),
                    _buildActivityItem(
                      "Fuel consumption report generated",
                      "3 hours ago",
                      Icons.local_gas_station,
                      primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehiclesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Fleet Vehicles",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Vehicle",
                size: bs.sm,
                icon: Icons.add,
                onPressed: () {},
              ),
            ],
          ),
          ...vehicles.map((vehicle) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor(vehicle["status"]),
                  ),
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          vehicle["type"] == "Truck" ? Icons.local_shipping :
                          vehicle["type"] == "Van" ? Icons.airport_shuttle :
                          Icons.motorcycle,
                          color: primaryColor,
                          size: 24,
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
                                  "${vehicle["id"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
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
                                    color: _getStatusColor(vehicle["status"]),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${vehicle["status"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${vehicle["model"]} (${vehicle["year"]}) - ${vehicle["plate"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Driver: ${vehicle["driver"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildVehicleInfoCard(
                        "Mileage",
                        "${((vehicle["mileage"] as int) / 1000).toStringAsFixed(1)}K km",
                        Icons.speed,
                      ),
                      _buildVehicleInfoCard(
                        "Fuel Efficiency",
                        "${vehicle["fuelEfficiency"]} km/l",
                        Icons.local_gas_station,
                      ),
                      _buildVehicleInfoCard(
                        "Monthly Distance",
                        "${((vehicle["monthlyDistance"] as int) / 1000).toStringAsFixed(1)}K km",
                        Icons.route,
                      ),
                      _buildVehicleInfoCard(
                        "Maintenance Cost",
                        "\$${((vehicle["maintenanceCost"] as int) / 1000000).toStringAsFixed(1)}M",
                        Icons.build,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMaintenanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Maintenance Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Schedule",
                size: bs.sm,
                icon: Icons.add,
                onPressed: () {},
              ),
            ],
          ),
          ...maintenanceSchedule.map((maintenance) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor(maintenance["status"]),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: _getStatusColor(maintenance["status"]).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.build,
                          color: _getStatusColor(maintenance["status"]),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${maintenance["vehicleId"]} - ${maintenance["type"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${maintenance["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(maintenance["status"]),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${maintenance["status"]}".toUpperCase().replaceAll("_", " "),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${maintenance["date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "\$${((maintenance["estimatedCost"] as int) / 1000).toStringAsFixed(0)}K",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${maintenance["workshop"]}",
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
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: color.withAlpha(50),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            SizedBox(height: spXs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String time, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              icon,
              color: color,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleInfoCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: disabledBoldColor,
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Fleet Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Vehicles", icon: Icon(Icons.directions_car)),
        Tab(text: "Maintenance", icon: Icon(Icons.build)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildVehiclesTab(),
        _buildMaintenanceTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}
