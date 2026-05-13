import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaEfficiencyAnalysisView extends StatefulWidget {
  const LtaEfficiencyAnalysisView({super.key});

  @override
  State<LtaEfficiencyAnalysisView> createState() => _LtaEfficiencyAnalysisViewState();
}

class _LtaEfficiencyAnalysisViewState extends State<LtaEfficiencyAnalysisView> {
  bool loading = true;
  String selectedPeriod = "This Month";
  String selectedMetric = "All Metrics";
  String selectedTeam = "All Teams";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> metricOptions = [
    {"label": "All Metrics", "value": "All Metrics"},
    {"label": "Delivery Time", "value": "Delivery Time"},
    {"label": "Route Efficiency", "value": "Route Efficiency"},
    {"label": "Fuel Consumption", "value": "Fuel Consumption"},
    {"label": "Vehicle Utilization", "value": "Vehicle Utilization"},
    {"label": "Driver Performance", "value": "Driver Performance"},
  ];

  List<Map<String, dynamic>> teamOptions = [
    {"label": "All Teams", "value": "All Teams"},
    {"label": "Team Alpha", "value": "Team Alpha"},
    {"label": "Team Beta", "value": "Team Beta"},
    {"label": "Team Gamma", "value": "Team Gamma"},
    {"label": "Team Delta", "value": "Team Delta"},
  ];

  List<Map<String, dynamic>> efficiencyMetrics = [
    {
      "title": "Overall Efficiency",
      "value": 87.5,
      "unit": "%",
      "change": 5.2,
      "trend": "up",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "title": "Average Delivery Time",
      "value": 24.5,
      "unit": "mins",
      "change": -3.1,
      "trend": "down",
      "icon": Icons.access_time,
      "color": primaryColor,
    },
    {
      "title": "Route Optimization",
      "value": 92.3,
      "unit": "%",
      "change": 2.8,
      "trend": "up",
      "icon": Icons.route,
      "color": infoColor,
    },
    {
      "title": "Fuel Efficiency",
      "value": 15.2,
      "unit": "km/l",
      "change": 1.5,
      "trend": "up",
      "icon": Icons.local_gas_station,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> performanceData = [
    {
      "driver": "John Smith",
      "driverId": "DR001",
      "efficiency": 94.5,
      "deliveries": 156,
      "avgTime": 22.3,
      "fuelScore": 88.7,
      "rating": 4.8,
      "status": "excellent",
    },
    {
      "driver": "Sarah Johnson",
      "driverId": "DR002",
      "efficiency": 91.2,
      "deliveries": 142,
      "avgTime": 24.1,
      "fuelScore": 85.3,
      "rating": 4.6,
      "status": "excellent",
    },
    {
      "driver": "Mike Wilson",
      "driverId": "DR003",
      "efficiency": 87.8,
      "deliveries": 138,
      "avgTime": 26.5,
      "fuelScore": 82.1,
      "rating": 4.4,
      "status": "good",
    },
    {
      "driver": "Lisa Brown",
      "driverId": "DR004",
      "efficiency": 85.3,
      "deliveries": 134,
      "avgTime": 27.8,
      "fuelScore": 79.8,
      "rating": 4.2,
      "status": "good",
    },
    {
      "driver": "David Chen",
      "driverId": "DR005",
      "efficiency": 82.1,
      "deliveries": 128,
      "avgTime": 29.2,
      "fuelScore": 76.5,
      "rating": 4.0,
      "status": "average",
    },
  ];

  List<Map<String, dynamic>> routeAnalysis = [
    {
      "route": "Route A1 - Downtown",
      "efficiency": 89.3,
      "avgDeliveries": 24,
      "avgTime": 4.2,
      "distance": 32.5,
      "fuelUsage": 2.8,
      "optimization": 85.7,
    },
    {
      "route": "Route B2 - Suburbs",
      "efficiency": 92.1,
      "avgDeliveries": 18,
      "avgTime": 5.8,
      "distance": 45.2,
      "fuelUsage": 3.5,
      "optimization": 88.4,
    },
    {
      "route": "Route C3 - Industrial",
      "efficiency": 87.5,
      "avgDeliveries": 12,
      "avgTime": 3.9,
      "distance": 28.7,
      "fuelUsage": 2.3,
      "optimization": 82.1,
    },
    {
      "route": "Route D4 - Commercial",
      "efficiency": 90.8,
      "avgDeliveries": 20,
      "avgTime": 4.7,
      "distance": 38.1,
      "fuelUsage": 3.1,
      "optimization": 86.9,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "excellent":
        return successColor;
      case "good":
        return infoColor;
      case "average":
        return warningColor;
      case "poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
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
                  color: (metric["color"] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  metric["icon"] as IconData,
                  color: metric["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${metric["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                (metric["trend"] as String) == "up" 
                    ? Icons.trending_up 
                    : Icons.trending_down,
                color: (metric["trend"] as String) == "up" 
                    ? successColor 
                    : dangerColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${(metric["value"] as num).toStringAsFixed(1)}",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: 4),
              Text(
                "${metric["unit"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: (metric["trend"] as String) == "up" 
                      ? successColor.withValues(alpha: 0.1)
                      : dangerColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${(metric["trend"] as String) == "up" ? '+' : ''}${(metric["change"] as num).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 11,
                    color: (metric["trend"] as String) == "up" 
                        ? successColor 
                        : dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard(Map<String, dynamic> driver) {
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
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  Icons.person,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${driver["driver"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "ID: ${driver["driverId"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
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
                  color: _getStatusColor("${driver["status"]}").withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${driver["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: _getStatusColor("${driver["status"]}"),
                    fontWeight: FontWeight.bold,
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
                  children: [
                    Text(
                      "${(driver["efficiency"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Efficiency",
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
                      "${driver["deliveries"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Deliveries",
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
                      "${(driver["avgTime"] as num).toStringAsFixed(1)}m",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Avg Time",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 14,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${(driver["rating"] as num).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Rating",
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
        ],
      ),
    );
  }

  Widget _buildRouteCard(Map<String, dynamic> route) {
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
              Icon(
                Icons.route,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${route["route"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: successColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${(route["efficiency"] as num).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.bold,
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
                  children: [
                    Text(
                      "${route["avgDeliveries"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Avg Deliveries",
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
                      "${(route["avgTime"] as num).toStringAsFixed(1)}h",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Avg Time",
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
                      "${(route["distance"] as num).toStringAsFixed(1)}km",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Distance",
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
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Efficiency Analysis"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Efficiency Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export report
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share report
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
                    label: "Metric Type",
                    items: metricOptions,
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Team",
                    items: teamOptions,
                    value: selectedTeam,
                    onChanged: (value, label) {
                      selectedTeam = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Key Metrics
            Text(
              "Key Efficiency Metrics",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: efficiencyMetrics.map((metric) {
                return _buildMetricCard(metric);
              }).toList(),
            ),

            // Driver Performance
            Text(
              "Top Performing Drivers",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              children: performanceData.map((driver) {
                return _buildPerformanceCard(driver);
              }).toList(),
            ),

            // Route Analysis
            Text(
              "Route Efficiency Analysis",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              children: routeAnalysis.map((route) {
                return _buildRouteCard(route);
              }).toList(),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Generate Detailed Report",
                    icon: Icons.assessment,
                    size: bs.md,
                    onPressed: () {
                      // Generate detailed report
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Optimize Routes",
                    icon: Icons.route,
                    size: bs.md,
                    onPressed: () {
                      // Navigate to route optimization
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
