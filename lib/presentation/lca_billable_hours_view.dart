import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaBillableHoursView extends StatefulWidget {
  const LcaBillableHoursView({super.key});

  @override
  State<LcaBillableHoursView> createState() => _LcaBillableHoursViewState();
}

class _LcaBillableHoursViewState extends State<LcaBillableHoursView> {
  String selectedPeriod = "This Month";
  String selectedAttorney = "All Attorneys";
  String selectedClient = "All Clients";
  
  List<Map<String, dynamic>> billableHours = [
    {
      "attorney": "Sarah Wilson",
      "totalHours": 168.5,
      "billableHours": 145.2,
      "nonBillableHours": 23.3,
      "utilizationRate": 86.2,
      "targetHours": 160.0,
      "totalRevenue": 50820.0,
      "avgRate": 350.0,
      "avatar": "https://picsum.photos/100/100?random=1&person",
      "department": "Corporate Law",
    },
    {
      "attorney": "Michael Davis",
      "totalHours": 182.0,
      "billableHours": 159.8,
      "nonBillableHours": 22.2,
      "utilizationRate": 87.8,
      "targetHours": 170.0,
      "totalRevenue": 67915.0,
      "avgRate": 425.0,
      "avatar": "https://picsum.photos/100/100?random=2&person",
      "department": "Litigation",
    },
    {
      "attorney": "Lisa Chen",
      "totalHours": 152.5,
      "billableHours": 128.7,
      "nonBillableHours": 23.8,
      "utilizationRate": 84.4,
      "targetHours": 150.0,
      "totalRevenue": 38610.0,
      "avgRate": 300.0,
      "avatar": "https://picsum.photos/100/100?random=3&person",
      "department": "Family Law",
    },
    {
      "attorney": "David Rodriguez",
      "totalHours": 164.2,
      "billableHours": 142.5,
      "nonBillableHours": 21.7,
      "utilizationRate": 86.8,
      "targetHours": 160.0,
      "totalRevenue": 53437.5,
      "avgRate": 375.0,
      "avatar": "https://picsum.photos/100/100?random=4&person",
      "department": "Real Estate",
    },
    {
      "attorney": "Emily Taylor",
      "totalHours": 148.0,
      "billableHours": 124.6,
      "nonBillableHours": 23.4,
      "utilizationRate": 84.2,
      "targetHours": 145.0,
      "totalRevenue": 40495.0,
      "avgRate": 325.0,
      "avatar": "https://picsum.photos/100/100?random=5&person",
      "department": "Healthcare Law",
    },
  ];

  List<Map<String, dynamic>> dailyHours = [
    {"date": "2025-06-16", "billable": 7.5, "nonBillable": 1.5, "total": 9.0},
    {"date": "2025-06-17", "billable": 8.2, "nonBillable": 0.8, "total": 9.0},
    {"date": "2025-06-18", "billable": 6.8, "nonBillable": 2.2, "total": 9.0},
    {"date": "2025-06-19", "billable": 7.9, "nonBillable": 1.1, "total": 9.0},
    {"date": "2025-06-20", "billable": 8.1, "nonBillable": 0.9, "total": 9.0},
  ];

