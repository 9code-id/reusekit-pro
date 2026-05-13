import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaPerformanceMetricsView extends StatefulWidget {
  const FmaPerformanceMetricsView({super.key});

  @override
  State<FmaPerformanceMetricsView> createState() => _FmaPerformanceMetricsViewState();
}

class _FmaPerformanceMetricsViewState extends State<FmaPerformanceMetricsView> {
  int currentTab = 0;
  String selectedPeriod = "monthly";
  String selectedLocation = "";
  String selectedMetric = "";
  
  List<Map<String, dynamic>> performanceData = [
    {
      "location": "Downtown Store",
      "revenue": 125000.0,
      "growth": 12.5,
      "customers": 2850,
      "satisfaction": 4.8,
      "efficiency": 92,
      "employees": 12,
      "avgTransactionValue": 43.86,
      "conversionRate": 68.5,
      "month": "June 2024"
    },
    {
      "location": "Mall Location",
      "revenue": 98000.0,
      "growth": 8.2,
      "customers": 2240,
      "satisfaction": 4.6,
      "efficiency": 88,
      "employees": 8,
      "avgTransactionValue": 43.75,
      "conversionRate": 62.3,
      "month": "June 2024"
    },
    {
      "location": "Airport Terminal",
      "revenue": 156000.0,
      "growth": -2.1,
      "customers": 3420,
      "satisfaction": 4.2,
      "efficiency": 76,
      "employees": 15,
      "avgTransactionValue": 45.61,
      "conversionRate": 55.8,
      "month": "June 2024"
    },
    {
      "location": "Suburban Branch",
      "revenue": 87000.0,
      "growth": 15.3,
      "customers": 1950,
      "satisfaction": 4.9,
      "efficiency": 95,
      "employees": 6,
      "avgTransactionValue": 44.62,
      "conversionRate": 71.2,
      "month": "June 2024"
    },
    {
      "location": "City Center",
      "revenue": 143000.0,
      "growth": 6.8,
      "customers": 3150,
      "satisfaction": 4.4,
      "efficiency": 82,
      "employees": 18,
      "avgTransactionValue": 45.40,
      "conversionRate": 64.7,
      "month": "June 2024"
    }
  ];

  List<Map<String, dynamic>> monthlyTrends = [
    {"month": "Jan", "revenue": 89000.0, "customers": 2100, "efficiency": 82},
    {"month": "Feb", "revenue": 95000.0, "customers": 2250, "efficiency": 85},
    {"month": "Mar", "revenue": 102000.0, "customers": 2400, "efficiency": 88},
    {"month": "Apr", "revenue": 108000.0, "customers": 2500, "efficiency": 90},
    {"month": "May", "revenue": 115000.0, "customers": 2650, "efficiency": 91},
    {"month": "Jun", "revenue": 122000.0, "customers": 2750, "efficiency": 89},
  ];

  List<Map<String, dynamic>> kpiMetrics = [
    {"name": "Revenue Growth", "value": 8.5, "target": 10.0, "unit": "%", "trend": "up"},
    {"name": "Customer Satisfaction", "value": 4.6, "target": 4.5, "unit": "★", "trend": "up"},
    {"name": "Operational Efficiency", "value": 86.6, "target": 90.0, "unit": "%", "trend": "down"},
    {"name": "Conversion Rate", "value": 64.5, "target": 70.0, "unit": "%", "trend": "up"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": ""},
    {"label": "Downtown Store", "value": "Downtown Store"},
    {"label": "Mall Location", "value": "Mall Location"},
    {"label": "Airport Terminal", "value": "Airport Terminal"},
    {"label": "Suburban Branch", "value": "Suburban Branch"},
    {"label": "City Center", "value": "City Center"},
  ];

  List<Map<String, dynamic>> metricOptions = [
    {"label": "All Metrics", "value": ""},
    {"label": "Revenue", "value": "revenue"},
    {"label": "Customer Satisfaction", "value": "satisfaction"},
    {"label": "Efficiency", "value": "efficiency"},
    {"label": "Growth", "value": "growth"},
  ];

  Color _getGrowthColor(double growth) {
    if (growth > 10) return successColor;
    if (growth > 0) return warningColor;
    return dangerColor;
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "up":
        return successColor;
      case "down":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Performance Metrics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Locations", icon: Icon(Icons.location_on)),
        Tab(text: "KPIs", icon: Icon(Icons.track_changes)),
        Tab(text: "Trends", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildLocationsTab(),
        _buildKPIsTab(),
        _buildTrendsTab(),
      ],
    );
  }

