import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDashboard3View extends StatefulWidget {
  @override
  State<GrlDashboard3View> createState() => _GrlDashboard3ViewState();
}

class _GrlDashboard3ViewState extends State<GrlDashboard3View> {
  bool loading = false;
  String selectedTimeframe = "This Week";
  
  List<Map<String, dynamic>> customerData = [
    {"name": "Alice Cooper", "orders": 12, "spent": 2450.00, "lastOrder": "2024-01-15", "status": "Premium", "avatar": "https://picsum.photos/50/50?random=1&keyword=woman"},
    {"name": "Bob Johnson", "orders": 8, "spent": 1890.50, "lastOrder": "2024-01-14", "status": "Regular", "avatar": "https://picsum.photos/50/50?random=2&keyword=man"},
    {"name": "Carol Smith", "orders": 15, "spent": 3200.75, "lastOrder": "2024-01-13", "status": "VIP", "avatar": "https://picsum.photos/50/50?random=3&keyword=woman"},
    {"name": "David Wilson", "orders": 5, "spent": 890.25, "lastOrder": "2024-01-12", "status": "New", "avatar": "https://picsum.photos/50/50?random=4&keyword=man"},
    {"name": "Eva Martinez", "orders": 20, "spent": 4150.00, "lastOrder": "2024-01-11", "status": "VIP", "avatar": "https://picsum.photos/50/50?random=5&keyword=woman"},
  ];

  List<Map<String, dynamic>> satisfactionData = [
    {"rating": 5, "count": 156, "percentage": 62.0},
    {"rating": 4, "count": 78, "percentage": 31.0},
    {"rating": 3, "count": 12, "percentage": 5.0},
    {"rating": 2, "count": 3, "percentage": 1.0},
    {"rating": 1, "count": 2, "percentage": 1.0},
  ];

  List<Map<String, dynamic>> supportTickets = [
    {"id": "TKT-001", "customer": "John Doe", "subject": "Payment Issue", "priority": "High", "status": "Open", "created": "2024-01-15"},
    {"id": "TKT-002", "customer": "Jane Smith", "subject": "Product Question", "priority": "Medium", "status": "In Progress", "created": "2024-01-14"},
    {"id": "TKT-003", "customer": "Mike Brown", "subject": "Shipping Delay", "priority": "Low", "status": "Resolved", "created": "2024-01-13"},
    {"id": "TKT-004", "customer": "Sarah Davis", "subject": "Refund Request", "priority": "High", "status": "Open", "created": "2024-01-12"},
  ];

  List<Map<String, dynamic>> timeframeItems = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
  ];

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Analytics"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            child: QButton(
              icon: Icons.download,
              size: bs.sm,
              onPressed: () {
                ss("Customer report exported successfully");
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeframe Filter
            Row(
              children: [
                Text(
                  "Timeframe:",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Select Timeframe",
                    items: timeframeItems,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Customer Metrics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildMetricCard("Total Customers", "1,247", Icons.people, primaryColor, "+8.5%"),
                _buildMetricCard("New Customers", "89", Icons.person_add, successColor, "+15.2%"),
                _buildMetricCard("Avg Order Value", "\$${(125.50).currency}", Icons.shopping_cart, infoColor, "+3.7%"),
                _buildMetricCard("Customer Retention", "87.3%", Icons.refresh, warningColor, "-2.1%"),
              ],
            ),

            // Customer Satisfaction
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Customer Satisfaction",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "4.5/5.0",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: satisfactionData.map((rating) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 20,
                            child: Text(
                              "${rating["rating"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (index) {
                              return Icon(
                                index < (rating["rating"] as int) ? Icons.star : Icons.star_border,
                                size: 14,
                                color: warningColor,
                              );
                            }),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: (rating["percentage"] as double) / 100,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _getRatingColor(rating["rating"] as int),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          SizedBox(
                            width: 40,
                            child: Text(
                              "${rating["count"]}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          SizedBox(
                            width: 35,
                            child: Text(
                              "${(rating["percentage"] as double).toStringAsFixed(0)}%",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Top Customers
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Customers",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Opening customer management");
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: customerData.map((customer) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getCustomerStatusColor(customer["status"]),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                image: DecorationImage(
                                  image: NetworkImage("${customer["avatar"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${customer["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getCustomerStatusColor(customer["status"]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${customer["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getCustomerStatusColor(customer["status"]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${customer["orders"]} orders • Last: ${customer["lastOrder"]}",
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
                                  "\$${(customer["spent"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Total Spent",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
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
            ),

            // Support Tickets
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Support Tickets",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Opening support dashboard");
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: supportTickets.map((ticket) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _getPriorityColor(ticket["priority"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.support_agent,
                                color: _getPriorityColor(ticket["priority"]),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${ticket["id"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getPriorityColor(ticket["priority"]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${ticket["priority"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getPriorityColor(ticket["priority"]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${ticket["subject"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${ticket["customer"]} • ${ticket["created"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getTicketStatusColor(ticket["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${ticket["status"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: _getTicketStatusColor(ticket["status"]),
                                ),
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

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Customer Survey",
                    icon: Icons.poll,
                    size: bs.md,
                    onPressed: () {
                      si("Creating customer satisfaction survey");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Support Center",
                    icon: Icons.help_center,
                    size: bs.md,
                    onPressed: () {
                      si("Opening support center");
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

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String change) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: change.startsWith('+') ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: change.startsWith('+') ? successColor : dangerColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
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
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRatingColor(int rating) {
    if (rating >= 4) return successColor;
    if (rating == 3) return warningColor;
    return dangerColor;
  }

  Color _getCustomerStatusColor(String status) {
    switch (status) {
      case "VIP":
        return warningColor;
      case "Premium":
        return primaryColor;
      case "Regular":
        return infoColor;
      case "New":
        return successColor;
      default:
        return disabledBoldColor;
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

  Color _getTicketStatusColor(String status) {
    switch (status) {
      case "Open":
        return dangerColor;
      case "In Progress":
        return warningColor;
      case "Resolved":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
