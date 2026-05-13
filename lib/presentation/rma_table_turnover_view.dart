import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaTableTurnoverView extends StatefulWidget {
  const RmaTableTurnoverView({super.key});

  @override
  State<RmaTableTurnoverView> createState() => _RmaTableTurnoverViewState();
}

class _RmaTableTurnoverViewState extends State<RmaTableTurnoverView> {
  String selectedPeriod = "today";
  String selectedTable = "all";
  String sortBy = "turnover";
  
  List<Map<String, dynamic>> tableMetrics = [
    {
      "tableId": "T-01",
      "tableNumber": "01",
      "seats": 2,
      "type": "booth",
      "turnovers": 8,
      "totalRevenue": 425.75,
      "averageDuration": 45,
      "averageSpending": 53.22,
      "status": "excellent",
      "currentOccupancy": "occupied",
      "lastTurnover": "20:15",
      "peakHours": ["12:00", "13:00", "19:00", "20:00"],
      "efficiency": 95,
    },
    {
      "tableId": "T-02",
      "tableNumber": "02",
      "seats": 4,
      "type": "standard",
      "turnovers": 6,
      "totalRevenue": 578.50,
      "averageDuration": 65,
      "averageSpending": 96.42,
      "status": "good",
      "currentOccupancy": "available",
      "lastTurnover": "19:45",
      "peakHours": ["18:30", "19:30", "20:30"],
      "efficiency": 82,
    },
    {
      "tableId": "T-03",
      "tableNumber": "03",
      "seats": 6,
      "type": "large",
      "turnovers": 4,
      "totalRevenue": 680.25,
      "averageDuration": 85,
      "averageSpending": 170.06,
      "status": "good",
      "currentOccupancy": "reserved",
      "lastTurnover": "18:30",
      "peakHours": ["18:00", "20:00"],
      "efficiency": 78,
    },
    {
      "tableId": "T-04",
      "tableNumber": "04",
      "seats": 2,
      "type": "window",
      "turnovers": 7,
      "totalRevenue": 315.80,
      "averageDuration": 55,
      "averageSpending": 45.11,
      "status": "good",
      "currentOccupancy": "cleaning",
      "lastTurnover": "20:00",
      "peakHours": ["12:30", "19:00", "20:00"],
      "efficiency": 88,
    },
    {
      "tableId": "T-05",
      "tableNumber": "05",
      "seats": 4,
      "type": "standard",
      "turnovers": 5,
      "totalRevenue": 450.00,
      "averageDuration": 70,
      "averageSpending": 90.00,
      "status": "average",
      "currentOccupancy": "occupied",
      "lastTurnover": "19:15",
      "peakHours": ["19:00", "20:00"],
      "efficiency": 65,
    },
    {
      "tableId": "T-06",
      "tableNumber": "06",
      "seats": 8,
      "type": "private",
      "turnovers": 2,
      "totalRevenue": 850.00,
      "averageDuration": 120,
      "averageSpending": 425.00,
      "status": "excellent",
      "currentOccupancy": "available",
      "lastTurnover": "17:30",
      "peakHours": ["18:00"],
      "efficiency": 90,
    },
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "today"},
    {"label": "Yesterday", "value": "yesterday"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
  ];

