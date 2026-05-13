import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStatus7View extends StatefulWidget {
  @override
  State<GrlStatus7View> createState() => _GrlStatus7ViewState();
}

class _GrlStatus7ViewState extends State<GrlStatus7View> {
  String selectedPeriod = "This Month";
  String selectedType = "All";
  bool showDetailsView = false;
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Year", "value": "This Year"},
  ];
  
  List<Map<String, dynamic>> typeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Revenue", "value": "Revenue"},
    {"label": "Orders", "value": "Orders"},
    {"label": "Customers", "value": "Customers"},
    {"label": "Products", "value": "Products"},
  ];

  Map<String, dynamic> overallStats = {
    "totalRevenue": 125430.50,
    "totalOrders": 1847,
    "totalCustomers": 856,
    "averageOrderValue": 67.92,
    "growthRate": 12.5,
    "conversionRate": 3.8,
  };

  List<Map<String, dynamic>> statusCategories = [
    {
      "id": 1,
      "title": "Sales Performance",
      "subtitle": "Revenue and Order Analytics",
      "icon": Icons.trending_up,
      "color": successColor,
      "value": 125430.50,
      "change": 12.5,
      "changeType": "increase",
      "metrics": [
        {"label": "Total Revenue", "value": "\$125,430.50", "change": "+12.5%"},
        {"label": "Orders Count", "value": "1,847", "change": "+8.3%"},
        {"label": "Avg Order Value", "value": "\$67.92", "change": "+5.1%"},
        {"label": "Conversion Rate", "value": "3.8%", "change": "+0.4%"},
      ],
      "details": [
        "Best performing day: July 15th with \$8,450 revenue",
        "Top selling category: Electronics (42% of revenue)",
        "Peak sales hours: 2:00 PM - 4:00 PM",
        "Mobile transactions: 68% of total orders",
      ],
    },
    {
      "id": 2,
      "title": "Customer Engagement",
      "subtitle": "User Activity and Retention",
      "icon": Icons.people,
      "color": primaryColor,
      "value": 856.0,
      "change": -2.1,
      "changeType": "decrease",
      "metrics": [
        {"label": "Active Customers", "value": "856", "change": "-2.1%"},
        {"label": "New Registrations", "value": "143", "change": "+15.2%"},
        {"label": "Retention Rate", "value": "76.4%", "change": "+3.2%"},
        {"label": "Avg Session Time", "value": "8m 34s", "change": "+12.8%"},
      ],
      "details": [
        "Most active age group: 25-34 years (38% of users)",
        "Preferred login method: Social media (52%)",
        "Average pages per session: 4.7",
        "Bounce rate: 23.5% (improved from 28.1%)",
      ],
    },
    {
      "id": 3,
      "title": "Inventory Status",
      "subtitle": "Stock Levels and Movement",
      "icon": Icons.inventory,
      "color": warningColor,
      "value": 2340.0,
      "change": 5.8,
      "changeType": "increase",
      "metrics": [
        {"label": "Total Products", "value": "2,340", "change": "+5.8%"},
        {"label": "Low Stock Items", "value": "47", "change": "-12.4%"},
        {"label": "Out of Stock", "value": "12", "change": "+20.0%"},
        {"label": "Turnover Rate", "value": "2.3x", "change": "+8.5%"},
      ],
      "details": [
        "Fastest moving category: Smartphones (avg 2.1 days)",
        "Slowest moving: Home decor (avg 45.6 days)",
        "Restocking alerts sent: 23 items this week",
        "Supplier delivery time: 5.2 days average",
      ],
    },
    {
      "id": 4,
      "title": "Marketing Campaigns",
      "subtitle": "ROI and Campaign Performance",
      "icon": Icons.campaign,
      "color": infoColor,
      "value": 4.2,
      "change": 18.5,
      "changeType": "increase",
      "metrics": [
        {"label": "Campaign ROI", "value": "4.2x", "change": "+18.5%"},
        {"label": "Email Open Rate", "value": "24.7%", "change": "+3.1%"},
        {"label": "Click-through Rate", "value": "5.9%", "change": "+1.2%"},
        {"label": "Social Reach", "value": "45.2K", "change": "+22.3%"},
      ],
      "details": [
        "Best performing campaign: Summer Sale (ROI: 6.8x)",
        "Top traffic source: Instagram (32% of visits)",
        "Email subscribers: 12,450 (+240 this month)",
        "Ad spend efficiency: \$2.40 per acquisition",
      ],
    },
    {
      "id": 5,
      "title": "System Performance",
      "subtitle": "Technical Metrics and Uptime",
      "icon": Icons.speed,
      "color": secondaryColor,
      "value": 99.8,
      "change": 0.2,
      "changeType": "increase",
      "metrics": [
        {"label": "System Uptime", "value": "99.8%", "change": "+0.2%"},
        {"label": "Page Load Time", "value": "1.3s", "change": "-8.5%"},
        {"label": "Error Rate", "value": "0.12%", "change": "-15.3%"},
        {"label": "API Response", "value": "145ms", "change": "-12.1%"},
      ],
      "details": [
        "Server response time: 89ms average",
        "Database query efficiency: 94.2%",
        "CDN cache hit rate: 87.5%",
        "Peak concurrent users: 2,340 (July 20th)",
      ],
    },
    {
      "id": 6,
      "title": "Financial Health",
      "subtitle": "Profit Margins and Expenses",
      "icon": Icons.account_balance,
      "color": dangerColor,
      "value": 23.4,
      "change": -1.8,
      "changeType": "decrease",
      "metrics": [
        {"label": "Gross Margin", "value": "23.4%", "change": "-1.8%"},
        {"label": "Operating Costs", "value": "\$84,230", "change": "+4.2%"},
        {"label": "Net Profit", "value": "\$29,380", "change": "+7.1%"},
        {"label": "Cash Flow", "value": "\$156,780", "change": "+9.3%"},
      ],
      "details": [
        "Highest expense: Marketing (34% of costs)",
        "Cost per acquisition: \$18.50",
        "Customer lifetime value: \$240.80",
        "Break-even point: 1,250 orders/month",
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredCategories {
    List<Map<String, dynamic>> filtered = statusCategories;
    
    if (selectedType != "All") {
      filtered = filtered.where((category) {
        String title = category["title"] as String;
        switch (selectedType) {
          case "Revenue":
            return title.contains("Sales") || title.contains("Financial");
          case "Orders":
            return title.contains("Sales") || title.contains("Customer");
          case "Customers":
            return title.contains("Customer") || title.contains("Marketing");
          case "Products":
            return title.contains("Inventory") || title.contains("Sales");
          default:
            return true;
        }
      }).toList();
    }
    
    return filtered;
  }

  Widget _buildOverallSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Overall Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Revenue",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "\$${((overallStats["totalRevenue"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Growth Rate",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "+${(overallStats["growthRate"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Icon(
                          Icons.trending_up,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              _buildMiniStat("Orders", "${overallStats["totalOrders"]}"),
              SizedBox(width: spSm),
              _buildMiniStat("Customers", "${overallStats["totalCustomers"]}"),
              SizedBox(width: spSm),
              _buildMiniStat("AOV", "\$${((overallStats["averageOrderValue"] as double)).currency}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(40),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withAlpha(200),
              ),
            ),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(Map<String, dynamic> category) {
    Color categoryColor = category["color"] as Color;
    bool isPositive = category["changeType"] == "increase";
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(color: categoryColor.withAlpha(50)),
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: categoryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    category["icon"] as IconData,
                    color: categoryColor,
                    size: 28,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${category["title"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${category["subtitle"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: isPositive ? successColor : dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositive ? Icons.trending_up : Icons.trending_down,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${isPositive ? '+' : ''}${(category["change"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Metrics Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 140,
              children: (category["metrics"] as List).map((metric) {
                bool metricPositive = (metric["change"] as String).startsWith('+');
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: categoryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: categoryColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${metric["label"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${metric["value"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            metricPositive ? Icons.arrow_upward : Icons.arrow_downward,
                            color: metricPositive ? successColor : dangerColor,
                            size: 14,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${metric["change"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: metricPositive ? successColor : dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spSm),
            
            // Insights
            Text(
              "Key Insights:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spXs),
            
            Column(
              children: (category["details"] as List).map((detail) => 
                Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: categoryColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "$detail",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ).toList(),
            ),
            
            SizedBox(height: spSm),
            
            // Action Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "View Detailed Report",
                size: bs.sm,
                onPressed: () {
                  si("Detailed report for ${category["title"]} opened");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Analytics"),
        actions: [
          GestureDetector(
            onTap: () {
              showDetailsView = !showDetailsView;
              setState(() {});
            },
            child: Icon(
              showDetailsView ? Icons.view_list : Icons.dashboard,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(width: spSm),
          Icon(Icons.download, color: disabledBoldColor),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Summary
            _buildOverallSummary(),
            
            SizedBox(height: spMd),
            
            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Period",
                      items: periodOptions,
                      value: selectedPeriod,
                      onChanged: (value, label) {
                        selectedPeriod = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Category",
                      items: typeOptions,
                      value: selectedType,
                      onChanged: (value, label) {
                        selectedType = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Results Header
            Row(
              children: [
                Text(
                  "Performance Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredCategories.length} categories",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Status Categories
            if (filteredCategories.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.analytics,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Data Available",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredCategories.map((category) => _buildStatusCard(category)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
