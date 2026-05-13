import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaApplicationTrackerView extends StatefulWidget {
  const AmaApplicationTrackerView({super.key});

  @override
  State<AmaApplicationTrackerView> createState() => _AmaApplicationTrackerViewState();
}

class _AmaApplicationTrackerViewState extends State<AmaApplicationTrackerView> {
  String selectedField = "";
  String selectedStatus = "all";
  String selectedPeriod = "this_month";
  int currentTab = 0;
  
  List<Map<String, dynamic>> fieldOptions = [
    {"label": "All Fields", "value": "all"},
    {"label": "Field A - North Plot", "value": "field_a"},
    {"label": "Field B - South Plot", "value": "field_b"},
    {"label": "Field C - East Plot", "value": "field_c"},
    {"label": "Field D - West Plot", "value": "field_d"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Planned", "value": "planned"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Delayed", "value": "delayed"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "this_week"},
    {"label": "This Month", "value": "this_month"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "This Year", "value": "this_year"},
    {"label": "All Time", "value": "all_time"},
  ];

  List<Map<String, dynamic>> applications = [
    {
      "id": "APP001",
      "field": "Field A - North Plot",
      "crop": "Rice",
      "fertilizer": "NPK 16-16-16",
      "plannedDate": "2025-06-15",
      "actualDate": "2025-06-15",
      "plannedAmount": 50.0,
      "actualAmount": 48.0,
      "unit": "kg/ha",
      "status": "Completed",
      "weather": "Sunny",
      "soilMoisture": "Adequate",
      "applicationMethod": "Broadcasting",
      "operator": "John Smith",
      "equipment": "Spreader A",
      "cost": 1200.0,
      "notes": "Applied during morning hours, even distribution achieved",
      "effectiveness": 95,
      "growthStage": "Vegetative",
      "nextApplication": "2025-06-29",
      "photos": ["photo1.jpg", "photo2.jpg"]
    },
    {
      "id": "APP002",
      "field": "Field B - South Plot",
      "crop": "Wheat",
      "fertilizer": "Urea",
      "plannedDate": "2025-06-16",
      "actualDate": "",
      "plannedAmount": 40.0,
      "actualAmount": 0.0,
      "unit": "kg/ha",
      "status": "In Progress",
      "weather": "Partly Cloudy",
      "soilMoisture": "Good",
      "applicationMethod": "Side Dressing",
      "operator": "Sarah Johnson",
      "equipment": "Manual Spreader",
      "cost": 800.0,
      "notes": "Weather conditions suitable, ready to proceed",
      "effectiveness": 0,
      "growthStage": "Tillering",
      "nextApplication": "2025-06-30",
      "photos": []
    },
    {
      "id": "APP003",
      "field": "Field C - East Plot",
      "crop": "Tomato",
      "fertilizer": "Compost",
      "plannedDate": "2025-06-14",
      "actualDate": "",
      "plannedAmount": 2.0,
      "actualAmount": 0.0,
      "unit": "ton/ha",
      "status": "Delayed",
      "weather": "Rainy",
      "soilMoisture": "Excessive",
      "applicationMethod": "Manual Spreading",
      "operator": "Mike Wilson",
      "equipment": "Hand Tools",
      "cost": 600.0,
      "notes": "Delayed due to continuous rain, waiting for better conditions",
      "effectiveness": 0,
      "growthStage": "Flowering",
      "nextApplication": "2025-07-14",
      "photos": []
    },
    {
      "id": "APP004",
      "field": "Field D - West Plot",
      "crop": "Corn",
      "fertilizer": "DAP",
      "plannedDate": "2025-06-17",
      "actualDate": "",
      "plannedAmount": 35.0,
      "actualAmount": 0.0,
      "unit": "kg/ha",
      "status": "Planned",
      "weather": "Sunny",
      "soilMoisture": "Good",
      "applicationMethod": "Broadcasting",
      "operator": "Tom Brown",
      "equipment": "Spreader B",
      "cost": 900.0,
      "notes": "Ready for application, equipment checked",
      "effectiveness": 0,
      "growthStage": "Booting",
      "nextApplication": "2025-07-01",
      "photos": []
    },
    {
      "id": "APP005",
      "field": "Field A - North Plot",
      "crop": "Rice",
      "fertilizer": "Bone Meal",
      "plannedDate": "2025-06-12",
      "actualDate": "2025-06-13",
      "plannedAmount": 25.0,
      "actualAmount": 26.0,
      "unit": "kg/ha",
      "status": "Completed",
      "weather": "Cloudy",
      "soilMoisture": "Good",
      "applicationMethod": "Incorporation",
      "operator": "Lisa Davis",
      "equipment": "Rotavator",
      "cost": 875.0,
      "notes": "Slight increase in amount due to field conditions, well incorporated",
      "effectiveness": 92,
      "growthStage": "Early Vegetative",
      "nextApplication": "2025-06-26",
      "photos": ["photo3.jpg"]
    },
    {
      "id": "APP006",
      "field": "Field B - South Plot",
      "crop": "Wheat",
      "fertilizer": "NPK 12-32-16",
      "plannedDate": "2025-06-10",
      "actualDate": "",
      "plannedAmount": 45.0,
      "actualAmount": 0.0,
      "unit": "kg/ha",
      "status": "Cancelled",
      "weather": "Stormy",
      "soilMoisture": "Waterlogged",
      "applicationMethod": "Broadcasting",
      "operator": "David Lee",
      "equipment": "Spreader A",
      "cost": 0.0,
      "notes": "Cancelled due to severe weather and waterlogged conditions",
      "effectiveness": 0,
      "growthStage": "Booting",
      "nextApplication": "2025-06-24",
      "photos": []
    },
  ];

