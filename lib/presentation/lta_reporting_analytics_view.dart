import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaReportingAnalyticsView extends StatefulWidget {
  const LtaReportingAnalyticsView({super.key});

  @override
  State<LtaReportingAnalyticsView> createState() => _LtaReportingAnalyticsViewState();
}

class _LtaReportingAnalyticsViewState extends State<LtaReportingAnalyticsView> {
  String selectedPeriod = "This Month";
  String selectedReportType = "Overview";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"}
  ];

  List<Map<String, dynamic>> reportTypeOptions = [
    {"label": "Overview", "value": "Overview"},
    {"label": "Revenue", "value": "Revenue"},
    {"label": "Orders", "value": "Orders"},
    {"label": "Drivers", "value": "Drivers"},
    {"label": "Vehicles", "value": "Vehicles"},
    {"label": "Performance", "value": "Performance"}
  ];

  // Analytics Data
  Map<String, dynamic> overviewData = {
    "totalRevenue": 45750000.0,
    "totalOrders": 1247,
    "completedOrders": 1098,
    "pendingOrders": 84,
    "cancelledOrders": 65,
    "activeDrivers": 25,
    "totalDrivers": 30,
    "activeVehicles": 22,
    "totalVehicles": 28,
    "averageRating": 4.3,
    "totalDistance": 18450.5,
    "fuelConsumption": 2340.8,
    "customerSatisfaction": 88.5
  };

  List<Map<String, dynamic>> revenueData = [
    {"month": "Jan", "revenue": 3200000.0},
    {"month": "Feb", "revenue": 3500000.0},
    {"month": "Mar", "revenue": 3800000.0},
    {"month": "Apr", "revenue": 4100000.0},
    {"month": "May", "revenue": 3900000.0},
    {"month": "Jun", "revenue": 4200000.0},
    {"month": "Jul", "revenue": 4500000.0},
    {"month": "Aug", "revenue": 4300000.0},
    {"month": "Sep", "revenue": 4600000.0},
    {"month": "Oct", "revenue": 4800000.0},
    {"month": "Nov", "revenue": 4400000.0},
    {"month": "Dec", "revenue": 4750000.0}
  ];

  List<Map<String, dynamic>> topPerformers = [
    {
      "rank": 1,
      "driverName": "Ahmad Suryanto",
      "completedOrders": 156,
      "revenue": 3200000.0,
      "rating": 4.8,
      "vehicleNumber": "B 1234 XYZ"
    },
    {
      "rank": 2,
      "driverName": "Budi Santoso",
      "completedOrders": 142,
      "revenue": 2950000.0,
      "rating": 4.7,
      "vehicleNumber": "B 5678 ABC"
    },
    {
      "rank": 3,
      "driverName": "Sari Wulandari",
      "completedOrders": 138,
      "revenue": 2800000.0,
      "rating": 4.6,
      "vehicleNumber": "B 9012 DEF"
    },
    {
      "rank": 4,
      "driverName": "Eko Prasetyo",
      "completedOrders": 125,
      "revenue": 2600000.0,
      "rating": 4.5,
      "vehicleNumber": "B 3456 GHI"
    },
    {
      "rank": 5,
      "driverName": "Indra Kusuma",
      "completedOrders": 118,
      "revenue": 2450000.0,
      "rating": 4.4,
      "vehicleNumber": "B 7890 JKL"
    }
  ];

  List<Map<String, dynamic>> orderAnalytics = [
    {"status": "Completed", "count": 1098, "percentage": 88.1},
    {"status": "Pending", "count": 84, "percentage": 6.7},
    {"status": "Cancelled", "count": 65, "percentage": 5.2}
  ];

  List<Map<String, dynamic>> customerFeedback = [
    {"rating": 5, "count": 487, "percentage": 44.4},
    {"rating": 4, "count": 312, "percentage": 28.4},
    {"rating": 3, "count": 189, "percentage": 17.2},
    {"rating": 2, "count": 78, "percentage": 7.1},
    {"rating": 1, "count": 32, "percentage": 2.9}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reports & Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Report exported successfully");
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filter Options
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
                    label: "Report Type",
                    items: reportTypeOptions,
                    value: selectedReportType,
                    onChanged: (value, label) {
                      selectedReportType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Key Metrics Overview
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
                    "Key Performance Metrics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          "Total Revenue",
                          "Rp ${(overviewData["totalRevenue"] as double).currency}",
                          Icons.monetization_on,
                          successColor,
                          "+12.5%"
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildMetricCard(
                          "Completed Orders",
                          "${overviewData["completedOrders"]}",
                          Icons.check_circle,
                          primaryColor,
                          "+8.3%"
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          "Active Drivers",
                          "${overviewData["activeDrivers"]}/${overviewData["totalDrivers"]}",
                          Icons.person,
                          infoColor,
                          "83.3%"
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildMetricCard(
                          "Average Rating",
                          "${overviewData["averageRating"]}★",
                          Icons.star,
                          warningColor,
                          "+0.2"
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Revenue Trend Chart
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
                  Row(
                    children: [
                      Text(
                        "Revenue Trend",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Monthly",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    height: 200,
                    child: Column(
                      children: [
                        Expanded(
                          child: QHorizontalScroll(
                            children: revenueData.map((data) {
                              double maxRevenue = revenueData.map((d) => d["revenue"] as double).reduce((a, b) => a > b ? a : b);
                              double height = ((data["revenue"] as double) / maxRevenue) * 160;
                              
                              return Container(
                                width: 40,
                                margin: EdgeInsets.only(right: spSm),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: height,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${data["month"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
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

            // Order Status Analytics
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
                    "Order Status Distribution",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...orderAnalytics.map((data) {
                    Color statusColor = data["status"] == "Completed" 
                        ? successColor 
                        : data["status"] == "Pending" 
                            ? warningColor 
                            : dangerColor;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${data["status"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${data["count"]} (${(data["percentage"] as double).toStringAsFixed(1)}%)",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: (data["percentage"] as double) / 100,
                            backgroundColor: Colors.grey.withAlpha(30),
                            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Top Performers
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
                    "Top Performing Drivers",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: topPerformers.length,
                    separatorBuilder: (context, index) => SizedBox(height: spSm),
                    itemBuilder: (context, index) {
                      final performer = topPerformers[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: performer["rank"] <= 3 ? warningColor : disabledBoldColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "#${performer["rank"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${performer["driverName"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "${performer["vehicleNumber"]} • ${performer["completedOrders"]} orders",
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
                                  "Rp ${((performer["revenue"] as double) / 1000000).toStringAsFixed(1)}M",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.star, size: 12, color: warningColor),
                                    Text(
                                      " ${performer["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Customer Satisfaction
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
                  Row(
                    children: [
                      Text(
                        "Customer Satisfaction",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${overviewData["customerSatisfaction"]}%",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  ...customerFeedback.map((feedback) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < (feedback["rating"] as int) ? Icons.star : Icons.star_border,
                                size: 16,
                                color: index < (feedback["rating"] as int) ? warningColor : disabledBoldColor,
                              );
                            }),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: (feedback["percentage"] as double) / 100,
                              backgroundColor: Colors.grey.withAlpha(30),
                              valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${feedback["count"]} (${(feedback["percentage"] as double).toStringAsFixed(1)}%)",
                            style: TextStyle(
                              fontSize: 12,
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

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    size: bs.md,
                    onPressed: () {
                      ss("Report export initiated");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Schedule Report",
                    size: bs.md,
                    onPressed: () {
                      // Navigate to schedule report
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
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              Spacer(),
              Text(
                change,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
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
}
