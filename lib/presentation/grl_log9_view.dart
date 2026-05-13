import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLog9View extends StatefulWidget {
  @override
  State<GrlLog9View> createState() => _GrlLog9ViewState();
}

class _GrlLog9ViewState extends State<GrlLog9View> {
  String searchQuery = "";
  String selectedMetric = "Response Time";
  String selectedTimeRange = "Last Hour";
  String selectedService = "All Services";

  List<Map<String, dynamic>> metrics = [
    {"label": "Response Time", "value": "Response Time"},
    {"label": "Throughput", "value": "Throughput"},
    {"label": "Error Rate", "value": "Error Rate"},
    {"label": "CPU Usage", "value": "CPU Usage"},
    {"label": "Memory Usage", "value": "Memory Usage"},
  ];

  List<Map<String, dynamic>> timeRanges = [
    {"label": "Last Hour", "value": "Last Hour"},
    {"label": "Last 6 Hours", "value": "Last 6 Hours"},
    {"label": "Last 24 Hours", "value": "Last 24 Hours"},
    {"label": "Last 7 Days", "value": "Last 7 Days"},
  ];

  List<Map<String, dynamic>> services = [
    {"label": "All Services", "value": "All Services"},
    {"label": "Authentication API", "value": "Authentication API"},
    {"label": "Payment Service", "value": "Payment Service"},
    {"label": "User Management", "value": "User Management"},
    {"label": "Database Service", "value": "Database Service"},
  ];

  List<Map<String, dynamic>> performanceMetrics = [
    {
      "name": "Response Time",
      "current": 245.5,
      "target": 200.0,
      "unit": "ms",
      "trend": "up",
      "status": "Warning",
      "percentage": 85.4,
      "history": [220, 230, 235, 240, 245, 246]
    },
    {
      "name": "Throughput",
      "current": 2847,
      "target": 3000,
      "unit": "req/sec",
      "trend": "stable",
      "status": "Good",
      "percentage": 94.9,
      "history": [2800, 2820, 2840, 2845, 2847, 2847]
    },
    {
      "name": "Error Rate",
      "current": 0.8,
      "target": 1.0,
      "unit": "%",
      "trend": "down",
      "status": "Excellent",
      "percentage": 20.0,
      "history": [1.2, 1.0, 0.9, 0.8, 0.8, 0.8]
    },
    {
      "name": "CPU Usage",
      "current": 68.5,
      "target": 80.0,
      "unit": "%",
      "trend": "up",
      "status": "Normal",
      "percentage": 85.6,
      "history": [60, 62, 65, 67, 68, 68.5]
    },
  ];

  List<Map<String, dynamic>> serviceHealth = [
    {
      "name": "Authentication API",
      "status": "Healthy",
      "uptime": "99.9%",
      "response_time": "120ms",
      "requests": "45.2K",
      "errors": "12",
      "last_incident": "2 days ago"
    },
    {
      "name": "Payment Service",
      "status": "Warning",
      "uptime": "98.5%",
      "response_time": "450ms", 
      "requests": "23.8K",
      "errors": "156",
      "last_incident": "3 hours ago"
    },
    {
      "name": "User Management",
      "status": "Healthy",
      "uptime": "99.8%",
      "response_time": "180ms",
      "requests": "67.3K",
      "errors": "8",
      "last_incident": "1 week ago"
    },
    {
      "name": "Database Service",
      "status": "Critical",
      "uptime": "95.2%",
      "response_time": "850ms",
      "requests": "89.1K",
      "errors": "342",
      "last_incident": "30 minutes ago"
    },
  ];

