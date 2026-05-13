import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CshAgentReportsView extends StatefulWidget {
  const CshAgentReportsView({super.key});

  @override
  State<CshAgentReportsView> createState() => _CshAgentReportsViewState();
}

class _CshAgentReportsViewState extends State<CshAgentReportsView> {
  String selectedPeriod = "This Month";
  String selectedAgent = "All Agents";
  String selectedMetric = "All Metrics";
  
  List<Map<String, dynamic>> reportPeriods = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> agents = [
    {"label": "All Agents", "value": "All Agents"},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Mike Chen", "value": "Mike Chen"},
    {"label": "Emily Davis", "value": "Emily Davis"},
    {"label": "David Wilson", "value": "David Wilson"},
    {"label": "Lisa Brown", "value": "Lisa Brown"},
  ];

  List<Map<String, dynamic>> metrics = [
    {"label": "All Metrics", "value": "All Metrics"},
    {"label": "Response Time", "value": "Response Time"},
    {"label": "Resolution Rate", "value": "Resolution Rate"},
    {"label": "Customer Satisfaction", "value": "Customer Satisfaction"},
    {"label": "Ticket Volume", "value": "Ticket Volume"},
    {"label": "First Contact Resolution", "value": "First Contact Resolution"},
  ];

  List<Map<String, dynamic>> agentPerformance = [
    {
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/60/60?random=1",
      "ticketsHandled": 145,
      "avgResponseTime": "2m 15s",
      "resolutionRate": 94.5,
      "satisfaction": 4.8,
      "status": "online",
      "department": "Technical Support"
    },
    {
      "name": "Mike Chen",
      "avatar": "https://picsum.photos/60/60?random=2",
      "ticketsHandled": 132,
      "avgResponseTime": "1m 45s",
      "resolutionRate": 96.2,
      "satisfaction": 4.9,
      "status": "online",
      "department": "Sales Support"
    },
    {
      "name": "Emily Davis",
      "avatar": "https://picsum.photos/60/60?random=3",
      "ticketsHandled": 118,
      "avgResponseTime": "3m 02s",
      "resolutionRate": 92.1,
      "satisfaction": 4.6,
      "status": "away",
      "department": "Billing Support"
    },
    {
      "name": "David Wilson",
      "avatar": "https://picsum.photos/60/60?random=4",
      "ticketsHandled": 156,
      "avgResponseTime": "2m 38s",
      "resolutionRate": 91.8,
      "satisfaction": 4.7,
      "status": "online",
      "department": "Technical Support"
    },
    {
      "name": "Lisa Brown",
      "avatar": "https://picsum.photos/60/60?random=5",
      "ticketsHandled": 109,
      "avgResponseTime": "2m 55s",
      "resolutionRate": 93.4,
      "satisfaction": 4.5,
      "status": "offline",
      "department": "General Support"
    },
  ];

  List<Map<String, dynamic>> performanceMetrics = [
    {
      "title": "Average Response Time",
      "value": "2m 27s",
      "change": -15.2,
      "icon": Icons.timer,
      "color": successColor,
    },
    {
      "title": "Resolution Rate",
      "value": "93.6%",
      "change": 2.3,
      "icon": Icons.check_circle,
      "color": primaryColor,
    },
    {
      "title": "Customer Satisfaction",
      "value": "4.7",
      "change": 0.2,
      "icon": Icons.star,
      "color": warningColor,
    },
    {
      "title": "First Contact Resolution",
      "value": "78.4%",
      "change": 3.1,
      "icon": Icons.touch_app,
      "color": infoColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agent Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Report exported successfully");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Report shared successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Report Filters",
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
                        child: QDropdownField(
                          label: "Period",
                          items: reportPeriods,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Agent",
                          items: agents,
                          value: selectedAgent,
                          onChanged: (value, label) {
                            selectedAgent = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Metric",
                    items: metrics,
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Performance Metrics Overview
            Text(
              "Performance Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: performanceMetrics.map((metric) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              metric["icon"] as IconData,
                              size: 20,
                              color: metric["color"] as Color,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (metric["change"] as double) >= 0
                                  ? successColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (metric["change"] as double) >= 0
                                    ? successColor
                                    : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${metric["value"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Agent Performance List
            Text(
              "Agent Performance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: agentPerformance.map((agent) {
                  int index = agentPerformance.indexOf(agent);
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: index < agentPerformance.length - 1
                            ? BorderSide(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              )
                            : BorderSide.none,
                      ),
                    ),
                    child: Row(
                      spacing: spSm,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage("${agent["avatar"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: agent["status"] == "online"
                                      ? successColor
                                      : agent["status"] == "away"
                                          ? warningColor
                                          : disabledColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${agent["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${agent["department"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: spMd,
                                children: [
                                  Column(
                                    spacing: 2,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Tickets",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${agent["ticketsHandled"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    spacing: 2,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Avg Response",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${agent["avgResponseTime"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    spacing: 2,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Resolution",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${(agent["resolutionRate"] as double).toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    spacing: 2,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Satisfaction",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Row(
                                        spacing: 4,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 14,
                                            color: warningColor,
                                          ),
                                          Text(
                                            "${agent["satisfaction"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Generate Report",
                    icon: Icons.assessment,
                    size: bs.md,
                    onPressed: () {
                      ss("Detailed report generated successfully");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Schedule Report",
                    icon: Icons.schedule,
                    size: bs.md,
                    onPressed: () {
                      ss("Report scheduled successfully");
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
}
