import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaBrakeInspectionView extends StatefulWidget {
  const CmaBrakeInspectionView({super.key});

  @override
  State<CmaBrakeInspectionView> createState() => _CmaBrakeInspectionViewState();
}

class _CmaBrakeInspectionViewState extends State<CmaBrakeInspectionView> {
  Map<String, dynamic> brakeStatus = {
    "front_pads": {
      "thickness": 8.5,
      "minimum_thickness": 3.0,
      "condition": "Good",
      "wear_percentage": 75,
      "last_replaced": "2023-08-15",
      "brand": "Brembo",
      "type": "Ceramic",
    },
    "rear_pads": {
      "thickness": 6.2,
      "minimum_thickness": 3.0,
      "condition": "Needs Attention",
      "wear_percentage": 45,
      "last_replaced": "2023-08-15",
      "brand": "Brembo",
      "type": "Ceramic",
    },
    "front_rotors": {
      "thickness": 28.5,
      "minimum_thickness": 26.0,
      "condition": "Good",
      "surface_condition": "Smooth",
      "last_replaced": "2022-05-20",
    },
    "rear_rotors": {
      "thickness": 18.2,
      "minimum_thickness": 16.0,
      "condition": "Good",
      "surface_condition": "Minor scoring",
      "last_replaced": "2022-05-20",
    },
    "brake_fluid": {
      "level": "Full",
      "color": "Light Amber",
      "condition": "Good",
      "last_changed": "2024-03-10",
      "type": "DOT 3",
      "moisture_content": 2.1,
    },
  };

  List<Map<String, dynamic>> inspectionHistory = [
    {
      "id": 1,
      "date": "2024-06-15",
      "mileage": 82000,
      "inspector": "Mike Johnson",
      "shop": "AutoCare Center",
      "cost": 125.50,
      "findings": {
        "front_pads": "Good - 8mm thickness",
        "rear_pads": "Needs attention - 6mm thickness",
        "front_rotors": "Good condition",
        "rear_rotors": "Minor scoring present",
        "brake_fluid": "Good condition, 2.1% moisture",
      },
      "recommendations": [
        "Replace rear brake pads within 5,000 miles",
        "Monitor brake fluid moisture content",
        "Resurface rear rotors if noise develops",
      ],
      "next_inspection": "2024-12-15",
    },
    {
      "id": 2,
      "date": "2023-12-10",
      "mileage": 78500,
      "inspector": "Sarah Wilson",
      "shop": "Brake Specialists",
      "cost": 95.00,
      "findings": {
        "front_pads": "Good - 10mm thickness",
        "rear_pads": "Good - 8mm thickness",
        "front_rotors": "Excellent condition",
        "rear_rotors": "Good condition",
        "brake_fluid": "Good condition",
      },
      "recommendations": [
        "Continue regular inspections",
        "Replace brake fluid next year",
      ],
      "next_inspection": "2024-06-10",
    },
  ];

