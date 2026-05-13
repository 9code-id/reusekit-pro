import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaAuditTrailView extends StatefulWidget {
  const LcaAuditTrailView({super.key});

  @override
  State<LcaAuditTrailView> createState() => _LcaAuditTrailViewState();
}

class _LcaAuditTrailViewState extends State<LcaAuditTrailView> {
  int currentTab = 0;

  final List<Map<String, dynamic>> auditStats = [
    {
      "title": "Total Activities",
      "value": "2,847",
      "icon": Icons.sports,
      "color": "#3B82F6",
      "change": "+12%",
      "period": "This Month"
    },
    {
      "title": "User Actions",
      "value": "1,923",
      "icon": Icons.person_outline,
      "color": "#10B981",
      "change": "+8%",
      "period": "This Month"
    },
    {
      "title": "System Events",
      "value": "924",
      "icon": Icons.computer,
      "color": "#F59E0B",
      "change": "+15%",
      "period": "This Month"
    },
    {
      "title": "Failed Attempts",
      "value": "23",
      "icon": Icons.error_outline,
      "color": "#EF4444",
      "change": "-5%",
      "period": "This Month"
    }
  ];

  final List<Map<String, dynamic>> recentActivities = [
    {
      "id": "AUD-001",
      "user": "John Smith",
      "action": "User Login",
      "resource": "Authentication System",
      "timestamp": "2024-06-15 14:30:25",
      "ipAddress": "192.168.1.101",
      "status": "Success",
      "risk": "Low"
    },
    {
      "id": "AUD-002",
      "user": "Sarah Johnson",
      "action": "Document Access",
      "resource": "Confidential File X",
      "timestamp": "2024-06-15 14:25:18",
      "ipAddress": "192.168.1.102",
      "status": "Success",
      "risk": "Medium"
    },
    {
      "id": "AUD-003",
      "user": "Mike Wilson",
      "action": "Permission Change",
      "resource": "User Management",
      "timestamp": "2024-06-15 14:20:45",
      "ipAddress": "192.168.1.103",
      "status": "Success",
      "risk": "High"
    },
    {
      "id": "AUD-004",
      "user": "Unknown",
      "action": "Failed Login",
      "resource": "Authentication System",
      "timestamp": "2024-06-15 14:15:33",
      "ipAddress": "203.45.67.89",
      "status": "Failed",
      "risk": "High"
    },
    {
      "id": "AUD-005",
      "user": "Emma Davis",
      "action": "Data Export",
      "resource": "Customer Database",
      "timestamp": "2024-06-15 14:10:12",
      "ipAddress": "192.168.1.104",
      "status": "Success",
      "risk": "Medium"
    }
  ];

  final List<Map<String, dynamic>> systemEvents = [
    {
      "id": "SYS-001",
      "event": "System Backup",
      "description": "Automated daily backup completed successfully",
      "timestamp": "2024-06-15 02:00:00",
      "status": "Completed",
      "duration": "45 minutes",
      "type": "Backup"
    },
    {
      "id": "SYS-002",
      "event": "Security Update",
      "description": "Critical security patches applied",
      "timestamp": "2024-06-15 01:30:00",
      "status": "Completed",
      "duration": "15 minutes",
      "type": "Security"
    },
    {
      "id": "SYS-003",
      "event": "Database Maintenance",
      "description": "Routine database optimization performed",
      "timestamp": "2024-06-14 23:00:00",
      "status": "Completed",
      "duration": "30 minutes",
      "type": "Maintenance"
    },
    {
      "id": "SYS-004",
      "event": "Server Restart",
      "description": "Scheduled server restart for updates",
      "timestamp": "2024-06-14 22:00:00",
      "status": "Completed",
      "duration": "5 minutes",
      "type": "System"
    }
  ];

