import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaRevenueTrackingView extends StatefulWidget {
  const RmaRevenueTrackingView({super.key});

  @override
  State<RmaRevenueTrackingView> createState() => _RmaRevenueTrackingViewState();
}

class _RmaRevenueTrackingViewState extends State<RmaRevenueTrackingView> {
  int selectedTabIndex = 0;
  String searchQuery = "";
  String selectedPeriod = "current_month";
  String selectedSource = "all";
  String selectedRegion = "all";
  
  List<Map<String, dynamic>> revenueStreams = [
    {
      "name": "RMA Processing Fees",
      "current_month": 45000.00,
      "last_month": 42000.00,
      "growth": 7.1,
      "percentage": 35.5,
      "color": Colors.blue,
      "trend": "up",
    },
    {
      "name": "Premium Support Services",
      "current_month": 28000.00,
      "last_month": 31000.00,
      "growth": -9.7,
      "percentage": 22.1,
      "color": Colors.green,
      "trend": "down",
    },
    {
      "name": "Extended Warranty",
      "current_month": 32000.00,
      "last_month": 29000.00,
      "growth": 10.3,
      "percentage": 25.2,
      "color": Colors.orange,
      "trend": "up",
    },
    {
      "name": "Shipping & Handling",
      "current_month": 15000.00,
      "last_month": 14500.00,
      "growth": 3.4,
      "percentage": 11.8,
      "color": Colors.purple,
      "trend": "up",
    },
    {
      "name": "Rush Processing",
      "current_month": 7000.00,
      "last_month": 6200.00,
      "growth": 12.9,
      "percentage": 5.5,
      "color": Colors.red,
      "trend": "up",
    },
  ];

  List<Map<String, dynamic>> monthlyRevenue = [
    {
      "month": "Jan 2024",
      "revenue": 98000.00,
      "transactions": 2450,
      "avg_value": 40.00,
      "growth": 5.2,
    },
    {
      "month": "Feb 2024",
      "revenue": 105000.00,
      "transactions": 2680,
      "avg_value": 39.18,
      "growth": 7.1,
    },
    {
      "month": "Mar 2024",
      "revenue": 115000.00,
      "transactions": 2890,
      "avg_value": 39.79,
      "growth": 9.5,
    },
    {
      "month": "Apr 2024",
      "revenue": 108000.00,
      "transactions": 2720,
      "avg_value": 39.71,
      "growth": -6.1,
    },
    {
      "month": "May 2024",
      "revenue": 122000.00,
      "transactions": 3050,
      "avg_value": 40.00,
      "growth": 13.0,
    },
    {
      "month": "Jun 2024",
      "revenue": 118000.00,
      "transactions": 2980,
      "avg_value": 39.60,
      "growth": -3.3,
    },
    {
      "month": "Jul 2024",
      "revenue": 132000.00,
      "transactions": 3200,
      "avg_value": 41.25,
      "growth": 11.9,
    },
    {
      "month": "Aug 2024",
      "revenue": 128000.00,
      "transactions": 3150,
      "avg_value": 40.63,
      "growth": -3.0,
    },
    {
      "month": "Sep 2024",
      "revenue": 135000.00,
      "transactions": 3380,
      "avg_value": 39.94,
      "growth": 5.5,
    },
    {
      "month": "Oct 2024",
      "revenue": 142000.00,
      "transactions": 3520,
      "avg_value": 40.34,
      "growth": 5.2,
    },
    {
      "month": "Nov 2024",
      "revenue": 138000.00,
      "transactions": 3450,
      "avg_value": 40.00,
      "growth": -2.8,
    },
    {
      "month": "Dec 2024",
      "revenue": 127000.00,
      "transactions": 3180,
      "avg_value": 39.94,
      "growth": -8.0,
    },
  ];

  List<Map<String, dynamic>> regionalRevenue = [
    {
      "region": "North America",
      "revenue": 85000.00,
      "percentage": 67.0,
      "growth": 8.5,
      "transactions": 2150,
    },
    {
      "region": "Europe",
      "revenue": 28000.00,
      "percentage": 22.0,
      "growth": 12.3,
      "transactions": 720,
    },
    {
      "region": "Asia Pacific",
      "revenue": 10000.00,
      "percentage": 7.9,
      "growth": 15.8,
      "transactions": 250,
    },
    {
      "region": "Latin America",
      "revenue": 4000.00,
      "percentage": 3.1,
      "growth": 6.2,
      "transactions": 98,
    },
  ];

