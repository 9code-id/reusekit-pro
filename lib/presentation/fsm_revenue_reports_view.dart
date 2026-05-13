import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmRevenueReportsView extends StatefulWidget {
  const FsmRevenueReportsView({super.key});

  @override
  State<FsmRevenueReportsView> createState() => _FsmRevenueReportsViewState();
}

class _FsmRevenueReportsViewState extends State<FsmRevenueReportsView> {
  String selectedPeriod = "This Month";
  String selectedServiceType = "All Services";
  String selectedClient = "All Clients";
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> serviceTypeItems = [
    {"label": "All Services", "value": "All Services"},
    {"label": "Installation", "value": "Installation"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Repair", "value": "Repair"},
    {"label": "Emergency", "value": "Emergency"},
  ];

  List<Map<String, dynamic>> clientItems = [
    {"label": "All Clients", "value": "All Clients"},
    {"label": "Enterprise", "value": "Enterprise"},
    {"label": "Commercial", "value": "Commercial"},
    {"label": "Residential", "value": "Residential"},
  ];

  List<Map<String, dynamic>> revenueMetrics = [
    {
      "metric": "Total Revenue",
      "value": 485600,
      "target": 450000,
      "change": 12.8,
      "icon": Icons.monetization_on,
      "color": successColor,
    },
    {
      "metric": "Average Job Value",
      "value": 425.75,
      "target": 400.00,
      "change": 6.4,
      "icon": Icons.work,
      "color": primaryColor,
    },
    {
      "metric": "Monthly Recurring",
      "value": 125400,
      "target": 120000,
      "change": 4.5,
      "icon": Icons.refresh,
      "color": infoColor,
    },
    {
      "metric": "Profit Margin",
      "value": 32.5,
      "target": 30.0,
      "change": 8.3,
      "icon": Icons.trending_up,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> revenueBreakdown = [
    {"service": "Installation Services", "revenue": 165800, "percentage": 34.1, "color": primaryColor},
    {"service": "Maintenance Contracts", "revenue": 145200, "percentage": 29.9, "color": successColor},
    {"service": "Repair Services", "revenue": 98400, "percentage": 20.3, "color": warningColor},
    {"service": "Emergency Services", "revenue": 76200, "percentage": 15.7, "color": dangerColor},
  ];

  List<Map<String, dynamic>> topClients = [
    {
      "clientName": "TechCorp Industries",
      "clientType": "Enterprise",
      "revenue": 48500,
      "jobsCompleted": 24,
      "contractValue": "Annual",
      "growth": 15.2,
      "lastPayment": "2024-01-15",
    },
    {
      "clientName": "Downtown Office Complex",
      "clientType": "Commercial",
      "revenue": 36800,
      "jobsCompleted": 18,
      "contractValue": "Quarterly",
      "growth": 8.7,
      "lastPayment": "2024-01-14",
    },
    {
      "clientName": "Metro Shopping Center",
      "clientType": "Commercial",
      "revenue": 32400,
      "jobsCompleted": 16,
      "contractValue": "Monthly",
      "growth": 12.3,
      "lastPayment": "2024-01-13",
    },
    {
      "clientName": "Residential Services Group",
      "clientType": "Residential",
      "revenue": 28900,
      "jobsCompleted": 42,
      "contractValue": "One-time",
      "growth": 5.8,
      "lastPayment": "2024-01-12",
    },
    {
      "clientName": "Manufacturing Plus LLC",
      "clientType": "Enterprise",
      "revenue": 25600,
      "jobsCompleted": 12,
      "contractValue": "Bi-annual",
      "growth": 22.1,
      "lastPayment": "2024-01-11",
    },
  ];

  List<Map<String, dynamic>> monthlyTrends = [
    {"month": "Jan", "revenue": 485600, "target": 450000, "jobs": 1140},
    {"month": "Dec", "revenue": 462300, "target": 450000, "jobs": 1085},
    {"month": "Nov", "revenue": 448900, "target": 420000, "jobs": 1052},
    {"month": "Oct", "revenue": 435200, "target": 420000, "jobs": 1021},
    {"month": "Sep", "revenue": 421800, "target": 400000, "jobs": 995},
    {"month": "Aug", "revenue": 408500, "target": 400000, "jobs": 967},
  ];

  List<Map<String, dynamic>> servicePerformance = [
    {
      "service": "HVAC Installation",
      "revenue": 128500,
      "margin": 35.2,
      "jobs": 185,
      "avgValue": 694.59,
      "growth": 18.4,
    },
    {
      "service": "Electrical Maintenance",
      "revenue": 96800,
      "margin": 42.1,
      "jobs": 245,
      "avgValue": 395.10,
      "growth": 12.7,
    },
    {
      "service": "Plumbing Repair",
      "revenue": 85400,
      "margin": 28.9,
      "jobs": 312,
      "avgValue": 273.72,
      "growth": 8.3,
    },
    {
      "service": "Emergency HVAC",
      "revenue": 76200,
      "margin": 45.8,
      "jobs": 98,
      "avgValue": 777.55,
      "growth": 25.1,
    },
    {
      "service": "Appliance Service",
      "revenue": 58700,
      "margin": 31.5,
      "jobs": 189,
      "avgValue": 310.58,
      "growth": 6.2,
    },
  ];

  List<Map<String, dynamic>> revenueOpportunities = [
    {
      "opportunity": "Preventive Maintenance Upsell",
      "potentialRevenue": 85000,
      "probability": "High",
      "timeframe": "3 months",
      "description": "Convert one-time repair customers to maintenance contracts",
    },
    {
      "opportunity": "Emergency Service Premium",
      "potentialRevenue": 45000,
      "probability": "Medium",
      "timeframe": "1 month",
      "description": "Implement premium pricing for after-hours emergency services",
    },
    {
      "opportunity": "Enterprise Contract Expansion",
      "potentialRevenue": 120000,
      "probability": "High",
      "timeframe": "6 months",
      "description": "Expand services with existing enterprise clients",
    },
    {
      "opportunity": "Seasonal Service Packages",
      "potentialRevenue": 65000,
      "probability": "Medium",
      "timeframe": "4 months",
      "description": "Create seasonal HVAC maintenance packages",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Revenue Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.show_chart),
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
                        "Revenue Filters",
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
                          label: "Service Type",
                          items: serviceTypeItems,
                          value: selectedServiceType,
                          onChanged: (value, label) {
                            selectedServiceType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Client Type",
                    items: clientItems,
                    value: selectedClient,
                    onChanged: (value, label) {
                      selectedClient = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Revenue Metrics
            Text(
              "Revenue Overview",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: revenueMetrics.map((metric) {
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
                              color: (metric["change"] as double) >= 0 ? successColor.withAlpha(25) : dangerColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: (metric["change"] as double) >= 0 ? successColor : dangerColor,
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
                        metric["metric"].toString().contains("Margin") 
                          ? "${metric["value"]}%"
                          : "\$${((metric["value"] as num).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Target: ${metric["metric"].toString().contains("Margin") ? "${metric["target"]}%" : "\$${((metric["target"] as num).toDouble()).currency}"}",
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

            // Revenue Breakdown
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
                      Icon(Icons.pie_chart, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Revenue by Service Type",
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
                    children: revenueBreakdown.map((service) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (service["color"] as Color).withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: (service["color"] as Color).withAlpha(50)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: service["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${service["service"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${((service["revenue"] as num).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${(service["percentage"] as double).toStringAsFixed(1)}%",
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
                children: [
                  Row(
                    children: [
                      Icon(Icons.business, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Top Revenue Clients",
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
                    children: topClients.map((client) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
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
                                        "${client["clientName"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${client["clientType"]} • ${client["contractValue"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "+${(client["growth"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
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
                                        "\$${((client["revenue"] as num).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                      Text(
                                        "Revenue",
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${client["jobsCompleted"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Jobs",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "Last payment: ${client["lastPayment"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
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

            // Service Performance
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
                      Icon(Icons.build, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Service Performance",
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
                    children: servicePerformance.map((service) {
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
                                    "${service["service"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "+${(service["growth"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
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
                                        "\$${((service["revenue"] as num).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Revenue",
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
                                        "${service["margin"]}%",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Margin",
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
                                        "${service["jobs"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Jobs",
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
                                        "\$${((service["avgValue"] as num).toDouble()).toStringAsFixed(0)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Avg Value",
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

            // Revenue Opportunities
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.attach_money, color: successColor),
                      SizedBox(width: spSm),
                      Text(
                        "Revenue Opportunities",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: revenueOpportunities.map((opportunity) {
                      Color probabilityColor = opportunity["probability"] == "High" ? successColor : warningColor;
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${opportunity["opportunity"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: probabilityColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${opportunity["probability"]} Probability",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: probabilityColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${opportunity["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "Potential Revenue: \$${((opportunity["potentialRevenue"] as num).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Timeframe: ${opportunity["timeframe"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
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
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.trending_up, color: successColor),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Total potential annual revenue: \$${((revenueOpportunities.fold(0.0, (sum, item) => sum + (item["potentialRevenue"] as num).toDouble()))).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                    label: "Forecast Revenue",
                    icon: Icons.analytics,
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
