import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmAnalyticsDashboardView extends StatefulWidget {
  const IwmAnalyticsDashboardView({super.key});

  @override
  State<IwmAnalyticsDashboardView> createState() => _IwmAnalyticsDashboardViewState();
}

class _IwmAnalyticsDashboardViewState extends State<IwmAnalyticsDashboardView> {
  String selectedPeriod = "Last 30 Days";
  bool loading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> periodItems = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> inventoryMetrics = [
    {
      "title": "Total Inventory Value",
      "value": 2850000,
      "change": 12.5,
      "trend": "up",
      "icon": Icons.inventory,
      "color": primaryColor,
    },
    {
      "title": "Stock Turnover Rate",
      "value": 8.5,
      "change": -2.3,
      "trend": "down",
      "icon": Icons.refresh,
      "color": warningColor,
    },
    {
      "title": "Out of Stock Items",
      "value": 23,
      "change": -15.2,
      "trend": "down",
      "icon": Icons.warning,
      "color": dangerColor,
    },
    {
      "title": "Purchase Orders",
      "value": 156,
      "change": 8.7,
      "trend": "up",
      "icon": Icons.shopping_cart,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> topCategories = [
    {"name": "Electronics", "value": 850000, "percentage": 35, "items": 234},
    {"name": "Raw Materials", "value": 650000, "percentage": 27, "items": 189},
    {"name": "Components", "value": 420000, "percentage": 18, "items": 156},
    {"name": "Tools", "value": 280000, "percentage": 12, "items": 98},
    {"name": "Supplies", "value": 200000, "percentage": 8, "items": 67},
  ];

  List<Map<String, dynamic>> recentTransactions = [
    {
      "id": "TXN001",
      "type": "Purchase",
      "description": "Office Supplies Order",
      "amount": 2500.00,
      "date": "2024-06-19",
      "vendor": "Global Supply Co.",
      "status": "Completed",
    },
    {
      "id": "TXN002",
      "type": "Issue",
      "description": "IT Equipment Issue",
      "amount": 1200.00,
      "date": "2024-06-18",
      "department": "IT Department",
      "status": "Processed",
    },
    {
      "id": "TXN003",
      "type": "Return",
      "description": "Defective Components",
      "amount": 800.00,
      "date": "2024-06-17",
      "vendor": "Tech Components Ltd.",
      "status": "Pending",
    },
    {
      "id": "TXN004",
      "type": "Purchase",
      "description": "Raw Materials Stock",
      "amount": 5600.00,
      "date": "2024-06-16",
      "vendor": "Industrial Materials Inc.",
      "status": "Completed",
    },
  ];

  List<Map<String, dynamic>> lowStockAlerts = [
    {"item": "A4 Paper", "current": 15, "minimum": 50, "category": "Office Supplies"},
    {"item": "Printer Ink HP", "current": 8, "minimum": 20, "category": "Electronics"},
    {"item": "Safety Helmets", "current": 12, "minimum": 25, "category": "Safety"},
    {"item": "USB Cables", "current": 28, "minimum": 50, "category": "Electronics"},
  ];

  Widget _buildMetricCard(Map<String, dynamic> metric) {
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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (metric["color"] as Color).withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  metric["icon"],
                  color: metric["color"] as Color,
                  size: 24,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: metric["trend"] == "up" 
                      ? successColor.withAlpha(25)
                      : dangerColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      metric["trend"] == "up" 
                          ? Icons.trending_up 
                          : Icons.trending_down,
                      size: 12,
                      color: metric["trend"] == "up" 
                          ? successColor 
                          : dangerColor,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${(metric["change"] as num).abs().toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        color: metric["trend"] == "up" 
                            ? successColor 
                            : dangerColor,
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
            metric["title"] == "Total Inventory Value" 
                ? "\$${((metric["value"] as num).toDouble()).currency}"
                : metric["title"] == "Stock Turnover Rate"
                    ? "${metric["value"]}"
                    : "${metric["value"]}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${metric["title"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${category["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${category["items"]} items",
                  style: TextStyle(
                    fontSize: 13,
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
                "\$${((category["value"] as num).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(height: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${category["percentage"]}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    Color typeColor = transaction["type"] == "Purchase" 
        ? successColor 
        : transaction["type"] == "Issue"
            ? warningColor
            : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: typeColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${transaction["description"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${transaction["id"]} • ${transaction["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${transaction["type"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: typeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "Amount: ",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$${(transaction["amount"] as double).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Spacer(),
              Text(
                "${transaction["vendor"] ?? transaction["department"] ?? "N/A"}",
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

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    double percentage = ((alert["current"] as num) / (alert["minimum"] as num)) * 100;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: dangerColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: dangerColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${alert["item"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${alert["category"]}",
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
                "${alert["current"]} / ${alert["minimum"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
              SizedBox(height: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${percentage.toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Analytics Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Transactions", icon: Icon(Icons.receipt)),
        Tab(text: "Alerts", icon: Icon(Icons.warning)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Period Filter
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Time Period",
                      items: periodItems,
                      value: selectedPeriod,
                      onChanged: (value, label) {
                        selectedPeriod = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Metrics Cards
              ResponsiveGridView(
                padding: EdgeInsets.all(0),
                minItemWidth: 200,
                children: inventoryMetrics.map((metric) => _buildMetricCard(metric)).toList(),
              ),

              // Quick Stats
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quick Statistics",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ResponsiveGridView(
                      padding: EdgeInsets.all(0),
                      minItemWidth: 200,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "1,234",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Total Items",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "89",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Active Vendors",
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
            ],
          ),
        ),

        // Categories Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Top Categories by Value",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...topCategories.map((category) => _buildCategoryCard(category)),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Transactions Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...recentTransactions.map((transaction) => _buildTransactionCard(transaction)),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Alerts Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Low Stock Alerts",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...lowStockAlerts.map((alert) => _buildAlertCard(alert)),
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
