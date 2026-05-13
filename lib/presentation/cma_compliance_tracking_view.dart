import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaComplianceTrackingView extends StatefulWidget {
  const CmaComplianceTrackingView({super.key});

  @override
  State<CmaComplianceTrackingView> createState() => _CmaComplianceTrackingViewState();
}

class _CmaComplianceTrackingViewState extends State<CmaComplianceTrackingView> {
  int currentTab = 0;
  String selectedVehicle = "";
  String selectedDriver = "";
  String selectedCompliance = "";
  String complianceType = "";
  String description = "";
  String dueDate = "";
  
  List<Map<String, dynamic>> complianceRecords = [
    {
      "id": "COMP001",
      "type": "Vehicle Inspection",
      "vehicle": "TRK-001",
      "driver": "John Smith",
      "dueDate": "2025-06-25",
      "status": "Pending",
      "priority": "High",
      "description": "Annual safety inspection required",
      "inspector": "Mike Johnson",
      "lastCompleted": "2024-06-25",
      "completionRate": 95.0,
      "violations": 0,
      "cost": 150.00,
      "documents": ["inspection_report.pdf", "safety_certificate.pdf"],
      "reminders": 3,
      "category": "Safety"
    },
    {
      "id": "COMP002",
      "type": "Driver License",
      "vehicle": "VAN-002",
      "driver": "Maria Garcia",
      "dueDate": "2025-07-15",
      "status": "Completed",
      "priority": "Medium",
      "description": "Commercial driver license renewal",
      "inspector": "DMV Office",
      "lastCompleted": "2025-06-10",
      "completionRate": 100.0,
      "violations": 0,
      "cost": 85.00,
      "documents": ["license_copy.pdf", "medical_certificate.pdf"],
      "reminders": 0,
      "category": "Legal"
    },
    {
      "id": "COMP003",
      "type": "Environmental Check",
      "vehicle": "TRK-003",
      "driver": "David Chen",
      "dueDate": "2025-06-30",
      "status": "Overdue",
      "priority": "Critical",
      "description": "Emissions testing and environmental compliance",
      "inspector": "EPA Testing Center",
      "lastCompleted": "2024-12-15",
      "completionRate": 88.5,
      "violations": 1,
      "cost": 200.00,
      "documents": ["emissions_report.pdf"],
      "reminders": 5,
      "category": "Environmental"
    },
    {
      "id": "COMP004",
      "type": "Insurance Verification",
      "vehicle": "CAR-004",
      "driver": "Sarah Johnson",
      "dueDate": "2025-08-20",
      "status": "Upcoming",
      "priority": "Medium",
      "description": "Commercial vehicle insurance policy renewal",
      "inspector": "Insurance Company",
      "lastCompleted": "2024-08-20",
      "completionRate": 92.0,
      "violations": 0,
      "cost": 1200.00,
      "documents": ["policy_document.pdf", "coverage_details.pdf"],
      "reminders": 1,
      "category": "Financial"
    }
  ];

  List<Map<String, dynamic>> vehicles = [
    {"label": "TRK-001 - Delivery Truck", "value": "TRK-001"},
    {"label": "VAN-002 - Cargo Van", "value": "VAN-002"},
    {"label": "TRK-003 - Heavy Truck", "value": "TRK-003"},
    {"label": "CAR-004 - Service Car", "value": "CAR-004"}
  ];

