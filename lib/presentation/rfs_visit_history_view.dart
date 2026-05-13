import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsVisitHistoryView extends StatefulWidget {
  const RfsVisitHistoryView({super.key});

  @override
  State<RfsVisitHistoryView> createState() => _RfsVisitHistoryViewState();
}

class _RfsVisitHistoryViewState extends State<RfsVisitHistoryView> {
  int currentTab = 0;
  
  // Visit History State
  String selectedTimeframe = "week";
  String selectedCustomer = "";
  String selectedTable = "";
  bool showCompletedOnly = false;
  
  // Analytics State
  String analyticsDateRange = "month";
  String selectedMetric = "visits";
  
  // Reports State
  String reportType = "summary";
  String reportPeriod = "month";
  bool includeAnalytics = true;
  
  // Settings State
  bool trackVisitDuration = true;
  bool trackTableTurnover = true;
  bool trackWaitingTime = true;
  String retentionPeriod = "1year";
  bool realTimeUpdates = true;
  
  final List<Map<String, dynamic>> visitHistory = [
    {
      "id": "V001",
      "customerId": "CUST001",
      "customerName": "Sarah Johnson",
      "date": "2024-01-16",
      "time": "12:30 PM",
      "table": "Table 5",
      "partySize": 2,
      "duration": 65,
      "orderTotal": 45.80,
      "waitTime": 8,
      "status": "Completed",
      "server": "Alice Smith",
      "items": ["Cappuccino", "Avocado Toast", "Fresh Juice"],
      "paymentMethod": "Card",
      "satisfaction": 5,
      "notes": "Regular customer, requested quiet table"
    },
    {
      "id": "V002",
      "customerId": "CUST002",
      "customerName": "Michael Chen",
      "date": "2024-01-16",
      "time": "1:15 PM",
      "table": "Table 12",
      "partySize": 4,
      "duration": 45,
      "orderTotal": 120.50,
      "waitTime": 12,
      "status": "Completed",
      "server": "Bob Wilson",
      "items": ["Caesar Salad", "Pasta", "Wine", "Dessert"],
      "paymentMethod": "Cash",
      "satisfaction": 4,
      "notes": "Business lunch meeting"
    },
    {
      "id": "V003",
      "customerId": "CUST003",
      "customerName": "Emma Wilson",
      "date": "2024-01-16",
      "time": "2:00 PM",
      "table": "Table 8",
      "partySize": 3,
      "duration": 55,
      "orderTotal": 67.25,
      "waitTime": 5,
      "status": "In Progress",
      "server": "Charlie Davis",
      "items": ["Pancakes", "Coffee", "Orange Juice"],
      "paymentMethod": "Card",
      "satisfaction": null,
      "notes": "Family with young child"
    },
    {
      "id": "V004",
      "customerId": "CUST004",
      "customerName": "David Rodriguez",
      "date": "2024-01-15",
      "time": "8:30 AM",
      "table": "Counter",
      "partySize": 1,
      "duration": 25,
      "orderTotal": 15.75,
      "waitTime": 3,
      "status": "Completed",
      "server": "Alice Smith",
      "items": ["Espresso", "Croissant"],
      "paymentMethod": "Mobile",
      "satisfaction": 5,
      "notes": "Daily regular, takeaway order"
    },
    {
      "id": "V005",
      "customerId": "CUST005",
      "customerName": "Lisa Garcia",
      "date": "2024-01-15",
      "time": "7:45 PM",
      "table": "Table 3",
      "partySize": 2,
      "duration": 85,
      "orderTotal": 89.90,
      "waitTime": 15,
      "status": "Completed",
      "server": "Diana Lee",
      "items": ["Steak", "Salad", "Wine", "Dessert"],
      "paymentMethod": "Card",
      "satisfaction": 4,
      "notes": "Anniversary dinner"
    }
  ];
  