  List<Map<String, dynamic>> clientBreakdown = [
    {"client": "TechCorp Industries", "hours": 42.5, "revenue": 14875.0, "percentage": 29.3},
    {"client": "Johnson Corp", "hours": 38.2, "revenue": 16235.0, "percentage": 26.4},
    {"client": "Smith Family Trust", "hours": 24.8, "revenue": 7440.0, "percentage": 17.1},
    {"client": "Metro Construction", "hours": 19.5, "revenue": 7312.5, "percentage": 13.5},
    {"client": "Healthcare Partners", "hours": 20.0, "revenue": 6500.0, "percentage": 13.7},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> attorneyOptions = [
    {"label": "All Attorneys", "value": "All Attorneys"},
    {"label": "Sarah Wilson", "value": "Sarah Wilson"},
    {"label": "Michael Davis", "value": "Michael Davis"},
    {"label": "Lisa Chen", "value": "Lisa Chen"},
    {"label": "David Rodriguez", "value": "David Rodriguez"},
    {"label": "Emily Taylor", "value": "Emily Taylor"},
  ];

  Color _getUtilizationColor(double rate) {
    if (rate >= 85.0) return successColor;
    if (rate >= 75.0) return warningColor;
    return dangerColor;
  }

  Widget _buildOverallSummary() {
    double totalBillableHours = billableHours.fold(0.0, (sum, a) => sum + (a["billableHours"] as double));
    double totalRevenue = billableHours.fold(0.0, (sum, a) => sum + (a["totalRevenue"] as double));
    double avgUtilization = billableHours.fold(0.0, (sum, a) => sum + (a["utilizationRate"] as double)) / billableHours.length;
    double totalTargetHours = billableHours.fold(0.0, (sum, a) => sum + (a["targetHours"] as double));

    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        children: [
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
                      Text(
                        "${totalBillableHours.toStringAsFixed(1)}h",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Billable",
                        style: TextStyle(
                          fontSize: 12,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${totalRevenue.currency}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Revenue",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${avgUtilization.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: _getUtilizationColor(avgUtilization),
                        ),
                      ),
                      Text(
                        "Avg Utilization",
                        style: TextStyle(
                          fontSize: 12,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${totalTargetHours.toStringAsFixed(0)}h",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Target Hours",
                        style: TextStyle(
                          fontSize: 12,
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
    );
  }

  Widget _buildFilters() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
              label: "Attorney",
              items: attorneyOptions,
              value: selectedAttorney,
              onChanged: (value, label) {
                selectedAttorney = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttorneyBreakdown() {
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Attorney Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...billableHours.map((attorney) {
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
                    color: _getUtilizationColor(attorney["utilizationRate"]),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("${attorney["avatar"]}"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${attorney["attorney"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${attorney["department"]}",
                              style: TextStyle(
                                fontSize: 14,
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
                            "${(attorney["utilizationRate"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: _getUtilizationColor(attorney["utilizationRate"]),
                            ),
                          ),
                          Text(
                            "Utilization",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
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
                              "${(attorney["billableHours"] as double).toStringAsFixed(1)}h",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Billable Hours",
                              style: TextStyle(
                                fontSize: 11,
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
                              "${(attorney["nonBillableHours"] as double).toStringAsFixed(1)}h",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Non-Billable",
                              style: TextStyle(
                                fontSize: 11,
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
                              "\$${(attorney["totalRevenue"] as double).currency}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Revenue",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Progress vs Target",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${(attorney["billableHours"] as double).toStringAsFixed(1)} / ${(attorney["targetHours"] as double).toStringAsFixed(0)}h",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: ((attorney["billableHours"] as double) / (attorney["targetHours"] as double)).clamp(0.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: (attorney["billableHours"] as double) >= (attorney["targetHours"] as double) 
                                    ? successColor 
                                    : primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDailyChart() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
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
            "Daily Hours Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...dailyHours.map((day) {
            double billablePercent = (day["billable"] as double) / (day["total"] as double);
            double nonBillablePercent = (day["nonBillable"] as double) / (day["total"] as double);

            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${day["date"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(day["billable"] as double).toStringAsFixed(1)}h billable",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${(day["nonBillable"] as double).toStringAsFixed(1)}h non-billable",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: (billablePercent * 100).round(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusSm),
                                bottomLeft: Radius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: (nonBillablePercent * 100).round(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(radiusSm),
                                bottomRight: Radius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildClientBreakdown() {
    return Container(
      margin: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Client Hours Breakdown",
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
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: clientBreakdown.map((client) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${client["client"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${(client["hours"] as double).toStringAsFixed(1)}h • \$${(client["revenue"] as double).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${(client["percentage"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Billable Hours"),
        actions: [
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              ss("Export hours report");
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              ss("Hours settings");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildOverallSummary(),
            _buildFilters(),
            SizedBox(height: spMd),
            _buildAttorneyBreakdown(),
            _buildDailyChart(),
            SizedBox(height: spMd),
            _buildClientBreakdown(),
          ],
        ),
      ),
    );
  }
}
