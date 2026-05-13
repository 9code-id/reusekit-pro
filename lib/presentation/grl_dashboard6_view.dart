import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDashboard6View extends StatefulWidget {
  @override
  State<GrlDashboard6View> createState() => _GrlDashboard6ViewState();
}

class _GrlDashboard6ViewState extends State<GrlDashboard6View> {
  bool loading = false;
  String selectedTimeframe = "This Month";
  
  List<Map<String, dynamic>> websiteMetrics = [
    {"metric": "Page Views", "value": 248570, "change": 15.2, "icon": Icons.visibility},
    {"metric": "Unique Visitors", "value": 45320, "change": 8.7, "icon": Icons.people},
    {"metric": "Bounce Rate", "value": 35.2, "change": -12.5, "icon": Icons.exit_to_app, "unit": "%"},
    {"metric": "Avg Session", "value": 4.8, "change": 22.1, "icon": Icons.schedule, "unit": "min"},
  ];

  List<Map<String, dynamic>> trafficSources = [
    {"source": "Organic Search", "visitors": 18450, "percentage": 40.7, "color": "success"},
    {"source": "Direct", "visitors": 12890, "percentage": 28.4, "color": "primary"},
    {"source": "Social Media", "visitors": 8650, "percentage": 19.1, "color": "info"},
    {"source": "Referral", "visitors": 3420, "percentage": 7.5, "color": "warning"},
    {"source": "Email", "visitors": 1910, "percentage": 4.2, "color": "danger"},
  ];

  List<Map<String, dynamic>> topPages = [
    {"page": "/home", "views": 45230, "uniqueViews": 38940, "avgTime": "3:24"},
    {"page": "/products", "views": 32180, "uniqueViews": 28750, "avgTime": "5:42"},
    {"page": "/about", "views": 18560, "uniqueViews": 16420, "avgTime": "2:15"},
    {"page": "/contact", "views": 12340, "uniqueViews": 11890, "avgTime": "1:48"},
    {"page": "/blog", "views": 9870, "uniqueViews": 8920, "avgTime": "6:33"},
  ];

  List<Map<String, dynamic>> conversionData = [
    {"funnel": "Landing Page", "visitors": 45320, "rate": 100.0},
    {"funnel": "Product View", "visitors": 28640, "rate": 63.2},
    {"funnel": "Add to Cart", "visitors": 12890, "rate": 28.4},
    {"funnel": "Checkout", "visitors": 8520, "rate": 18.8},
    {"funnel": "Purchase", "visitors": 3420, "rate": 7.5},
  ];

  List<Map<String, dynamic>> deviceData = [
    {"device": "Desktop", "users": 22560, "percentage": 49.8, "sessions": 34250},
    {"device": "Mobile", "users": 18940, "percentage": 41.8, "sessions": 28640},
    {"device": "Tablet", "users": 3820, "percentage": 8.4, "sessions": 5890},
  ];

  List<Map<String, dynamic>> timeframeItems = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "This Quarter", "value": "This Quarter"},
  ];

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Website Analytics"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            child: QButton(
              icon: Icons.refresh,
              size: bs.sm,
              onPressed: () {
                loading = true;
                setState(() {});
                Future.delayed(Duration(seconds: 2), () {
                  loading = false;
                  setState(() {});
                  ss("Analytics data refreshed");
                });
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeframe Filter
            Row(
              children: [
                Text(
                  "Timeframe:",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Select Timeframe",
                    items: timeframeItems,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Key Metrics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: websiteMetrics.map((metric) {
                String displayValue;
                if (metric.containsKey("unit")) {
                  displayValue = "${(metric["value"] as num).toStringAsFixed(1)}${metric["unit"]}";
                } else {
                  displayValue = "${(metric["value"] as num).toStringAsFixed(0)}";
                }
                
                return _buildMetricCard(
                  metric["metric"],
                  displayValue,
                  metric["icon"],
                  primaryColor,
                  "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                );
              }).toList(),
            ),

            // Traffic Sources
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Traffic Sources",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: trafficSources.map((source) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: _getColorFromString(source["color"]),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${source["source"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: (source["percentage"] as double) / 100,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _getColorFromString(source["color"]),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${((source["visitors"] as int) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${(source["percentage"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 11,
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

            // Device Analytics
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Device Analytics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: deviceData.map((device) {
                      IconData deviceIcon;
                      Color deviceColor;
                      
                      switch (device["device"]) {
                        case "Desktop":
                          deviceIcon = Icons.computer;
                          deviceColor = primaryColor;
                          break;
                        case "Mobile":
                          deviceIcon = Icons.smartphone;
                          deviceColor = successColor;
                          break;
                        case "Tablet":
                          deviceIcon = Icons.tablet;
                          deviceColor = warningColor;
                          break;
                        default:
                          deviceIcon = Icons.devices;
                          deviceColor = infoColor;
                      }
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: deviceColor,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  deviceIcon,
                                  color: deviceColor,
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${device["device"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${((device["users"] as int) / 1000).toStringAsFixed(1)}K Users",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: deviceColor,
                              ),
                            ),
                            Text(
                              "${(device["percentage"] as double).toStringAsFixed(1)}% of total",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              width: double.infinity,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: (device["percentage"] as double) / 100,
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: deviceColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
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

            // Top Pages
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Pages",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Opening detailed page analytics");
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: topPages.map((page) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.web,
                                color: infoColor,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${page["page"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Avg Time: ${page["avgTime"]}",
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
                                  "${((page["views"] as int) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Views",
                                  style: TextStyle(
                                    fontSize: 11,
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

            // Conversion Funnel
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Conversion Funnel",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spXs,
                    children: conversionData.map((step) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${step["funnel"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  widthFactor: (step["rate"] as double) / 100,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _getFunnelColor(step["rate"] as double),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              width: 80,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${((step["visitors"] as int) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${(step["rate"] as double).toStringAsFixed(1)}%",
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
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {
                      ss("Analytics report exported successfully");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Set Goals",
                    icon: Icons.flag,
                    size: bs.md,
                    onPressed: () {
                      si("Opening goal setting interface");
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

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String change) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: change.startsWith('+') ? successColor.withAlpha(20) : 
                        change.startsWith('-') ? (title == "Bounce Rate" ? successColor.withAlpha(20) : dangerColor.withAlpha(20)) : 
                        warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: change.startsWith('+') ? successColor : 
                          change.startsWith('-') ? (title == "Bounce Rate" ? successColor : dangerColor) : 
                          warningColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
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

  Color _getColorFromString(String colorName) {
    switch (colorName) {
      case "primary":
        return primaryColor;
      case "success":
        return successColor;
      case "danger":
        return dangerColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  Color _getFunnelColor(double rate) {
    if (rate >= 80) return successColor;
    if (rate >= 50) return warningColor;
    if (rate >= 25) return infoColor;
    return dangerColor;
  }
}