  final List<Map<String, dynamic>> auditReports = [
    {
      "title": "Daily Activity Report",
      "type": "Activity",
      "date": "2024-06-15",
      "events": 342,
      "status": "Generated",
      "size": "2.4 MB"
    },
    {
      "title": "Weekly Security Summary",
      "type": "Security",
      "date": "2024-06-14",
      "events": 1847,
      "status": "Available",
      "size": "8.1 MB"
    },
    {
      "title": "Monthly Compliance Report",
      "type": "Compliance",
      "date": "2024-06-01",
      "events": 12435,
      "status": "Archived",
      "size": "24.7 MB"
    },
    {
      "title": "User Access Report",
      "type": "Access",
      "date": "2024-06-10",
      "events": 923,
      "status": "Available",
      "size": "3.2 MB"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Audit Trail",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Activities", icon: Icon(Icons.timeline)),
        Tab(text: "System Events", icon: Icon(Icons.settings)),
        Tab(text: "Reports", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildActivitiesTab(),
        _buildSystemEventsTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.timeline,
                  size: 48,
                  color: Colors.white,
                ),
                Text(
                  "Audit Trail System",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Comprehensive activity monitoring and logging",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(180),
                  ),
                ),
              ],
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: auditStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spMd),
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
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Color(int.parse("0xFF${stat["color"].substring(1)}")),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            stat["icon"],
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (stat["change"].toString().contains('+') ? successColor : dangerColor).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${stat["change"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: stat["change"].toString().contains('+') ? successColor : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${stat["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${stat["value"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${stat["period"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
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
                  "Recent Critical Activities",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...recentActivities.take(5).map((activity) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 3,
                          color: activity["risk"] == "High" 
                              ? dangerColor
                              : activity["risk"] == "Medium"
                                  ? warningColor
                                  : successColor,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${activity["user"]} - ${activity["action"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${activity["resource"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${activity["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: activity["risk"] == "High" 
                                ? dangerColor.withAlpha(20)
                                : activity["risk"] == "Medium"
                                    ? warningColor.withAlpha(20)
                                    : successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${activity["risk"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: activity["risk"] == "High" 
                                  ? dangerColor
                                  : activity["risk"] == "Medium"
                                      ? warningColor
                                      : successColor,
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
    );
  }

  Widget _buildActivitiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search activities...",
                  value: "",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...recentActivities.map((activity) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: activity["status"] == "Failed" 
                        ? dangerColor
                        : activity["risk"] == "High"
                            ? dangerColor
                            : activity["risk"] == "Medium"
                                ? warningColor
                                : successColor,
                  ),
                ),
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
                              "${activity["id"]} - ${activity["action"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "User: ${activity["user"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: activity["status"] == "Failed" 
                              ? dangerColor.withAlpha(20)
                              : successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${activity["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: activity["status"] == "Failed" ? dangerColor : successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.folder,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Resource: ${activity["resource"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Timestamp: ${activity["timestamp"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.computer,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "IP Address: ${activity["ipAddress"]}",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: activity["risk"] == "High" 
                              ? dangerColor.withAlpha(20)
                              : activity["risk"] == "Medium"
                                  ? warningColor.withAlpha(20)
                                  : successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Risk: ${activity["risk"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: activity["risk"] == "High" 
                                ? dangerColor
                                : activity["risk"] == "Medium"
                                    ? warningColor
                                    : successColor,
                          ),
                        ),
                      ),
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
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSystemEventsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search system events...",
                  value: "",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.backup,
                      size: 32,
                      color: Colors.white,
                    ),
                    Text(
                      "Backups",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "3 Today",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.security,
                      size: 32,
                      color: Colors.white,
                    ),
                    Text(
                      "Security",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "5 Updates",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.build,
                      size: 32,
                      color: Colors.white,
                    ),
                    Text(
                      "Maintenance",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "2 Tasks",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ...systemEvents.map((event) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: event["type"] == "Security" 
                        ? dangerColor
                        : event["type"] == "Maintenance"
                            ? warningColor
                            : event["type"] == "Backup"
                                ? successColor
                                : infoColor,
                  ),
                ),
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
                              "${event["id"]} - ${event["event"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${event["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: event["type"] == "Security" 
                              ? dangerColor.withAlpha(20)
                              : event["type"] == "Maintenance"
                                  ? warningColor.withAlpha(20)
                                  : event["type"] == "Backup"
                                      ? successColor.withAlpha(20)
                                      : infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${event["type"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: event["type"] == "Security" 
                                ? dangerColor
                                : event["type"] == "Maintenance"
                                    ? warningColor
                                    : event["type"] == "Backup"
                                        ? successColor
                                        : infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Timestamp",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${event["timestamp"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Duration",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${event["duration"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Status",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${event["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
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
          }).toList(),
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
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search reports...",
                  value: "",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Export All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: auditReports.map((report) {
              return Container(
                padding: EdgeInsets.all(spMd),
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
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.description,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: report["status"] == "Generated" || report["status"] == "Available"
                                ? successColor.withAlpha(20)
                                : infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${report["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: report["status"] == "Generated" || report["status"] == "Available"
                                  ? successColor
                                  : infoColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${report["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${report["type"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Events",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${report["events"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "File Size",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${report["size"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${report["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        QButton(
                          label: "Download",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
