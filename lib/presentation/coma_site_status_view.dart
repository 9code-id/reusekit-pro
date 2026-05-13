import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaSiteStatusView extends StatefulWidget {
  const ComaSiteStatusView({super.key});

  @override
  State<ComaSiteStatusView> createState() => _ComaSiteStatusViewState();
}

class _ComaSiteStatusViewState extends State<ComaSiteStatusView> {
  String selectedSite = "downtown_office";
  String selectedFilter = "all";

  List<Map<String, dynamic>> sites = [
    {"label": "Downtown Office - Site A", "value": "downtown_office"},
    {"label": "Residential Villa - Site B", "value": "residential_villa"},
    {"label": "Mall Renovation - Site C", "value": "mall_renovation"},
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Issues", "value": "issues"},
    {"label": "Completed", "value": "completed"},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> siteActivities = [
      {
        "title": "Foundation Inspection",
        "status": "completed",
        "time": "09:15 AM",
        "inspector": "Mike Johnson",
        "location": "Building A - Level B1",
        "notes": "Foundation structure meets all safety requirements",
        "priority": "high",
      },
      {
        "title": "Electrical Installation",
        "status": "in_progress",
        "time": "11:30 AM",
        "worker": "Sarah Chen",
        "location": "Building A - Floor 5",
        "progress": 75,
        "priority": "medium",
      },
      {
        "title": "Safety Equipment Check",
        "status": "pending",
        "time": "02:00 PM",
        "inspector": "David Wilson",
        "location": "Site Perimeter",
        "dueTime": "02:30 PM",
        "priority": "high",
      },
      {
        "title": "Concrete Delivery",
        "status": "issue",
        "time": "08:45 AM",
        "issue": "Delayed due to traffic",
        "location": "Main Entrance",
        "expectedTime": "10:00 AM",
        "priority": "high",
      },
    ];

    List<Map<String, dynamic>> weatherData = [
      {"time": "Now", "temp": 72, "condition": "Sunny", "icon": Icons.wb_sunny},
      {"time": "12 PM", "temp": 75, "condition": "Partly Cloudy", "icon": Icons.wb_cloudy},
      {"time": "3 PM", "temp": 73, "condition": "Cloudy", "icon": Icons.cloud},
      {"time": "6 PM", "temp": 69, "condition": "Clear", "icon": Icons.wb_sunny},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Site Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh site status
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Site and Filter Selection
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QDropdownField(
                    label: "Select Site",
                    items: sites,
                    value: selectedSite,
                    onChanged: (value, label) {
                      selectedSite = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Filter",
                    items: statusFilters,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Site Overview Cards
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 150,
              children: [
                _buildStatusCard(
                  "Active Workers",
                  "28",
                  Icons.people,
                  primaryColor,
                  subtitle: "On site today",
                ),
                _buildStatusCard(
                  "Safety Score",
                  "94%",
                  Icons.security,
                  successColor,
                  subtitle: "Last 7 days",
                ),
                _buildStatusCard(
                  "Equipment",
                  "12 Active",
                  Icons.construction,
                  infoColor,
                  subtitle: "2 in maintenance",
                ),
                _buildStatusCard(
                  "Issues",
                  "3 Open",
                  Icons.warning,
                  warningColor,
                  subtitle: "1 critical",
                ),
              ],
            ),

            // Weather Conditions
            Container(
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
                      Icon(
                        Icons.wb_sunny,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Weather Conditions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QHorizontalScroll(
                    children: weatherData.map((weather) {
                      return Container(
                        width: 100,
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(right: spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Text(
                              "${weather["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Icon(
                              weather["icon"],
                              color: primaryColor,
                              size: 24,
                            ),
                            Text(
                              "${weather["temp"]}°F",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${weather["condition"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Live Site Activities
            Container(
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
                      Icon(
                        Icons.timeline,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Live Site Activities",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Live",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: siteActivities.map((activity) {
                      Color statusColor = _getStatusColor(activity["status"]);
                      IconData statusIcon = _getStatusIcon(activity["status"]);

                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: statusColor.withAlpha(30)),
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  statusIcon,
                                  color: statusColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${activity["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor(activity["priority"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${activity["priority"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _getPriorityColor(activity["priority"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: disabledBoldColor,
                                  size: 12,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${activity["time"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.location_on,
                                  color: disabledBoldColor,
                                  size: 12,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${activity["location"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (activity["inspector"] != null)
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: disabledBoldColor,
                                    size: 12,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Inspector: ${activity["inspector"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            if (activity["worker"] != null)
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: disabledBoldColor,
                                    size: 12,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Worker: ${activity["worker"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            if (activity["progress"] != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Progress: ${activity["progress"]}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  LinearProgressIndicator(
                                    value: (activity["progress"] as int) / 100,
                                    backgroundColor: disabledColor,
                                    valueColor: AlwaysStoppedAnimation(statusColor),
                                  ),
                                ],
                              ),
                            if (activity["notes"] != null)
                              Text(
                                "${activity["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            if (activity["issue"] != null)
                              Text(
                                "Issue: ${activity["issue"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Quick Actions
            Container(
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
                    "Site Actions",
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
                          label: "Check-in",
                          icon: Icons.location_on,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Report Issue",
                          icon: Icons.report_problem,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Safety Log",
                          icon: Icons.security,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Emergency",
                          icon: Icons.emergency,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String value, IconData icon, Color color, {String? subtitle}) {
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return primaryColor;
      case "pending":
        return warningColor;
      case "issue":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "in_progress":
        return Icons.timer;
      case "pending":
        return Icons.schedule;
      case "issue":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
