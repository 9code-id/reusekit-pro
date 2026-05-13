import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmRecurringWorkOrdersView extends StatefulWidget {
  const FsmRecurringWorkOrdersView({super.key});

  @override
  State<FsmRecurringWorkOrdersView> createState() => _FsmRecurringWorkOrdersViewState();
}

class _FsmRecurringWorkOrdersViewState extends State<FsmRecurringWorkOrdersView> {
  String searchQuery = "";
  String selectedFilter = "All";
  int selectedTab = 0;

  List<String> filterOptions = ["All", "Active", "Paused", "Expired"];

  // Mock data for recurring work orders
  List<Map<String, dynamic>> recurringOrders = [
    {
      "id": "RWO-001",
      "title": "HVAC System Preventive Maintenance",
      "customer": "ABC Corporation",
      "technician": "John Smith",
      "status": "Active",
      "frequency": "Monthly",
      "nextDue": "2024-02-15",
      "lastCompleted": "2024-01-15",
      "location": "Building A - All Floors",
      "equipment": "HVAC Units #001-005",
      "estimatedDuration": "4 hours",
      "cost": 850.00,
      "priority": "Medium",
      "startDate": "2023-06-01",
      "endDate": "2025-05-31",
      "completedCount": 8,
      "description": "Regular maintenance of all HVAC units including filter replacement, system checks, and performance optimization.",
      "checklist": [
        "Inspect air filters and replace if needed",
        "Check refrigerant levels",
        "Clean condenser coils",
        "Test thermostat calibration",
        "Inspect electrical connections",
        "Check belt tension and alignment",
        "Document performance readings"
      ],
      "materials": [
        {"item": "Air Filters", "quantity": 10, "cost": 150.00},
        {"item": "Refrigerant", "quantity": 2, "cost": 120.00},
        {"item": "Cleaning Supplies", "quantity": 1, "cost": 45.00},
      ],
      "notifications": ["3 days before", "1 day before"],
      "autoAssign": true
    },
    {
      "id": "RWO-002",
      "title": "Generator Weekly Inspection",
      "customer": "Metro Hospital",
      "technician": "David Brown",
      "status": "Active",
      "frequency": "Weekly",
      "nextDue": "2024-01-22",
      "lastCompleted": "2024-01-15",
      "location": "Generator Room A & B",
      "equipment": "Backup Generators #1-3",
      "estimatedDuration": "2 hours",
      "cost": 300.00,
      "priority": "High",
      "startDate": "2023-01-01",
      "endDate": "2024-12-31",
      "completedCount": 52,
      "description": "Weekly safety inspection and testing of emergency backup generators to ensure operational readiness.",
      "checklist": [
        "Visual inspection of generator units",
        "Check oil levels and quality",
        "Test battery voltage",
        "Run generators for 30 minutes",
        "Check fuel levels",
        "Inspect exhaust system",
        "Test automatic transfer switch"
      ],
      "materials": [
        {"item": "Oil Sample Kit", "quantity": 1, "cost": 25.00},
        {"item": "Test Equipment", "quantity": 1, "cost": 0.00},
      ],
      "notifications": ["1 day before"],
      "autoAssign": true
    },
    {
      "id": "RWO-003",
      "title": "Fire Safety System Annual Check",
      "customer": "City Mall",
      "technician": "Lisa Anderson",
      "status": "Paused",
      "frequency": "Annually",
      "nextDue": "2024-03-01",
      "lastCompleted": "2023-03-01",
      "location": "All Floors and Emergency Exits",
      "equipment": "Fire Alarm System",
      "estimatedDuration": "8 hours",
      "cost": 1200.00,
      "priority": "High",
      "startDate": "2022-03-01",
      "endDate": "2027-02-28",
      "completedCount": 2,
      "description": "Comprehensive annual inspection of fire safety systems including alarms, sprinklers, and emergency lighting.",
      "checklist": [
        "Test all smoke detectors",
        "Inspect fire extinguishers",
        "Check emergency lighting",
        "Test sprinkler system",
        "Verify emergency exit signs",
        "Update inspection documentation",
        "Submit compliance report"
      ],
      "materials": [
        {"item": "Inspection Tags", "quantity": 50, "cost": 75.00},
        {"item": "Test Smoke", "quantity": 2, "cost": 45.00},
        {"item": "Documentation Forms", "quantity": 1, "cost": 0.00},
      ],
      "notifications": ["30 days before", "7 days before"],
      "autoAssign": false,
      "pauseReason": "Facility renovation in progress"
    },
    {
      "id": "RWO-004",
      "title": "Elevator Maintenance Service",
      "customer": "Downtown Office Complex",
      "technician": "Mike Wilson",
      "status": "Active",
      "frequency": "Quarterly",
      "nextDue": "2024-04-01",
      "lastCompleted": "2024-01-01",
      "location": "Elevators A, B, C",
      "equipment": "Passenger Elevators",
      "estimatedDuration": "6 hours",
      "cost": 1500.00,
      "priority": "Medium",
      "startDate": "2023-01-01",
      "endDate": "2025-12-31",
      "completedCount": 4,
      "description": "Quarterly maintenance service for passenger elevators including safety inspections and performance checks.",
      "checklist": [
        "Inspect cables and pulleys",
        "Test safety systems",
        "Lubricate moving parts",
        "Check door mechanisms",
        "Test emergency communication",
        "Calibrate floor leveling",
        "Update maintenance logs"
      ],
      "materials": [
        {"item": "Lubricants", "quantity": 3, "cost": 150.00},
        {"item": "Safety Inspection Kit", "quantity": 1, "cost": 200.00},
        {"item": "Replacement Parts", "quantity": 1, "cost": 300.00},
      ],
      "notifications": ["14 days before", "3 days before"],
      "autoAssign": true
    },
    {
      "id": "RWO-005",
      "title": "Security System Bi-Annual Check",
      "customer": "XYZ Industries",
      "technician": "Sarah Johnson",
      "status": "Expired",
      "frequency": "Bi-annually",
      "nextDue": "2024-01-01",
      "lastCompleted": "2023-07-01",
      "location": "Main Building - All Zones",
      "equipment": "Security Camera System",
      "estimatedDuration": "5 hours",
      "cost": 750.00,
      "priority": "Medium",
      "startDate": "2022-01-01",
      "endDate": "2023-12-31",
      "completedCount": 4,
      "description": "Bi-annual inspection and maintenance of security camera systems and access control systems.",
      "checklist": [
        "Test all security cameras",
        "Check recording equipment",
        "Verify access control systems",
        "Clean camera lenses",
        "Update system firmware",
        "Test backup systems",
        "Generate compliance report"
      ],
      "materials": [
        {"item": "Cleaning Supplies", "quantity": 1, "cost": 30.00},
        {"item": "Backup Storage", "quantity": 1, "cost": 150.00},
      ],
      "notifications": ["30 days before", "7 days before"],
      "autoAssign": true,
      "expiredReason": "Contract ended"
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> filtered = recurringOrders;

    if (selectedFilter != "All") {
      filtered = filtered.where((order) => order["status"] == selectedFilter).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((order) {
        return order["id"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               order["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               order["customer"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               order["technician"].toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Paused":
        return warningColor;
      case "Expired":
        return disabledColor;
      default:
        return primaryColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return primaryColor;
    }
  }

  Color getFrequencyColor(String frequency) {
    switch (frequency) {
      case "Daily":
        return dangerColor;
      case "Weekly":
        return warningColor;
      case "Monthly":
        return infoColor;
      case "Quarterly":
        return primaryColor;
      case "Bi-annually":
        return successColor;
      case "Annually":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Recurring Work Orders",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Active Orders", icon: Icon(Icons.repeat)),
        Tab(text: "Schedule", icon: Icon(Icons.calendar_today)),
        Tab(text: "Templates", icon: Icon(Icons.content_copy)),
      ],
      tabChildren: [
        _buildActiveOrdersTab(),
        _buildScheduleTab(),
        _buildTemplatesTab(),
      ],
    );
  }

  Widget _buildActiveOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filter
          QTextField(
            label: "Search recurring orders...",
            value: searchQuery,
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),

          // Filter Chips
          QCategoryPicker(
            items: filterOptions.map((option) => {
              "label": option,
              "value": option,
            }).toList(),
            value: selectedFilter,
            onChanged: (index, label, value, item) {
              selectedFilter = value;
              setState(() {});
            },
          ),

          // Statistics Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatsCard("Total Active", "${filteredOrders.where((o) => o["status"] == "Active").length}", Icons.repeat, successColor),
              _buildStatsCard("Due This Week", "${_getOrdersDueThisWeek().length}", Icons.schedule, warningColor),
              _buildStatsCard("Overdue", "${_getOverdueOrders().length}", Icons.warning, dangerColor),
              _buildStatsCard("Monthly Revenue", "\$${_calculateMonthlyRevenue().toStringAsFixed(0)}", Icons.attach_money, primaryColor),
            ],
          ),

          // Recurring Orders List
          ...filteredOrders.map((order) => _buildRecurringOrderCard(order)),

          // Add New Recurring Order Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create New Recurring Order",
              icon: Icons.add,
              onPressed: () => _showCreateRecurringOrderDialog(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(String title, String value, IconData icon, Color color) {
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
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecurringOrderCard(Map<String, dynamic> order) {
    bool isDue = _isOrderDue(order);
    bool isOverdue = _isOrderOverdue(order);

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isOverdue ? dangerColor : isDue ? warningColor : getStatusColor(order["status"]),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          // Header with Status Indicators
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          order["id"],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        if (isOverdue) ...[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "OVERDUE",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ] else if (isDue) ...[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "DUE SOON",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      order["title"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: getStatusColor(order["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  order["status"],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: getStatusColor(order["status"]),
                  ),
                ),
              ),
            ],
          ),

          // Basic Information
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.business, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            order["customer"],
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.person, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          order["technician"],
                          style: TextStyle(fontSize: 12, color: disabledBoldColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            order["location"],
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: getFrequencyColor(order["frequency"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      order["frequency"],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: getFrequencyColor(order["frequency"]),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: getPriorityColor(order["priority"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      order["priority"],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: getPriorityColor(order["priority"]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Schedule Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: isDue || isOverdue ? warningColor.withAlpha(10) : disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Next Due",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        order["nextDue"],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isDue || isOverdue ? warningColor : primaryColor,
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
                        "Last Completed",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        order["lastCompleted"] ?? "Never",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Completed",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${order["completedCount"]}x",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Cost and Duration
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Estimated Duration",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      order["estimatedDuration"],
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Cost per Service",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "\$${(order["cost"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: isDue || isOverdue ? "Schedule Now" : "View Details",
                  size: bs.sm,
                  onPressed: () => isDue || isOverdue ? _scheduleOrder(order) : _viewOrderDetails(order),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editRecurringOrder(order),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: order["status"] == "Active" ? Icons.pause : Icons.play_arrow,
                size: bs.sm,
                onPressed: () => _toggleOrderStatus(order),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showOrderMenu(order),
              ),
            ],
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
          // Calendar View Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: primaryColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Schedule Overview",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "View upcoming recurring maintenance schedules",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Month View",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // This Week's Schedule
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
                  "This Week's Schedule",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ..._buildWeeklySchedule(),
              ],
            ),
          ),

          // Upcoming Recurring Orders
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
                  "Next 30 Days",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ..._buildUpcomingSchedule(),
              ],
            ),
          ),

          // Schedule Conflicts
          if (_hasScheduleConflicts()) ...[
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: warningColor),
                      SizedBox(width: spSm),
                      Text(
                        "Schedule Conflicts Detected",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  ..._buildScheduleConflicts(),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildWeeklySchedule() {
    List<Map<String, dynamic>> weeklySchedule = [
      {"day": "Monday", "date": "Jan 22", "orders": ["RWO-002"]},
      {"day": "Tuesday", "date": "Jan 23", "orders": []},
      {"day": "Wednesday", "date": "Jan 24", "orders": ["RWO-001"]},
      {"day": "Thursday", "date": "Jan 25", "orders": []},
      {"day": "Friday", "date": "Jan 26", "orders": ["RWO-002"]},
      {"day": "Saturday", "date": "Jan 27", "orders": []},
      {"day": "Sunday", "date": "Jan 28", "orders": []},
    ];

    return weeklySchedule.map((day) => Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (day["orders"] as List).isNotEmpty ? primaryColor.withAlpha(10) : disabledColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day["day"],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  day["date"],
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: (day["orders"] as List).isEmpty 
                ? Text(
                    "No scheduled maintenance",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: (day["orders"] as List).map((orderId) {
                      var order = recurringOrders.firstWhere((o) => o["id"] == orderId);
                      return Text(
                        "${order["title"]} - ${order["customer"]}",
                        style: TextStyle(fontSize: 12),
                      );
                    }).toList(),
                  ),
          ),
          if ((day["orders"] as List).isNotEmpty)
            QButton(
              icon: Icons.schedule,
              size: bs.sm,
              onPressed: () => _viewDaySchedule(day),
            ),
        ],
      ),
    )).toList();
  }

  List<Widget> _buildUpcomingSchedule() {
    // Mock upcoming schedule for next 30 days
    List<Map<String, dynamic>> upcomingOrders = [
      {"date": "2024-02-15", "orderId": "RWO-001", "type": "scheduled"},
      {"date": "2024-02-22", "orderId": "RWO-002", "type": "scheduled"},
      {"date": "2024-03-01", "orderId": "RWO-003", "type": "due"},
      {"date": "2024-04-01", "orderId": "RWO-004", "type": "scheduled"},
    ];

    return upcomingOrders.map((upcoming) {
      var order = recurringOrders.firstWhere((o) => o["id"] == upcoming["orderId"]);
      
      return Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: upcoming["type"] == "due" ? warningColor.withAlpha(10) : disabledColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              child: Text(
                upcoming["date"],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: upcoming["type"] == "due" ? warningColor : primaryColor,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${order["id"]} - ${order["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${order["customer"]} • ${order["frequency"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            if (upcoming["type"] == "due")
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: warningColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "DUE",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      );
    }).toList();
  }

  bool _hasScheduleConflicts() => true; // Mock data

  List<Widget> _buildScheduleConflicts() {
    List<Map<String, dynamic>> conflicts = [
      {
        "date": "2024-01-22",
        "technician": "John Smith",
        "orders": ["RWO-001", "RWO-002"],
        "reason": "Technician double-booked"
      },
    ];

    return conflicts.map((conflict) => Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(Icons.error, color: dangerColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${conflict["date"]} - ${conflict["technician"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  conflict["reason"],
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Resolve",
            size: bs.sm,
            onPressed: () => _resolveConflict(conflict),
          ),
        ],
      ),
    )).toList();
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Create Template Section
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
                  "Create New Template",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Save time by creating reusable templates for common recurring maintenance tasks.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Create Template",
                        icon: Icons.add,
                        onPressed: () => _createTemplate(),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Import Template",
                      icon: Icons.file_upload,
                      size: bs.sm,
                      onPressed: () => _importTemplate(),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Available Templates
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
                  "Available Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ..._buildTemplateList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTemplateList() {
    List<Map<String, dynamic>> templates = [
      {
        "name": "HVAC Maintenance",
        "description": "Standard HVAC system maintenance checklist",
        "category": "HVAC",
        "frequency": "Monthly",
        "estimatedTime": "4 hours",
        "usageCount": 8,
        "lastUsed": "2024-01-15"
      },
      {
        "name": "Generator Inspection",
        "description": "Weekly generator safety inspection protocol",
        "category": "Generator",
        "frequency": "Weekly", 
        "estimatedTime": "2 hours",
        "usageCount": 52,
        "lastUsed": "2024-01-15"
      },
      {
        "name": "Fire Safety Check",
        "description": "Annual fire safety system inspection",
        "category": "Safety",
        "frequency": "Annually",
        "estimatedTime": "8 hours",
        "usageCount": 2,
        "lastUsed": "2023-03-01"
      },
    ];

    return templates.map((template) => Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      template["name"],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        template["category"],
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  template["description"],
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${template["frequency"]} • ${template["estimatedTime"]} • Used ${template["usageCount"]}x",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Column(
            children: [
              QButton(
                label: "Use Template",
                size: bs.sm,
                onPressed: () => _useTemplate(template),
              ),
              SizedBox(height: spXs),
              Row(
                children: [
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () => _editTemplate(template),
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    icon: Icons.copy,
                    size: bs.sm,
                    onPressed: () => _duplicateTemplate(template),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    )).toList();
  }

  List<Map<String, dynamic>> _getOrdersDueThisWeek() {
    // Mock implementation
    return recurringOrders.where((order) => _isOrderDue(order)).toList();
  }

  List<Map<String, dynamic>> _getOverdueOrders() {
    // Mock implementation  
    return recurringOrders.where((order) => _isOrderOverdue(order)).toList();
  }

  bool _isOrderDue(Map<String, dynamic> order) {
    // Mock implementation - check if order is due within 3 days
    return order["id"] == "RWO-001" || order["id"] == "RWO-002";
  }

  bool _isOrderOverdue(Map<String, dynamic> order) {
    // Mock implementation
    return order["status"] == "Expired";
  }

  double _calculateMonthlyRevenue() {
    return recurringOrders
        .where((order) => order["status"] == "Active")
        .fold(0.0, (sum, order) {
          double cost = order["cost"] as double;
          String frequency = order["frequency"];
          
          // Convert to monthly revenue
          switch (frequency) {
            case "Weekly":
              return sum + (cost * 4);
            case "Monthly":
              return sum + cost;
            case "Quarterly":
              return sum + (cost / 3);
            case "Bi-annually":
              return sum + (cost / 6);
            case "Annually":
              return sum + (cost / 12);
            default:
              return sum + cost;
          }
        });
  }

  void _showCreateRecurringOrderDialog() {
    //navigateTo(CreateRecurringOrderView())
    ss("Opening create recurring order form...");
  }

  void _scheduleOrder(Map<String, dynamic> order) {
    ss("Scheduling ${order["id"]} for immediate execution...");
  }

  void _viewOrderDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Recurring Order Details"),
        content: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  order["title"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                _buildDetailRow("ID", order["id"]),
                _buildDetailRow("Customer", order["customer"]),
                _buildDetailRow("Technician", order["technician"]),
                _buildDetailRow("Status", order["status"]),
                _buildDetailRow("Frequency", order["frequency"]),
                _buildDetailRow("Priority", order["priority"]),
                _buildDetailRow("Location", order["location"]),
                _buildDetailRow("Equipment", order["equipment"]),
                _buildDetailRow("Next Due", order["nextDue"]),
                _buildDetailRow("Last Completed", order["lastCompleted"] ?? "Never"),
                _buildDetailRow("Cost per Service", "\$${(order["cost"] as double).toStringAsFixed(2)}"),
                _buildDetailRow("Completed Count", "${order["completedCount"]}"),
                SizedBox(height: spSm),
                Text(
                  "Description:",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(order["description"]),
              ],
            ),
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _editRecurringOrder(Map<String, dynamic> order) {
    ss("Opening edit form for ${order["id"]}...");
  }

  void _toggleOrderStatus(Map<String, dynamic> order) {
    String newStatus = order["status"] == "Active" ? "Paused" : "Active";
    ss("Changed ${order["id"]} status to $newStatus");
    
    setState(() {
      order["status"] = newStatus;
    });
  }

  void _showOrderMenu(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Order Actions"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.copy),
              title: Text("Duplicate Order"),
              onTap: () {
                Navigator.pop(context);
                _duplicateOrder(order);
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("View History"),
              onTap: () {
                Navigator.pop(context);
                _viewOrderHistory(order);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Order"),
              onTap: () {
                Navigator.pop(context);
                _deleteOrder(order);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _viewDaySchedule(Map<String, dynamic> day) {
    ss("Viewing schedule for ${day["day"]}, ${day["date"]}");
  }

  void _resolveConflict(Map<String, dynamic> conflict) {
    ss("Resolving schedule conflict for ${conflict["date"]}");
  }

  void _createTemplate() {
    ss("Opening template creation form...");
  }

  void _importTemplate() {
    ss("Opening template import dialog...");
  }

  void _useTemplate(Map<String, dynamic> template) {
    ss("Creating recurring order from template: ${template["name"]}");
  }

  void _editTemplate(Map<String, dynamic> template) {
    ss("Editing template: ${template["name"]}");
  }

  void _duplicateTemplate(Map<String, dynamic> template) {
    ss("Duplicating template: ${template["name"]}");
  }

  void _duplicateOrder(Map<String, dynamic> order) {
    ss("Duplicating recurring order: ${order["id"]}");
  }

  void _viewOrderHistory(Map<String, dynamic> order) {
    ss("Viewing history for recurring order: ${order["id"]}");
  }

  void _deleteOrder(Map<String, dynamic> order) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this recurring order? This action cannot be undone.");
    if (isConfirmed) {
      ss("Recurring order ${order["id"]} deleted successfully");
      setState(() {
        recurringOrders.remove(order);
      });
    }
  }
}
