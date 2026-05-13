import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmInventoryAuditsView extends StatefulWidget {
  const IwmInventoryAuditsView({super.key});

  @override
  State<IwmInventoryAuditsView> createState() => _IwmInventoryAuditsViewState();
}

class _IwmInventoryAuditsViewState extends State<IwmInventoryAuditsView> {
  int selectedTab = 0;
  String selectedWarehouse = "all";
  String selectedAuditType = "all";
  String selectedStatus = "all";
  
  List<Map<String, dynamic>> warehouses = [
    {"label": "All Warehouses", "value": "all"},
    {"label": "Main Warehouse", "value": "main"},
    {"label": "Secondary Warehouse", "value": "secondary"},
    {"label": "Distribution Center", "value": "distribution"},
  ];
  
  List<Map<String, dynamic>> auditTypes = [
    {"label": "All Types", "value": "all"},
    {"label": "Full Audit", "value": "full"},
    {"label": "Cycle Count", "value": "cycle"},
    {"label": "Spot Check", "value": "spot"},
    {"label": "ABC Analysis", "value": "abc"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Planned", "value": "planned"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Cancelled", "value": "cancelled"},
  ];
  
  List<Map<String, dynamic>> auditSummary = [
    {
      "title": "Total Audits",
      "value": 58,
      "subtitle": "This Year",
      "icon": Icons.assignment,
      "color": primaryColor
    },
    {
      "title": "In Progress",
      "value": 8,
      "subtitle": "Active Audits",
      "icon": Icons.schedule,
      "color": warningColor
    },
    {
      "title": "Completed",
      "value": 45,
      "subtitle": "77.6% Complete",
      "icon": Icons.check_circle,
      "color": successColor
    },
    {
      "title": "Accuracy Rate",
      "value": 94.5,
      "subtitle": "% Average",
      "icon": Icons.gps_fixed,
      "color": infoColor
    },
  ];
  
  List<Map<String, dynamic>> inventoryAudits = [
    {
      "id": "IA-2024-001",
      "type": "Full Audit",
      "warehouse": "Main Warehouse",
      "zones": ["A1-A5", "B1-B3", "C1-C2"],
      "status": "In Progress",
      "plannedDate": "2024-01-15",
      "startDate": "2024-01-15",
      "endDate": null,
      "progress": 0.65,
      "auditTeam": ["John Smith", "Sarah Johnson", "Mike Chen"],
      "totalItems": 2500,
      "auditedItems": 1625,
      "discrepancies": 23,
      "accuracyRate": 98.6,
      "estimatedCompletion": "2024-01-20"
    },
    {
      "id": "IA-2024-002",
      "type": "Cycle Count",
      "warehouse": "Distribution Center",
      "zones": ["Zone A"],
      "status": "Completed",
      "plannedDate": "2024-01-10",
      "startDate": "2024-01-10",
      "endDate": "2024-01-12",
      "progress": 1.0,
      "auditTeam": ["Emily Davis", "Alex Rodriguez"],
      "totalItems": 850,
      "auditedItems": 850,
      "discrepancies": 8,
      "accuracyRate": 99.1,
      "estimatedCompletion": null
    },
    {
      "id": "IA-2024-003",
      "type": "Spot Check",
      "warehouse": "Secondary Warehouse",
      "zones": ["High Value Zone"],
      "status": "Planned",
      "plannedDate": "2024-01-25",
      "startDate": null,
      "endDate": null,
      "progress": 0.0,
      "auditTeam": ["Lisa Wang"],
      "totalItems": 150,
      "auditedItems": 0,
      "discrepancies": 0,
      "accuracyRate": 0.0,
      "estimatedCompletion": "2024-01-26"
    },
  ];
  
