import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmAuditTrailsView extends StatefulWidget {
  const IwmAuditTrailsView({super.key});

  @override
  State<IwmAuditTrailsView> createState() => _IwmAuditTrailsViewState();
}

class _IwmAuditTrailsViewState extends State<IwmAuditTrailsView> {
  int selectedTab = 0;
  String selectedAction = "all";
  String selectedUser = "all";
  String selectedModule = "all";
  String dateRange = "last_7_days";
  
  List<Map<String, dynamic>> actionFilters = [
    {"label": "All Actions", "value": "all"},
    {"label": "Create", "value": "create"},
    {"label": "Update", "value": "update"},
    {"label": "Delete", "value": "delete"},
    {"label": "Login", "value": "login"},
    {"label": "Export", "value": "export"},
  ];
  
  List<Map<String, dynamic>> userFilters = [
    {"label": "All Users", "value": "all"},
    {"label": "Admin Users", "value": "admin"},
    {"label": "Regular Users", "value": "regular"},
    {"label": "System", "value": "system"},
  ];
  
  List<Map<String, dynamic>> moduleFilters = [
    {"label": "All Modules", "value": "all"},
    {"label": "Inventory", "value": "inventory"},
    {"label": "Orders", "value": "orders"},
    {"label": "Users", "value": "users"},
    {"label": "Reports", "value": "reports"},
    {"label": "Settings", "value": "settings"},
  ];
  