  List<Map<String, dynamic>> tableOptions = [
    {"label": "All Tables", "value": "all"},
    {"label": "Table 01", "value": "T-01"},
    {"label": "Table 02", "value": "T-02"},
    {"label": "Table 03", "value": "T-03"},
    {"label": "Table 04", "value": "T-04"},
    {"label": "Table 05", "value": "T-05"},
    {"label": "Table 06", "value": "T-06"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Turnover Rate", "value": "turnover"},
    {"label": "Revenue", "value": "revenue"},
    {"label": "Efficiency", "value": "efficiency"},
    {"label": "Duration", "value": "duration"},
  ];

  Widget _buildOverallStats() {
    final totalTurnovers = tableMetrics.map((t) => t["turnovers"] as int).reduce((a, b) => a + b);
    final totalRevenue = tableMetrics.map((t) => t["totalRevenue"] as double).reduce((a, b) => a + b);
    final avgDuration = tableMetrics.map((t) => t["averageDuration"] as int).reduce((a, b) => a + b) / tableMetrics.length;
    final avgEfficiency = tableMetrics.map((t) => t["efficiency"] as int).reduce((a, b) => a + b) / tableMetrics.length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Turnover Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildStatCard(
                "Total Turnovers",
                "$totalTurnovers",
                Icons.refresh,
                primaryColor,
              ),
              _buildStatCard(
                "Total Revenue",
                "\$${totalRevenue.currency}",
                Icons.attach_money,
                successColor,
              ),
              _buildStatCard(
                "Avg. Duration",
                "${avgDuration.round()} min",
                Icons.timer,
                infoColor,
              ),
              _buildStatCard(
                "Avg. Efficiency",
                "${avgEfficiency.round()}%",
                Icons.trending_up,
                warningColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
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
          SizedBox(height: spXs),
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

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                  label: "Table",
                  items: tableOptions,
                  value: selectedTable,
                  onChanged: (value, label) {
                    selectedTable = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Sort By",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableMetricCard(Map<String, dynamic> table) {
    final statusColor = table["status"] == "excellent" ? successColor :
                       table["status"] == "good" ? infoColor :
                       table["status"] == "average" ? warningColor :
                       dangerColor;

    final occupancyColor = table["currentOccupancy"] == "occupied" ? dangerColor :
                          table["currentOccupancy"] == "reserved" ? warningColor :
                          table["currentOccupancy"] == "cleaning" ? infoColor :
                          successColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
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
                    Row(
                      children: [
                        Text(
                          "Table ${table["tableNumber"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${table["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.people, color: infoColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${table["seats"]} seats • ${table["type"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: occupancyColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${table["currentOccupancy"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: occupancyColor,
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
                  Row(
                    children: [
                      Icon(Icons.refresh, color: primaryColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${table["turnovers"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${table["efficiency"]}% efficient",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 150,
            children: [
              _buildMetric("Revenue", "\$${((table["totalRevenue"] as double)).currency}", Icons.attach_money, successColor),
              _buildMetric("Avg. Duration", "${table["averageDuration"]} min", Icons.timer, infoColor),
              _buildMetric("Avg. Spending", "\$${((table["averageSpending"] as double)).currency}", Icons.account_balance_wallet, warningColor),
              _buildMetric("Last Turnover", "${table["lastTurnover"]}", Icons.access_time, primaryColor),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Peak Hours:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  children: (table["peakHours"] as List).map((hour) => 
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$hour",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ),
                  ).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  icon: Icons.analytics,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('TableAnalytics')
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.history,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('TurnoverHistory')
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.timer,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('OptimizeTiming')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                "Table Performance",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Export Report",
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('ExportTurnoverReport')
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...tableMetrics.map((table) {
            final efficiency = table["efficiency"] as int;
            final turnoverRate = (table["turnovers"] as int) / 10 * 100; // Assuming 10 is max possible
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        child: Text(
                          "T-${table["tableNumber"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Efficiency",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "$efficiency%",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: efficiency >= 80 ? successColor : efficiency >= 60 ? warningColor : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            LinearProgressIndicator(
                              value: efficiency / 100,
                              backgroundColor: Colors.grey.withAlpha(50),
                              valueColor: AlwaysStoppedAnimation(
                                efficiency >= 80 ? successColor : efficiency >= 60 ? warningColor : dangerColor,
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
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredTables {
    List<Map<String, dynamic>> filtered = List.from(tableMetrics);
    
    // Apply table filter
    if (selectedTable != "all") {
      filtered = filtered.where((table) => table["tableId"] == selectedTable).toList();
    }
    
    // Apply sorting
    switch (sortBy) {
      case "turnover":
        filtered.sort((a, b) => (b["turnovers"] as int).compareTo(a["turnovers"] as int));
        break;
      case "revenue":
        filtered.sort((a, b) => (b["totalRevenue"] as double).compareTo(a["totalRevenue"] as double));
        break;
      case "efficiency":
        filtered.sort((a, b) => (b["efficiency"] as int).compareTo(a["efficiency"] as int));
        break;
      case "duration":
        filtered.sort((a, b) => (a["averageDuration"] as int).compareTo(b["averageDuration"] as int));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table Turnover"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo('TurnoverAnalytics')
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo('TurnoverSettings')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildOverallStats(),
            _buildFilters(),
            _buildPerformanceChart(),
            Container(
              padding: EdgeInsets.all(spMd),
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
                        "Table Metrics (${filteredTables.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Optimize",
                        icon: Icons.tune,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('OptimizeTurnover')
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  if (filteredTables.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.table_restaurant,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No table data found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredTables.map((table) => _buildTableMetricCard(table)).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