  Widget _buildDashboardTab() {
    double totalRevenue = performanceData.fold(0.0, (sum, item) => sum + (item["revenue"] as double));
    int totalCustomers = performanceData.fold(0, (sum, item) => sum + (item["customers"] as int));
    double avgSatisfaction = performanceData.fold(0.0, (sum, item) => sum + (item["satisfaction"] as double)) / performanceData.length;
    double avgEfficiency = performanceData.fold(0.0, (sum, item) => sum + (item["efficiency"] as int)) / performanceData.length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildDashboardCard(
                "Total Revenue",
                "\$${totalRevenue.currency}",
                Icons.attach_money,
                primaryColor,
                "+8.5%",
                successColor,
              ),
              _buildDashboardCard(
                "Total Customers",
                "${totalCustomers.toString()}",
                Icons.people,
                infoColor,
                "+12.3%",
                successColor,
              ),
              _buildDashboardCard(
                "Avg Satisfaction",
                "${avgSatisfaction.toStringAsFixed(1)}★",
                Icons.star,
                warningColor,
                "+0.2",
                successColor,
              ),
              _buildDashboardCard(
                "Avg Efficiency",
                "${avgEfficiency.toStringAsFixed(1)}%",
                Icons.trending_up,
                successColor,
                "-2.1%",
                dangerColor,
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Performance Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: performanceData.take(3).map((location) {
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: primaryColor.withAlpha(20),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${location["location"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${location["customers"]} customers",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "\$${(location["revenue"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "${(location["growth"] as double) >= 0 ? '+' : ''}${(location["growth"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _getGrowthColor(location["growth"] as double),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${location["efficiency"]}%",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: (location["efficiency"] as int) >= 90 ? successColor : warningColor,
                                  ),
                                ),
                                Text(
                                  "Efficiency",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Key Performance Indicators",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: kpiMetrics.map((kpi) {
                    bool isOnTarget = (kpi["value"] as double) >= (kpi["target"] as double);
                    Color statusColor = isOnTarget ? successColor : dangerColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: statusColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${kpi["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                kpi["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                                color: _getTrendColor(kpi["trend"]),
                                size: 20,
                              ),
                            ],
                          ),
                          Text(
                            "${kpi["value"]}${kpi["unit"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                          Text(
                            "Target: ${kpi["target"]}${kpi["unit"]}",
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(String title, String value, IconData icon, Color color, String change, Color changeColor) {
    return Container(
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
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            change,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: changeColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationsTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
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
                  label: "Location",
                  items: locationOptions,
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Metric",
                  items: metricOptions,
                  value: selectedMetric,
                  onChanged: (value, label) {
                    selectedMetric = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(spMd),
            itemCount: performanceData.length,
            itemBuilder: (context, index) {
              final location = performanceData[index];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${location["location"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${location["month"]} • ${location["employees"]} employees",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spMd,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: _getGrowthColor(location["growth"] as double).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${(location["growth"] as double) >= 0 ? '+' : ''}${(location["growth"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _getGrowthColor(location["growth"] as double),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        _buildMetricCard(
                          "Revenue",
                          "\$${(location["revenue"] as double).currency}",
                          Icons.attach_money,
                          successColor,
                        ),
                        _buildMetricCard(
                          "Customers",
                          "${location["customers"]}",
                          Icons.people,
                          infoColor,
                        ),
                        _buildMetricCard(
                          "Satisfaction",
                          "${location["satisfaction"]}★",
                          Icons.star,
                          warningColor,
                        ),
                        _buildMetricCard(
                          "Efficiency",
                          "${location["efficiency"]}%",
                          Icons.trending_up,
                          primaryColor,
                        ),
                      ],
                    ),
                    Divider(color: disabledColor),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Avg Transaction Value",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(location["avgTransactionValue"] as double).toStringAsFixed(2)}",
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
                                "Conversion Rate",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${(location["conversionRate"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKPIsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Key Performance Indicators",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: kpiMetrics.map((kpi) {
                    bool isOnTarget = (kpi["value"] as double) >= (kpi["target"] as double);
                    Color statusColor = isOnTarget ? successColor : dangerColor;
                    double progress = (kpi["value"] as double) / (kpi["target"] as double);
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: statusColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${kpi["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Target: ${kpi["target"]}${kpi["unit"]}",
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
                                    "${kpi["value"]}${kpi["unit"]}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: statusColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        kpi["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                                        color: _getTrendColor(kpi["trend"]),
                                        size: 16,
                                      ),
                                      Text(
                                        kpi["trend"] == "up" ? "Improving" : "Declining",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _getTrendColor(kpi["trend"]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: disabledColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: progress > 1 ? 1 : progress,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${(progress * 100).toStringAsFixed(0)}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: statusColor,
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
        ],
      ),
    );
  }

  Widget _buildTrendsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Monthly Performance Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 250,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: monthlyTrends.map((data) {
                            double maxRevenue = monthlyTrends.map((d) => d["revenue"] as double).reduce((a, b) => a > b ? a : b);
                            double revenueHeight = ((data["revenue"] as double) / maxRevenue) * 120;
                            
                            int maxCustomers = monthlyTrends.map((d) => d["customers"] as int).reduce((a, b) => a > b ? a : b);
                            double customerHeight = ((data["customers"] as int) / maxCustomers) * 120;
                            
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${((data["revenue"] as double) / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: revenueHeight,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Container(
                                      width: 12,
                                      height: customerHeight,
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Container(
                                      width: 12,
                                      height: ((data["efficiency"] as int) / 100) * 120,
                                      decoration: BoxDecoration(
                                        color: infoColor,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${data["month"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: spMd),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLegendItem("Revenue", primaryColor),
                          SizedBox(width: spMd),
                          _buildLegendItem("Customers", successColor),
                          SizedBox(width: spMd),
                          _buildLegendItem("Efficiency", infoColor),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildTrendCard(
                "Revenue Growth",
                "8.5% vs Last Month",
                Icons.trending_up,
                successColor,
                "Positive trend continues",
              ),
              _buildTrendCard(
                "Customer Growth",
                "12.3% vs Last Month",
                Icons.people,
                successColor,
                "Strong customer acquisition",
              ),
              _buildTrendCard(
                "Efficiency Decline",
                "-2.1% vs Last Month",
                Icons.trending_down,
                dangerColor,
                "Needs attention",
              ),
              _buildTrendCard(
                "Satisfaction Stable",
                "+0.2 vs Last Month",
                Icons.star,
                warningColor,
                "Maintaining high levels",
              ),
            ],
          ),
        ],
      ),
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
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTrendCard(String title, String value, IconData icon, Color color, String description) {
    return Container(
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
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            description,
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