  List<Map<String, dynamic>> topCustomers = [
    {
      "name": "TechCorp Solutions",
      "revenue": 12500.00,
      "transactions": 89,
      "avg_value": 140.45,
      "type": "Enterprise",
      "growth": 18.5,
    },
    {
      "name": "Global Electronics",
      "revenue": 8900.00,
      "transactions": 156,
      "avg_value": 57.05,
      "type": "Business",
      "growth": 12.3,
    },
    {
      "name": "Innovate Systems",
      "revenue": 7200.00,
      "transactions": 42,
      "avg_value": 171.43,
      "type": "Enterprise",
      "growth": 25.8,
    },
    {
      "name": "Digital Dynamics",
      "revenue": 6800.00,
      "transactions": 78,
      "avg_value": 87.18,
      "type": "Business",
      "growth": 8.9,
    },
    {
      "name": "Future Tech Inc",
      "revenue": 5500.00,
      "transactions": 63,
      "avg_value": 87.30,
      "type": "Business",
      "growth": 15.2,
    },
  ];

  Widget _buildOverviewTab() {
    double totalRevenue = revenueStreams.map((stream) => stream["current_month"] as double).fold(0.0, (a, b) => a + b);
    double totalGrowth = revenueStreams.map((stream) => stream["growth"] as double).fold(0.0, (a, b) => a + b) / revenueStreams.length;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Revenue Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          // Summary cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.monetization_on, color: successColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalRevenue.currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Revenue",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        totalGrowth >= 0 ? Icons.trending_up : Icons.trending_down,
                        color: totalGrowth >= 0 ? successColor : dangerColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${totalGrowth >= 0 ? '+' : ''}${totalGrowth.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: totalGrowth >= 0 ? successColor : dangerColor,
                        ),
                      ),
                      Text(
                        "Growth Rate",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Text(
            "Revenue Streams",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: revenueStreams.map((stream) {
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
                      color: stream["color"],
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
                            "${stream["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "\$${(stream["current_month"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (stream["growth"] as double) >= 0 ? successColor : dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${(stream["growth"] as double) >= 0 ? '+' : ''}${(stream["growth"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${(stream["percentage"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: stream["color"],
                          ),
                        ),
                        Text(
                          "of total",
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
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Revenue Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          // Period selector
          QDropdownField(
            label: "Time Period",
            items: [
              {"label": "Last 12 Months", "value": "last_12_months"},
              {"label": "Current Year", "value": "current_year"},
              {"label": "Last Quarter", "value": "last_quarter"},
              {"label": "Current Month", "value": "current_month"},
            ],
            value: selectedPeriod,
            onChanged: (value, label) {
              selectedPeriod = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          // Monthly revenue chart placeholder
          Container(
            height: 200,
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "Monthly Revenue Trend",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Expanded(
                  child: Center(
                    child: Icon(
                      Icons.show_chart,
                      size: 80,
                      color: disabledColor,
                    ),
                  ),
                ),
                Text(
                  "Chart visualization would be displayed here",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          Text(
            "Monthly Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: monthlyRevenue.take(6).map((month) {
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
                            "${month["month"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${(month["revenue"] as double).currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              (month["growth"] as double) >= 0 ? Icons.trending_up : Icons.trending_down,
                              color: (month["growth"] as double) >= 0 ? successColor : dangerColor,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${(month["growth"] as double) >= 0 ? '+' : ''}${(month["growth"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: (month["growth"] as double) >= 0 ? successColor : dangerColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${month["transactions"]} transactions",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Avg: \$${(month["avg_value"] as double).toStringAsFixed(2)}",
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
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionalTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Regional Revenue",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: regionalRevenue.map((region) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                        Expanded(
                          child: Text(
                            "${region["region"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${(region["percentage"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: (region["percentage"] as double) / 100.0,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
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
                                "Revenue",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(region["revenue"] as double).currency}",
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
                                "Growth",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "+${(region["growth"] as double).toStringAsFixed(1)}%",
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
                                "Transactions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${region["transactions"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spMd),
          
          Text(
            "Top Revenue Customers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: topCustomers.map((customer) {
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
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: customer["type"] == "Enterprise" 
                            ? warningColor.withAlpha(51)
                            : infoColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        customer["type"] == "Enterprise" 
                            ? Icons.business
                            : Icons.store,
                        color: customer["type"] == "Enterprise" 
                            ? warningColor
                            : infoColor,
                        size: 24,
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "\$${(customer["revenue"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${customer["transactions"]} trans",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: customer["type"] == "Enterprise" ? warningColor : infoColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${customer["type"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "+${(customer["growth"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Revenue Tracking",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.monetization_on)),
        Tab(text: "Trends", icon: Icon(Icons.trending_up)),
        Tab(text: "Regional", icon: Icon(Icons.public)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildTrendsTab(),
        _buildRegionalTab(),
      ],
    );
  }
}
