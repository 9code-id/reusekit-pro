import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHome4View extends StatefulWidget {
  @override
  State<GrlHome4View> createState() => _GrlHome4ViewState();
}

class _GrlHome4ViewState extends State<GrlHome4View> {
  int selectedTab = 0;
  String searchQuery = "";
  
  final List<Map<String, dynamic>> navigationTabs = [
    {"title": "Overview", "icon": Icons.dashboard},
    {"title": "Analytics", "icon": Icons.analytics},
    {"title": "Reports", "icon": Icons.assignment},
    {"title": "Settings", "icon": Icons.settings},
  ];

  final List<Map<String, dynamic>> kpiCards = [
    {
      "title": "Total Revenue",
      "value": "\$45,672",
      "change": "+12.5%",
      "changeUp": true,
      "icon": Icons.monetization_on,
      "color": successColor,
      "subtitle": "This month",
    },
    {
      "title": "Active Users",
      "value": "8,542",
      "change": "+8.2%",
      "changeUp": true,
      "icon": Icons.people,
      "color": infoColor,
      "subtitle": "Last 30 days",
    },
    {
      "title": "Conversion Rate",
      "value": "3.24%",
      "change": "-2.1%",
      "changeUp": false,
      "icon": Icons.trending_up,
      "color": warningColor,
      "subtitle": "Avg. this week",
    },
    {
      "title": "Orders",
      "value": "1,247",
      "change": "+15.3%",
      "changeUp": true,
      "icon": Icons.shopping_cart,
      "color": primaryColor,
      "subtitle": "This month",
    },
  ];

  final List<Map<String, dynamic>> recentTransactions = [
    {
      "id": "TXN-001",
      "customer": "John Smith",
      "amount": 299.99,
      "status": "Completed",
      "date": "2024-01-15",
      "type": "Sale",
      "method": "Credit Card",
    },
    {
      "id": "TXN-002",
      "customer": "Sarah Wilson",
      "amount": 156.50,
      "status": "Pending",
      "date": "2024-01-15",
      "type": "Refund",
      "method": "PayPal",
    },
    {
      "id": "TXN-003",
      "customer": "Michael Brown",
      "amount": 89.99,
      "status": "Completed",
      "date": "2024-01-14",
      "type": "Sale",
      "method": "Bank Transfer",
    },
    {
      "id": "TXN-004",
      "customer": "Emma Davis",
      "amount": 445.00,
      "status": "Failed",
      "date": "2024-01-14",
      "type": "Sale",
      "method": "Credit Card",
    },
  ];

  final List<Map<String, dynamic>> quickActions = [
    {
      "title": "Create Report",
      "subtitle": "Generate new analytics report",
      "icon": Icons.description,
      "color": primaryColor,
    },
    {
      "title": "Export Data",
      "subtitle": "Download data in CSV format",
      "icon": Icons.download,
      "color": infoColor,
    },
    {
      "title": "Send Invoice",
      "subtitle": "Create and send invoice",
      "icon": Icons.receipt,
      "color": successColor,
    },
    {
      "title": "Manage Users",
      "subtitle": "Add or edit user accounts",
      "icon": Icons.person_add,
      "color": warningColor,
    },
  ];

  final List<Map<String, dynamic>> chartData = [
    {"month": "Jan", "revenue": 35000, "orders": 145},
    {"month": "Feb", "revenue": 42000, "orders": 167},
    {"month": "Mar", "revenue": 38000, "orders": 134},
    {"month": "Apr", "revenue": 51000, "orders": 189},
    {"month": "May", "revenue": 47000, "orders": 156},
    {"month": "Jun", "revenue": 45672, "orders": 178},
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'pending':
        return warningColor;
      case 'failed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Business Dashboard",
      selectedIndex: selectedTab,
      tabs: navigationTabs.map((tab) => Tab(
        text: "${tab["title"]}",
        icon: Icon(tab["icon"] as IconData),
      )).toList(),
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(200)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome back, Administrator",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Here's what's happening with your business today",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        QButton(
                          label: "View Reports",
                          color: Colors.white,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Quick Actions",
                          color: Colors.white.withAlpha(100),
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // KPI Cards
              Text(
                "Key Performance Indicators",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 170,
                children: kpiCards.map((kpi) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: (kpi["color"] as Color).withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                kpi["icon"] as IconData,
                                size: 20,
                                color: kpi["color"] as Color,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: (kpi["changeUp"] as bool) ? successColor.withAlpha(30) : dangerColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${kpi["change"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: (kpi["changeUp"] as bool) ? successColor : dangerColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${kpi["value"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${kpi["title"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${kpi["subtitle"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // Quick Actions
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 150,
                children: quickActions.map((action) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: (action["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            action["icon"] as IconData,
                            size: 24,
                            color: action["color"] as Color,
                          ),
                        ),
                        Text(
                          "${action["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${action["subtitle"]}",
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
            ],
          ),
        ),

        // Analytics Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Revenue Analytics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Monthly Performance",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Revenue and order trends over the last 6 months",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Container(
                      height: 200,
                      child: Column(
                        spacing: spSm,
                        children: chartData.map((data) {
                          double maxRevenue = chartData.map((d) => d["revenue"] as int).reduce((a, b) => a > b ? a : b).toDouble();
                          double percentage = ((data["revenue"] as int) / maxRevenue);
                          
                          return Row(
                            children: [
                              SizedBox(
                                width: 30,
                                child: Text(
                                  "${data["month"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Container(
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: disabledColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: percentage,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              SizedBox(
                                width: 70,
                                child: Text(
                                  "\$${((data["revenue"] as int).toDouble() / 1000).toStringAsFixed(0)}K",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Reports Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Recent Transactions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    label: "Export All",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
              Column(
                spacing: spSm,
                children: recentTransactions.map((transaction) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                spacing: spXs,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${transaction["id"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor("${transaction["status"]}").withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${transaction["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor("${transaction["status"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${transaction["customer"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${transaction["type"]} • ${transaction["method"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "${transaction["date"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "\$${((transaction["amount"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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

        // Settings Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dashboard Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Preferences",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Column(
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Email Notifications",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Switch(
                              value: true,
                              onChanged: (value) {},
                              activeColor: primaryColor,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Push Notifications",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Switch(
                              value: false,
                              onChanged: (value) {},
                              activeColor: primaryColor,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Dark Mode",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Switch(
                              value: false,
                              onChanged: (value) {},
                              activeColor: primaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Save Settings",
                      size: bs.md,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