  List<Map<String, dynamic>> trackingMetrics = [
    {
      "metric": "Application Accuracy",
      "value": 96.5,
      "unit": "%",
      "description": "Accuracy of actual vs planned amounts",
      "trend": "up",
      "icon": Icons.gps_fixed
    },
    {
      "metric": "On-Time Completion",
      "value": 78.0,
      "unit": "%",
      "description": "Applications completed on schedule",
      "trend": "stable",
      "icon": Icons.schedule
    },
    {
      "metric": "Cost Efficiency",
      "value": 92.3,
      "unit": "%",
      "description": "Actual vs budgeted costs",
      "trend": "up",
      "icon": Icons.attach_money
    },
    {
      "metric": "Weather Delays",
      "value": 15.0,
      "unit": "%",
      "description": "Applications delayed due to weather",
      "trend": "down",
      "icon": Icons.wb_cloudy
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in progress':
        return primaryColor;
      case 'planned':
        return infoColor;
      case 'delayed':
        return warningColor;
      case 'cancelled':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Icon _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Icon(Icons.check_circle, color: successColor, size: 16);
      case 'in progress':
        return Icon(Icons.play_circle, color: primaryColor, size: 16);
      case 'planned':
        return Icon(Icons.schedule, color: infoColor, size: 16);
      case 'delayed':
        return Icon(Icons.warning, color: warningColor, size: 16);
      case 'cancelled':
        return Icon(Icons.cancel, color: dangerColor, size: 16);
      default:
        return Icon(Icons.help, color: disabledBoldColor, size: 16);
    }
  }

  List<Map<String, dynamic>> _getFilteredApplications() {
    return applications.where((app) {
      bool matchesField = selectedField == "all" || app["field"] == selectedField;
      bool matchesStatus = selectedStatus == "all" || app["status"].toLowerCase() == selectedStatus.toLowerCase();
      // Add period filtering logic here if needed
      return matchesField && matchesStatus;
    }).toList();
  }

