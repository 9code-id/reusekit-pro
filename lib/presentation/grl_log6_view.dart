import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLog6View extends StatefulWidget {
  @override
  State<GrlLog6View> createState() => _GrlLog6ViewState();
}

class _GrlLog6ViewState extends State<GrlLog6View> {
  String searchQuery = "";
  String selectedAction = "All";
  String selectedUser = "All";
  String selectedTimeRange = "Today";
  String selectedModule = "All";

  List<Map<String, dynamic>> actions = [
    {"label": "All", "value": "All"},
    {"label": "Login", "value": "Login"},
    {"label": "Logout", "value": "Logout"},
    {"label": "Create", "value": "Create"},
    {"label": "Update", "value": "Update"},
    {"label": "Delete", "value": "Delete"},
    {"label": "View", "value": "View"},
  ];

  List<Map<String, dynamic>> users = [
    {"label": "All", "value": "All"},
    {"label": "Admin", "value": "Admin"},
    {"label": "John Doe", "value": "John Doe"},
    {"label": "Jane Smith", "value": "Jane Smith"},
    {"label": "System", "value": "System"},
  ];

  List<Map<String, dynamic>> timeRanges = [
    {"label": "Today", "value": "Today"},
    {"label": "Yesterday", "value": "Yesterday"},
    {"label": "Last 7 days", "value": "Last 7 days"},
    {"label": "Last 30 days", "value": "Last 30 days"},
  ];

  List<Map<String, dynamic>> modules = [
    {"label": "All", "value": "All"},
    {"label": "User Management", "value": "User Management"},
    {"label": "Product Management", "value": "Product Management"},
    {"label": "Order Management", "value": "Order Management"},
    {"label": "System Settings", "value": "System Settings"},
  ];

  List<Map<String, dynamic>> auditTrails = [
    {
      "id": 1,
      "timestamp": "2024-01-15 14:30:25",
      "user": "John Doe",
      "action": "Update",
      "module": "User Management",
      "target": "User Profile",
      "target_id": "USER_12345",
      "old_value": "Email: john.old@email.com",
      "new_value": "Email: john.new@email.com",
      "ip_address": "192.168.1.105",
      "user_agent": "Chrome 120.0",
      "risk_level": "Low"
    },
    {
      "id": 2,
      "timestamp": "2024-01-15 14:25:15",
      "user": "Admin",
      "action": "Delete",
      "module": "Product Management",
      "target": "Product",
      "target_id": "PROD_67890",
      "old_value": "Product: Premium Widget",
      "new_value": null,
      "ip_address": "192.168.1.100",
      "user_agent": "Firefox 121.0",
      "risk_level": "High"
    },
    {
      "id": 3,
      "timestamp": "2024-01-15 14:20:45",
      "user": "Jane Smith",
      "action": "Create",
      "module": "Order Management",
      "target": "Order",
      "target_id": "ORD_11111",
      "old_value": null,
      "new_value": "Order Total: \$299.99",
      "ip_address": "192.168.1.110",
      "user_agent": "Safari 17.2",
      "risk_level": "Medium"
    },
    {
      "id": 4,
      "timestamp": "2024-01-15 14:15:30",
      "user": "System",
      "action": "Update",
      "module": "System Settings",
      "target": "Configuration",
      "target_id": "CONFIG_001",
      "old_value": "Max Login Attempts: 3",
      "new_value": "Max Login Attempts: 5",
      "ip_address": "127.0.0.1",
      "user_agent": "System Process",
      "risk_level": "Medium"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audit Trail"),
        actions: [
          IconButton(
            icon: Icon(Icons.security),
            onPressed: () {
              // Security settings
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export audit trail
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search audit trail...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),

            // Filter Row 1
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Action",
                    items: actions,
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
                    items: users,
                    value: selectedUser,
                    onChanged: (value, label) {
                      selectedUser = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Filter Row 2
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Module",
                    items: modules,
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
                    label: "Time Range",
                    items: timeRanges,
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
              minItemWidth: 150,
              children: [
                _buildStatCard("Total Actions", "4,567", Icons.timeline, primaryColor),
                _buildStatCard("High Risk", "45", Icons.security, dangerColor),
                _buildStatCard("Active Users", "23", Icons.people, successColor),
                _buildStatCard("Today's Actions", "156", Icons.today, infoColor),
              ],
            ),

            // Audit Trail List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        topRight: Radius.circular(radiusLg),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.security, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Recent Audit Trail",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${auditTrails.length} Entries",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: auditTrails.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final audit = auditTrails[index];
                      return _buildAuditItem(audit);
                    },
                  ),
                ],
              ),
            ),

            // Export Options
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export CSV",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {
                      // Export CSV
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Generate Report",
                    icon: Icons.assessment,
                    size: bs.md,
                    onPressed: () {
                      // Generate report
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditItem(Map<String, dynamic> audit) {
    Color riskColor = _getRiskColor(audit["risk_level"]);
    IconData actionIcon = _getActionIcon(audit["action"]);
    
    return ExpansionTile(
      tilePadding: EdgeInsets.all(spSm),
      childrenPadding: EdgeInsets.all(spSm),
      leading: Container(
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: riskColor.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusXs),
        ),
        child: Icon(actionIcon, color: riskColor, size: 18),
      ),
      title: Text(
        "${audit["user"]} performed ${audit["action"]} on ${audit["target"]}",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: riskColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${audit["risk_level"]} Risk",
                  style: TextStyle(
                    fontSize: 10,
                    color: riskColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${audit["module"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 12, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${audit["timestamp"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.computer, size: 12, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${audit["ip_address"]}",
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
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Text(
                    "Target ID:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${audit["target_id"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "User Agent:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${audit["user_agent"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              if (audit["old_value"] != null) ...[
                Text(
                  "Previous Value:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${audit["old_value"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
                    ),
                  ),
                ),
              ],
              if (audit["new_value"] != null) ...[
                Text(
                  "New Value:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${audit["new_value"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                    ),
                  ),
                ),
              ],
              Row(
                children: [
                  QButton(
                    label: "Flag",
                    icon: Icons.flag,
                    size: bs.sm,
                    onPressed: () {
                      // Flag audit entry
                    },
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Investigate",
                    icon: Icons.search,
                    size: bs.sm,
                    onPressed: () {
                      // Start investigation
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getActionIcon(String action) {
    switch (action) {
      case "Login":
        return Icons.login;
      case "Logout":
        return Icons.logout;
      case "Create":
        return Icons.add;
      case "Update":
        return Icons.edit;
      case "Delete":
        return Icons.delete;
      case "View":
        return Icons.visibility;
      default:
        return Icons.timeline;
    }
  }
}
