import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmWorkOrderManagementView extends StatefulWidget {
  const FsmWorkOrderManagementView({super.key});

  @override
  State<FsmWorkOrderManagementView> createState() => _FsmWorkOrderManagementViewState();
}

class _FsmWorkOrderManagementViewState extends State<FsmWorkOrderManagementView> {
  int currentTab = 0;
  String selectedFilter = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> filterItems = [
    {"label": "All Orders", "value": "all"},
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "this_week"},
    {"label": "This Month", "value": "this_month"},
    {"label": "Overdue", "value": "overdue"},
  ];

  List<Map<String, dynamic>> workOrders = [
    {
      "id": "WO-2024-001",
      "title": "HVAC System Maintenance",
      "client": "Downtown Office Complex",
      "priority": "critical",
      "status": "in_progress",
      "assignedTo": "John Smith",
      "progress": 75,
      "dueDate": "2024-12-19",
      "cost": 850.00,
      "hours": 6.5,
    },
    {
      "id": "WO-2024-002",
      "title": "Plumbing Repair",
      "client": "City Hospital",
      "priority": "high",
      "status": "pending",
      "assignedTo": "Sarah Johnson",
      "progress": 0,
      "dueDate": "2024-12-20",
      "cost": 450.00,
      "hours": 3.0,
    },
    {
      "id": "WO-2024-003",
      "title": "Electrical Panel Upgrade",
      "client": "Manufacturing Plant",
      "priority": "medium",
      "status": "completed",
      "assignedTo": "Mike Wilson",
      "progress": 100,
      "dueDate": "2024-12-18",
      "cost": 1200.00,
      "hours": 8.0,
    },
    {
      "id": "WO-2024-004",
      "title": "Security System Installation",
      "client": "Retail Store Chain",
      "priority": "low",
      "status": "cancelled",
      "assignedTo": "Lisa Brown",
      "progress": 25,
      "dueDate": "2024-12-22",
      "cost": 750.00,
      "hours": 4.5,
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "type": "status_change",
      "workOrderId": "WO-2024-001",
      "message": "Work order status changed to In Progress",
      "timestamp": "2024-12-19 09:30",
      "user": "John Smith",
    },
    {
      "type": "assignment",
      "workOrderId": "WO-2024-005",
      "message": "Work order assigned to Sarah Johnson",
      "timestamp": "2024-12-19 08:45",
      "user": "Manager",
    },
    {
      "type": "completion",
      "workOrderId": "WO-2024-003",
      "message": "Work order completed successfully",
      "timestamp": "2024-12-18 16:20",
      "user": "Mike Wilson",
    },
    {
      "type": "creation",
      "workOrderId": "WO-2024-006",
      "message": "New work order created",
      "timestamp": "2024-12-18 14:15",
      "user": "Manager",
    },
  ];

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return warningColor;
      case "in_progress":
        return infoColor;
      case "completed":
        return successColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case "status_change":
        return Icons.update;
      case "assignment":
        return Icons.person_add;
      case "completion":
        return Icons.check_circle;
      case "creation":
        return Icons.add_circle;
      default:
        return Icons.info;
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      spacing: spMd,
      children: [
        // Statistics Cards
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.assignment, size: 32, color: primaryColor),
                    SizedBox(height: spXs),
                    Text(
                      "${workOrders.length}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Orders",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.pending, size: 32, color: warningColor),
                    SizedBox(height: spXs),
                    Text(
                      "${workOrders.where((wo) => wo["status"] == "pending").length}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
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
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.trending_up, size: 32, color: infoColor),
                    SizedBox(height: spXs),
                    Text(
                      "${workOrders.where((wo) => wo["status"] == "in_progress").length}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
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
          ],
        ),

        // Performance Metrics
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
                "Performance Metrics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "\$${((workOrders.map((wo) => wo["cost"] as double).reduce((a, b) => a + b))).currency}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Revenue",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${((workOrders.map((wo) => wo["hours"] as double).reduce((a, b) => a + b))).toStringAsFixed(1)}h",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Total Hours",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${((workOrders.where((wo) => wo["status"] == "completed").length / workOrders.length) * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Completion Rate",
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
            ],
          ),
        ),

        // Recent Activities
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Activities",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QButton(
                    label: "View All",
                    size: bs.sm,
                    onPressed: () {
                      // Navigate to activities
                    },
                  ),
                ],
              ),
              ...recentActivities.take(3).map((activity) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          _getActivityIcon(activity["type"]),
                          size: 16,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${activity["message"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${activity["workOrderId"]} • ${activity["user"]} • ${activity["timestamp"]}",
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
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkOrdersTab() {
    return Column(
      spacing: spMd,
      children: [
        // Search and Filter
        Container(
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
                  Icon(Icons.search, color: primaryColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Search work orders",
                      value: searchQuery,
                      hint: "Search by ID, client, or title...",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              QDropdownField(
                label: "Filter",
                items: filterItems,
                value: selectedFilter,
                onChanged: (value, label) {
                  selectedFilter = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),

        // Work Orders List
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Work Orders (${workOrders.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QButton(
                    label: "Create New",
                    size: bs.sm,
                    onPressed: () {
                      // Navigate to create work order
                    },
                  ),
                ],
              ),
              ...workOrders.map((wo) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getPriorityColor(wo["priority"]),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${wo["id"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${wo["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(wo["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${wo["status"]}".replaceAll("_", " ").toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor(wo["status"]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${wo["client"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.person, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${wo["assignedTo"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "Due: ${wo["dueDate"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      if (wo["status"] == "in_progress")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: spXs),
                            Text(
                              "Progress: ${wo["progress"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            LinearProgressIndicator(
                              value: (wo["progress"] as int) / 100,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                            ),
                          ],
                        ),
                      Row(
                        children: [
                          Text(
                            "\$${(wo["cost"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${wo["hours"]}h",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          QButton(
                            label: "View",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to work order details
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Work Order Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Work Orders", icon: Icon(Icons.assignment)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildOverviewTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildWorkOrdersTab(),
        ),
      ],
      onInit: (tabController) {
        // Tab controller initialized
      },
    );
  }
}
