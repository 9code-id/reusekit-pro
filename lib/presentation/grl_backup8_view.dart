import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBackup8View extends StatefulWidget {
  @override
  State<GrlBackup8View> createState() => _GrlBackup8ViewState();
}

class _GrlBackup8ViewState extends State<GrlBackup8View> {
  String selectedPeriod = "7_days";
  bool isLoading = false;
  
  List<Map<String, dynamic>> backupTrendData = [
    {
      "date": DateTime.now().subtract(Duration(days: 6)),
      "size": 1.2,
      "files": 234,
      "duration": 8,
      "status": "success",
    },
    {
      "date": DateTime.now().subtract(Duration(days: 5)),
      "size": 1.8,
      "files": 456,
      "duration": 12,
      "status": "success",
    },
    {
      "date": DateTime.now().subtract(Duration(days: 4)),
      "size": 0.9,
      "files": 123,
      "duration": 5,
      "status": "success",
    },
    {
      "date": DateTime.now().subtract(Duration(days: 3)),
      "size": 2.1,
      "files": 567,
      "duration": 15,
      "status": "failed",
    },
    {
      "date": DateTime.now().subtract(Duration(days: 2)),
      "size": 1.6,
      "files": 345,
      "duration": 10,
      "status": "success",
    },
    {
      "date": DateTime.now().subtract(Duration(days: 1)),
      "size": 2.4,
      "files": 678,
      "duration": 18,
      "status": "success",
    },
    {
      "date": DateTime.now(),
      "size": 1.9,
      "files": 432,
      "duration": 13,
      "status": "success",
    },
  ];

