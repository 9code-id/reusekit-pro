import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMetric2View extends StatefulWidget {
  const GrlMetric2View({Key? key}) : super(key: key);

  @override
  State<GrlMetric2View> createState() => _GrlMetric2ViewState();
}

class _GrlMetric2ViewState extends State<GrlMetric2View> {
  int currentTab = 0;
  
  // Sales Metrics
  List<Map<String, dynamic>> salesData = [
    {
      "title": "Total Revenue",
      "value": 285750.00,
      "change": 15.8,
      "target": 300000.00,
      "icon": Icons.attach_money,
      "period": "This Quarter"
    },
    {
      "title": "New Customers",
      "value": 1247,
      "change": 22.3,
      "target": 1500,
      "icon": Icons.person_add,
      "period": "This Month"
    },
    {
      "title": "Average Order Value",
      "value": 156.80,
      "change": -2.1,
      "target": 165.00,
      "icon": Icons.shopping_bag,
      "period": "This Month"
    },
    {
      "title": "Conversion Rate",
      "value": 4.2,
      "change": 8.5,
      "target": 5.0,
      "icon": Icons.trending_up,
      "period": "This Week"
    }
  ];

  // Marketing Metrics
  List<Map<String, dynamic>> marketingData = [
    {
      "title": "Website Traffic",
      "value": 98750,
      "change": 18.6,
      "target": 120000,
      "icon": Icons.web,
      "period": "This Month"
    },
    {
      "title": "Social Media Reach",
      "value": 456800,
      "change": 25.4,
      "target": 500000,
      "icon": Icons.share,
      "period": "This Month"
    },
    {
      "title": "Email Open Rate",
      "value": 28.5,
      "change": 5.2,
      "target": 35.0,
      "icon": Icons.email,
      "period": "This Month"
    },
    {
      "title": "Cost Per Lead",
      "value": 24.50,
      "change": -12.3,
      "target": 20.00,
      "icon": Icons.paid,
      "period": "This Month"
    }
  ];

  // Operations Metrics
  List<Map<String, dynamic>> operationsData = [
    {
      "title": "Order Fulfillment",
      "value": 96.8,
      "change": 3.2,
      "target": 98.0,
      "icon": Icons.inventory,
      "period": "This Week"
    },
    {
      "title": "Customer Satisfaction",
      "value": 4.6,
      "change": 4.5,
      "target": 4.8,
      "icon": Icons.star,
      "period": "This Month"
    },
    {
      "title": "Support Response Time",
      "value": 2.3,
      "change": -18.7,
      "target": 2.0,
      "icon": Icons.support_agent,
      "period": "This Week"
    },
    {
      "title": "System Uptime",
      "value": 99.7,
      "change": 0.5,
      "target": 99.9,
      "icon": Icons.cloud_done,
      "period": "This Month"
    }
  ];

  List<Map<String, dynamic>> getCurrentTabData() {
    switch (currentTab) {
      case 0:
        return salesData;
      case 1:
        return marketingData;
      case 2:
        return operationsData;
      default:
        return salesData;
    }
  }

  String _formatValue(dynamic value, String title) {
    if (title.contains("Revenue") || title.contains("Value") || title.contains("Cost")) {
      return "\$${((value as double).toDouble()).currency}";
    } else if (title.contains("Rate") || title.contains("Uptime") || title.contains("Satisfaction")) {
      if (title.contains("Satisfaction")) {
        return "${(value as double).toStringAsFixed(1)}/5.0";
      }
      return "${(value as double).toStringAsFixed(1)}%";
    } else if (title.contains("Time")) {
      return "${(value as double).toStringAsFixed(1)}h";
    } else if ((value as num) >= 1000) {
      return "${((value as num) / 1000).toStringAsFixed(1)}K";
    }
    return "${value}";
  }

  String getTabTitle() {
    switch (currentTab) {
      case 0:
        return "Sales Performance";
      case 1:
        return "Marketing Analytics";
      case 2:
        return "Operations Metrics";
      default:
        return "Business Metrics";
    }
  }

  String getTabDescription() {
    switch (currentTab) {
      case 0:
        return "Revenue, customers, and sales conversion tracking";
      case 1:
        return "Digital marketing performance and ROI analysis";
      case 2:
        return "Operational efficiency and customer service metrics";
      default:
        return "Comprehensive business performance overview";
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Business Metrics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Sales", icon: Icon(Icons.trending_up)),
        Tab(text: "Marketing", icon: Icon(Icons.campaign)),
        Tab(text: "Operations", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildMetricsTab(),
        _buildMetricsTab(),
        _buildMetricsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }

  Widget _buildMetricsTab() {
    final currentData = getCurrentTabData();
    final totalMetrics = currentData.length;
    final positiveMetrics = currentData.where((metric) => (metric["change"] as double) >= 0).length;
    final averageChange = currentData.map((metric) => metric["change"] as double).reduce((a, b) => a + b) / totalMetrics;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      currentTab == 0 ? Icons.trending_up : currentTab == 1 ? Icons.campaign : Icons.settings,
                      color: primaryColor,
                      size: 28,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTabTitle(),
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            getTabDescription(),
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
                        color: averageChange >= 0 ? successColor : dangerColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            averageChange >= 0 ? Icons.trending_up : Icons.trending_down,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${averageChange.abs().toStringAsFixed(1)}%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Quick Stats
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Improving Metrics",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "$positiveMetrics of $totalMetrics",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
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
                          color: Colors.white.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Average Change",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${averageChange >= 0 ? '+' : ''}${averageChange.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: averageChange >= 0 ? successColor : dangerColor,
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

          SizedBox(height: spLg),

          // Metrics Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: currentData.map((metric) {
              final isPositive = (metric["change"] as double) >= 0;
              final progressValue = ((metric["value"] as num) / (metric["target"] as num)).clamp(0.0, 1.0);
              final changeColor = isPositive ? successColor : dangerColor;
              
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with icon and change
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            metric["icon"] as IconData,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: changeColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                                size: 12,
                                color: changeColor,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${(metric["change"] as double).abs().toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: changeColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Current Value
                    Text(
                      _formatValue(metric["value"], "${metric["title"]}"),
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spXs),
                    
                    // Title and Period
                    Text(
                      "${metric["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    Text(
                      "${metric["period"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Progress to target
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Target: ${_formatValue(metric["target"], "${metric["title"]}")}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${(progressValue * 100).toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: progressValue >= 1.0 ? successColor : warningColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          width: double.infinity,
                          height: 6,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: progressValue,
                            child: Container(
                              decoration: BoxDecoration(
                                color: progressValue >= 1.0 ? successColor : primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
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

          SizedBox(height: spLg),

          // Action Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Export Data",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () {
                          _exportTabData();
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        icon: Icons.analytics,
                        size: bs.sm,
                        onPressed: () {
                          _viewDetailedReport();
                        },
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Configure Alerts",
                    icon: Icons.notifications,
                    size: bs.sm,
                    onPressed: () {
                      _configureAlerts();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _exportTabData() {
    // Export tab data implementation
  }

  void _viewDetailedReport() {
    // View detailed report implementation
  }

  void _configureAlerts() {
    // Configure alerts implementation
  }
}