  List<Map<String, dynamic>> maintenanceSchedule = [
    {
      "component": "Rear Brake Pads",
      "current_condition": "Needs Attention",
      "recommended_mileage": 85000,
      "current_mileage": 82000,
      "miles_remaining": 3000,
      "priority": "High",
      "estimated_cost": 180.00,
    },
    {
      "component": "Brake Fluid Flush",
      "current_condition": "Good",
      "recommended_mileage": 90000,
      "current_mileage": 82000,
      "miles_remaining": 8000,
      "priority": "Medium",
      "estimated_cost": 95.00,
    },
    {
      "component": "Front Brake Pads",
      "current_condition": "Good",
      "recommended_mileage": 95000,
      "current_mileage": 82000,
      "miles_remaining": 13000,
      "priority": "Low",
      "estimated_cost": 220.00,
    },
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Brake Inspection",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Status", icon: Icon(Icons.disc_full)),
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
          _buildOverallStatus(),
          _buildBrakePadsStatus(),
          _buildBrakeRotorsStatus(),
          _buildBrakeFluidStatus(),
        ],
      ),
    );
  }

  Widget _buildOverallStatus() {
    List<String> alerts = [];
    int goodComponents = 0;
    int totalComponents = 0;

    brakeStatus.forEach((component, data) {
      totalComponents++;
      if (data["condition"] == "Good") {
        goodComponents++;
      } else {
        alerts.add("${_getComponentDisplayName(component)} ${data["condition"]}");
      }
    });

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: alerts.isEmpty ? successColor : warningColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.disc_full,
                color: primaryColor,
                size: 28,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Brake System Status",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: alerts.isEmpty ? successColor : warningColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  alerts.isEmpty ? "ALL GOOD" : "NEEDS ATTENTION",
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
                  children: [
                    Text(
                      "$goodComponents",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Components Good",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${alerts.length}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: alerts.isEmpty ? successColor : warningColor,
                      ),
                    ),
                    Text(
                      "Need Attention",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "3",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Months Since Last",
                      textAlign: TextAlign.center,
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
          
          if (alerts.isNotEmpty) ...[
            SizedBox(height: spSm),
            ...alerts.map((alert) => Container(
              margin: EdgeInsets.only(bottom: spXs),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: warningColor,
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
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Schedule Inspection",
                  size: bs.sm,
                  onPressed: () {
                    _scheduleInspection();
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Find Shop",
                size: bs.sm,
                onPressed: () {
                  _findBrakeShops();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBrakePadsStatus() {
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
            "Brake Pads",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          _buildBrakeComponent(
            "Front Pads",
            brakeStatus["front_pads"],
            Icons.crop_square,
          ),
          
          SizedBox(height: spSm),
          
          _buildBrakeComponent(
            "Rear Pads",
            brakeStatus["rear_pads"],
            Icons.crop_square,
          ),
        ],
      ),
    );
  }

  Widget _buildBrakeRotorsStatus() {
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
            "Brake Rotors",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          _buildRotorComponent(
            "Front Rotors",
            brakeStatus["front_rotors"],
          ),
          
          SizedBox(height: spSm),
          
          _buildRotorComponent(
            "Rear Rotors",
            brakeStatus["rear_rotors"],
          ),
        ],
      ),
    );
  }

  Widget _buildBrakeFluidStatus() {
    Map<String, dynamic> fluid = brakeStatus["brake_fluid"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getBrakeComponentColor(fluid["condition"]),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.water_drop,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Brake Fluid",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getBrakeComponentColor(fluid["condition"]),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${fluid["condition"]}",
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
                      "Level",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${fluid["level"]}",
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
                      "Color",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${fluid["color"]}",
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
                      "Type",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${fluid["type"]}",
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
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Moisture Content",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${fluid["moisture_content"]}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: (fluid["moisture_content"] as double) > 3.0 
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
                      "Last Changed",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(fluid["last_changed"]).dMMMy}",
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
              value: (fluid["moisture_content"] as double) / 5.0,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                (fluid["moisture_content"] as double) > 3.0 ? dangerColor :
                (fluid["moisture_content"] as double) > 2.0 ? warningColor : successColor,
              ),
              minHeight: 8,
            ),
          ),
          
          SizedBox(height: spXs),
          
          Text(
            "Replace fluid when moisture content exceeds 3%",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrakeComponent(String title, Map<String, dynamic> component, IconData icon) {
    double wearPercentage = (component["wear_percentage"] as int).toDouble();
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: _getBrakeComponentColor(component["condition"]).withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: _getBrakeComponentColor(component["condition"]),
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${component["condition"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _getBrakeComponentColor(component["condition"]),
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
                      "Thickness",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${component["thickness"]}mm",
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
                      "Wear Level",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${wearPercentage.toInt()}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _getBrakeComponentColor(component["condition"]),
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
                      "Brand",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${component["brand"]}",
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
              value: wearPercentage / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                wearPercentage > 50 ? successColor :
                wearPercentage > 25 ? warningColor : dangerColor,
              ),
              minHeight: 6,
            ),
          ),
          
          SizedBox(height: spXs),
          
          Text(
            "Last replaced: ${DateTime.parse(component["last_replaced"]).dMMMy}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRotorComponent(String title, Map<String, dynamic> component) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: _getBrakeComponentColor(component["condition"]).withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.disc_full,
                color: _getBrakeComponentColor(component["condition"]),
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${component["condition"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _getBrakeComponentColor(component["condition"]),
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
                      "Thickness",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${component["thickness"]}mm",
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
                      "Min Thickness",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${component["minimum_thickness"]}mm",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
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
                      "Surface",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${component["surface_condition"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: component["surface_condition"] == "Smooth" 
                            ? successColor 
                            : warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spXs),
          
          Text(
            "Last replaced: ${DateTime.parse(component["last_replaced"]).dMMMy}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
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

          ...maintenanceSchedule.map((item) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getMaintenancePriorityColor(item["priority"]),
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
                        "${item["component"]}",
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
                        color: _getMaintenancePriorityColor(item["priority"]),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${item["priority"]} Priority",
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
                            "Recommended At",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(item["recommended_mileage"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} mi",
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
                            "${item["miles_remaining"]} mi",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: item["miles_remaining"] < 5000 
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
                            "Est. Cost",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(item["estimated_cost"] as double).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Schedule Now",
                    size: bs.sm,
                    onPressed: () {
                      _scheduleComponentService(item["component"]);
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
            "Brake Inspection History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...inspectionHistory.map((inspection) => Container(
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
                      Icons.assignment,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Inspection - ${DateTime.parse(inspection["date"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                            "Mileage",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(inspection["mileage"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} mi",
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
                            "\$${(inspection["cost"] as double).currency}",
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
                            "Inspector",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${inspection["inspector"]}",
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
                
                Text(
                  "Findings:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...(inspection["findings"] as Map<String, dynamic>).entries.map((entry) => 
                  Padding(
                    padding: EdgeInsets.only(left: spSm, bottom: spXs),
                    child: Text(
                      "• ${_getComponentDisplayName(entry.key)}: ${entry.value}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  )
                ).toList(),
                
                SizedBox(height: spSm),
                
                Text(
                  "Recommendations:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...(inspection["recommendations"] as List).map((rec) => 
                  Padding(
                    padding: EdgeInsets.only(left: spSm, bottom: spXs),
                    child: Text(
                      "• $rec",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  )
                ).toList(),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Color _getBrakeComponentColor(String condition) {
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

  String _getComponentDisplayName(String component) {
    switch (component) {
      case "front_pads":
        return "Front Pads";
      case "rear_pads":
        return "Rear Pads";
      case "front_rotors":
        return "Front Rotors";
      case "rear_rotors":
        return "Rear Rotors";
      case "brake_fluid":
        return "Brake Fluid";
      default:
        return component;
    }
  }

  void _scheduleInspection() {
    si("Schedule brake inspection feature coming soon");
  }

  void _findBrakeShops() {
    si("Find brake service shops feature coming soon");
  }

  void _scheduleService() {
    si("Schedule brake service feature coming soon");
  }

  void _scheduleComponentService(String component) {
    si("Schedule service for $component");
  }
}
