import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaTireMaintenanceView extends StatefulWidget {
  const CmaTireMaintenanceView({super.key});

  @override
  State<CmaTireMaintenanceView> createState() => _CmaTireMaintenanceViewState();
}

class _CmaTireMaintenanceViewState extends State<CmaTireMaintenanceView> {
  Map<String, dynamic> tireStatus = {
    "front_left": {
      "pressure": 32.5,
      "recommended_pressure": 35.0,
      "tread_depth": 6.5,
      "condition": "Good",
      "last_rotation": "2024-05-15",
      "brand": "Michelin",
      "model": "Defender T+H",
      "size": "225/60R16",
    },
    "front_right": {
      "pressure": 34.0,
      "recommended_pressure": 35.0,
      "tread_depth": 6.8,
      "condition": "Good",
      "last_rotation": "2024-05-15",
      "brand": "Michelin",
      "model": "Defender T+H",
      "size": "225/60R16",
    },
    "rear_left": {
      "pressure": 31.0,
      "recommended_pressure": 35.0,
      "tread_depth": 5.2,
      "condition": "Needs Attention",
      "last_rotation": "2024-05-15",
      "brand": "Michelin",
      "model": "Defender T+H",
      "size": "225/60R16",
    },
    "rear_right": {
      "pressure": 33.5,
      "recommended_pressure": 35.0,
      "tread_depth": 5.8,
      "condition": "Good",
      "last_rotation": "2024-05-15",
      "brand": "Michelin",
      "model": "Defender T+H",
      "size": "225/60R16",
    },
  };

  List<Map<String, dynamic>> maintenanceHistory = [
    {
      "id": 1,
      "date": "2024-05-15",
      "type": "Tire Rotation",
      "mileage": 80500,
      "cost": 35.00,
      "shop": "Tire Center Pro",
      "notes": "Rotated all four tires, pressures adjusted",
      "next_due_mileage": 86500,
    },
    {
      "id": 2,
      "date": "2024-02-20",
      "type": "Tire Balancing",
      "mileage": 78200,
      "cost": 60.00,
      "shop": "AutoCare Center",
      "notes": "Balanced all wheels, fixed vibration issue",
      "next_due_mileage": 88200,
    },
    {
      "id": 3,
      "date": "2023-11-10",
      "type": "New Tires",
      "mileage": 75000,
      "cost": 680.00,
      "shop": "Tire Warehouse",
      "notes": "Installed new Michelin Defender T+H tires",
      "next_due_mileage": 105000,
    },
  ];

  List<Map<String, dynamic>> maintenanceSchedule = [
    {
      "type": "Tire Rotation",
      "next_due_mileage": 86500,
      "current_mileage": 84250,
      "miles_remaining": 2250,
      "interval": 6000,
      "priority": "Medium",
    },
    {
      "type": "Tire Balancing",
      "next_due_mileage": 88200,
      "current_mileage": 84250,
      "miles_remaining": 3950,
      "interval": 10000,
      "priority": "Low",
    },
    {
      "type": "Wheel Alignment",
      "next_due_mileage": 89000,
      "current_mileage": 84250,
      "miles_remaining": 4750,
      "interval": 12000,
      "priority": "Medium",
    },
  ];

