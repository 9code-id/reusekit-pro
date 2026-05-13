import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmWorkOrderHistoryView extends StatefulWidget {
  const FsmWorkOrderHistoryView({super.key});

  @override
  State<FsmWorkOrderHistoryView> createState() => _FsmWorkOrderHistoryViewState();
}

class _FsmWorkOrderHistoryViewState extends State<FsmWorkOrderHistoryView> {
  String searchQuery = "";
  String selectedFilter = "All";
  String selectedTimeRange = "This Month";
  int selectedTab = 0;

  List<String> filterOptions = ["All", "Completed", "Cancelled", "Overdue"];
  List<String> timeRangeOptions = ["This Week", "This Month", "Last 3 Months", "This Year", "Custom"];

  // Mock data for work order history
  List<Map<String, dynamic>> workOrderHistory = [
    {
      "id": "WO-150",
      "title": "Generator Maintenance Service",
      "customer": "Metro Hospital",
      "technician": "David Brown",
      "status": "Completed",
      "priority": "High",
      "startDate": "2024-01-10",
      "completedDate": "2024-01-12",
      "duration": "2 days 4 hours",
      "location": "Generator Room A",
      "equipment": "Backup Generator #1",
      "cost": 2850.00,
      "rating": 4.8,
      "feedback": "Excellent service, very professional and thorough.",
      "materials": [
        {"item": "Oil Filter", "quantity": 2, "cost": 45.00},
        {"item": "Air Filter", "quantity": 1, "cost": 85.00},
        {"item": "Spark Plugs", "quantity": 8, "cost": 120.00},
      ],
      "timeEntries": [
        {"date": "2024-01-10", "hours": 6.5, "description": "Initial inspection and diagnostics"},
        {"date": "2024-01-11", "hours": 8.0, "description": "Parts replacement and testing"},
        {"date": "2024-01-12", "hours": 4.0, "description": "Final testing and documentation"},
      ],
      "invoiceNumber": "INV-001150",
      "paymentStatus": "Paid"
    },
    {
      "id": "WO-149",
      "title": "HVAC System Repair",
      "customer": "ABC Corporation",
      "technician": "John Smith",
      "status": "Completed",
      "priority": "Medium",
      "startDate": "2024-01-08",
      "completedDate": "2024-01-09",
      "duration": "1 day 5 hours",
      "location": "Building B - Floor 2",
      "equipment": "HVAC Unit #003",
      "cost": 1650.00,
      "rating": 4.5,
      "feedback": "Good work, system is running smoothly now.",
      "materials": [
        {"item": "Thermostat", "quantity": 1, "cost": 150.00},
        {"item": "Refrigerant", "quantity": 3, "cost": 180.00},
      ],
      "timeEntries": [
        {"date": "2024-01-08", "hours": 7.0, "description": "System diagnosis and repair"},
        {"date": "2024-01-09", "hours": 5.0, "description": "Testing and calibration"},
      ],
      "invoiceNumber": "INV-001149",
      "paymentStatus": "Paid"
    },
    {
      "id": "WO-148",
      "title": "Emergency Plumbing Repair",
      "customer": "Downtown Office Complex",
      "technician": "Mike Wilson",
      "status": "Completed",
      "priority": "Critical",
      "startDate": "2024-01-07",
      "completedDate": "2024-01-07",
      "duration": "8 hours",
      "location": "Basement Level",
      "equipment": "Main Water Line",
      "cost": 3200.00,
      "rating": 5.0,
      "feedback": "Amazing response time! Fixed the emergency quickly and professionally.",
      "materials": [
        {"item": "Pipe Fittings", "quantity": 10, "cost": 250.00},
        {"item": "Valves", "quantity": 3, "cost": 450.00},
        {"item": "Sealant", "quantity": 2, "cost": 80.00},
      ],
      "timeEntries": [
        {"date": "2024-01-07", "hours": 8.0, "description": "Emergency pipe repair and replacement"},
      ],
      "invoiceNumber": "INV-001148",
      "paymentStatus": "Paid"
    },
    {
      "id": "WO-147",
      "title": "Electrical Panel Upgrade",
      "customer": "XYZ Industries",
      "technician": "Sarah Johnson",
      "status": "Cancelled",
      "priority": "Medium",
      "startDate": "2024-01-05",
      "completedDate": null,
      "duration": null,
      "location": "Warehouse C",
      "equipment": "Main Electrical Panel",
      "cost": 0.00,
      "rating": null,
      "feedback": null,
      "materials": [],
      "timeEntries": [],
      "invoiceNumber": null,
      "paymentStatus": "N/A",
      "cancellationReason": "Customer postponed due to budget constraints"
    },
    {
      "id": "WO-146",
      "title": "Fire System Inspection",
      "customer": "City Mall",
      "technician": "Lisa Anderson",
      "status": "Overdue",
      "priority": "High",
      "startDate": "2024-01-03",
      "completedDate": null,
      "duration": null,
      "location": "All Floors",
      "equipment": "Fire Alarm System",
      "cost": 0.00,
      "rating": null,
      "feedback": null,
      "materials": [],
      "timeEntries": [
        {"date": "2024-01-03", "hours": 4.0, "description": "Partial inspection completed"},
      ],
      "invoiceNumber": null,
      "paymentStatus": "Pending"
    },
  ];

