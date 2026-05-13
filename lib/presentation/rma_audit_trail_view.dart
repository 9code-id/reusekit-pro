import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaAuditTrailView extends StatefulWidget {
  const RmaAuditTrailView({Key? key}) : super(key: key);

  @override
  State<RmaAuditTrailView> createState() => _RmaAuditTrailViewState();
}

class _RmaAuditTrailViewState extends State<RmaAuditTrailView> {
  String selectedAction = "all";
  String selectedUser = "all";
  String selectedPeriod = "week";
  bool loading = false;

  List<Map<String, dynamic>> actionFilters = [
    {"label": "All Actions", "value": "all"},
    {"label": "Created", "value": "created"},
    {"label": "Updated", "value": "updated"},
    {"label": "Deleted", "value": "deleted"},
    {"label": "Approved", "value": "approved"},
    {"label": "Rejected", "value": "rejected"},
  ];

  List<Map<String, dynamic>> userFilters = [
    {"label": "All Users", "value": "all"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Michael Chen", "value": "michael_chen"},
    {"label": "Emma Rodriguez", "value": "emma_rodriguez"},
    {"label": "David Thompson", "value": "david_thompson"},
  ];

  List<Map<String, dynamic>> periodFilters = [
    {"label": "Last Week", "value": "week"},
    {"label": "Last Month", "value": "month"},
    {"label": "Last Quarter", "value": "quarter"},
    {"label": "Last Year", "value": "year"},
  ];

  List<Map<String, dynamic>> auditLogs = [
    {
      "id": "AL001",
      "timestamp": "2025-06-17 14:30:25",
      "user": "Sarah Johnson",
      "userRole": "RMA Manager",
      "action": "approved",
      "entity": "RMA Request",
      "entityId": "RMA-2025-0156",
      "description": "Approved refund request for damaged product",
      "ipAddress": "192.168.1.45",
      "userAgent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
      "changes": {
        "status": {"from": "pending", "to": "approved"},
        "approvedBy": {"from": null, "to": "Sarah Johnson"},
        "approvalDate": {"from": null, "to": "2025-06-17"}
      },
      "riskLevel": "medium",
    },
    {
      "id": "AL002",
      "timestamp": "2025-06-17 13:45:12",
      "user": "Michael Chen",
      "userRole": "Quality Inspector",
      "action": "created",
      "entity": "Inspection Report",
      "entityId": "INS-2025-0234",
      "description": "Created new product inspection report",
      "ipAddress": "192.168.1.67",
      "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)",
      "changes": {
        "inspectionDate": {"from": null, "to": "2025-06-17"},
        "inspector": {"from": null, "to": "Michael Chen"},
        "status": {"from": null, "to": "completed"}
      },
      "riskLevel": "low",
    },
    {
      "id": "AL003",
      "timestamp": "2025-06-17 12:20:08",
      "user": "Emma Rodriguez",
      "userRole": "Customer Service",
      "action": "updated",
      "entity": "Customer Information",
      "entityId": "CUST-2025-1234",
      "description": "Updated customer contact information",
      "ipAddress": "192.168.1.23",
      "userAgent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
      "changes": {
        "email": {"from": "old@email.com", "to": "new@email.com"},
        "phone": {"from": "+1234567890", "to": "+1987654321"}
      },
      "riskLevel": "low",
    },
    {
      "id": "AL004",
      "timestamp": "2025-06-17 11:15:33",
      "user": "David Thompson",
      "userRole": "System Admin",
      "action": "deleted",
      "entity": "User Account",
      "entityId": "USER-2025-0789",
      "description": "Deleted inactive user account",
      "ipAddress": "192.168.1.12",
      "userAgent": "Mozilla/5.0 (Linux; Ubuntu)",
      "changes": {
        "status": {"from": "inactive", "to": "deleted"},
        "deletedBy": {"from": null, "to": "David Thompson"},
        "deletionReason": {"from": null, "to": "Account cleanup"}
      },
      "riskLevel": "high",
    },
    {
      "id": "AL005",
      "timestamp": "2025-06-17 10:30:45",
      "user": "Sarah Johnson",
      "userRole": "RMA Manager",
      "action": "rejected",
      "entity": "RMA Request",
      "entityId": "RMA-2025-0157",
      "description": "Rejected return request due to policy violation",
      "ipAddress": "192.168.1.45",
      "userAgent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
      "changes": {
        "status": {"from": "pending", "to": "rejected"},
        "rejectionReason": {"from": null, "to": "Beyond return window"}
      },
      "riskLevel": "medium",
    },
  ];

  List<Map<String, dynamic>> securityEvents = [
    {
      "timestamp": "2025-06-17 09:45:12",
      "event": "Failed Login Attempt",
      "user": "unknown",
      "ipAddress": "203.45.67.89",
      "severity": "medium",
      "details": "Multiple failed login attempts from suspicious IP",
    },
    {
      "timestamp": "2025-06-17 08:30:25",
      "event": "Privilege Escalation",
      "user": "John Doe",
      "ipAddress": "192.168.1.56",
      "severity": "high",
      "details": "User attempted to access admin-only functions",
    },
    {
      "timestamp": "2025-06-17 07:15:08",
      "event": "Data Export",
      "user": "Emma Rodriguez",
      "ipAddress": "192.168.1.23",
      "severity": "low",
      "details": "Exported customer data for monthly report",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audit Trail"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () => _exportAuditLog(),
          ),
          IconButton(
            icon: Icon(Icons.security),
            onPressed: () => _viewSecurityReport(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            SizedBox(height: spLg),
            _buildAuditSummary(),
            SizedBox(height: spLg),
            _buildAuditLogs(),
            SizedBox(height: spLg),
            _buildSecurityEvents(),
            SizedBox(height: spLg),
            _buildComplianceReport(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
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
          Text(
            "Audit Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Action Type",
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
          SizedBox(height: spMd),
          QDropdownField(
            label: "Time Period",
            items: periodFilters,
            value: selectedPeriod,
            onChanged: (value, label) {
              selectedPeriod = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAuditSummary() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Total Events",
          "${auditLogs.length}",
          Icons.event_note,
          primaryColor,
          "Last 7 days",
        ),
        _buildSummaryCard(
          "High Risk Actions",
          "3",
          Icons.warning,
          dangerColor,
          "Requires attention",
        ),
        _buildSummaryCard(
          "Active Users",
          "12",
          Icons.people,
          successColor,
          "Currently logged in",
        ),
        _buildSummaryCard(
          "Security Alerts",
          "2",
          Icons.security,
          warningColor,
          "Last 24 hours",
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color, String subtitle) {
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
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
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

  Widget _buildAuditLogs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => _viewAllLogs(),
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        ...auditLogs.map((log) => _buildAuditLogCard(log)).toList(),
      ],
    );
  }

  Widget _buildAuditLogCard(Map<String, dynamic> log) {
    Color actionColor = _getActionColor(log["action"]);
    Color riskColor = _getRiskColor(log["riskLevel"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: riskColor,
          ),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                    decoration: BoxDecoration(
                      color: actionColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${log["action"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: actionColor,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "${log["entity"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${log["timestamp"]}".substring(11, 16),
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Text(
                "${log["description"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Row(
                children: [
                  Icon(Icons.person, size: 14, color: primaryColor),
                  SizedBox(width: 4),
                  Text(
                    "${log["user"]} (${log["userRole"]})",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Icon(Icons.badge, size: 14, color: disabledBoldColor),
                  SizedBox(width: 4),
                  Text(
                    "${log["entityId"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem("IP Address", "${log["ipAddress"]}"),
                      ),
                      Expanded(
                        child: _buildDetailItem("Risk Level", "${log["riskLevel"]}".toUpperCase()),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Changes Made:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...((log["changes"] as Map<String, dynamic>).entries.map((change) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "${change.key}:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${change.value["from"] ?? "null"}",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(Icons.arrow_forward, size: 12, color: disabledBoldColor),
                          SizedBox(width: spSm),
                          Text(
                            "${change.value["to"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Color _getActionColor(String action) {
    switch (action) {
      case "created":
        return successColor;
      case "updated":
        return infoColor;
      case "deleted":
        return dangerColor;
      case "approved":
        return successColor;
      case "rejected":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildSecurityEvents() {
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
              Text(
                "Security Events",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _viewSecurityReport(),
                child: Text(
                  "View Report",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: dangerColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...securityEvents.map((event) => _buildSecurityEventCard(event)).toList(),
        ],
      ),
    );
  }

  Widget _buildSecurityEventCard(Map<String, dynamic> event) {
    Color severityColor = _getSeverityColor(event["severity"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: severityColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: severityColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: severityColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(Icons.security, color: severityColor, size: 20),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${event["event"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${event["details"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "User: ${event["user"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "IP: ${event["ipAddress"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
            decoration: BoxDecoration(
              color: severityColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${event["severity"]}".toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: severityColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildComplianceReport() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Icon(Icons.assessment, color: primaryColor, size: 32),
              SizedBox(height: spSm),
              Text(
                "Generate Report",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spXs),
              Text(
                "Create comprehensive audit reports",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Generate",
                  size: bs.sm,
                  onPressed: () => _generateReport(),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Icon(Icons.archive, color: successColor, size: 32),
              SizedBox(height: spSm),
              Text(
                "Archive Logs",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spXs),
              Text(
                "Archive old audit logs for compliance",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Archive",
                  size: bs.sm,
                  onPressed: () => _archiveLogs(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _exportAuditLog() {
    ss("Audit log exported successfully");
  }

  void _viewSecurityReport() {
    si("Opening security report");
  }

  void _viewAllLogs() {
    si("Opening complete audit logs");
  }

  void _generateReport() {
    si("Generating compliance report");
  }

  void _archiveLogs() {
    si("Archiving old audit logs");
  }
}