  Widget _buildOverviewTab() {
    List<Map<String, dynamic>> filteredApps = _getFilteredApplications();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        // Tracking Metrics
        ResponsiveGridView(
          padding: EdgeInsets.all(spSm),
          minItemWidth: 200,
          children: trackingMetrics.map((metric) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        metric["icon"] as IconData,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${metric["metric"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Icon(
                        metric["trend"] == "up" 
                            ? Icons.trending_up 
                            : metric["trend"] == "down" 
                                ? Icons.trending_down 
                                : Icons.trending_flat,
                        color: metric["trend"] == "up" 
                            ? successColor 
                            : metric["trend"] == "down" 
                                ? dangerColor 
                                : disabledBoldColor,
                        size: 16,
                      ),
                    ],
                  ),
                  Text(
                    "${(metric["value"] as num).toStringAsFixed(1)}${metric["unit"]}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${metric["description"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        // Filter Controls
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.filter_list,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Filter Applications",
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
                      label: "Field",
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
                      label: "Status",
                      items: statusOptions,
                      value: selectedStatus,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              QDropdownField(
                label: "Time Period",
                items: periodOptions,
                value: selectedPeriod,
                onChanged: (value, label) {
                  selectedPeriod = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),

        // Applications List
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.track_changes,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Applications (${filteredApps.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Add New",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spSm),
              ...filteredApps.map((application) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          _getStatusIcon(application["status"]),
                          SizedBox(width: spXs),
                          Text(
                            "${application["id"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(application["status"]),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${application["status"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Text(
                        "${application["field"]} • ${application["crop"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${application["fertilizer"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "\$${((application["cost"] as double).toDouble()).currency}",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Text(
                            "Planned: ${application["plannedDate"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
                            ),
                          ),
                          Spacer(),
                          if (application["actualDate"].isNotEmpty)
                            Text(
                              "Actual: ${application["actualDate"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 11,
                              ),
                            ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Text(
                            "Amount: ${(application["plannedAmount"] as double).toStringAsFixed(1)} ${application["unit"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
                            ),
                          ),
                          if (application["actualAmount"] > 0)
                            Text(
                              " → ${(application["actualAmount"] as double).toStringAsFixed(1)} ${application["unit"]}",
                              style: TextStyle(
                                color: application["actualAmount"] != application["plannedAmount"] 
                                    ? warningColor 
                                    : successColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Text(
                            "Operator: ${application["operator"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 10,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Weather: ${application["weather"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      
                      if (application["notes"].isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.blue.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${application["notes"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: application["status"] == "Planned" ? "Start" : "Update",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Details",
                              size: bs.sm,
                              onPressed: () {},
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
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        // Performance Summary
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.analytics,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Performance Analytics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              
              // Status Distribution
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Application Status Distribution",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    
                    ...statusOptions.skip(1).map((status) {
                      int count = applications.where((app) => 
                        app["status"].toLowerCase() == status["value"].toLowerCase()).length;
                      double percentage = applications.isNotEmpty 
                          ? (count / applications.length) * 100 
                          : 0;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(status["value"]),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${status["label"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Text(
                                  "$count (${percentage.toStringAsFixed(1)}%)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: percentage / 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(status["value"]),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
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

        // Cost Analysis
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Cost Analysis",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
              
              ResponsiveGridView(
                padding: EdgeInsets.all(spSm),
                minItemWidth: 200,
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Cost",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "\$${((applications.map((app) => app["cost"] as double).fold(0.0, (sum, cost) => sum + cost)).toDouble()).currency}",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Average per Application",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "\$${applications.isNotEmpty ? ((applications.map((app) => app["cost"] as double).fold(0.0, (sum, cost) => sum + cost) / applications.length).toDouble()).currency : '0.00'}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
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

        // Effectiveness Tracking
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.trending_up,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Effectiveness Tracking",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              
              ...applications.where((app) => app["effectiveness"] > 0).map((application) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${application["field"]} - ${application["fertilizer"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Text(
                            "${application["effectiveness"]}%",
                            style: TextStyle(
                              color: application["effectiveness"] >= 90 
                                  ? successColor 
                                  : application["effectiveness"] >= 70 
                                      ? warningColor 
                                      : dangerColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (application["effectiveness"] as int) / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: application["effectiveness"] >= 90 
                                  ? successColor 
                                  : application["effectiveness"] >= 70 
                                      ? warningColor 
                                      : dangerColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                      
                      Text(
                        "Applied: ${application["actualDate"]} • ${application["growthStage"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Application Tracker",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildOverviewTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildAnalyticsTab(),
        ),
      ],
    );
  }
}