  List<Map<String, dynamic>> get filteredHistory {
    List<Map<String, dynamic>> filtered = workOrderHistory;

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
      case "Completed":
        return successColor;
      case "Cancelled":
        return disabledColor;
      case "Overdue":
        return dangerColor;
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Work Order History",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Analytics", icon: Icon(Icons.bar_chart)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildHistoryTab(),
        _buildAnalyticsTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          QTextField(
            label: "Search work orders...",
            value: searchQuery,
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),

          // Filter Row
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter Status",
                  items: filterOptions.map((option) => {
                    "label": option,
                    "value": option,
                  }).toList(),
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Time Range",
                  items: timeRangeOptions.map((option) => {
                    "label": option,
                    "value": option,
                  }).toList(),
                  value: selectedTimeRange,
                  onChanged: (value, label) {
                    selectedTimeRange = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Statistics Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatsCard("Total Orders", "${filteredHistory.length}", Icons.assignment, primaryColor),
              _buildStatsCard("Completed", "${filteredHistory.where((o) => o["status"] == "Completed").length}", Icons.check_circle, successColor),
              _buildStatsCard("Average Rating", "4.6", Icons.star, warningColor),
              _buildStatsCard("Total Revenue", "\$${_calculateTotalRevenue().toStringAsFixed(0)}", Icons.attach_money, infoColor),
            ],
          ),

          // Work Order History List
          ...filteredHistory.map((order) => _buildHistoryCard(order)),
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

  Widget _buildHistoryCard(Map<String, dynamic> order) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: getStatusColor(order["status"]),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          // Header
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

          // Basic Info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
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
                        Icon(Icons.business, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          order["customer"],
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
                  Text(
                    "Cost",
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

          // Dates and Duration
          Container(
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
                      Text(
                        "Start Date",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        order["startDate"],
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                if (order["completedDate"] != null) ...[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          order["completedDate"],
                          style: TextStyle(fontSize: 12),
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
                            fontSize: 11,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          order["duration"] ?? "N/A",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Rating and Feedback (for completed orders)
          if (order["status"] == "Completed" && order["rating"] != null) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) => Icon(
                          index < (order["rating"] as double).floor() ? Icons.star : Icons.star_border,
                          size: 16,
                          color: warningColor,
                        )),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${order["rating"]}/5.0",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  if (order["feedback"] != null) ...[
                    SizedBox(height: spXs),
                    Text(
                      order["feedback"],
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],

          // Cancellation Reason (for cancelled orders)
          if (order["status"] == "Cancelled" && order["cancellationReason"] != null) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cancellation Reason",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    order["cancellationReason"],
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _showOrderDetails(order),
                ),
              ),
              SizedBox(width: spSm),
              if (order["status"] == "Completed") ...[
                QButton(
                  icon: Icons.receipt,
                  size: bs.sm,
                  onPressed: () => _showInvoice(order),
                ),
                SizedBox(width: spXs),
              ],
              QButton(
                icon: Icons.file_download,
                size: bs.sm,
                onPressed: () => _exportOrder(order),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Performance Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Average Completion Time", "1.8 days", Icons.timer, infoColor),
              _buildMetricCard("First-Time Fix Rate", "85%", Icons.build, successColor),
              _buildMetricCard("Customer Satisfaction", "4.6/5", Icons.star, warningColor),
              _buildMetricCard("Revenue This Month", "\$8,700", Icons.attach_money, primaryColor),
            ],
          ),

          // Completion Rate Trend
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
                  "Monthly Completion Rate",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                Container(
                  height: 200,
                  child: Center(
                    child: Text(
                      "Chart: Monthly completion rates would be displayed here",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Technician Performance
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
                  "Technician Performance (This Month)",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ..._buildTechnicianStats(),
              ],
            ),
          ),

