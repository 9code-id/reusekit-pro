import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlInvoice4View extends StatefulWidget {
  @override
  State<GrlInvoice4View> createState() => _GrlInvoice4ViewState();
}

class _GrlInvoice4ViewState extends State<GrlInvoice4View> {
  int currentTab = 0;

  List<Map<String, dynamic>> invoiceStats = [
    {
      "title": "Total Revenue",
      "value": 125000.0,
      "change": 12.5,
      "period": "This Month",
      "icon": Icons.attach_money,
      "color": successColor,
    },
    {
      "title": "Pending Invoices",
      "value": 15.0,
      "change": -8.2,
      "period": "This Month",
      "icon": Icons.access_time,
      "color": warningColor,
    },
    {
      "title": "Overdue Amount",
      "value": 8500.0,
      "change": 15.3,
      "period": "This Month",
      "icon": Icons.warning,
      "color": dangerColor,
    },
    {
      "title": "Paid This Month",
      "value": 28.0,
      "change": 22.1,
      "period": "This Month",
      "icon": Icons.check_circle,
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "type": "payment",
      "client": "TechStart Inc.",
      "amount": 4250.0,
      "invoice": "INV-2024-001",
      "time": "2 hours ago",
      "status": "Paid",
    },
    {
      "type": "created",
      "client": "Digital Solutions Ltd.",
      "amount": 1850.0,
      "invoice": "INV-2024-012",
      "time": "5 hours ago",
      "status": "Sent",
    },
    {
      "type": "overdue",
      "client": "Marketing Pro Agency",
      "amount": 3200.0,
      "invoice": "INV-2024-003",
      "time": "1 day ago",
      "status": "Overdue",
    },
    {
      "type": "reminder",
      "client": "StartUp Innovations",
      "amount": 2750.0,
      "invoice": "INV-2024-008",
      "time": "2 days ago",
      "status": "Reminder Sent",
    },
  ];

  List<Map<String, dynamic>> monthlyData = [
    {"month": "Jan", "revenue": 85000.0, "invoices": 24},
    {"month": "Feb", "revenue": 92000.0, "invoices": 28},
    {"month": "Mar", "revenue": 78000.0, "invoices": 22},
    {"month": "Apr", "revenue": 105000.0, "invoices": 31},
    {"month": "May", "revenue": 98000.0, "invoices": 29},
    {"month": "Jun", "revenue": 125000.0, "invoices": 35},
  ];

  List<Map<String, dynamic>> topClients = [
    {
      "name": "TechStart Inc.",
      "totalAmount": 15400.0,
      "invoiceCount": 8,
      "lastInvoice": "2024-01-15",
    },
    {
      "name": "Digital Solutions Ltd.",
      "totalAmount": 12800.0,
      "invoiceCount": 6,
      "lastInvoice": "2024-01-12",
    },
    {
      "name": "Marketing Pro Agency",
      "totalAmount": 11200.0,
      "invoiceCount": 7,
      "lastInvoice": "2024-01-10",
    },
    {
      "name": "E-Commerce Solutions",
      "totalAmount": 9650.0,
      "invoiceCount": 5,
      "lastInvoice": "2024-01-08",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Invoice Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Activity", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAnalyticsTab(),
        _buildActivityTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spLg,
        children: [
          _buildQuickActions(),
          _buildStatsGrid(),
          _buildRecentInvoices(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spLg,
        children: [
          _buildRevenueChart(),
          _buildTopClients(),
          _buildMonthlyComparison(),
        ],
      ),
    );
  }

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spLg,
        children: [
          _buildActivityTimeline(),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Quick Actions",
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
                child: _buildActionButton(
                  "Create Invoice",
                  Icons.add,
                  primaryColor,
                  () {},
                ),
              ),
              Expanded(
                child: _buildActionButton(
                  "Send Reminder",
                  Icons.notifications,
                  warningColor,
                  () {},
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: _buildActionButton(
                  "View Reports",
                  Icons.assessment,
                  infoColor,
                  () {},
                ),
              ),
              Expanded(
                child: _buildActionButton(
                  "Export Data",
                  Icons.download,
                  successColor,
                  () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(100)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spXs,
          children: [
            Icon(icon, color: color, size: 20),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: invoiceStats.map((stat) {
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    stat["icon"],
                    color: stat["color"],
                    size: 28,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spXs,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: (stat["change"] as double) >= 0 
                          ? successColor.withAlpha(25)
                          : dangerColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${(stat["change"] as double) >= 0 ? '+' : ''}${(stat["change"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        color: (stat["change"] as double) >= 0 ? successColor : dangerColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "${stat["title"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              Text(
                stat["title"].toString().contains("Revenue") || stat["title"].toString().contains("Amount")
                    ? "\$${(stat["value"] as double).currency}"
                    : "${(stat["value"] as double).toInt()}",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: stat["color"],
                ),
              ),
              Text(
                "${stat["period"]}",
                style: TextStyle(
                  color: disabledColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecentInvoices() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Invoices",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
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
          ),
          ...List.generate(4, (index) {
            final isLast = index == 3;
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: isLast ? null : Border(
                  bottom: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.receipt_long,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "INV-2024-${index + 1}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Client Name ${index + 1}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: spXs,
                    children: [
                      Text(
                        "\$${(1000.0 + (index * 500)).currency}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: index.isEven ? successColor.withAlpha(25) : warningColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          index.isEven ? "Paid" : "Pending",
                          style: TextStyle(
                            color: index.isEven ? successColor : warningColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Revenue Trend",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(monthlyData.length, (index) {
                final data = monthlyData[index];
                final maxRevenue = monthlyData.map((d) => d["revenue"] as double).reduce((a, b) => a > b ? a : b);
                final height = ((data["revenue"] as double) / maxRevenue) * 160;
                
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: spXs,
                  children: [
                    Text(
                      "\$${((data["revenue"] as double) / 1000).toInt()}K",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      width: 30,
                      height: height,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    Text(
                      "${data["month"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopClients() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: warningColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "Top Clients",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(topClients.length, (index) {
            final client = topClients[index];
            final isLast = index == topClients.length - 1;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: isLast ? null : Border(
                  bottom: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${client["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${client["invoiceCount"]} invoices",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "\$${(client["totalAmount"] as double).currency}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMonthlyComparison() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Monthly Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...monthlyData.take(3).map((data) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: spSm),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${data["month"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${data["invoices"]} invoices",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${(data["revenue"] as double).currency}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
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

  Widget _buildActivityTimeline() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.timeline,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(recentActivity.length, (index) {
            final activity = recentActivity[index];
            final isLast = index == recentActivity.length - 1;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: isLast ? null : Border(
                  bottom: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getActivityColor(activity["type"]).withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      _getActivityIcon(activity["type"]),
                      color: _getActivityColor(activity["type"]),
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${activity["client"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${activity["invoice"]} - \$${(activity["amount"] as double).currency}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${activity["time"]}",
                          style: TextStyle(
                            color: disabledColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spXs,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getActivityColor(activity["type"]).withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${activity["status"]}",
                      style: TextStyle(
                        color: _getActivityColor(activity["type"]),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case "payment":
        return Icons.payment;
      case "created":
        return Icons.add;
      case "overdue":
        return Icons.warning;
      case "reminder":
        return Icons.notifications;
      default:
        return Icons.info;
    }
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case "payment":
        return successColor;
      case "created":
        return primaryColor;
      case "overdue":
        return dangerColor;
      case "reminder":
        return warningColor;
      default:
        return infoColor;
    }
  }
}