  int selectedTab = 0;
  String selectedTire = "front_left";

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Tire Maintenance",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Status", icon: Icon(Icons.tire_repair)),
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildStatusTab(),
        _buildScheduleTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildStatusTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTireOverview(),
          _buildTireDetails(),
          _buildTirePressureMonitor(),
          _buildMaintenanceAlerts(),
        ],
      ),
    );
  }

  Widget _buildTireOverview() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Text(
            "Tire Status Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 200,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vehicle Top View",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Front Left Tire
              Positioned(
                top: 10,
                left: 20,
                child: _buildTireIndicator("front_left", "FL"),
              ),
              // Front Right Tire
              Positioned(
                top: 10,
                right: 20,
                child: _buildTireIndicator("front_right", "FR"),
              ),
              // Rear Left Tire
              Positioned(
                bottom: 10,
                left: 20,
                child: _buildTireIndicator("rear_left", "RL"),
              ),
              // Rear Right Tire
              Positioned(
                bottom: 10,
                right: 20,
                child: _buildTireIndicator("rear_right", "RR"),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          QCategoryPicker(
            items: [
              {"label": "Front Left", "value": "front_left"},
              {"label": "Front Right", "value": "front_right"},
              {"label": "Rear Left", "value": "rear_left"},
              {"label": "Rear Right", "value": "rear_right"},
            ],
            value: selectedTire,
            onChanged: (index, label, value, item) {
              selectedTire = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTireIndicator(String position, String label) {
    Map<String, dynamic> tire = tireStatus[position];
    Color statusColor = _getTireStatusColor(tire["condition"]);
    
    return GestureDetector(
      onTap: () {
        selectedTire = position;
        setState(() {});
      },
      child: Container(
        width: 40,
        height: 25,
        decoration: BoxDecoration(
          color: selectedTire == position ? primaryColor : statusColor,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: selectedTire == position ? primaryColor : statusColor,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTireDetails() {
    Map<String, dynamic> tire = tireStatus[selectedTire];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getTireStatusColor(tire["condition"]),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${_getTirePositionName(selectedTire)} Tire",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getTireStatusColor(tire["condition"]),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${tire["condition"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          Text(
            "${tire["brand"]} ${tire["model"]} - ${tire["size"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: _buildTireMetric(
                  "Pressure",
                  "${tire["pressure"]} PSI",
                  "Recommended: ${tire["recommended_pressure"]} PSI",
                  Icons.speed,
                  (tire["pressure"] as double) < (tire["recommended_pressure"] as double) - 2 
                      ? warningColor 
                      : successColor,
                ),
              ),
              Expanded(
                child: _buildTireMetric(
                  "Tread Depth",
                  "${tire["tread_depth"]}/32\"",
                  "Replace at 2/32\"",
                  Icons.straighten,
                  (tire["tread_depth"] as double) > 4 
                      ? successColor 
                      : (tire["tread_depth"] as double) > 2 
                          ? warningColor 
                          : dangerColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "Last Rotation: ${DateTime.parse(tire["last_rotation"]).dMMMy}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Update Pressure",
                  size: bs.sm,
                  onPressed: () {
                    _updateTirePressure(selectedTire);
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Check Tread",
                size: bs.sm,
                onPressed: () {
                  _checkTreadDepth(selectedTire);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTireMetric(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
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
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTirePressureMonitor() {
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
          Text(
            "Tire Pressure Monitor",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ...tireStatus.entries.map((entry) {
            String position = entry.key;
            Map<String, dynamic> tire = entry.value;
            double pressure = tire["pressure"];
            double recommended = tire["recommended_pressure"];
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    child: Text(
                      _getTirePositionName(position),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: LinearProgressIndicator(
                        value: pressure / (recommended * 1.2),
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          pressure < (recommended - 2) ? dangerColor :
                          pressure < (recommended - 1) ? warningColor : successColor,
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Container(
                    width: 80,
                    child: Text(
                      "${pressure.toStringAsFixed(1)} PSI",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: pressure < (recommended - 2) ? dangerColor :
                               pressure < (recommended - 1) ? warningColor : successColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          
          SizedBox(height: spSm),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Check All Pressures",
              icon: Icons.speed,
              size: bs.sm,
              onPressed: () {
                _checkAllPressures();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceAlerts() {
    List<String> alerts = [];
    
    tireStatus.forEach((position, tire) {
      if ((tire["pressure"] as double) < (tire["recommended_pressure"] as double) - 2) {
        alerts.add("${_getTirePositionName(position)} tire pressure is low");
      }
      if ((tire["tread_depth"] as double) < 3) {
        alerts.add("${_getTirePositionName(position)} tire tread is wearing thin");
      }
    });
    
    if (alerts.isEmpty) {
      alerts.add("All tires are in good condition");
    }
    
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
              Icon(
                alerts.length == 1 && alerts[0].contains("good condition") 
                    ? Icons.check_circle 
                    : Icons.warning,
                color: alerts.length == 1 && alerts[0].contains("good condition") 
                    ? successColor 
                    : warningColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Maintenance Alerts",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          ...alerts.map((alert) => Container(
            margin: EdgeInsets.only(bottom: spXs),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: alert.contains("good condition") 
                  ? successColor.withAlpha(25) 
                  : warningColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  alert.contains("good condition") 
                      ? Icons.check_circle 
                      : Icons.warning,
                  color: alert.contains("good condition") 
                      ? successColor 
                      : warningColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    alert,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Maintenance Schedule",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Schedule Service",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  _scheduleService();
                },
              ),
            ],
          ),

          ...maintenanceSchedule.map((service) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getMaintenancePriorityColor(service["priority"]),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${service["type"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getMaintenancePriorityColor(service["priority"]),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${service["priority"]} Priority",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
                            "Next Due",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(service["next_due_mileage"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} mi",
                            style: TextStyle(
                              fontSize: 16,
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
                            "Miles Remaining",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${service["miles_remaining"]} mi",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: service["miles_remaining"] < 1000 
                                  ? warningColor 
                                  : successColor,
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
                            "Interval",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(service["interval"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} mi",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: LinearProgressIndicator(
                    value: ((service["interval"] as int) - (service["miles_remaining"] as int)) / (service["interval"] as int),
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      service["miles_remaining"] < 1000 ? warningColor : primaryColor,
                    ),
                    minHeight: 6,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Schedule Now",
                    size: bs.sm,
                    onPressed: () {
                      _scheduleSpecificService(service["type"]);
                    },
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Tire Maintenance History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...maintenanceHistory.map((record) => Container(
            margin: EdgeInsets.only(bottom: spSm),
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
                    Icon(
                      _getMaintenanceTypeIcon(record["type"]),
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${record["type"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${DateTime.parse(record["date"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
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
                            "Mileage",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(record["mileage"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} mi",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
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
                            "Cost",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(record["cost"] as double).currency}",
                            style: TextStyle(
                              fontSize: 16,
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
                            "Next Due",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(record["next_due_mileage"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} mi",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(
                      Icons.store,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${record["shop"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                Text(
                  "${record["notes"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Color _getTireStatusColor(String condition) {
    switch (condition) {
      case "Good":
        return successColor;
      case "Needs Attention":
        return warningColor;
      case "Replace Soon":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getMaintenancePriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getMaintenanceTypeIcon(String type) {
    switch (type) {
      case "Tire Rotation":
        return Icons.rotate_right;
      case "Tire Balancing":
        return Icons.balance;
      case "New Tires":
        return Icons.tire_repair;
      case "Wheel Alignment":
        return Icons.straighten;
      default:
        return Icons.build;
    }
  }

  String _getTirePositionName(String position) {
    switch (position) {
      case "front_left":
        return "Front Left";
      case "front_right":
        return "Front Right";
      case "rear_left":
        return "Rear Left";
      case "rear_right":
        return "Rear Right";
      default:
        return position;
    }
  }

  void _updateTirePressure(String position) {
    si("Update tire pressure for ${_getTirePositionName(position)}");
  }

  void _checkTreadDepth(String position) {
    si("Check tread depth for ${_getTirePositionName(position)}");
  }

  void _checkAllPressures() {
    si("Checking all tire pressures...");
  }

  void _scheduleService() {
    si("Schedule tire maintenance service");
  }

  void _scheduleSpecificService(String serviceType) {
    si("Schedule $serviceType service");
  }
}