          // Revenue Analysis
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
                  "Revenue Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ..._buildRevenueBreakdown(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
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
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTechnicianStats() {
    Map<String, Map<String, dynamic>> techStats = {};
    
    for (var order in workOrderHistory.where((o) => o["status"] == "Completed")) {
      String tech = order["technician"];
      if (!techStats.containsKey(tech)) {
        techStats[tech] = {"completed": 0, "totalCost": 0.0, "ratings": []};
      }
      techStats[tech]!["completed"]++;
      techStats[tech]!["totalCost"] += order["cost"];
      if (order["rating"] != null) {
        techStats[tech]!["ratings"].add(order["rating"]);
      }
    }

    return techStats.entries.map((entry) {
      String tech = entry.key;
      Map<String, dynamic> stats = entry.value;
      double avgRating = stats["ratings"].isEmpty ? 0.0 : 
          (stats["ratings"] as List).reduce((a, b) => a + b) / (stats["ratings"] as List).length;

      return Container(
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
                  Text(
                    tech,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${stats["completed"]} orders • \$${(stats["totalCost"] as double).toStringAsFixed(0)} revenue",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            if (avgRating > 0) ...[
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: warningColor),
                  SizedBox(width: spXs),
                  Text(
                    avgRating.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _buildRevenueBreakdown() {
    Map<String, double> customerRevenue = {};
    
    for (var order in workOrderHistory.where((o) => o["status"] == "Completed")) {
      String customer = order["customer"];
      customerRevenue[customer] = (customerRevenue[customer] ?? 0) + (order["cost"] as double);
    }

    var sortedCustomers = customerRevenue.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    double totalRevenue = customerRevenue.values.fold(0, (sum, value) => sum + value);

    return sortedCustomers.take(5).map((entry) {
      double percentage = (entry.value / totalRevenue) * 100;
      
      return Container(
        margin: EdgeInsets.only(bottom: spSm),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  "\$${entry.value.toStringAsFixed(0)} (${percentage.toStringAsFixed(1)}%)",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spXs),
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Report Generation Options
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
                  "Generate Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Report Type",
                        items: [
                          {"label": "Work Order Summary", "value": "summary"},
                          {"label": "Technician Performance", "value": "performance"},
                          {"label": "Customer Analysis", "value": "customer"},
                          {"label": "Financial Report", "value": "financial"},
                        ],
                        value: "summary",
                        onChanged: (value, label) {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Date Range",
                        items: timeRangeOptions.map((option) => {
                          "label": option,
                          "value": option,
                        }).toList(),
                        value: "This Month",
                        onChanged: (value, label) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Generate PDF Report",
                        icon: Icons.picture_as_pdf,
                        onPressed: () => _generateReport("PDF"),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Export to Excel",
                        icon: Icons.table_chart,
                        onPressed: () => _generateReport("Excel"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Recent Reports
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
                  "Recent Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ..._buildRecentReports(),
              ],
            ),
          ),

          // Export Options
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
                  "Bulk Export Options",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildExportOption("All Work Orders", "Export complete work order database", Icons.assignment),
                    _buildExportOption("Customer Data", "Export customer information and history", Icons.people),
                    _buildExportOption("Financial Data", "Export billing and payment records", Icons.attach_money),
                    _buildExportOption("Time Entries", "Export detailed time tracking data", Icons.access_time),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRecentReports() {
    List<Map<String, dynamic>> reports = [
      {
        "title": "Monthly Work Order Summary",
        "date": "2024-01-15",
        "type": "PDF",
        "size": "2.3 MB"
      },
      {
        "title": "Technician Performance Report",
        "date": "2024-01-10",
        "type": "Excel",
        "size": "1.8 MB"
      },
      {
        "title": "Customer Analysis Q4 2023",
        "date": "2024-01-05",
        "type": "PDF",
        "size": "3.1 MB"
      },
    ];

    return reports.map((report) => Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            report["type"] == "PDF" ? Icons.picture_as_pdf : Icons.table_chart,
            color: report["type"] == "PDF" ? dangerColor : successColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report["title"],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${report["date"]} • ${report["size"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () => _downloadReport(report),
          ),
        ],
      ),
    )).toList();
  }

  Widget _buildExportOption(String title, String description, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryColor),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Export",
            size: bs.sm,
            onPressed: () => _exportData(title),
          ),
        ],
      ),
    );
  }

  double _calculateTotalRevenue() {
    return filteredHistory
        .where((order) => order["status"] == "Completed")
        .fold(0.0, (sum, order) => sum + (order["cost"] as double));
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Order Details - ${order["id"]}"),
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
                _buildDetailRow("Customer", order["customer"]),
                _buildDetailRow("Technician", order["technician"]),
                _buildDetailRow("Location", order["location"]),
                _buildDetailRow("Equipment", order["equipment"]),
                _buildDetailRow("Start Date", order["startDate"]),
                if (order["completedDate"] != null)
                  _buildDetailRow("Completed", order["completedDate"]),
                _buildDetailRow("Status", order["status"]),
                _buildDetailRow("Priority", order["priority"]),
                if (order["cost"] > 0)
                  _buildDetailRow("Total Cost", "\$${(order["cost"] as double).toStringAsFixed(2)}"),
                if (order["materials"].isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Text(
                    "Materials Used:",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  ...(order["materials"] as List).map((material) => 
                    Text("• ${material["item"]} (${material["quantity"]}) - \$${(material["cost"] as double).toStringAsFixed(2)}")),
                ],
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
            width: 100,
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

  void _showInvoice(Map<String, dynamic> order) {
    if (order["invoiceNumber"] != null) {
      ss("Opening invoice ${order["invoiceNumber"]}...");
    }
  }

  void _exportOrder(Map<String, dynamic> order) {
    ss("Exporting order ${order["id"]}...");
  }

  void _generateReport(String format) {
    ss("Generating $format report...");
  }

  void _downloadReport(Map<String, dynamic> report) {
    ss("Downloading ${report["title"]}...");
  }

  void _exportData(String dataType) {
    ss("Exporting $dataType...");
  }
}