  List<Map<String, dynamic>> performanceMetrics = [
    {
      "title": "Average Backup Time",
      "value": "12.3 min",
      "trend": "+2.1%",
      "trendDirection": "up",
      "icon": Icons.schedule,
      "color": primaryColor,
    },
    {
      "title": "Success Rate",
      "value": "94.2%",
      "trend": "-1.2%",
      "trendDirection": "down",
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "Average Size",
      "value": "1.7 GB",
      "trend": "+0.8%",
      "trendDirection": "up",
      "icon": Icons.storage,
      "color": infoColor,
    },
    {
      "title": "Data Saved",
      "value": "23.4 GB",
      "trend": "+15.3%",
      "trendDirection": "up",
      "icon": Icons.save,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> categoryBreakdown = [
    {
      "category": "Photos & Videos",
      "size": 8.5,
      "percentage": 45,
      "files": 2847,
      "color": primaryColor,
      "trend": "+12%",
    },
    {
      "category": "Documents",
      "size": 4.2,
      "percentage": 22,
      "files": 156,
      "color": successColor,
      "trend": "+5%",
    },
    {
      "category": "App Data",
      "size": 3.8,
      "percentage": 20,
      "files": 89,
      "color": warningColor,
      "trend": "-2%",
    },
    {
      "category": "Other",
      "size": 2.5,
      "percentage": 13,
      "files": 234,
      "color": infoColor,
      "trend": "+8%",
    },
  ];

  List<Map<String, dynamic>> recentAlerts = [
    {
      "type": "warning",
      "title": "Storage Almost Full",
      "message": "Google Drive storage is 89% full. Consider upgrading your plan.",
      "time": DateTime.now().subtract(Duration(hours: 2)),
      "resolved": false,
    },
    {
      "type": "error",
      "title": "Backup Failed",
      "message": "Backup failed on Dec 19 due to network connectivity issues.",
      "time": DateTime.now().subtract(Duration(days: 3)),
      "resolved": true,
    },
    {
      "type": "info",
      "title": "New Device Added",
      "message": "iPad Pro has been successfully added to backup list.",
      "time": DateTime.now().subtract(Duration(days: 5)),
      "resolved": true,
    },
    {
      "type": "success",
      "title": "Backup Completed",
      "message": "Full backup completed successfully with 2,847 files.",
      "time": DateTime.now().subtract(Duration(hours: 6)),
      "resolved": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _exportReport,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time Period Selector
            QHorizontalScroll(
              children: [
                {"label": "7 Days", "value": "7_days"},
                {"label": "30 Days", "value": "30_days"},
                {"label": "3 Months", "value": "3_months"},
                {"label": "1 Year", "value": "1_year"},
              ].map((period) => GestureDetector(
                onTap: () {
                  selectedPeriod = period["value"]!;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: selectedPeriod == period["value"] ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Text(
                    period["label"]!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: selectedPeriod == period["value"] ? Colors.white : primaryColor,
                    ),
                  ),
                ),
              )).toList(),
            ),

            SizedBox(height: spMd),

            // Performance Metrics
            Text(
              "Performance Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: performanceMetrics.map((metric) => Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (metric["color"] as Color).withAlpha(20),
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
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${metric["value"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: metric["color"] as Color,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          metric["trendDirection"] == "up" ? Icons.trending_up : Icons.trending_down,
                          size: 16,
                          color: metric["trendDirection"] == "up" ? successColor : dangerColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${metric["trend"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: metric["trendDirection"] == "up" ? successColor : dangerColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "vs last period",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )).toList(),
            ),

            SizedBox(height: spMd),

            // Backup Trend Chart
            Text(
              "Backup Size Trend",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Chart placeholder (simplified visualization)
                  Container(
                    height: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: backupTrendData.map((data) => Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: (data["size"] as double) * 60,
                                decoration: BoxDecoration(
                                  color: data["status"] == "success" ? primaryColor : dangerColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusXs),
                                    topRight: Radius.circular(radiusXs),
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${(data["date"] as DateTime).day}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )).toList(),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${_calculateAverageSize().toStringAsFixed(1)} GB",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Average Size",
                              style: TextStyle(
                                fontSize: 12,
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
                              "${_calculateTotalFiles()}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Total Files",
                              style: TextStyle(
                                fontSize: 12,
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
                              "${_calculateSuccessRate().toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Success Rate",
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
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Category Breakdown
            Text(
              "Data Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...categoryBreakdown.map((category) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 50,
                    decoration: BoxDecoration(
                      color: category["color"] as Color,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${category["category"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${(category["size"] as double).toStringAsFixed(1)} GB",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: category["color"] as Color,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: (category["percentage"] as int) / 100,
                                backgroundColor: disabledColor,
                                valueColor: AlwaysStoppedAnimation<Color>(category["color"] as Color),
                                minHeight: 6,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${category["percentage"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: category["color"] as Color,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Text(
                              "${category["files"]} files",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${category["trend"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (category["trend"] as String).startsWith('+') ? successColor : dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),

            SizedBox(height: spMd),

            // Recent Alerts
            Text(
              "Recent Alerts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...recentAlerts.map((alert) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getAlertColor(alert["type"]),
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getAlertColor(alert["type"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        _getAlertIcon(alert["type"]),
                        color: _getAlertColor(alert["type"]),
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${alert["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              if (alert["resolved"] as bool)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "RESOLVED",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${alert["message"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${_getRelativeTime(alert["time"] as DateTime)}",
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
              ),
            )).toList(),

            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    size: bs.md,
                    icon: Icons.download,
                    onPressed: _exportReport,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Schedule Report",
                    size: bs.md,
                    icon: Icons.schedule,
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

  double _calculateAverageSize() {
    if (backupTrendData.isEmpty) return 0;
    double total = backupTrendData.fold(0, (sum, data) => sum + (data["size"] as double));
    return total / backupTrendData.length;
  }

  int _calculateTotalFiles() {
    return backupTrendData.fold(0, (sum, data) => sum + (data["files"] as int));
  }

  double _calculateSuccessRate() {
    if (backupTrendData.isEmpty) return 0;
    int successful = backupTrendData.where((data) => data["status"] == "success").length;
    return (successful / backupTrendData.length) * 100;
  }

  Color _getAlertColor(String type) {
    switch (type) {
      case 'error':
        return dangerColor;
      case 'warning':
        return warningColor;
      case 'success':
        return successColor;
      case 'info':
      default:
        return infoColor;
    }
  }

  IconData _getAlertIcon(String type) {
    switch (type) {
      case 'error':
        return Icons.error;
      case 'warning':
        return Icons.warning;
      case 'success':
        return Icons.check_circle;
      case 'info':
      default:
        return Icons.info;
    }
  }

  String _getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else {
      return "${difference.inDays} days ago";
    }
  }

  void _refreshData() async {
    isLoading = true;
    setState(() {});
    
    showLoading();
    
    // Simulate data refresh
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    isLoading = false;
    setState(() {});
    
    ss("Analytics data refreshed successfully!");
  }

  void _exportReport() async {
    showLoading();
    
    // Simulate report generation
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    
    ss("Backup analytics report exported successfully!");
  }
}