  List<Map<String, dynamic>> bottlenecks = [
    {
      "id": 1,
      "timestamp": "2024-01-15 17:45:23",
      "service": "Database Service",
      "type": "Slow Query",
      "severity": "High",
      "description": "Query execution time exceeded 2 seconds",
      "query": "SELECT * FROM users WHERE created_at > '2024-01-01'",
      "execution_time": "2.45s",
      "affected_endpoints": ["GET /users", "POST /auth/login"],
      "optimization": "Add index on created_at column"
    },
    {
      "id": 2,
      "timestamp": "2024-01-15 17:40:15",
      "service": "Payment Service",
      "type": "Memory Leak",
      "severity": "Medium",
      "description": "Memory usage continuously increasing",
      "memory_usage": "4.2GB",
      "memory_limit": "8GB",
      "affected_endpoints": ["POST /payments/process"],
      "optimization": "Restart service and investigate object references"
    },
    {
      "id": 3,
      "timestamp": "2024-01-15 17:35:30",
      "service": "Authentication API",
      "type": "Rate Limiting",
      "severity": "Low",
      "description": "High number of authentication requests",
      "request_rate": "450/min",
      "rate_limit": "500/min",
      "affected_endpoints": ["POST /auth/login", "POST /auth/refresh"],
      "optimization": "Implement request caching for repeated calls"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Performance Metrics"),
        actions: [
          IconButton(
            icon: Icon(Icons.speed),
            onPressed: () {
              // Performance dashboard
            },
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              // Optimization settings
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Performance analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search metrics...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),

            // Filter Row
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Metric",
                    items: metrics,
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
                    label: "Service",
                    items: services,
                    value: selectedService,
                    onChanged: (value, label) {
                      selectedService = value;
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
                    label: "Time Range",
                    items: timeRanges,
                    value: selectedTimeRange,
                    onChanged: (value, label) {
                      selectedTimeRange = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.assessment, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Custom Report",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Performance Metrics Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: performanceMetrics.map((metric) => _buildPerformanceCard(metric)).toList(),
            ),

            // Service Health Overview
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        topRight: Radius.circular(radiusLg),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.health_and_safety, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Service Health Overview",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${serviceHealth.length} Services",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: serviceHealth.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final service = serviceHealth[index];
                      return _buildServiceHealthItem(service);
                    },
                  ),
                ],
              ),
            ),

            // Performance Bottlenecks
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        topRight: Radius.circular(radiusLg),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: warningColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Performance Bottlenecks",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${bottlenecks.length} Issues",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: bottlenecks.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final bottleneck = bottlenecks[index];
                      return _buildBottleneckItem(bottleneck);
                    },
                  ),
                ],
              ),
            ),

            // Optimization Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Generate Report",
                    icon: Icons.assessment,
                    size: bs.md,
                    onPressed: () {
                      // Generate performance report
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Auto Optimize",
                    icon: Icons.auto_awesome,
                    size: bs.md,
                    onPressed: () {
                      // Run auto optimization
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

  Widget _buildPerformanceCard(Map<String, dynamic> metric) {
    Color statusColor = _getPerformanceColor(metric["status"]);
    IconData trendIcon = _getTrendIcon(metric["trend"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
              Icon(trendIcon, color: statusColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${metric["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${metric["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "${metric["current"]}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "${metric["unit"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "Target: ${metric["target"]} ${metric["unit"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          LinearProgressIndicator(
            value: (metric["percentage"] as num) / 100,
            backgroundColor: disabledColor.withAlpha(50),
            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
          ),
          SizedBox(height: spXs),
          Text(
            "${(metric["percentage"] as num).toStringAsFixed(1)}% of target",
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceHealthItem(Map<String, dynamic> service) {
    Color statusColor = _getHealthColor(service["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(Icons.circle, color: statusColor, size: 12),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${service["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Uptime: ${service["uptime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Response: ${service["response_time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Requests: ${service["requests"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Errors: ${service["errors"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {
                  // View service details
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottleneckItem(Map<String, dynamic> bottleneck) {
    Color severityColor = _getSeverityColor(bottleneck["severity"]);
    
    return ExpansionTile(
      tilePadding: EdgeInsets.all(spSm),
      childrenPadding: EdgeInsets.all(spSm),
      leading: Container(
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: severityColor.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusXs),
        ),
        child: Icon(Icons.speed, color: severityColor, size: 18),
      ),
      title: Text(
        "${bottleneck["type"]} in ${bottleneck["service"]}",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: severityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${bottleneck["severity"]} Severity",
                  style: TextStyle(
                    fontSize: 10,
                    color: severityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${bottleneck["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Optimization Suggestion:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${bottleneck["optimization"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ),
              Text(
                "Affected Endpoints:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              Wrap(
                spacing: spXs,
                children: (bottleneck["affected_endpoints"] as List).map((endpoint) => 
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$endpoint",
                      style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ).toList(),
              ),
              Row(
                children: [
                  QButton(
                    label: "Apply Fix",
                    icon: Icons.build,
                    size: bs.sm,
                    onPressed: () {
                      // Apply optimization
                    },
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Ignore",
                    icon: Icons.close,
                    size: bs.sm,
                    onPressed: () {
                      // Ignore bottleneck
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getPerformanceColor(String status) {
    switch (status) {
      case "Excellent":
        return successColor;
      case "Good":
        return infoColor;
      case "Normal":
        return primaryColor;
      case "Warning":
        return warningColor;
      case "Critical":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getHealthColor(String status) {
    switch (status) {
      case "Healthy":
        return successColor;
      case "Warning":
        return warningColor;
      case "Critical":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "up":
        return Icons.trending_up;
      case "down":
        return Icons.trending_down;
      case "stable":
        return Icons.trending_flat;
      default:
        return Icons.timeline;
    }
  }
}
