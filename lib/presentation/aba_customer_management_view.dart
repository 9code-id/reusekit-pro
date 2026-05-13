import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaCustomerManagementView extends StatefulWidget {
  const AbaCustomerManagementView({super.key});

  @override
  State<AbaCustomerManagementView> createState() => _AbaCustomerManagementViewState();
}

class _AbaCustomerManagementViewState extends State<AbaCustomerManagementView> {
  int selectedTab = 0;
  bool loading = false;

  List<Map<String, dynamic>> customerStats = [
    {"title": "Total Customers", "value": 1247, "icon": Icons.people, "color": "primary", "change": "+12%"},
    {"title": "Active Customers", "value": 1089, "icon": Icons.verified_user, "color": "success", "change": "+8%"},
    {"title": "New This Month", "value": 94, "icon": Icons.person_add, "color": "info", "change": "+23%"},
    {"title": "Churned", "value": 15, "icon": Icons.person_remove, "color": "warning", "change": "-5%"}
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "type": "New Customer",
      "customer": "John Smith",
      "description": "Registered as premium customer",
      "timestamp": "2024-01-20T10:30:00",
      "icon": Icons.person_add,
      "color": "success"
    },
    {
      "type": "Order Placed",
      "customer": "Sarah Johnson",
      "description": "Placed order worth \$2,450",
      "timestamp": "2024-01-20T09:15:00",
      "icon": Icons.shopping_cart,
      "color": "primary"
    },
    {
      "type": "Support Ticket",
      "customer": "Mike Wilson",
      "description": "Opened support ticket #1234",
      "timestamp": "2024-01-20T08:45:00",
      "icon": Icons.support,
      "color": "warning"
    },
    {
      "type": "Payment Received",
      "customer": "Emily Davis",
      "description": "Payment of \$1,200 received",
      "timestamp": "2024-01-19T16:20:00",
      "icon": Icons.payment,
      "color": "success"
    },
    {
      "type": "Profile Updated",
      "customer": "David Brown",
      "description": "Updated contact information",
      "timestamp": "2024-01-19T14:10:00",
      "icon": Icons.edit,
      "color": "info"
    }
  ];

  List<Map<String, dynamic>> topCustomers = [
    {
      "name": "Acme Corporation",
      "email": "contact@acme.com",
      "totalSpent": 45000.00,
      "orders": 28,
      "lastOrder": "2024-01-18",
      "avatar": "https://picsum.photos/60/60?random=1",
      "status": "Premium"
    },
    {
      "name": "Global Tech Solutions",
      "email": "info@globaltech.com",
      "totalSpent": 38500.00,
      "orders": 22,
      "lastOrder": "2024-01-15",
      "avatar": "https://picsum.photos/60/60?random=2",
      "status": "Enterprise"
    },
    {
      "name": "Innovation Labs",
      "email": "hello@innovationlabs.com",
      "totalSpent": 32000.00,
      "orders": 19,
      "lastOrder": "2024-01-20",
      "avatar": "https://picsum.photos/60/60?random=3",
      "status": "Premium"
    },
    {
      "name": "Future Systems",
      "email": "contact@futuresys.com",
      "totalSpent": 28750.00,
      "orders": 16,
      "lastOrder": "2024-01-17",
      "avatar": "https://picsum.photos/60/60?random=4",
      "status": "Premium"
    }
  ];

  List<Map<String, dynamic>> upcomingTasks = [
    {
      "task": "Follow up with John Smith",
      "type": "Follow-up",
      "dueDate": "2024-01-22",
      "priority": "High",
      "customer": "John Smith"
    },
    {
      "task": "Contract renewal reminder",
      "type": "Contract",
      "dueDate": "2024-01-23",
      "priority": "Medium",
      "customer": "Acme Corporation"
    },
    {
      "task": "Product demo scheduled",
      "type": "Demo",
      "dueDate": "2024-01-24",
      "priority": "High",
      "customer": "Tech Innovations"
    },
    {
      "task": "Support ticket resolution",
      "type": "Support",
      "dueDate": "2024-01-25",
      "priority": "Medium",
      "customer": "Global Solutions"
    }
  ];

  Color _getStatColor(String colorType) {
    switch (colorType) {
      case "primary":
        return primaryColor;
      case "success":
        return successColor;
      case "info":
        return infoColor;
      case "warning":
        return warningColor;
      case "danger":
        return dangerColor;
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
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // navigateTo CustomerAnalyticsView
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // navigateTo CustomerSettingsView
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Quick Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Add Customer",
                    icon: Icons.person_add,
                    size: bs.md,
                    onPressed: () {
                      // navigateTo AddCustomerView
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "View All",
                    icon: Icons.list,
                    size: bs.md,
                    onPressed: () {
                      // navigateTo CustomerListView
                    },
                  ),
                ),
              ],
            ),

            // Customer Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: customerStats.map((stat) {
                return Container(
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
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: _getStatColor("${stat["color"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              color: _getStatColor("${stat["color"]}"),
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${stat["change"]}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: _getStatColor("${stat["color"]}"),
                        ),
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Recent Activities Section
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
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo ActivityLogView
                        },
                      ),
                    ],
                  ),
                  ...recentActivities.take(5).map((activity) {
                    return Container(
                      padding: EdgeInsets.all(spXs),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: _getStatColor("${activity["color"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              activity["icon"] as IconData,
                              color: _getStatColor("${activity["color"]}"),
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${activity["type"]} - ${activity["customer"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
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
                            "${DateTime.parse("${activity["timestamp"]}").dMMMy}",
                            style: TextStyle(
                              fontSize: 11,
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

            // Top Customers Section
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
                    children: [
                      Text(
                        "Top Customers",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo TopCustomersView
                        },
                      ),
                    ],
                  ),
                  ...topCustomers.map((customer) {
                    return Container(
                      padding: EdgeInsets.all(spXs),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              "${customer["avatar"]}",
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${customer["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${customer["email"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${(customer["totalSpent"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${customer["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor,
                                  ),
                                ),
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

            // Upcoming Tasks Section
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
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo TasksView
                        },
                      ),
                    ],
                  ),
                  ...upcomingTasks.map((task) {
                    return Container(
                      padding: EdgeInsets.all(spXs),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: _getPriorityColor("${task["priority"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.task,
                              color: _getPriorityColor("${task["priority"]}"),
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${task["task"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${task["customer"]} • ${task["type"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${DateTime.parse("${task["dueDate"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor("${task["priority"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${task["priority"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: _getPriorityColor("${task["priority"]}"),
                                  ),
                                ),
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

            // Quick Analytics Section
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
                    "Quick Insights",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "87%",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Customer Satisfaction",
                                textAlign: TextAlign.center,
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
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "2.3",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Avg Response Time (hrs)",
                                textAlign: TextAlign.center,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
