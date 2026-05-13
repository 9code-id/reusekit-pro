import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaHomeView extends StatefulWidget {
  const ImaHomeView({super.key});

  @override
  State<ImaHomeView> createState() => _ImaHomeViewState();
}

class _ImaHomeViewState extends State<ImaHomeView> {
  String selectedPeriod = "Today";
  List<String> periods = ["Today", "This Week", "This Month", "This Quarter"];
  
  List<Map<String, dynamic>> quickActions = [
    {
      "icon": Icons.add_shopping_cart,
      "label": "New Sale",
      "color": "success",
      "route": "NewSaleView",
    },
    {
      "icon": Icons.receipt_long,
      "label": "Add Expense",
      "color": "warning",
      "route": "AddExpenseView",
    },
    {
      "icon": Icons.inventory,
      "label": "Inventory",
      "color": "info",
      "route": "InventoryView",
    },
    {
      "icon": Icons.analytics,
      "label": "Reports",
      "color": "primary",
      "route": "ReportsView",
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "icon": Icons.shopping_cart,
      "title": "New Sale Created",
      "description": "Invoice #INV-2025-001 for \$1,250.00",
      "time": "5 minutes ago",
      "color": "success",
    },
    {
      "icon": Icons.people,
      "title": "New Customer Added",
      "description": "John Smith - ABC Corporation",
      "time": "15 minutes ago",
      "color": "info",
    },
    {
      "icon": Icons.inventory,
      "title": "Low Stock Alert",
      "description": "Wireless Headphones - 5 units remaining",
      "time": "1 hour ago",
      "color": "warning",
    },
    {
      "icon": Icons.payment,
      "title": "Payment Received",
      "description": "Invoice #INV-2025-002 - \$850.00",
      "time": "2 hours ago",
      "color": "success",
    },
    {
      "icon": Icons.campaign,
      "title": "Marketing Campaign",
      "description": "Summer Sale campaign launched",
      "time": "3 hours ago",
      "color": "primary",
    },
  ];

  List<Map<String, dynamic>> upcomingTasks = [
    {
      "title": "Follow up with potential client",
      "description": "Schedule meeting with ABC Corp",
      "dueDate": "Today, 2:00 PM",
      "priority": "High",
      "completed": false,
    },
    {
      "title": "Review monthly financial report",
      "description": "Analyze performance metrics",
      "dueDate": "Tomorrow, 10:00 AM",
      "priority": "Medium",
      "completed": false,
    },
    {
      "title": "Update inventory levels",
      "description": "Restock popular items",
      "dueDate": "Jun 20, 9:00 AM",
      "priority": "Low",
      "completed": false,
    },
    {
      "title": "Team meeting preparation",
      "description": "Prepare agenda for weekly meeting",
      "dueDate": "Jun 21, 3:00 PM",
      "priority": "Medium",
      "completed": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMA Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // navigateTo('NotificationsView')
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // navigateTo('SearchView')
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // navigateTo('ProfileView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Welcome Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(200),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good Morning, John!",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Here's what's happening with your business today",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(30),
                          borderRadius: BorderRadius.circular(radius2xl),
                        ),
                        child: Icon(
                          Icons.wb_sunny,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Period Filter
            QDropdownField(
              label: "Time Period",
              items: periods.map((period) => {
                "label": period,
                "value": period,
              }).toList(),
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),

            // Key Metrics
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildMetricCard(
                  title: "Revenue",
                  value: "\$12,450",
                  change: "+8.2%",
                  icon: Icons.trending_up,
                  color: successColor,
                  isPositive: true,
                ),
                _buildMetricCard(
                  title: "Orders",
                  value: "47",
                  change: "+12.5%",
                  icon: Icons.shopping_cart,
                  color: primaryColor,
                  isPositive: true,
                ),
                _buildMetricCard(
                  title: "Customers",
                  value: "1,234",
                  change: "+3.1%",
                  icon: Icons.people,
                  color: infoColor,
                  isPositive: true,
                ),
                _buildMetricCard(
                  title: "Expenses",
                  value: "\$3,280",
                  change: "-2.4%",
                  icon: Icons.receipt_long,
                  color: warningColor,
                  isPositive: false,
                ),
              ],
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    minItemWidth: 200,
                    children: quickActions.map((action) {
                      Color actionColor = _getActionColor(action["color"]);
                      return GestureDetector(
                        onTap: () {
                          // navigateTo(action["route"])
                        },
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: actionColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(color: actionColor.withAlpha(30)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: actionColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radius2xl),
                                ),
                                child: Icon(
                                  action["icon"],
                                  color: actionColor,
                                  size: 28,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${action["label"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Recent Activities
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Text(
                        "Recent Activities",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // navigateTo('AllActivitiesView')
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...recentActivities.take(4).map((activity) {
                    Color activityColor = _getActivityColor(activity["color"]);
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: activityColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: activityColor.withAlpha(20)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: activityColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              activity["icon"],
                              color: activityColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${activity["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${activity["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${activity["time"]}",
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
              ),
            ),

            // Upcoming Tasks
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Text(
                        "Upcoming Tasks",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // navigateTo('TasksView')
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...upcomingTasks.take(3).map((task) {
                    Color priorityColor = _getPriorityColor(task["priority"]);
                    bool isCompleted = task["completed"];
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: isCompleted 
                            ? successColor.withAlpha(5) 
                            : priorityColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isCompleted 
                              ? successColor.withAlpha(20) 
                              : priorityColor.withAlpha(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              task["completed"] = !task["completed"];
                              setState(() {});
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: isCompleted ? successColor : Colors.transparent,
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(
                                  color: isCompleted ? successColor : disabledBoldColor,
                                ),
                              ),
                              child: isCompleted
                                  ? Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${task["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isCompleted ? disabledBoldColor : primaryColor,
                                    decoration: isCompleted 
                                        ? TextDecoration.lineThrough 
                                        : TextDecoration.none,
                                  ),
                                ),
                                Text(
                                  "${task["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: priorityColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${task["priority"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: priorityColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${task["dueDate"]}",
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
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Business Insights
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "AI Business Insights",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Your sales are 12% higher than last month\n• Consider restocking Wireless Headphones - demand is increasing\n• Customer retention rate improved by 5% this quarter\n• Marketing ROI is performing 18% above industry average",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: spSm),
                  GestureDetector(
                    onTap: () {
                      // navigateTo('InsightsView')
                    },
                    child: Text(
                      "View Detailed Analysis",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String change,
    required IconData icon,
    required Color color,
    required bool isPositive,
  }) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: isPositive 
                      ? successColor.withAlpha(20) 
                      : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 12,
                      color: isPositive ? successColor : dangerColor,
                    ),
                    Text(
                      change,
                      style: TextStyle(
                        color: isPositive ? successColor : dangerColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Color _getActionColor(String colorName) {
    switch (colorName) {
      case "success":
        return successColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      case "primary":
        return primaryColor;
      default:
        return primaryColor;
    }
  }

  Color _getActivityColor(String colorName) {
    switch (colorName) {
      case "success":
        return successColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      case "primary":
        return primaryColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
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
}