  List<Map<String, dynamic>> auditFindings = [
    {
      "auditId": "IA-2024-001",
      "finding": "Systematic shortage in Zone A2",
      "severity": "High",
      "category": "Process Issue",
      "description": "Consistent shortage of fast-moving items suggests receiving process issue",
      "itemsAffected": 15,
      "valueImpact": 8500.0,
      "recommendation": "Review receiving procedures and implement additional controls",
      "status": "Open",
      "assignedTo": "John Smith"
    },
    {
      "auditId": "IA-2024-001",
      "finding": "Inventory location errors",
      "severity": "Medium",
      "category": "Data Accuracy",
      "description": "Items found in different locations than system records",
      "itemsAffected": 8,
      "valueImpact": 1200.0,
      "recommendation": "Implement barcode scanning for location tracking",
      "status": "In Progress",
      "assignedTo": "Sarah Johnson"
    },
    {
      "auditId": "IA-2024-002",
      "finding": "Minor quantity discrepancies",
      "severity": "Low",
      "category": "Count Variance",
      "description": "Small quantity differences within acceptable tolerance",
      "itemsAffected": 8,
      "valueImpact": 320.0,
      "recommendation": "Continue regular cycle counts",
      "status": "Closed",
      "assignedTo": "Emily Davis"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Inventory Audits",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Audits", icon: Icon(Icons.assignment)),
        Tab(text: "Findings", icon: Icon(Icons.search)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAuditsTab(),
        _buildFindingsTab(),
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
          _buildAuditSummary(),
          _buildAuditSchedule(),
          _buildAccuracyTrends(),
        ],
      ),
    );
  }

  Widget _buildAuditsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAuditFilters(),
          _buildAuditsList(),
        ],
      ),
    );
  }

  Widget _buildFindingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFindingFilters(),
          _buildFindingsList(),
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
                  label: "Audit Type",
                  items: auditTypes,
                  value: selectedAuditType,
                  onChanged: (value, label) {
                    selectedAuditType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Status",
            items: statusOptions,
            value: selectedStatus,
            onChanged: (value, label) {
              selectedStatus = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAuditFilters() {
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
            icon: Icons.add,
            label: "Schedule Audit",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFindingFilters() {
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
              label: "Severity",
              items: [
                {"label": "All Severity", "value": "all"},
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
            icon: Icons.file_download,
            label: "Export",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAuditSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Audit Summary",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: auditSummary.map((summary) => _buildSummaryCard(summary)).toList(),
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
            summary["value"] is double ? "${(summary["value"] as double).toStringAsFixed(1)}" : "${summary["value"]}",
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

  Widget _buildAuditSchedule() {
    List<Map<String, dynamic>> upcomingAudits = [
      {"date": "2024-01-25", "type": "Spot Check", "warehouse": "Secondary Warehouse"},
      {"date": "2024-02-01", "type": "Cycle Count", "warehouse": "Main Warehouse"},
      {"date": "2024-02-10", "type": "Full Audit", "warehouse": "Distribution Center"},
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
            "Upcoming Audits",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...upcomingAudits.map((audit) => _buildScheduleItem(audit)),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(Map<String, dynamic> audit) {
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
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: infoColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${audit["type"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${audit["warehouse"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${audit["date"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccuracyTrends() {
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
            "Accuracy Trends",
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
                    "Accuracy Trends Chart",
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

  Widget _buildAuditsList() {
    return Column(
      spacing: spSm,
      children: inventoryAudits.map((audit) => _buildAuditCard(audit)).toList(),
    );
  }

  Widget _buildAuditCard(Map<String, dynamic> audit) {
    Color statusColor = _getStatusColor(audit["status"]);
    
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
                      "${audit["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${audit["type"]} • ${audit["warehouse"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${audit["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                  ),
                ),
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
                      "Zones: ${(audit["zones"] as List).join(", ")}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Team: ${(audit["auditTeam"] as List).join(", ")}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Planned: ${audit["plannedDate"]}",
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
                    "${audit["auditedItems"]}/${audit["totalItems"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${((audit["progress"] as double) * 100).toStringAsFixed(0)}% Complete",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  if (audit["accuracyRate"] > 0)
                    Text(
                      "${(audit["accuracyRate"] as double).toStringAsFixed(1)}% Accuracy",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                ],
              ),
            ],
          ),
          if (audit["discrepancies"] > 0)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    size: 16,
                    color: dangerColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${audit["discrepancies"]} discrepancies found",
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
                    ),
                  ),
                ],
              ),
            ),
          if (audit["progress"] > 0 && audit["progress"] < 1)
            Row(
              children: [
                Container(
                  width: double.infinity,
                  height: 4,
                  child: LinearProgressIndicator(
                    value: audit["progress"],
                    backgroundColor: disabledOutlineBorderColor,
                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  ),
                ),
              ],
            ),
          Row(
            children: [
              if (audit["estimatedCompletion"] != null)
                Text(
                  "Est. completion: ${audit["estimatedCompletion"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
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

  Widget _buildFindingsList() {
    return Column(
      spacing: spSm,
      children: auditFindings.map((finding) => _buildFindingCard(finding)).toList(),
    );
  }

  Widget _buildFindingCard(Map<String, dynamic> finding) {
    Color severityColor = _getSeverityColor(finding["severity"]);
    Color statusColor = _getFindingStatusColor(finding["status"]);
    
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
                      "${finding["finding"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Audit: ${finding["auditId"]} • ${finding["category"]}",
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
                      "${finding["severity"]}",
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
                      "${finding["status"]}",
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
            "${finding["description"]}",
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
                      "Items Affected: ${finding["itemsAffected"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Value Impact: \$${((finding["valueImpact"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Assigned to: ${finding["assignedTo"]}",
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
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recommendation:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${finding["recommendation"]}",
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
              Spacer(),
              QButton(
                label: "Update Status",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'planned':
        return infoColor;
      case 'in progress':
        return warningColor;
      case 'completed':
        return successColor;
      case 'cancelled':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
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

  Color _getFindingStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return dangerColor;
      case 'in progress':
        return warningColor;
      case 'closed':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
