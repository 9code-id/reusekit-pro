import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmDiscrepancyReportsView extends StatefulWidget {
  const IwmDiscrepancyReportsView({super.key});

  @override
  State<IwmDiscrepancyReportsView> createState() => _IwmDiscrepancyReportsViewState();
}

class _IwmDiscrepancyReportsViewState extends State<IwmDiscrepancyReportsView> {
  int selectedTab = 0;
  String selectedWarehouse = "all";
  String selectedSeverity = "all";
  String selectedDateRange = "last_30_days";
  
  List<Map<String, dynamic>> warehouses = [
    {"label": "All Warehouses", "value": "all"},
    {"label": "Main Warehouse", "value": "main"},
    {"label": "Secondary Warehouse", "value": "secondary"},
    {"label": "Distribution Center", "value": "distribution"},
  ];
  
  List<Map<String, dynamic>> severityOptions = [
    {"label": "All Severity", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];
  
  List<Map<String, dynamic>> dateRanges = [
    {"label": "Last 7 Days", "value": "last_7_days"},
    {"label": "Last 30 Days", "value": "last_30_days"},
    {"label": "Last 90 Days", "value": "last_90_days"},
    {"label": "Custom Range", "value": "custom"},
  ];
  
  List<Map<String, dynamic>> discrepancySummary = [
    {
      "title": "Total Discrepancies",
      "value": 234,
      "subtitle": "Last 30 Days",
      "icon": Icons.warning,
      "color": dangerColor
    },
    {
      "title": "Critical Issues",
      "value": 18,
      "subtitle": "Require Action",
      "icon": Icons.error,
      "color": dangerColor
    },
    {
      "title": "Resolved",
      "value": 189,
      "subtitle": "80.8% Resolution",
      "icon": Icons.check_circle,
      "color": successColor
    },
    {
      "title": "Pending Review",
      "value": 27,
      "subtitle": "Need Attention",
      "icon": Icons.schedule,
      "color": warningColor
    },
  ];
  
  List<Map<String, dynamic>> discrepancyReports = [
    {
      "id": "DR-2024-001",
      "countId": "PC-2024-001",
      "warehouse": "Main Warehouse",
      "location": "Zone A1-B3",
      "severity": "Critical",
      "totalDiscrepancies": 15,
      "valueImpact": 12500.0,
      "reportDate": "2024-01-15",
      "status": "Under Investigation",
      "assignedTo": "John Smith",
      "items": [
        {"sku": "SKU-001", "shortage": 5, "value": 2500.0},
        {"sku": "SKU-002", "overage": 3, "value": 1800.0},
        {"sku": "SKU-003", "shortage": 7, "value": 8200.0},
      ]
    },
    {
      "id": "DR-2024-002",
      "countId": "PC-2024-003",
      "warehouse": "Distribution Center",
      "location": "Zone B2-C1",
      "severity": "High",
      "totalDiscrepancies": 8,
      "valueImpact": 3200.0,
      "reportDate": "2024-01-12",
      "status": "Resolved",
      "assignedTo": "Sarah Johnson",
      "items": [
        {"sku": "SKU-004", "shortage": 2, "value": 800.0},
        {"sku": "SKU-005", "overage": 4, "value": 1600.0},
        {"sku": "SKU-006", "shortage": 2, "value": 800.0},
      ]
    },
    {
      "id": "DR-2024-003",
      "countId": "PC-2024-002",
      "warehouse": "Secondary Warehouse",
      "location": "Zone C3-D1",
      "severity": "Medium",
      "totalDiscrepancies": 12,
      "valueImpact": 1800.0,
      "reportDate": "2024-01-10",
      "status": "Pending Review",
      "assignedTo": "Mike Chen",
      "items": [
        {"sku": "SKU-007", "shortage": 6, "value": 900.0},
        {"sku": "SKU-008", "overage": 6, "value": 900.0},
      ]
    },
  ];
  
  List<Map<String, dynamic>> actionItems = [
    {
      "reportId": "DR-2024-001",
      "action": "Physical Recount",
      "priority": "High",
      "assignedTo": "John Smith",
      "dueDate": "2024-01-20",
      "status": "In Progress",
      "description": "Perform physical recount of high-value items"
    },
    {
      "reportId": "DR-2024-001",
      "action": "Process Investigation",
      "priority": "Medium",
      "assignedTo": "Sarah Johnson",
      "dueDate": "2024-01-22",
      "status": "Pending",
      "description": "Review receiving and shipping processes"
    },
    {
      "reportId": "DR-2024-003",
      "action": "System Reconciliation",
      "priority": "Low",
      "assignedTo": "Mike Chen",
      "dueDate": "2024-01-25",
      "status": "Completed",
      "description": "Update system quantities based on count"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Discrepancy Reports",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Reports", icon: Icon(Icons.report)),
        Tab(text: "Actions", icon: Icon(Icons.task)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildReportsTab(),
        _buildActionsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          _buildDiscrepancySummary(),
          _buildTrendChart(),
          _buildTopDiscrepancyCategories(),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportFilters(),
          _buildReportsList(),
        ],
      ),
    );
  }

  Widget _buildActionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActionFilters(),
          _buildActionItemsList(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
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
              Expanded(
                child: QDropdownField(
                  label: "Warehouse",
                  items: warehouses,
                  value: selectedWarehouse,
                  onChanged: (value, label) {
                    selectedWarehouse = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Severity",
                  items: severityOptions,
                  value: selectedSeverity,
                  onChanged: (value, label) {
                    selectedSeverity = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Date Range",
            items: dateRanges,
            value: selectedDateRange,
            onChanged: (value, label) {
              selectedDateRange = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReportFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QDropdownField(
              label: "Warehouse",
              items: warehouses,
              value: selectedWarehouse,
              onChanged: (value, label) {
                selectedWarehouse = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.file_download,
            label: "Export",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QDropdownField(
              label: "Priority",
              items: [
                {"label": "All Priorities", "value": "all"},
                {"label": "High", "value": "high"},
                {"label": "Medium", "value": "medium"},
                {"label": "Low", "value": "low"},
              ],
              value: "all",
              onChanged: (value, label) {
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.add_task,
            label: "New Action",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildDiscrepancySummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Discrepancy Summary",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: discrepancySummary.map((summary) => _buildSummaryCard(summary)).toList(),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(Map<String, dynamic> summary) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (summary["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  summary["icon"],
                  color: summary["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${summary["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${summary["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${summary["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendChart() {
    return Container(
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
          Text(
            "Discrepancy Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.trending_up,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Trend Chart",
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

  Widget _buildTopDiscrepancyCategories() {
    List<Map<String, dynamic>> categories = [
      {"category": "High-Value Items", "count": 45, "percentage": 35.2},
      {"category": "Fast-Moving Items", "count": 38, "percentage": 29.7},
      {"category": "Seasonal Items", "count": 29, "percentage": 22.7},
      {"category": "Bulk Items", "count": 16, "percentage": 12.4},
    ];

    return Container(
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
          Text(
            "Top Discrepancy Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...categories.map((category) => _buildCategoryItem(category)),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${category["category"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${category["count"]} discrepancies",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${(category["percentage"] as double).toStringAsFixed(1)}%",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsList() {
    return Column(
      spacing: spSm,
      children: discrepancyReports.map((report) => _buildReportCard(report)).toList(),
    );
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    Color severityColor = _getSeverityColor(report["severity"]);
    Color statusColor = _getStatusColor(report["status"]);
    
    return Container(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${report["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${report["warehouse"]} • ${report["location"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: severityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${report["severity"]}",
                      style: TextStyle(
                        color: severityColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${report["status"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Count ID: ${report["countId"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Assigned to: ${report["assignedTo"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Report Date: ${report["reportDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${report["totalDiscrepancies"]}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  Text(
                    "Discrepancies",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${((report["valueImpact"] as double).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Top Affected Items:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...(report["items"] as List).take(3).map((item) => Text(
                  "• ${item["sku"]}: ${item.containsKey("shortage") ? "-${item["shortage"]}" : "+${item["overage"]}"} units (\$${((item["value"] as double).toDouble()).currency})",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                )),
              ],
            ),
          ),
          Row(
            children: [
              Spacer(),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionItemsList() {
    return Column(
      spacing: spSm,
      children: actionItems.map((action) => _buildActionCard(action)).toList(),
    );
  }

  Widget _buildActionCard(Map<String, dynamic> action) {
    Color priorityColor = _getPriorityColor(action["priority"]);
    Color statusColor = _getActionStatusColor(action["status"]);
    
    return Container(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${action["action"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Report: ${action["reportId"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${action["priority"]}",
                      style: TextStyle(
                        color: priorityColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${action["status"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "${action["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Assigned to: ${action["assignedTo"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Due Date: ${action["dueDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Update",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'under investigation':
        return warningColor;
      case 'resolved':
        return successColor;
      case 'pending review':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getActionStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'in progress':
        return warningColor;
      case 'completed':
        return successColor;
      case 'pending':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