  List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "Last 7 Days", "value": "last_7_days"},
    {"label": "Last 30 Days", "value": "last_30_days"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "Last 6 Months", "value": "last_6_months"},
    {"label": "This Year", "value": "this_year"},
  ];
  
  List<Map<String, dynamic>> auditLogs = [
    {
      "id": "AUD-2024-001",
      "timestamp": "2024-01-15 10:30:25",
      "user": "John Smith",
      "userRole": "Admin",
      "action": "Create",
      "module": "Inventory",
      "resource": "Product",
      "resourceId": "PRD-001",
      "description": "Created new product 'iPhone 15 Pro'",
      "ipAddress": "192.168.1.100",
      "userAgent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
      "status": "Success",
      "details": {
        "name": "iPhone 15 Pro",
        "category": "Electronics",
        "price": 999.99,
        "stock": 50
      }
    },
    {
      "id": "AUD-2024-002",
      "timestamp": "2024-01-15 10:25:18",
      "user": "Sarah Johnson",
      "userRole": "Manager",
      "action": "Update",
      "module": "Orders",
      "resource": "Order",
      "resourceId": "ORD-2024-001",
      "description": "Updated order status to 'Shipped'",
      "ipAddress": "192.168.1.101",
      "userAgent": "Mozilla/5.0 (Mac OS X 10.15.7)",
      "status": "Success",
      "details": {
        "old_status": "Processing",
        "new_status": "Shipped",
        "tracking_number": "TRK123456789"
      }
    },
    {
      "id": "AUD-2024-003",
      "timestamp": "2024-01-15 10:20:12",
      "user": "Mike Chen",
      "userRole": "Staff",
      "action": "Delete",
      "module": "Inventory",
      "resource": "Product",
      "resourceId": "PRD-999",
      "description": "Attempted to delete product 'Test Product'",
      "ipAddress": "192.168.1.102",
      "userAgent": "Mozilla/5.0 (Linux; Ubuntu)",
      "status": "Failed",
      "details": {
        "error": "Insufficient permissions",
        "reason": "User does not have delete permissions"
      }
    },
    {
      "id": "AUD-2024-004",
      "timestamp": "2024-01-15 09:45:30",
      "user": "System",
      "userRole": "System",
      "action": "Export",
      "module": "Reports",
      "resource": "Inventory Report",
      "resourceId": "RPT-INV-2024-001",
      "description": "Automated inventory report generation",
      "ipAddress": "127.0.0.1",
      "userAgent": "System/1.0",
      "status": "Success",
      "details": {
        "format": "PDF",
        "records": 1250,
        "file_size": "2.4 MB"
      }
    },
    {
      "id": "AUD-2024-005",
      "timestamp": "2024-01-15 09:30:15",
      "user": "Emily Davis",
      "userRole": "Staff",
      "action": "Login",
      "module": "Authentication",
      "resource": "User",
      "resourceId": "USR-005",
      "description": "User login successful",
      "ipAddress": "192.168.1.103",
      "userAgent": "Mozilla/5.0 (iPhone; iOS 17.0)",
      "status": "Success",
      "details": {
        "login_method": "Password",
        "session_id": "SES-123456",
        "device_type": "Mobile"
      }
    },
  ];
  
  List<Map<String, dynamic>> securityEvents = [
    {
      "id": "SEC-2024-001",
      "timestamp": "2024-01-15 11:15:42",
      "type": "Failed Login",
      "severity": "Medium",
      "user": "unknown@example.com",
      "ipAddress": "203.0.113.5",
      "description": "Multiple failed login attempts",
      "details": "5 consecutive failed login attempts within 10 minutes",
      "action_taken": "IP temporarily blocked"
    },
    {
      "id": "SEC-2024-002",
      "timestamp": "2024-01-15 08:22:15",
      "type": "Permission Escalation",
      "severity": "High",
      "user": "Mike Chen",
      "ipAddress": "192.168.1.102",
      "description": "Attempted unauthorized access to admin functions",
      "details": "User tried to access user management without proper permissions",
      "action_taken": "Access denied, admin notified"
    },
    {
      "id": "SEC-2024-003",
      "timestamp": "2024-01-14 16:45:30",
      "type": "Data Export",
      "severity": "Low",
      "user": "Sarah Johnson",
      "ipAddress": "192.168.1.101",
      "description": "Large data export performed",
      "details": "Exported 10,000 customer records",
      "action_taken": "Export logged for compliance"
    },
  ];
  
  List<Map<String, dynamic>> complianceReports = [
    {
      "period": "January 2024",
      "total_events": 1247,
      "critical_events": 3,
      "failed_logins": 25,
      "data_exports": 15,
      "permission_changes": 8,
      "compliance_score": 98.5,
      "status": "Compliant"
    },
    {
      "period": "December 2023",
      "total_events": 1156,
      "critical_events": 1,
      "failed_logins": 18,
      "data_exports": 22,
      "permission_changes": 12,
      "compliance_score": 99.2,
      "status": "Compliant"
    },
    {
      "period": "November 2023",
      "total_events": 1089,
      "critical_events": 5,
      "failed_logins": 31,
      "data_exports": 19,
      "permission_changes": 6,
      "compliance_score": 97.8,
      "status": "Compliant"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Audit Trails",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Activity Logs", icon: Icon(Icons.list)),
        Tab(text: "Security Events", icon: Icon(Icons.security)),
        Tab(text: "Compliance", icon: Icon(Icons.verified)),
      ],
      tabChildren: [
        _buildActivityLogsTab(),
        _buildSecurityEventsTab(),
        _buildComplianceTab(),
      ],
    );
  }

  Widget _buildActivityLogsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLogFilters(),
          _buildLogStatistics(),
          _buildAuditLogsList(),
        ],
      ),
    );
  }

  Widget _buildSecurityEventsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSecurityFilters(),
          _buildSecurityStats(),
          _buildSecurityEventsList(),
        ],
      ),
    );
  }

  Widget _buildComplianceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildComplianceOverview(),
          _buildComplianceReports(),
          _buildComplianceActions(),
        ],
      ),
    );
  }

  Widget _buildLogFilters() {
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
                  label: "Action",
                  items: actionFilters,
                  value: selectedAction,
                  onChanged: (value, label) {
                    selectedAction = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "User",
                  items: userFilters,
                  value: selectedUser,
                  onChanged: (value, label) {
                    selectedUser = value;
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
                  label: "Module",
                  items: moduleFilters,
                  value: selectedModule,
                  onChanged: (value, label) {
                    selectedModule = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Date Range",
                  items: dateRangeOptions,
                  value: dateRange,
                  onChanged: (value, label) {
                    dateRange = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(child: Container()),
              QButton(
                icon: Icons.search,
                label: "Apply Filters",
                size: bs.sm,
                onPressed: () {
                  _applyFilters();
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.download,
                label: "Export",
                size: bs.sm,
                onPressed: () {
                  _exportLogs();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogStatistics() {
    List<Map<String, dynamic>> stats = [
      {
        "title": "Total Events",
        "value": "1,247",
        "subtitle": "Last 30 days",
        "icon": Icons.timeline,
        "color": primaryColor
      },
      {
        "title": "User Actions",
        "value": "892",
        "subtitle": "71.5% of total",
        "icon": Icons.person,
        "color": successColor
      },
      {
        "title": "System Events",
        "value": "355",
        "subtitle": "28.5% of total",
        "icon": Icons.settings,
        "color": infoColor
      },
      {
        "title": "Failed Actions",
        "value": "23",
        "subtitle": "1.8% failure rate",
        "icon": Icons.error,
        "color": dangerColor
      },
    ];

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: stats.map((stat) => _buildStatCard(stat)).toList(),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
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
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"],
                  color: stat["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditLogsList() {
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
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...auditLogs.map((log) => _buildAuditLogItem(log)),
        ],
      ),
    );
  }

  Widget _buildAuditLogItem(Map<String, dynamic> log) {
    Color statusColor = _getStatusColor(log["status"]);
    Color actionColor = _getActionColor(log["action"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: actionColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${log["action"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: actionColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${log["module"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${log["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${log["user"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "(${log["userRole"]})",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${log["timestamp"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
          Text(
            "${log["description"]}",
            style: TextStyle(
              fontSize: 13,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Text(
                "IP: ${log["ipAddress"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Resource: ${log["resource"]} (${log["resourceId"]})",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  _showLogDetails(log);
                },
                child: Text(
                  "View Details",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityFilters() {
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
              label: "Date Range",
              items: dateRangeOptions,
              value: dateRange,
              onChanged: (value, label) {
                dateRange = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.filter_list,
            label: "Filter",
            size: bs.sm,
            onPressed: () {
              _applySecurityFilters();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityStats() {
    List<Map<String, dynamic>> securityStats = [
      {
        "title": "Security Events",
        "value": "47",
        "subtitle": "Last 30 days",
        "icon": Icons.security,
        "color": warningColor
      },
      {
        "title": "Failed Logins",
        "value": "25",
        "subtitle": "53% of events",
        "icon": Icons.login,
        "color": dangerColor
      },
      {
        "title": "Blocked IPs",
        "value": "8",
        "subtitle": "Auto-blocked",
        "icon": Icons.block,
        "color": dangerColor
      },
      {
        "title": "Security Score",
        "value": "94%",
        "subtitle": "Good standing",
        "icon": Icons.shield,
        "color": successColor
      },
    ];

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: securityStats.map((stat) => _buildStatCard(stat)).toList(),
    );
  }

  Widget _buildSecurityEventsList() {
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
            "Security Events",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...securityEvents.map((event) => _buildSecurityEventItem(event)),
        ],
      ),
    );
  }

  Widget _buildSecurityEventItem(Map<String, dynamic> event) {
    Color severityColor = _getSeverityColor(event["severity"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: severityColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: severityColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: severityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${event["severity"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: severityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "${event["type"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${event["timestamp"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
          Text(
            "${event["description"]}",
            style: TextStyle(
              fontSize: 13,
              color: primaryColor,
            ),
          ),
          Text(
            "${event["details"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Text(
                "User: ${event["user"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "IP: ${event["ipAddress"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              Text(
                "Action: ${event["action_taken"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceOverview() {
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
            "Compliance Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildComplianceCard(
                "Overall Score",
                "98.5%",
                "Excellent compliance",
                successColor,
                Icons.verified,
              ),
              _buildComplianceCard(
                "Data Retention",
                "100%",
                "All requirements met",
                successColor,
                Icons.storage,
              ),
              _buildComplianceCard(
                "Access Controls",
                "97%",
                "Minor improvements needed",
                warningColor,
                Icons.security,
              ),
              _buildComplianceCard(
                "Audit Frequency",
                "Daily",
                "Automated auditing",
                successColor,
                Icons.schedule,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceCard(String title, String value, String subtitle, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceReports() {
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
            "Monthly Compliance Reports",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...complianceReports.map((report) => _buildComplianceReportItem(report)),
        ],
      ),
    );
  }

  Widget _buildComplianceReportItem(Map<String, dynamic> report) {
    Color statusColor = report["compliance_score"] >= 95 ? successColor : warningColor;
    
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
                Row(
                  children: [
                    Text(
                      "${report["period"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${report["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    _buildReportStat("Events", "${report["total_events"]}"),
                    _buildReportStat("Critical", "${report["critical_events"]}"),
                    _buildReportStat("Failed Logins", "${report["failed_logins"]}"),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "Compliance Score: ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${report["compliance_score"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              _downloadComplianceReport(report["period"]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReportStat(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceActions() {
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
            "Compliance Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Generate Report",
                  icon: Icons.assessment,
                  size: bs.md,
                  onPressed: () {
                    _generateComplianceReport();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Schedule Audit",
                  icon: Icons.schedule,
                  size: bs.md,
                  onPressed: () {
                    _scheduleAudit();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'success':
        return successColor;
      case 'failed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getActionColor(String action) {
    switch (action.toLowerCase()) {
      case 'create':
        return successColor;
      case 'update':
        return infoColor;
      case 'delete':
        return dangerColor;
      case 'login':
        return primaryColor;
      case 'export':
        return warningColor;
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

  void _applyFilters() {
    ss("Filters applied successfully");
    setState(() {});
  }

  void _exportLogs() {
    ss("Exporting audit logs...");
  }

  void _showLogDetails(Map<String, dynamic> log) {
    // Show detailed log information
  }

  void _applySecurityFilters() {
    ss("Security filters applied");
    setState(() {});
  }

  void _downloadComplianceReport(String period) {
    ss("Downloading compliance report for $period...");
  }

  void _generateComplianceReport() {
    ss("Generating compliance report...");
  }

  void _scheduleAudit() {
    ss("Scheduling audit...");
  }
}
