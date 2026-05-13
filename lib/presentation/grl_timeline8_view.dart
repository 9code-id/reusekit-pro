import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTimeline8View extends StatefulWidget {
  @override
  State<GrlTimeline8View> createState() => _GrlTimeline8ViewState();
}

class _GrlTimeline8ViewState extends State<GrlTimeline8View> {
  List<Map<String, dynamic>> workflowSteps = [
    {
      "id": "1",
      "title": "Request Submitted",
      "description": "Employee submitted a vacation request for approval",
      "timestamp": "2024-01-20T09:15:00Z",
      "status": "completed",
      "assignee": {
        "name": "John Smith",
        "role": "Employee",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=employee",
        "department": "Engineering"
      },
      "actions": ["Submitted Form", "Uploaded Documents"],
      "duration": "5 minutes",
      "priority": "normal"
    },
    {
      "id": "2",
      "title": "Manager Review",
      "description": "Direct manager reviewing the vacation request details",
      "timestamp": "2024-01-20T10:30:00Z",
      "status": "completed",
      "assignee": {
        "name": "Sarah Johnson",
        "role": "Team Manager",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=manager",
        "department": "Engineering"
      },
      "actions": ["Reviewed Request", "Checked Team Schedule", "Approved"],
      "duration": "15 minutes",
      "priority": "normal"
    },
    {
      "id": "3",
      "title": "HR Verification",
      "description": "HR department verifying available vacation days and policy compliance",
      "timestamp": "2024-01-20T14:20:00Z",
      "status": "in_progress",
      "assignee": {
        "name": "Lisa Chen",
        "role": "HR Specialist",
        "avatar": "https://picsum.photos/40/40?random=3&keyword=hr",
        "department": "Human Resources"
      },
      "actions": ["Checking Balance", "Policy Review"],
      "duration": "Ongoing",
      "priority": "normal"
    },
    {
      "id": "4",
      "title": "Final Approval",
      "description": "Department head provides final approval for the vacation request",
      "timestamp": null,
      "status": "pending",
      "assignee": {
        "name": "Michael Rodriguez",
        "role": "Department Head",
        "avatar": "https://picsum.photos/40/40?random=4&keyword=director",
        "department": "Engineering"
      },
      "actions": [],
      "duration": "Pending",
      "priority": "normal"
    },
    {
      "id": "5",
      "title": "System Update",
      "description": "Automatic system update to reflect approved vacation in calendar",
      "timestamp": null,
      "status": "pending",
      "assignee": {
        "name": "Automated System",
        "role": "System Process",
        "avatar": "https://picsum.photos/40/40?random=5&keyword=system",
        "department": "IT"
      },
      "actions": [],
      "duration": "Instant",
      "priority": "low"
    },
    {
      "id": "6",
      "title": "Notification Sent",
      "description": "Email confirmation sent to employee and team members",
      "timestamp": null,
      "status": "pending",
      "assignee": {
        "name": "Notification Service",
        "role": "Email System",
        "avatar": "https://picsum.photos/40/40?random=6&keyword=notification",
        "department": "IT"
      },
      "actions": [],
      "duration": "Instant",
      "priority": "low"
    }
  ];

  String requestId = "REQ-2024-001234";
  String requestType = "Vacation Request";

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return warningColor;
      case "pending":
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "normal":
        return warningColor;
      case "low":
      default:
        return infoColor;
    }
  }

  IconData _getStepIcon(String title) {
    switch (title.toLowerCase()) {
      case "request submitted":
        return Icons.send;
      case "manager review":
        return Icons.person;
      case "hr verification":
        return Icons.verified_user;
      case "final approval":
        return Icons.approval;
      case "system update":
        return Icons.update;
      case "notification sent":
        return Icons.notifications;
      default:
        return Icons.circle;
    }
  }

  String _formatTimestamp(String? timestamp) {
    if (timestamp == null) return "";
    DateTime dateTime = DateTime.parse(timestamp);
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  String _getStatusText(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "in_progress":
        return "In Progress";
      case "pending":
        return "Pending";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workflow Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Workflow Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, infoColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_tree,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              requestType,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Request ID: $requestId",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Workflow Progress",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spXs),
                              LinearProgressIndicator(
                                value: 0.33,
                                backgroundColor: Colors.white.withAlpha(60),
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "2/6",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Workflow Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "2",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "1",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "In Progress",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.pending,
                          color: disabledBoldColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "3",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Workflow Timeline
            Text(
              "Workflow Steps",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            ...workflowSteps.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> step = entry.value;
              bool isLast = index == workflowSteps.length - 1;

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline Indicator
                    Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _getStatusColor("${step["status"]}"),
                            shape: BoxShape.circle,
                            boxShadow: [shadowSm],
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          child: Icon(
                            _getStepIcon("${step["title"]}"),
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        if (!isLast)
                          Container(
                            width: 3,
                            height: 80,
                            color: step["status"] == "completed"
                                ? successColor.withAlpha(150)
                                : Colors.grey.shade300,
                            margin: EdgeInsets.symmetric(vertical: spSm),
                          ),
                      ],
                    ),

                    SizedBox(width: spMd),

                    // Step Content
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                          border: step["status"] == "in_progress"
                              ? Border.all(
                                  color: warningColor.withAlpha(100),
                                  width: 2,
                                )
                              : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Step Header
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${step["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor("${step["status"]}").withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    _getStatusText("${step["status"]}"),
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: _getStatusColor("${step["status"]}"),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spXs),

                            // Timestamp
                            if (step["timestamp"] != null)
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    _formatTimestamp(step["timestamp"] as String?),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),

                            SizedBox(height: spSm),

                            // Description
                            Text(
                              "${step["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),

                            SizedBox(height: spMd),

                            // Assignee Information
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundImage: NetworkImage("${(step["assignee"] as Map)["avatar"]}"),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${(step["assignee"] as Map)["name"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "${(step["assignee"] as Map)["role"]} • ${(step["assignee"] as Map)["department"]}",
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
                                          color: _getPriorityColor("${step["priority"]}").withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${step["priority"]}".toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            color: _getPriorityColor("${step["priority"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        size: 14,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Duration: ${step["duration"]}",
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

                            // Actions Taken
                            if ((step["actions"] as List).isNotEmpty) ...[
                              SizedBox(height: spMd),
                              Text(
                                "Actions Taken:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              ...(step["actions"] as List).map((action) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: spXs),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline,
                                        size: 14,
                                        color: successColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "$action",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],

                            // Action Buttons
                            if (step["status"] == "in_progress") ...[
                              SizedBox(height: spMd),
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "View Details",
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.message,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spLg),

            // Quick Actions
            Container(
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Send Reminder",
                          size: bs.md,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Cancel Request",
                          size: bs.md,
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
}
