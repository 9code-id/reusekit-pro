import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmResponseTimeAnalysisView extends StatefulWidget {
  const FsmResponseTimeAnalysisView({super.key});

  @override
  State<FsmResponseTimeAnalysisView> createState() => _FsmResponseTimeAnalysisViewState();
}

class _FsmResponseTimeAnalysisViewState extends State<FsmResponseTimeAnalysisView> {
  String selectedPeriod = "Last 30 Days";
  String selectedPriority = "All Priorities";
  String selectedRegion = "All Regions";
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priorities", "value": "All Priorities"},
    {"label": "Emergency", "value": "Emergency"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> regionItems = [
    {"label": "All Regions", "value": "All Regions"},
    {"label": "North Region", "value": "North Region"},
    {"label": "South Region", "value": "South Region"},
    {"label": "East Region", "value": "East Region"},
    {"label": "West Region", "value": "West Region"},
  ];

  List<Map<String, dynamic>> responseMetrics = [
    {
      "metric": "Average Response Time",
      "value": "2.3 hrs",
      "numericValue": 2.3,
      "target": 3.0,
      "change": -12.5,
      "icon": Icons.timer,
      "color": successColor,
    },
    {
      "metric": "Emergency Response",
      "value": "18 mins",
      "numericValue": 0.3,
      "target": 0.5,
      "change": -15.8,
      "icon": Icons.emergency,
      "color": dangerColor,
    },
    {
      "metric": "SLA Compliance",
      "value": "94.2%",
      "numericValue": 94.2,
      "target": 90.0,
      "change": 6.3,
      "icon": Icons.check_circle,
      "color": primaryColor,
    },
    {
      "metric": "Customer Waiting",
      "value": "1.8 hrs",
      "numericValue": 1.8,
      "target": 2.0,
      "change": -8.1,
      "icon": Icons.hourglass_empty,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> priorityBreakdown = [
    {
      "priority": "Emergency",
      "avgResponseTime": 0.3,
      "target": 0.5,
      "slaCompliance": 96.8,
      "count": 125,
      "color": dangerColor,
    },
    {
      "priority": "High",
      "avgResponseTime": 1.2,
      "target": 2.0,
      "slaCompliance": 95.4,
      "count": 298,
      "color": warningColor,
    },
    {
      "priority": "Medium",
      "avgResponseTime": 3.1,
      "target": 4.0,
      "slaCompliance": 93.7,
      "count": 542,
      "color": infoColor,
    },
    {
      "priority": "Low",
      "avgResponseTime": 8.7,
      "target": 24.0,
      "slaCompliance": 91.2,
      "count": 280,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> regionPerformance = [
    {
      "region": "North Region",
      "avgResponseTime": 2.1,
      "slaCompliance": 96.5,
      "teamSize": 12,
      "activeJobs": 45,
      "improvement": 8.2,
    },
    {
      "region": "South Region",
      "avgResponseTime": 2.3,
      "slaCompliance": 94.8,
      "teamSize": 10,
      "activeJobs": 38,
      "improvement": 5.1,
    },
    {
      "region": "East Region",
      "avgResponseTime": 2.5,
      "slaCompliance": 92.3,
      "teamSize": 8,
      "activeJobs": 32,
      "improvement": -2.3,
    },
    {
      "region": "West Region",
      "avgResponseTime": 2.8,
      "slaCompliance": 90.7,
      "teamSize": 9,
      "activeJobs": 41,
      "improvement": 1.7,
    },
  ];

  List<Map<String, dynamic>> hourlyTrends = [
    {"hour": "00:00", "avgTime": 1.2, "volume": 2},
    {"hour": "02:00", "avgTime": 1.5, "volume": 1},
    {"hour": "04:00", "avgTime": 2.1, "volume": 3},
    {"hour": "06:00", "avgTime": 2.8, "volume": 8},
    {"hour": "08:00", "avgTime": 3.2, "volume": 25},
    {"hour": "10:00", "avgTime": 2.9, "volume": 42},
    {"hour": "12:00", "avgTime": 2.4, "volume": 38},
    {"hour": "14:00", "avgTime": 2.7, "volume": 45},
    {"hour": "16:00", "avgTime": 3.1, "volume": 52},
    {"hour": "18:00", "avgTime": 2.6, "volume": 35},
    {"hour": "20:00", "avgTime": 2.2, "volume": 18},
    {"hour": "22:00", "avgTime": 1.8, "volume": 8},
  ];

  List<Map<String, dynamic>> responseFactors = [
    {"factor": "Traffic Conditions", "impact": "High", "avgDelay": 35, "percentage": 28.5},
    {"factor": "Technician Availability", "impact": "High", "avgDelay": 42, "percentage": 31.2},
    {"factor": "Distance to Location", "impact": "Medium", "avgDelay": 25, "percentage": 18.7},
    {"factor": "Equipment Preparation", "impact": "Medium", "avgDelay": 18, "percentage": 12.3},
    {"factor": "Customer Communication", "impact": "Low", "avgDelay": 12, "percentage": 9.3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Response Time Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.access_time),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.filter_list, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Analysis Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Period",
                          items: periodItems,
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
                          label: "Priority",
                          items: priorityItems,
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Region",
                    items: regionItems,
                    value: selectedRegion,
                    onChanged: (value, label) {
                      selectedRegion = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Response Metrics
            Text(
              "Response Time Metrics",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: responseMetrics.map((metric) {
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
                              color: (metric["color"] as Color).withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"] as IconData,
                              color: metric["color"] as Color,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: (metric["change"] as double) <= 0 ? successColor.withAlpha(25) : dangerColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: (metric["change"] as double) <= 0 ? successColor : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["metric"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${metric["value"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Target: ${metric["target"]} ${metric["metric"].toString().contains("Time") ? "hrs" : metric["metric"].toString().contains("SLA") ? "%" : "mins"}",
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

            // Priority Breakdown
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
                      Icon(Icons.priority_high, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Response Time by Priority",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: priorityBreakdown.map((priority) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (priority["color"] as Color).withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: (priority["color"] as Color).withAlpha(50)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 40,
                              decoration: BoxDecoration(
                                color: priority["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${priority["priority"]} Priority",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${priority["count"]} requests",
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
                                  "${(priority["avgResponseTime"] as double) < 1 ? '${((priority["avgResponseTime"] as double) * 60).round()} mins' : '${(priority["avgResponseTime"] as double).toStringAsFixed(1)} hrs'}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: priority["color"] as Color,
                                  ),
                                ),
                                Text(
                                  "${priority["slaCompliance"]}% SLA compliance",
                                  style: TextStyle(
                                    fontSize: 10,
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

            // Regional Performance
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
                      Icon(Icons.location_on, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Regional Performance",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: regionPerformance.map((region) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${region["region"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${(region["improvement"] as double) >= 0 ? '+' : ''}${(region["improvement"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: (region["improvement"] as double) >= 0 ? successColor : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${region["avgResponseTime"]} hrs",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Avg Response",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${region["slaCompliance"]}%",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "SLA Compliance",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${region["teamSize"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Team Size",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${region["activeJobs"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Active Jobs",
                                        style: TextStyle(
                                          fontSize: 10,
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
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Response Factors
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
                      Icon(Icons.analytics, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Response Time Factors",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: responseFactors.map((factor) {
                      Color impactColor = factor["impact"] == "High" ? dangerColor :
                                         factor["impact"] == "Medium" ? warningColor : successColor;
                      return Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: impactColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${factor["impact"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: impactColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${factor["factor"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "+${factor["avgDelay"]} mins (${(factor["percentage"] as double).toStringAsFixed(1)}%)",
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
                ],
              ),
            ),

            // Hourly Trends Preview
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
                      Icon(Icons.schedule, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Peak Hours Analysis",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: successColor.withAlpha(50)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Best Performance",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "22:00 - 04:00",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "1.8 hrs avg",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
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
                            color: dangerColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: dangerColor.withAlpha(50)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Peak Demand",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "14:00 - 18:00",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "3.1 hrs avg",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
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

            // Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Set Alerts",
                    icon: Icons.notifications,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