  List<Map<String, dynamic>> drivers = [
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Maria Garcia", "value": "maria_garcia"},
    {"label": "David Chen", "value": "david_chen"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"}
  ];

  List<Map<String, dynamic>> complianceTypes = [
    {"label": "Vehicle Inspection", "value": "vehicle_inspection"},
    {"label": "Driver License", "value": "driver_license"},
    {"label": "Environmental Check", "value": "environmental"},
    {"label": "Insurance Verification", "value": "insurance"},
    {"label": "Safety Training", "value": "safety_training"},
    {"label": "Permit Renewal", "value": "permit"}
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Compliance Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Active Items", icon: Icon(Icons.assignment)),
        Tab(text: "Add Compliance", icon: Icon(Icons.add_task)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildActiveItemsTab(),
        _buildAddComplianceTab(),
        _buildReportsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildComplianceOverviewCards(),
          _buildPriorityCompliance(),
          _buildComplianceCalendar(),
        ],
      ),
    );
  }

  Widget _buildComplianceOverviewCards() {
    int totalCompliance = complianceRecords.length;
    int completedCount = complianceRecords.where((r) => r["status"] == "Completed").length;
    int overdueCount = complianceRecords.where((r) => r["status"] == "Overdue").length;
    int upcomingCount = complianceRecords.where((r) => r["status"] == "Upcoming").length;
    double avgCompletionRate = complianceRecords.fold(0.0, (sum, r) => sum + (r["completionRate"] as double)) / totalCompliance;
    
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildOverviewCard("Total Items", "$totalCompliance", Icons.assignment, primaryColor, "100%"),
        _buildOverviewCard("Completed", "$completedCount", Icons.check_circle, successColor, "${((completedCount / totalCompliance) * 100).toStringAsFixed(1)}%"),
        _buildOverviewCard("Overdue", "$overdueCount", Icons.error, dangerColor, overdueCount > 0 ? "Action Required" : "All Clear"),
        _buildOverviewCard("Avg Completion", "${avgCompletionRate.toStringAsFixed(1)}%", Icons.trending_up, infoColor, "+5.2%"),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityCompliance() {
    List<Map<String, dynamic>> priorityItems = complianceRecords.where((r) => 
      r["priority"] == "Critical" || r["priority"] == "High").toList()
      ..sort((a, b) => b["priority"].toString().compareTo(a["priority"].toString()));
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Priority Compliance Items",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${priorityItems.length} Items",
                  style: TextStyle(
                    color: dangerColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          if (priorityItems.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 48),
                    SizedBox(height: spSm),
                    Text(
                      "No priority compliance items",
                      style: TextStyle(
                        color: successColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "All compliance items are up to date",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...priorityItems.map((item) => _buildPriorityComplianceItem(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildPriorityComplianceItem(Map<String, dynamic> item) {
    Color priorityColor = item["priority"] == "Critical" ? dangerColor : 
                         item["priority"] == "High" ? warningColor : infoColor;
    Color statusColor = item["status"] == "Overdue" ? dangerColor : 
                       item["status"] == "Pending" ? warningColor : successColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: priorityColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: priorityColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(Icons.warning, color: priorityColor, size: 16),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["type"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${item["vehicle"]} • ${item["driver"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${item["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: disabledBoldColor, size: 14),
                SizedBox(width: spXs),
                Text(
                  "Due: ${item["dueDate"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Spacer(),
                if (item["reminders"] > 0)
                  Row(
                    children: [
                      Icon(Icons.notifications, color: warningColor, size: 14),
                      SizedBox(width: spXs),
                      Text(
                        "${item["reminders"]} reminders",
                        style: TextStyle(
                          color: warningColor,
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
  }

  Widget _buildComplianceCalendar() {
    Map<String, List<Map<String, dynamic>>> groupedByDate = {};
    
    for (var item in complianceRecords) {
      String date = item["dueDate"];
      if (!groupedByDate.containsKey(date)) {
        groupedByDate[date] = [];
      }
      groupedByDate[date]!.add(item);
    }
    
    List<String> sortedDates = groupedByDate.keys.toList()..sort();
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Upcoming Compliance Calendar",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...sortedDates.take(5).map((date) => _buildCalendarDateItem(date, groupedByDate[date]!)).toList(),
        ],
      ),
    );
  }

  Widget _buildCalendarDateItem(String date, List<Map<String, dynamic>> items) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(20)),
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
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(Icons.calendar_today, color: primaryColor, size: 16),
              ),
              SizedBox(width: spSm),
              Text(
                date,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${items.length} item${items.length > 1 ? 's' : ''}",
                  style: TextStyle(
                    color: infoColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          ...items.map((item) => Padding(
            padding: EdgeInsets.only(left: spMd),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: disabledBoldColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${item["type"]} - ${item["vehicle"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
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

  Widget _buildActiveItemsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildComplianceFilters(),
          _buildActiveComplianceList(),
        ],
      ),
    );
  }

  Widget _buildComplianceFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Filter Compliance Items",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Vehicle",
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
                  label: "Driver",
                  items: drivers,
                  value: selectedDriver,
                  onChanged: (value, label) {
                    selectedDriver = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          QDropdownField(
            label: "Compliance Type",
            items: complianceTypes,
            value: selectedCompliance,
            onChanged: (value, label) {
              selectedCompliance = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActiveComplianceList() {
    return Column(
      spacing: spSm,
      children: complianceRecords.map((item) => _buildComplianceCard(item)).toList(),
    );
  }

  Widget _buildComplianceCard(Map<String, dynamic> item) {
    Color statusColor = item["status"] == "Completed" ? successColor : 
                       item["status"] == "Overdue" ? dangerColor : 
                       item["status"] == "Pending" ? warningColor : infoColor;
    
    Color priorityColor = item["priority"] == "Critical" ? dangerColor : 
                         item["priority"] == "High" ? warningColor : infoColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(Icons.assignment, color: primaryColor, size: 24),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${item["type"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["priority"]}",
                            style: TextStyle(
                              color: priorityColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["status"]}",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "ID: ${item["id"]} • ${item["category"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.description, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${item["description"]}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Icon(Icons.local_shipping, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${item["vehicle"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(" • ", style: TextStyle(color: disabledBoldColor)),
                    Icon(Icons.person, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${item["driver"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildComplianceMetric("Due Date", "${item["dueDate"]}", Icons.calendar_today),
              _buildComplianceMetric("Inspector", "${item["inspector"]}", Icons.person_pin),
              _buildComplianceMetric("Cost", "\$${(item["cost"] as double).toStringAsFixed(2)}", Icons.attach_money),
              _buildComplianceMetric("Completion", "${(item["completionRate"] as double).toStringAsFixed(1)}%", Icons.trending_up),
            ],
          ),

          if ((item["documents"] as List).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.attach_file, color: infoColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Documents (${(item["documents"] as List).length})",
                        style: TextStyle(
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  ...((item["documents"] as List).map((doc) => Padding(
                    padding: EdgeInsets.only(left: spMd),
                    child: Text(
                      "• $doc",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 11,
                      ),
                    ),
                  )).toList()),
                ],
              ),
            ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              if (item["status"] != "Completed")
                QButton(
                  icon: Icons.check,
                  size: bs.sm,
                  onPressed: () {
                    ss("Compliance item marked as completed!");
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceMetric(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: disabledBoldColor, size: 16),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
              fontSize: 11,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddComplianceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Add New Compliance Item",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                QDropdownField(
                  label: "Compliance Type",
                  items: complianceTypes,
                  value: complianceType,
                  onChanged: (value, label) {
                    complianceType = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Vehicle",
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
                        label: "Driver",
                        items: drivers,
                        value: selectedDriver,
                        onChanged: (value, label) {
                          selectedDriver = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Description",
                  value: description,
                  hint: "Enter compliance description and requirements",
                  onChanged: (value) {
                    description = value;
                    setState(() {});
                  },
                ),

                QDatePicker(
                  label: "Due Date",
                  value: dueDate.isNotEmpty ? DateTime.parse(dueDate) : DateTime.now(),
                  onChanged: (value) {
                    dueDate = value.toString().split(' ')[0];
                    setState(() {});
                  },
                ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Add Compliance Item",
                    size: bs.md,
                    onPressed: () {
                      ss("Compliance item added successfully!");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildComplianceStatistics(),
          _buildCategoryBreakdown(),
          _buildComplianceTrends(),
        ],
      ),
    );
  }

  Widget _buildComplianceStatistics() {
    int totalViolations = complianceRecords.fold(0, (sum, r) => sum + (r["violations"] as int));
    double totalCosts = complianceRecords.fold(0.0, (sum, r) => sum + (r["cost"] as double));
    int totalReminders = complianceRecords.fold(0, (sum, r) => sum + (r["reminders"] as int));
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Compliance Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildStatCard("Total Violations", "$totalViolations", Icons.error, dangerColor),
              _buildStatCard("Total Costs", "\$${totalCosts.toStringAsFixed(0)}", Icons.attach_money, warningColor),
              _buildStatCard("Active Reminders", "$totalReminders", Icons.notifications, infoColor),
              _buildStatCard("Compliance Rate", "${(((complianceRecords.length - totalViolations) / complianceRecords.length) * 100).toStringAsFixed(1)}%", Icons.check_circle, successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdown() {
    Map<String, int> categoryCount = {};
    for (var record in complianceRecords) {
      String category = record["category"];
      categoryCount[category] = (categoryCount[category] ?? 0) + 1;
    }
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Compliance by Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...categoryCount.entries.map((entry) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(20)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(Icons.category, color: primaryColor, size: 16),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    entry.key,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${entry.value} items",
                    style: TextStyle(
                      color: infoColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
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

  Widget _buildComplianceTrends() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Compliance Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            height: 200,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.trending_up, color: successColor, size: 48),
                  SizedBox(height: spSm),
                  Text(
                    "Compliance Rate Improving",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "95% compliance achieved this month",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
