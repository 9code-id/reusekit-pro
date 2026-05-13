import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlChart5View extends StatefulWidget {
  @override
  State<GrlChart5View> createState() => _GrlChart5ViewState();
}

class _GrlChart5ViewState extends State<GrlChart5View> {
  String selectedMetric = "Website Traffic";
  int selectedTimeframe = 0;
  
  List<String> timeframes = ["Today", "This Week", "This Month", "This Year"];
  
  List<Map<String, dynamic>> metrics = [
    {"label": "Website Traffic", "value": "website_traffic"},
    {"label": "Conversion Rate", "value": "conversion_rate"},
    {"label": "Sales Performance", "value": "sales_performance"},
    {"label": "User Engagement", "value": "user_engagement"},
  ];

  List<Map<String, dynamic>> trafficData = [
    {"hour": "00", "visitors": 1240, "pageviews": 3580, "bounce": 0.32},
    {"hour": "06", "visitors": 2890, "pageviews": 7840, "bounce": 0.28},
    {"hour": "12", "visitors": 4560, "pageviews": 12340, "bounce": 0.25},
    {"hour": "18", "visitors": 3780, "pageviews": 9560, "bounce": 0.31},
    {"hour": "24", "visitors": 2100, "pageviews": 5890, "bounce": 0.35},
  ];

  List<Map<String, dynamic>> topPages = [
    {"page": "/dashboard", "views": 12540, "change": 15.3},
    {"page": "/products", "views": 8960, "change": -3.2},
    {"page": "/about", "views": 6780, "change": 8.7},
    {"page": "/contact", "views": 4230, "change": 12.1},
    {"page": "/blog", "views": 3450, "change": -5.8},
  ];

  List<Map<String, dynamic>> deviceStats = [
    {"device": "Desktop", "percentage": 58, "sessions": 24580, "color": Colors.blue},
    {"device": "Mobile", "percentage": 35, "sessions": 14870, "color": Colors.green},
    {"device": "Tablet", "percentage": 7, "sessions": 2980, "color": Colors.orange},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics Dashboard"),
        actions: [
          Icon(Icons.refresh, color: primaryColor),
          SizedBox(width: spSm),
          Icon(Icons.settings, color: primaryColor),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTimeframeSelector(),
            _buildMetricSelector(),
            _buildMainMetricsCard(),
            _buildTrafficChart(),
            _buildDeviceBreakdown(),
            _buildTopPagesAnalysis(),
            _buildInsightsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeframeSelector() {
    return QCategoryPicker(
      label: "Select Timeframe",
      items: timeframes.map((frame) => {
        "label": frame,
        "value": frame,
      }).toList(),
      value: timeframes[selectedTimeframe],
      onChanged: (index, label, value, item) {
        selectedTimeframe = index;
        setState(() {});
      },
    );
  }

  Widget _buildMetricSelector() {
    return QDropdownField(
      label: "Primary Metric",
      items: metrics,
      value: selectedMetric,
      onChanged: (value, label) {
        selectedMetric = value;
        setState(() {});
      },
    );
  }

  Widget _buildMainMetricsCard() {
    List<Map<String, dynamic>> mainMetrics = [
      {"title": "Total Visitors", "value": "42.8K", "change": "+18.2%", "icon": Icons.people, "positive": true},
      {"title": "Page Views", "value": "124.5K", "change": "+12.7%", "icon": Icons.visibility, "positive": true},
      {"title": "Bounce Rate", "value": "28.3%", "change": "-3.2%", "icon": Icons.exit_to_app, "positive": true},
      {"title": "Avg Session", "value": "4m 32s", "change": "+8.9%", "icon": Icons.timer, "positive": true},
    ];

    return ResponsiveGridView(
      minItemWidth: 200,
      children: mainMetrics.map((metric) {
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowMd],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    metric["icon"],
                    size: 24,
                    color: primaryColor,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: metric["positive"] ? successColor.withAlpha(25) : dangerColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${metric["change"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: metric["positive"] ? successColor : dangerColor,
                        fontWeight: FontWeight.w600,
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
    );
  }

  Widget _buildTrafficChart() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Traffic Flow Analysis",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                spacing: spSm,
                children: [
                  _buildLegendItem("Visitors", Colors.blue),
                  _buildLegendItem("Page Views", Colors.green),
                ],
              ),
            ],
          ),
          Container(
            height: 220,
            child: Column(
              spacing: spSm,
              children: trafficData.map((data) {
                final maxVisitors = trafficData.map((e) => e["visitors"] as int).reduce((a, b) => a > b ? a : b);
                final maxPageviews = trafficData.map((e) => e["pageviews"] as int).reduce((a, b) => a > b ? a : b);
                
                final visitorWidth = ((data["visitors"] as int) / maxVisitors) * 200;
                final pageviewWidth = ((data["pageviews"] as int) / maxPageviews) * 200;
                
                return Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        child: Text(
                          "${data["hour"]}:00",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: visitorWidth,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${((data["visitors"] as int) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: pageviewWidth,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${((data["pageviews"] as int) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: (data["bounce"] as double) < 0.3 ? successColor : warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${((data["bounce"] as double) * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
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

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      spacing: spXs,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDeviceBreakdown() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
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
          Row(
            spacing: spMd,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ...deviceStats.asMap().entries.map((entry) {
                        int index = entry.key;
                        var device = entry.value;
                        double startAngle = index == 0 ? 0 : 
                          deviceStats.take(index).fold(0.0, (sum, d) => sum + (d["percentage"] as int)) * 3.6;
                        
                        return Transform.rotate(
                          angle: startAngle * 3.14159 / 180,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: device["color"] as Color,
                                width: 8,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        );
                      }).toList(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${((deviceStats.fold(0, (sum, device) => sum + (device["sessions"] as int))) / 1000).toInt()}K",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  spacing: spSm,
                  children: deviceStats.map((device) {
                    return Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: device["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${device["device"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${((device["sessions"] as int) / 1000).toStringAsFixed(1)}K sessions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${device["percentage"]}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: device["color"] as Color,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopPagesAnalysis() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Performing Pages",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...topPages.map((page) {
            final change = page["change"] as double;
            final isPositive = change >= 0;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
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
                          "${((page["views"] as int) / 1000).toStringAsFixed(1)}K views",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    spacing: spXs,
                    children: [
                      Icon(
                        isPositive ? Icons.trending_up : Icons.trending_down,
                        size: 16,
                        color: isPositive ? successColor : dangerColor,
                      ),
                      Text(
                        "${isPositive ? '+' : ''}${change.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: isPositive ? successColor : dangerColor,
                          fontWeight: FontWeight.w600,
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

  Widget _buildInsightsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [infoColor.withAlpha(25), infoColor.withAlpha(51)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border(left: BorderSide(color: infoColor, width: 4)),
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: infoColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "AI Insights & Recommendations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          Text(
            "Peak traffic occurs between 12:00-18:00. Consider running targeted campaigns during these hours for maximum engagement.",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.4,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Export Data",
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
