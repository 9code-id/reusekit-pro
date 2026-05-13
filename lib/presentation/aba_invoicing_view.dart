import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaInvoicingView extends StatefulWidget {
  const AbaInvoicingView({super.key});

  @override
  State<AbaInvoicingView> createState() => _AbaInvoicingViewState();
}

class _AbaInvoicingViewState extends State<AbaInvoicingView> {
  int currentTab = 0;

  List<Map<String, dynamic>> recentInvoices = [
    {
      "id": "INV-2024-001",
      "clientName": "Tech Solutions Inc",
      "amount": 15750.00,
      "currency": "USD",
      "status": "paid",
      "dueDate": "2024-12-20",
      "createdDate": "2024-11-20",
      "description": "Web Development Services - November 2024",
      "paymentDate": "2024-12-18"
    },
    {
      "id": "INV-2024-002",
      "clientName": "Global Marketing Ltd",
      "amount": 8500.00,
      "currency": "USD",
      "status": "overdue",
      "dueDate": "2024-12-10",
      "createdDate": "2024-11-10",
      "description": "Digital Marketing Campaign - Q4 2024",
      "daysPastDue": 9
    },
    {
      "id": "INV-2024-003",
      "clientName": "Innovation Corp",
      "amount": 22300.00,
      "currency": "USD",
      "status": "pending",
      "dueDate": "2024-12-25",
      "createdDate": "2024-11-25",
      "description": "Software Development & Consulting - December 2024"
    },
    {
      "id": "INV-2024-004",
      "clientName": "Startup Ventures",
      "amount": 5200.00,
      "currency": "USD",
      "status": "draft",
      "dueDate": "2024-12-30",
      "createdDate": "2024-12-15",
      "description": "UX/UI Design Services - Phase 1"
    }
  ];

  List<Map<String, dynamic>> quickStats = [
    {
      "title": "Total Revenue",
      "value": 127500.00,
      "currency": "USD",
      "icon": Icons.trending_up,
      "color": "success",
      "period": "This Month"
    },
    {
      "title": "Outstanding",
      "value": 35200.00,
      "currency": "USD", 
      "icon": Icons.pending,
      "color": "warning",
      "period": "Unpaid Invoices"
    },
    {
      "title": "Overdue",
      "value": 8500.00,
      "currency": "USD",
      "icon": Icons.schedule,
      "color": "danger",
      "period": "Past Due"
    },
    {
      "title": "Draft Invoices",
      "value": 5200.00,
      "currency": "USD",
      "icon": Icons.edit_note,
      "color": "info",
      "period": "Ready to Send"
    }
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'paid': return successColor;
      case 'pending': return warningColor;
      case 'overdue': return dangerColor;
      case 'draft': return infoColor;
      default: return disabledBoldColor;
    }
  }

  Color _getStatColor(String colorType) {
    switch (colorType) {
      case 'success': return successColor;
      case 'warning': return warningColor;
      case 'danger': return dangerColor;
      case 'info': return infoColor;
      default: return primaryColor;
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: quickStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spSm),
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
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: _getStatColor("${stat["color"]}").withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            stat["icon"] as IconData,
                            color: _getStatColor("${stat["color"]}"),
                            size: 20,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${stat["period"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${((stat["value"] as double).toDouble()).currency} ${stat["currency"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: _getStatColor("${stat["color"]}"),
                      ),
                    ),
                    Text(
                      "${stat["title"]}",
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

          // Quick Actions
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
                  "Quick Actions",
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
                        label: "Create Invoice",
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to create invoice
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "View All",
                        icon: Icons.list,
                        color: secondaryColor,
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to invoice list
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Templates",
                        icon: Icons.description,
                        color: infoColor,
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to templates
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Reports",
                        icon: Icons.analytics,
                        color: warningColor,
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to reports
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Recent Invoices
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
                      "Recent Invoices",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // Navigate to all invoices
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                ...recentInvoices.take(3).map((invoice) {
                  return Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 3,
                          color: _getStatusColor("${invoice["status"]}"),
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
                                "${invoice["id"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "${invoice["clientName"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Due: ${DateTime.parse("${invoice["dueDate"]}").dMMMy}",
                                style: TextStyle(
                                  color: disabledColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${((invoice["amount"] as double).toDouble()).currency}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor("${invoice["status"]}").withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${invoice["status"]}".toUpperCase(),
                                style: TextStyle(
                                  color: _getStatusColor("${invoice["status"]}"),
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
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

          // Monthly Performance Chart
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
                  "Monthly Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildChartBar("Oct", 85000, 120000),
                      _buildChartBar("Nov", 95000, 120000),
                      _buildChartBar("Dec", 127500, 120000),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Revenue",
                      style: TextStyle(
                        fontSize: 11,
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
  }

  Widget _buildChartBar(String month, double value, double maxValue) {
    double height = (value / maxValue) * 100;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "${(value / 1000).toInt()}K",
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Container(
          width: 30,
          height: height,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(height: spXs),
        Text(
          month,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Payment Status Distribution
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
                  "Payment Status Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Center(
                          child: Text(
                            "60%\nPaid",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Center(
                          child: Text(
                            "25%\nPending",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Center(
                          child: Text(
                            "15%\nOverdue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Top Clients
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
                  "Top Clients by Revenue",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildClientRow("Tech Solutions Inc", 45250.00, 1),
                _buildClientRow("Innovation Corp", 32100.00, 2),
                _buildClientRow("Global Marketing Ltd", 28500.00, 3),
                _buildClientRow("Startup Ventures", 21650.00, 4),
              ],
            ),
          ),

          // Payment Trends
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
                  "Payment Trends",
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
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "12.5",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Avg Days to Pay",
                              style: TextStyle(
                                fontSize: 11,
                                color: successColor,
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
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "18.2K",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Avg Invoice Value",
                              style: TextStyle(
                                fontSize: 11,
                                color: warningColor,
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
    );
  }

  Widget _buildClientRow(String name, double revenue, int rank) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: rank <= 3 ? primaryColor : disabledColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              "$rank",
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 13,
            ),
          ),
        ),
        Text(
          "${(revenue.toDouble()).currency}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Invoicing Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}
