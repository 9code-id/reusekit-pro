import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaRevenueView extends StatefulWidget {
  const EmaRevenueView({super.key});

  @override
  State<EmaRevenueView> createState() => _EmaRevenueViewState();
}

class _EmaRevenueViewState extends State<EmaRevenueView> {
  String selectedPeriod = "This Month";
  String selectedView = "Overview";
  
  List<String> periods = ["This Week", "This Month", "Last Month", "This Year"];
  List<String> viewOptions = ["Overview", "Participants", "Sessions", "Plans"];

  Map<String, dynamic> revenueData = {
    "totalRevenue": 45750.00,
    "monthlyRevenue": 12400.00,
    "participantRevenue": 8950.00,
    "sessionRevenue": 15200.00,
    "subscriptionRevenue": 21600.00,
    "growthRate": 15.8,
    "totalParticipants": 186,
    "activeParticipants": 142,
    "totalSessions": 1248,
    "avgSessionValue": 12.18,
  };

  List<Map<String, dynamic>> revenueStreams = [
    {
      "title": "Subscription Plans",
      "amount": 21600.00,
      "percentage": 47.2,
      "trend": 8.5,
      "icon": Icons.subscriptions,
      "color": primaryColor,
      "description": "Monthly and yearly subscription revenue",
    },
    {
      "title": "Session Fees",
      "amount": 15200.00,
      "percentage": 33.2,
      "trend": 12.3,
      "icon": Icons.psychology,
      "color": successColor,
      "description": "Individual therapy and consultation sessions",
    },
    {
      "title": "Participant Fees",
      "amount": 8950.00,
      "percentage": 19.6,
      "trend": -2.1,
      "icon": Icons.people,
      "color": warningColor,
      "description": "Research participation and assessment fees",
    },
  ];

  List<Map<String, dynamic>> monthlyData = [
    {"month": "Jan", "revenue": 38500, "participants": 165, "sessions": 1120},
    {"month": "Feb", "revenue": 41200, "participants": 172, "sessions": 1185},
    {"month": "Mar", "revenue": 39800, "participants": 168, "sessions": 1156},
    {"month": "Apr", "revenue": 43600, "participants": 178, "sessions": 1224},
    {"month": "May", "revenue": 45750, "participants": 186, "sessions": 1248},
  ];

  List<Map<String, dynamic>> topParticipants = [
    {
      "name": "Dr. Sarah Wilson",
      "revenue": 4250.00,
      "sessions": 48,
      "participants": 24,
      "avgSession": 88.54,
      "plan": "Premium",
    },
    {
      "name": "Research Team Alpha",
      "revenue": 3890.00,
      "sessions": 52,
      "participants": 31,
      "avgSession": 74.81,
      "plan": "Enterprise",
    },
    {
      "name": "Dr. Michael Chen",
      "revenue": 3650.00,
      "sessions": 42,
      "participants": 28,
      "avgSession": 86.90,
      "plan": "Premium",
    },
    {
      "name": "Psychology Dept",
      "revenue": 3200.00,
      "sessions": 38,
      "participants": 22,
      "avgSession": 84.21,
      "plan": "Standard",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EMA Revenue Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _exportRevenueReport();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // navigateTo('RevenueSettingsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Revenue Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Revenue Dashboard",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Track EMA platform earnings and growth",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(15),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.trending_up,
                              size: 16,
                              color: successColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "+${(revenueData["growthRate"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${((revenueData["totalRevenue"] as double) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Revenue",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: disabledOutlineBorderColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${((revenueData["monthlyRevenue"] as double) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "This Month",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: disabledOutlineBorderColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${revenueData["activeParticipants"]}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Active Users",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
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

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: periods.map((period) => {
                      "label": period,
                      "value": period,
                    }).toList(),
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
                    label: "View",
                    items: viewOptions.map((view) => {
                      "label": view,
                      "value": view,
                    }).toList(),
                    value: selectedView,
                    onChanged: (value, label) {
                      selectedView = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Revenue Streams
            Text(
              "Revenue Streams",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              spacing: spSm,
              children: revenueStreams.map((stream) {
                Color streamColor = stream["color"];
                double trend = stream["trend"];
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: streamColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: streamColor.withAlpha(15),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stream["icon"],
                              size: 24,
                              color: streamColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${stream["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${stream["description"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            spacing: spXs,
                            children: [
                              Text(
                                "\$${((stream["amount"] as double) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: streamColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: trend >= 0 
                                      ? successColor.withAlpha(15)
                                      : dangerColor.withAlpha(15),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      trend >= 0 ? Icons.trending_up : Icons.trending_down,
                                      size: 12,
                                      color: trend >= 0 ? successColor : dangerColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${trend >= 0 ? '+' : ''}${trend.toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        color: trend >= 0 ? successColor : dangerColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Text(
                            "${(stream["percentage"] as double).toStringAsFixed(1)}% of total revenue",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 100,
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (stream["percentage"] as double) / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: streamColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
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

            // Monthly Trend Chart
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Monthly Revenue Trend",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    height: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: monthlyData.map((data) {
                        double revenue = (data["revenue"] as int).toDouble();
                        double maxRevenue = monthlyData
                            .map((d) => d["revenue"] as int)
                            .reduce((a, b) => a > b ? a : b)
                            .toDouble();
                        
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: (revenue / maxRevenue) * 150,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${data["month"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "\$${(revenue / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Top Participants
            Text(
              "Top Revenue Contributors",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              spacing: spSm,
              children: topParticipants.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> participant = entry.value;
                Color rankColor = index == 0 ? dangerColor : 
                                 index == 1 ? warningColor : 
                                 index == 2 ? successColor : primaryColor;
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: rankColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: rankColor.withAlpha(15),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Center(
                              child: Text(
                                "#${index + 1}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: rankColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${participant["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${participant["plan"]} Plan",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            spacing: spXs,
                            children: [
                              Text(
                                "\$${((participant["revenue"] as double) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: rankColor,
                                ),
                              ),
                              Text(
                                "Total Revenue",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${participant["sessions"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Sessions",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: disabledOutlineBorderColor,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${participant["participants"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Clients",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: disabledOutlineBorderColor,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "\$${(participant["avgSession"] as double).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                  ),
                                ),
                                Text(
                                  "Avg/Session",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 10,
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

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Revenue Actions",
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
                          label: "Export Report",
                          size: bs.sm,
                          onPressed: () {
                            _exportRevenueReport();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('DetailedRevenueView')
                          },
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
    );
  }

  void _exportRevenueReport() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Revenue report exported successfully!");
    });
  }
}
