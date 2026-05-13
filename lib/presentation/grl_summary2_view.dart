import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSummary2View extends StatefulWidget {
  @override
  State<GrlSummary2View> createState() => _GrlSummary2ViewState();
}

class _GrlSummary2ViewState extends State<GrlSummary2View> {
  String selectedPeriod = "This Quarter";
  String selectedDepartment = "All Departments";
  String selectedMetric = "Growth";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "All Departments"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Operations", "value": "Operations"},
    {"label": "Customer Service", "value": "Customer Service"},
  ];

  List<Map<String, dynamic>> metricOptions = [
    {"label": "Growth", "value": "Growth"},
    {"label": "Performance", "value": "Performance"},
    {"label": "Efficiency", "value": "Efficiency"},
    {"label": "Quality", "value": "Quality"},
  ];

  List<Map<String, dynamic>> operationalMetrics = [
    {
      "title": "Total Orders",
      "value": 15847,
      "change": 12.5,
      "trend": "up",
      "target": 16000,
      "icon": Icons.shopping_cart,
      "color": Colors.blue,
    },
    {
      "title": "Active Customers",
      "value": 8924,
      "change": 8.3,
      "trend": "up",
      "target": 9000,
      "icon": Icons.people,
      "color": Colors.green,
    },
    {
      "title": "Product Returns",
      "value": 234,
      "change": -15.2,
      "trend": "down",
      "target": 200,
      "icon": Icons.assignment_return,
      "color": Colors.orange,
    },
    {
      "title": "Support Tickets",
      "value": 456,
      "change": -8.7,
      "trend": "down",
      "target": 400,
      "icon": Icons.support_agent,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> departmentPerformance = [
    {
      "department": "Sales",
      "revenue": 2450000,
      "target": 2500000,
      "efficiency": 89.2,
      "satisfaction": 4.3,
      "growth": 15.8,
      "color": Colors.blue,
    },
    {
      "department": "Marketing",
      "revenue": 890000,
      "target": 950000,
      "efficiency": 78.4,
      "satisfaction": 4.1,
      "growth": 22.3,
      "color": Colors.green,
    },
    {
      "department": "Operations",
      "revenue": 1650000,
      "target": 1600000,
      "efficiency": 92.1,
      "satisfaction": 4.5,
      "growth": 8.9,
      "color": Colors.orange,
    },
    {
      "department": "Customer Service",
      "revenue": 450000,
      "target": 500000,
      "efficiency": 85.6,
      "satisfaction": 4.7,
      "growth": 11.2,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> monthlyTrends = [
    {"month": "Jan", "orders": 1200, "revenue": 420000, "customers": 850},
    {"month": "Feb", "orders": 1350, "revenue": 465000, "customers": 920},
    {"month": "Mar", "orders": 1480, "revenue": 512000, "customers": 980},
    {"month": "Apr", "orders": 1620, "revenue": 578000, "customers": 1050},
    {"month": "May", "orders": 1755, "revenue": 625000, "customers": 1120},
    {"month": "Jun", "orders": 1890, "revenue": 672000, "customers": 1200},
  ];

  List<Map<String, dynamic>> keyInsights = [
    {
      "title": "Revenue Growth Acceleration",
      "description": "Q2 revenue grew 18.5% compared to Q1, exceeding target by 12%",
      "impact": "High",
      "category": "Financial",
      "action": "Continue current marketing strategy",
    },
    {
      "title": "Customer Acquisition Surge",
      "description": "New customer acquisition increased 25% with improved conversion rates",
      "impact": "High",
      "category": "Growth",
      "action": "Scale successful acquisition channels",
    },
    {
      "title": "Operational Efficiency Gains",
      "description": "Process optimization reduced operational costs by 8.3%",
      "impact": "Medium",
      "category": "Operations",
      "action": "Implement across all departments",
    },
    {
      "title": "Customer Satisfaction Peak",
      "description": "Average satisfaction score reached 4.4/5, highest in company history",
      "impact": "Medium",
      "category": "Quality",
      "action": "Document and replicate best practices",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Operational Summary"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            SizedBox(height: spLg),
            _buildSummaryCards(),
            SizedBox(height: spLg),
            _buildDepartmentPerformance(),
            SizedBox(height: spLg),
            _buildTrendsChart(),
            SizedBox(height: spLg),
            _buildKeyInsights(),
            SizedBox(height: spLg),
            _buildActionItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filter Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
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
                  label: "Department",
                  items: departmentOptions,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Focus Metric",
            items: metricOptions,
            value: selectedMetric,
            onChanged: (value, label) {
              selectedMetric = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Operational Metrics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: operationalMetrics.map((metric) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
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
                          color: (metric["color"] as Color).withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          metric["icon"] as IconData,
                          color: metric["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${metric["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${(metric["value"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        metric["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                        color: metric["trend"] == "up" ? successColor : dangerColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${metric["change"] > 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: metric["trend"] == "up" ? successColor : dangerColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: (metric["value"] as int) / (metric["target"] as int),
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(metric["color"] as Color),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Target: ${(metric["target"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
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
    );
  }

  Widget _buildDepartmentPerformance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Department Performance",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: departmentPerformance.map((dept) {
              double targetProgress = (dept["revenue"] as int) / (dept["target"] as int);
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: disabledColor,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: dept["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${dept["department"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: targetProgress >= 1.0 ? successColor.withAlpha(25) : warningColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(targetProgress * 100).toStringAsFixed(0)}% of target",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: targetProgress >= 1.0 ? successColor : warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Revenue",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${((dept["revenue"] as int) / 1000).toStringAsFixed(0)}K",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
                                "Efficiency",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${(dept["efficiency"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
                                "Growth",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "+${(dept["growth"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
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
                                "Rating",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: warningColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${(dept["satisfaction"] as double).toStringAsFixed(1)}",
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
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    LinearProgressIndicator(
                      value: targetProgress > 1.0 ? 1.0 : targetProgress,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(dept["color"] as Color),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendsChart() {
    double maxRevenue = monthlyTrends.map((m) => m["revenue"] as int).reduce((a, b) => a > b ? a : b).toDouble();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Monthly Trends",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildLegendItem("Orders", Colors.blue),
                  _buildLegendItem("Revenue", Colors.green),
                  _buildLegendItem("Customers", Colors.orange),
                ],
              ),
              SizedBox(height: spMd),
              Container(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: monthlyTrends.map((month) {
                    double revenueHeight = ((month["revenue"] as int) / maxRevenue) * 150;
                    
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 40,
                          height: revenueHeight,
                          decoration: BoxDecoration(
                            color: Colors.green.withAlpha(180),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${month["month"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
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
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildKeyInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Key Insights",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          children: keyInsights.map((insight) {
            Color impactColor = insight["impact"] == "High" ? dangerColor : 
                              insight["impact"] == "Medium" ? warningColor : infoColor;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: impactColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: impactColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${insight["impact"]} Impact",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: impactColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${insight["category"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${insight["title"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${insight["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: warningColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Action: ${insight["action"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
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
    );
  }

  Widget _buildActionItems() {
    List<Map<String, dynamic>> actionItems = [
      {
        "title": "Scale Marketing Campaigns",
        "priority": "High",
        "dueDate": "End of Week",
        "department": "Marketing",
        "description": "Increase budget allocation for top-performing channels",
      },
      {
        "title": "Optimize Inventory Levels",
        "priority": "Medium",
        "dueDate": "Next Month",
        "department": "Operations",
        "description": "Reduce excess inventory while maintaining stock levels",
      },
      {
        "title": "Customer Service Training",
        "priority": "Medium",
        "dueDate": "2 Weeks",
        "department": "Customer Service",
        "description": "Implement new training program to maintain satisfaction levels",
      },
      {
        "title": "Process Documentation",
        "priority": "Low",
        "dueDate": "Next Quarter",
        "department": "All",
        "description": "Document successful processes for company-wide implementation",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recommended Actions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          children: actionItems.map((action) {
            Color priorityColor = action["priority"] == "High" ? dangerColor :
                                 action["priority"] == "Medium" ? warningColor : infoColor;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 60,
                    decoration: BoxDecoration(
                      color: priorityColor,
                      borderRadius: BorderRadius.circular(radiusXs),
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
                              "${action["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: priorityColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${action["priority"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: priorityColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${action["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${action["department"]} • Due: ${action["dueDate"]}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.arrow_forward,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