  final List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "3months"},
    {"label": "This Year", "value": "year"}
  ];
  
  final List<Map<String, dynamic>> customerOptions = [
    {"label": "All Customers", "value": ""},
    {"label": "Sarah Johnson", "value": "CUST001"},
    {"label": "Michael Chen", "value": "CUST002"},
    {"label": "Emma Wilson", "value": "CUST003"},
    {"label": "David Rodriguez", "value": "CUST004"},
    {"label": "Lisa Garcia", "value": "CUST005"}
  ];
  
  final List<Map<String, dynamic>> tableOptions = [
    {"label": "All Tables", "value": ""},
    {"label": "Table 1-5", "value": "1-5"},
    {"label": "Table 6-10", "value": "6-10"},
    {"label": "Table 11-15", "value": "11-15"},
    {"label": "Counter", "value": "counter"},
    {"label": "Outdoor", "value": "outdoor"}
  ];
  
  final List<Map<String, dynamic>> metricOptions = [
    {"label": "Total Visits", "value": "visits"},
    {"label": "Revenue", "value": "revenue"},
    {"label": "Average Duration", "value": "duration"},
    {"label": "Table Turnover", "value": "turnover"},
    {"label": "Customer Satisfaction", "value": "satisfaction"}
  ];
  
  final List<Map<String, dynamic>> reportTypeOptions = [
    {"label": "Summary Report", "value": "summary"},
    {"label": "Detailed Report", "value": "detailed"},
    {"label": "Analytics Report", "value": "analytics"},
    {"label": "Comparison Report", "value": "comparison"}
  ];
  
  final List<Map<String, dynamic>> reportPeriodOptions = [
    {"label": "Daily", "value": "day"},
    {"label": "Weekly", "value": "week"},
    {"label": "Monthly", "value": "month"},
    {"label": "Quarterly", "value": "quarter"},
    {"label": "Yearly", "value": "year"}
  ];
  
  final List<Map<String, dynamic>> retentionOptions = [
    {"label": "6 Months", "value": "6months"},
    {"label": "1 Year", "value": "1year"},
    {"label": "2 Years", "value": "2years"},
    {"label": "5 Years", "value": "5years"}
  ];

  List<Map<String, dynamic>> get filteredVisits {
    return visitHistory.where((visit) {
      bool matchesCustomer = selectedCustomer.isEmpty || 
          visit["customerId"] == selectedCustomer;
      
      bool matchesStatus = !showCompletedOnly || 
          visit["status"] == "Completed";
      
      bool matchesTable = selectedTable.isEmpty ||
          (visit["table"] as String).toLowerCase().contains(selectedTable.toLowerCase());
      
      return matchesCustomer && matchesStatus && matchesTable;
    }).toList();
  }

  void _exportReport() {
    ss("Visit history report exported successfully");
  }
  
  void _generateReport() {
    ss("Report generated successfully");
  }
  
  void _saveSettings() {
    ss("Visit tracking settings saved successfully");
  }

  Widget _buildVisitHistory() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Timeframe",
                  items: timeframeOptions,
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Customer",
                  items: customerOptions,
                  value: selectedCustomer,
                  onChanged: (value, label) {
                    selectedCustomer = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Table/Area",
                  items: tableOptions,
                  value: selectedTable,
                  onChanged: (value, label) {
                    selectedTable = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  label: "Completed Only",
                  items: [
                    {
                      "label": "Show completed visits only",
                      "value": true,
                      "checked": showCompletedOnly,
                    }
                  ],
                  value: [if (showCompletedOnly) {"label": "Show completed visits only", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    showCompletedOnly = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              {
                "title": "Total Visits",
                "value": "${filteredVisits.length}",
                "icon": Icons.people,
                "color": primaryColor
              },
              {
                "title": "Avg Duration",
                "value": "${(filteredVisits.isEmpty ? 0 : filteredVisits.map((v) => v["duration"] as int).reduce((a, b) => a + b) / filteredVisits.length).toInt()} min",
                "icon": Icons.timer,
                "color": infoColor
              },
              {
                "title": "Total Revenue",
                "value": "\$${filteredVisits.isEmpty ? "0.00" : ((filteredVisits.map((v) => v["orderTotal"] as double).reduce((a, b) => a + b)).toStringAsFixed(2))}",
                "icon": Icons.attach_money,
                "color": successColor
              },
              {
                "title": "Avg Wait Time",
                "value": "${(filteredVisits.isEmpty ? 0 : filteredVisits.map((v) => v["waitTime"] as int).reduce((a, b) => a + b) / filteredVisits.length).toInt()} min",
                "icon": Icons.schedule,
                "color": warningColor
              }
            ].map((stat) => Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    stat["icon"] as IconData,
                    color: stat["color"] as Color,
                    size: 20,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${stat["value"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${stat["title"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )).toList(),
          ),
          
          // Export Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Export Visit History",
              icon: Icons.download,
              size: bs.sm,
              onPressed: _exportReport,
            ),
          ),
          
          // Visit List
          ...filteredVisits.map((visit) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: (visit["status"] as String) == "In Progress" 
                      ? warningColor.withAlpha(100)
                      : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${visit["customerName"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: (visit["status"] as String) == "Completed" ? successColor : warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${visit["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.event, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${visit["date"]} at ${visit["time"]}",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                      Spacer(),
                      Icon(Icons.table_restaurant, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${visit["table"]}",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.group, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Party of ${visit["partySize"]}",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                      Spacer(),
                      Icon(Icons.timer, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${visit["duration"]} minutes",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.person, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Server: ${visit["server"]}",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                      Spacer(),
                      Text(
                        "\$${(visit["orderTotal"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  
                  if ((visit["items"] as List).isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: secondaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Items Ordered:",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            (visit["items"] as List).join(", "),
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  if (visit["notes"] != null && (visit["notes"] as String).isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.note, size: 12, color: infoColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${visit["notes"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: infoColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  Row(
                    children: [
                      Icon(Icons.payment, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${visit["paymentMethod"]}",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                      if (visit["satisfaction"] != null) ...[
                        Spacer(),
                        Row(
                          children: List.generate(5, (index) => Icon(
                            index < (visit["satisfaction"] as int) ? Icons.star : Icons.star_border,
                            size: 12,
                            color: warningColor,
                          )),
                        ),
                      ],
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

  Widget _buildAnalytics() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Analytics Controls
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Date Range",
                  items: timeframeOptions,
                  value: analyticsDateRange,
                  onChanged: (value, label) {
                    analyticsDateRange = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Primary Metric",
                  items: metricOptions,
                  value: selectedMetric,
                  onChanged: (value, label) {
                    selectedMetric = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          // Key Metrics
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Key Performance Metrics",
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
                    {
                      "title": "Total Visits",
                      "value": "1,247",
                      "change": "+12%",
                      "positive": true,
                      "icon": Icons.people
                    },
                    {
                      "title": "Avg Visit Duration",
                      "value": "52 min",
                      "change": "+5%",
                      "positive": true,
                      "icon": Icons.timer
                    },
                    {
                      "title": "Table Turnover",
                      "value": "3.2x",
                      "change": "+8%",
                      "positive": true,
                      "icon": Icons.sync
                    },
                    {
                      "title": "Customer Satisfaction",
                      "value": "4.6/5",
                      "change": "+2%",
                      "positive": true,
                      "icon": Icons.star
                    }
                  ].map((metric) => Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (metric["positive"] as bool) ? successColor.withAlpha(10) : dangerColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: (metric["positive"] as bool) ? successColor.withAlpha(50) : dangerColor.withAlpha(50)
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          metric["icon"] as IconData,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${metric["value"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${metric["title"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${metric["change"]}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: (metric["positive"] as bool) ? successColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          
          // Peak Hours Analysis
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Peak Hours Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...[
                  {"time": "8:00 AM - 10:00 AM", "visits": 89, "percentage": 85},
                  {"time": "12:00 PM - 2:00 PM", "visits": 156, "percentage": 100},
                  {"time": "6:00 PM - 8:00 PM", "visits": 134, "percentage": 90},
                  {"time": "8:00 PM - 10:00 PM", "visits": 78, "percentage": 65}
                ].map((hour) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${hour["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${hour["visits"]} visits",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 6,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (hour["percentage"] as int) / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${hour["percentage"]}%",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
          
          // Table Performance
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Table Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 100,
                  children: [
                    {"table": "Table 1-5", "turnover": "3.5x", "revenue": "\$1,250"},
                    {"table": "Table 6-10", "turnover": "3.2x", "revenue": "\$1,180"},
                    {"table": "Table 11-15", "turnover": "2.8x", "revenue": "\$980"},
                    {"table": "Counter", "turnover": "5.1x", "revenue": "\$750"},
                    {"table": "Outdoor", "turnover": "2.5x", "revenue": "\$680"}
                  ].map((table) => Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: secondaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.table_restaurant, color: secondaryColor, size: 16),
                        SizedBox(height: spXs),
                        Text(
                          "${table["table"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${table["turnover"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ),
                        ),
                        Text(
                          "${table["revenue"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReports() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Report Configuration
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Generate Report",
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
                        label: "Report Type",
                        items: reportTypeOptions,
                        value: reportType,
                        onChanged: (value, label) {
                          reportType = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Period",
                        items: reportPeriodOptions,
                        value: reportPeriod,
                        onChanged: (value, label) {
                          reportPeriod = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                QSwitch(
                  label: "Include Analytics",
                  items: [
                    {
                      "label": "Include charts and analytics in report",
                      "value": true,
                      "checked": includeAnalytics,
                    }
                  ],
                  value: [if (includeAnalytics) {"label": "Include charts and analytics in report", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    includeAnalytics = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Generate Report",
                    icon: Icons.description,
                    size: bs.md,
                    onPressed: _generateReport,
                  ),
                ),
              ],
            ),
          ),
          
          // Recent Reports
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Recent Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...[
                  {
                    "name": "Monthly Visit Summary - January 2024",
                    "type": "Summary Report",
                    "date": "Jan 16, 2024",
                    "size": "2.1 MB",
                    "format": "PDF"
                  },
                  {
                    "name": "Table Performance Analysis - Q4 2023",
                    "type": "Analytics Report",
                    "date": "Jan 10, 2024",
                    "size": "3.5 MB",
                    "format": "Excel"
                  },
                  {
                    "name": "Customer Visit History - December 2023",
                    "type": "Detailed Report",
                    "date": "Jan 5, 2024",
                    "size": "4.2 MB",
                    "format": "PDF"
                  },
                  {
                    "name": "Peak Hours Comparison - 2023 vs 2022",
                    "type": "Comparison Report",
                    "date": "Jan 1, 2024",
                    "size": "1.8 MB",
                    "format": "Excel"
                  }
                ].map((report) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: secondaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        report["format"] == "PDF" ? Icons.picture_as_pdf : Icons.table_chart,
                        color: report["format"] == "PDF" ? dangerColor : successColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${report["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${report["type"]} • ${report["date"]} • ${report["size"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () {
                          ss("Report downloaded: ${report["name"]}");
                        },
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
          
          // Report Templates
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Report Templates",
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
                    {
                      "title": "Daily Summary",
                      "description": "Daily visit overview with key metrics",
                      "icon": Icons.today,
                      "color": primaryColor
                    },
                    {
                      "title": "Weekly Analysis",
                      "description": "Weekly trends and performance analysis",
                      "icon": Icons.date_range,
                      "color": successColor
                    },
                    {
                      "title": "Customer Insights",
                      "description": "Customer behavior and preferences",
                      "icon": Icons.insights,
                      "color": infoColor
                    },
                    {
                      "title": "Revenue Report",
                      "description": "Revenue analysis by time periods",
                      "icon": Icons.monetization_on,
                      "color": warningColor
                    }
                  ].map((template) => Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (template["color"] as Color).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: (template["color"] as Color).withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          template["icon"] as IconData,
                          color: template["color"] as Color,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${template["title"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${template["description"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Use Template",
                            size: bs.sm,
                            onPressed: () {
                              ss("Template selected: ${template["title"]}");
                            },
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Tracking Settings
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Visit Tracking Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QSwitch(
                  label: "Visit Duration Tracking",
                  items: [
                    {
                      "label": "Track how long customers stay at tables",
                      "value": true,
                      "checked": trackVisitDuration,
                    }
                  ],
                  value: [if (trackVisitDuration) {"label": "Track how long customers stay at tables", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    trackVisitDuration = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  label: "Table Turnover Tracking",
                  items: [
                    {
                      "label": "Monitor table availability and turnover rates",
                      "value": true,
                      "checked": trackTableTurnover,
                    }
                  ],
                  value: [if (trackTableTurnover) {"label": "Monitor table availability and turnover rates", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    trackTableTurnover = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  label: "Waiting Time Tracking",
                  items: [
                    {
                      "label": "Track customer waiting time before seating",
                      "value": true,
                      "checked": trackWaitingTime,
                    }
                  ],
                  value: [if (trackWaitingTime) {"label": "Track customer waiting time before seating", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    trackWaitingTime = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  label: "Real-time Updates",
                  items: [
                    {
                      "label": "Enable real-time visit status updates",
                      "value": true,
                      "checked": realTimeUpdates,
                    }
                  ],
                  value: [if (realTimeUpdates) {"label": "Enable real-time visit status updates", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    realTimeUpdates = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Data Retention
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Data Management",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QDropdownField(
                  label: "Data Retention Period",
                  items: retentionOptions,
                  value: retentionPeriod,
                  onChanged: (value, label) {
                    retentionPeriod = value;
                    setState(() {});
                  },
                ),
                
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: warningColor.withAlpha(50)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Visit history older than the retention period will be automatically archived.",
                          style: TextStyle(
                            fontSize: 11,
                            color: warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Performance Monitoring
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Performance Monitoring",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 120,
                  children: [
                    {
                      "title": "Database Size",
                      "value": "245 MB",
                      "icon": Icons.storage,
                      "color": infoColor
                    },
                    {
                      "title": "Active Records",
                      "value": "12,456",
                      "icon": Icons.description,
                      "color": primaryColor
                    },
                    {
                      "title": "Archived Records",
                      "value": "3,789",
                      "icon": Icons.archive,
                      "color": disabledBoldColor
                    },
                    {
                      "title": "Last Backup",
                      "value": "2 hours ago",
                      "icon": Icons.backup,
                      "color": successColor
                    }
                  ].map((metric) => Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (metric["color"] as Color).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          metric["icon"] as IconData,
                          color: metric["color"] as Color,
                          size: 20,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${metric["value"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${metric["title"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          
          // Save Settings
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Settings",
              size: bs.md,
              onPressed: _saveSettings,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Visit History",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Reports", icon: Icon(Icons.description)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildVisitHistory(),
        _buildAnalytics(),
        _buildReports(),
        _buildSettings(),
      ],
    );
  }
}
