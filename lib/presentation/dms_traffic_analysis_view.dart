import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsTrafficAnalysisView extends StatefulWidget {
  const DmsTrafficAnalysisView({super.key});

  @override
  State<DmsTrafficAnalysisView> createState() => _DmsTrafficAnalysisViewState();
}

class _DmsTrafficAnalysisViewState extends State<DmsTrafficAnalysisView> {
  int selectedTimeframe = 1;
  String selectedSegment = "all";
  String selectedDevice = "all";
  bool showRealTimeData = true;

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 24 Hours", "value": 0},
    {"label": "Last 7 Days", "value": 1},
    {"label": "Last 30 Days", "value": 2},
    {"label": "Last 90 Days", "value": 3},
  ];

  List<Map<String, dynamic>> segmentOptions = [
    {"label": "All Visitors", "value": "all"},
    {"label": "New Visitors", "value": "new"},
    {"label": "Returning Visitors", "value": "returning"},
    {"label": "Organic Traffic", "value": "organic"},
    {"label": "Paid Traffic", "value": "paid"},
  ];

  List<Map<String, dynamic>> deviceOptions = [
    {"label": "All Devices", "value": "all"},
    {"label": "Desktop", "value": "desktop"},
    {"label": "Mobile", "value": "mobile"},
    {"label": "Tablet", "value": "tablet"},
  ];

  List<Map<String, dynamic>> trafficMetrics = [
    {
      "title": "Total Visitors",
      "value": 124567,
      "change": 12.5,
      "icon": Icons.people,
      "color": "#3B82F6"
    },
    {
      "title": "Page Views",
      "value": 298432,
      "change": 8.3,
      "icon": Icons.visibility,
      "color": "#10B981"
    },
    {
      "title": "Sessions",
      "value": 187654,
      "change": 15.2,
      "icon": Icons.schedule,
      "color": "#F59E0B"
    },
    {
      "title": "Bounce Rate",
      "value": 34.8,
      "change": -2.1,
      "icon": Icons.trending_down,
      "color": "#EF4444",
      "isPercentage": true
    },
    {
      "title": "Avg. Session Duration",
      "value": 3.45,
      "change": 1.2,
      "icon": Icons.timer,
      "color": "#8B5CF6",
      "suffix": "min"
    },
    {
      "title": "Pages per Session",
      "value": 2.8,
      "change": 0.5,
      "icon": Icons.auto_stories,
      "color": "#EC4899"
    },
  ];

  List<Map<String, dynamic>> trafficSources = [
    {
      "source": "Organic Search",
      "visitors": 45890,
      "percentage": 36.8,
      "change": 8.2,
      "bounceRate": 32.1,
      "avgDuration": 4.2,
      "color": "#10B981"
    },
    {
      "source": "Direct",
      "visitors": 32450,
      "percentage": 26.1,
      "change": 12.5,
      "bounceRate": 28.5,
      "avgDuration": 5.8,
      "color": "#3B82F6"
    },
    {
      "source": "Social Media",
      "visitors": 23780,
      "percentage": 19.1,
      "change": 25.3,
      "bounceRate": 42.3,
      "avgDuration": 2.9,
      "color": "#F59E0B"
    },
    {
      "source": "Paid Search",
      "visitors": 15230,
      "percentage": 12.2,
      "change": -3.7,
      "bounceRate": 35.8,
      "avgDuration": 3.8,
      "color": "#EF4444"
    },
    {
      "source": "Email Marketing",
      "visitors": 4890,
      "percentage": 3.9,
      "change": 18.9,
      "bounceRate": 22.1,
      "avgDuration": 6.2,
      "color": "#8B5CF6"
    },
    {
      "source": "Referral",
      "visitors": 2327,
      "percentage": 1.9,
      "change": 5.4,
      "bounceRate": 38.7,
      "avgDuration": 3.1,
      "color": "#EC4899"
    },
  ];

  List<Map<String, dynamic>> topPages = [
    {
      "page": "/",
      "title": "Homepage",
      "views": 45670,
      "uniqueViews": 38230,
      "avgTimeOnPage": 2.8,
      "bounceRate": 35.2,
      "exitRate": 15.8
    },
    {
      "page": "/products",
      "title": "Product Catalog",
      "views": 32450,
      "uniqueViews": 28940,
      "avgTimeOnPage": 4.5,
      "bounceRate": 28.9,
      "exitRate": 22.1
    },
    {
      "page": "/blog",
      "title": "Blog Posts",
      "views": 23780,
      "uniqueViews": 21560,
      "avgTimeOnPage": 6.2,
      "bounceRate": 42.3,
      "exitRate": 35.7
    },
    {
      "page": "/about",
      "title": "About Us",
      "views": 15230,
      "uniqueViews": 14120,
      "avgTimeOnPage": 3.1,
      "bounceRate": 38.5,
      "exitRate": 45.2
    },
    {
      "page": "/contact",
      "title": "Contact Page",
      "views": 8960,
      "uniqueViews": 8340,
      "avgTimeOnPage": 2.4,
      "bounceRate": 52.1,
      "exitRate": 67.8
    },
  ];

  List<Map<String, dynamic>> deviceAnalytics = [
    {
      "device": "Desktop",
      "visitors": 72340,
      "percentage": 58.1,
      "bounceRate": 29.8,
      "avgDuration": 4.8,
      "pagesPerSession": 3.2,
      "conversionRate": 3.8
    },
    {
      "device": "Mobile",
      "visitors": 42890,
      "percentage": 34.4,
      "bounceRate": 38.5,
      "avgDuration": 2.9,
      "pagesPerSession": 2.1,
      "conversionRate": 2.1
    },
    {
      "device": "Tablet",
      "visitors": 9337,
      "percentage": 7.5,
      "bounceRate": 35.2,
      "avgDuration": 3.8,
      "pagesPerSession": 2.7,
      "conversionRate": 2.9
    },
  ];

  List<Map<String, dynamic>> realTimeData = [
    {
      "metric": "Active Users",
      "value": 1247,
      "trend": "up",
      "change": 15.2
    },
    {
      "metric": "Page Views (Last Hour)",
      "value": 3456,
      "trend": "up",
      "change": 8.7
    },
    {
      "metric": "New Sessions",
      "value": 892,
      "trend": "stable",
      "change": 0.5
    },
    {
      "metric": "Conversion Rate",
      "value": 3.2,
      "trend": "down",
      "change": -1.2
    },
  ];

  List<Map<String, dynamic>> geographicData = [
    {
      "country": "United States",
      "visitors": 45670,
      "percentage": 36.7,
      "sessions": 52340,
      "bounceRate": 32.1
    },
    {
      "country": "United Kingdom",
      "visitors": 23450,
      "percentage": 18.8,
      "sessions": 28760,
      "bounceRate": 29.8
    },
    {
      "country": "Canada",
      "visitors": 15670,
      "percentage": 12.6,
      "sessions": 18940,
      "bounceRate": 35.2
    },
    {
      "country": "Australia",
      "visitors": 12890,
      "percentage": 10.3,
      "sessions": 15230,
      "bounceRate": 38.5
    },
    {
      "country": "Germany",
      "visitors": 8960,
      "percentage": 7.2,
      "sessions": 10450,
      "bounceRate": 31.7
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Traffic Analysis"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            if (showRealTimeData) _buildRealTimeData(),
            _buildTrafficOverview(),
            _buildTrafficChart(),
            _buildTrafficSources(),
            _buildTopPages(),
            _buildDeviceAnalytics(),
            _buildGeographicAnalysis(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Traffic Analysis Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Timeframe",
                  items: timeframeOptions,
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Visitor Segment",
                  items: segmentOptions,
                  value: selectedSegment,
                  onChanged: (value, label) {
                    selectedSegment = value;
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
                  label: "Device Type",
                  items: deviceOptions,
                  value: selectedDevice,
                  onChanged: (value, label) {
                    selectedDevice = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Real-time Data",
                      "value": true,
                      "checked": showRealTimeData,
                    }
                  ],
                  value: [
                    if (showRealTimeData)
                      {
                        "label": "Real-time Data",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showRealTimeData = values.isNotEmpty;
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

  Widget _buildRealTimeData() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: successColor.withAlpha(50), width: 2),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: successColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "Real-time Traffic Data",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "Live",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: realTimeData.map((data) {
              Color trendColor;
              IconData trendIcon;
              
              switch (data["trend"]) {
                case "up":
                  trendColor = successColor;
                  trendIcon = Icons.trending_up;
                  break;
                case "down":
                  trendColor = dangerColor;
                  trendIcon = Icons.trending_down;
                  break;
                default:
                  trendColor = disabledBoldColor;
                  trendIcon = Icons.trending_flat;
              }

              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          trendIcon,
                          color: trendColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${data["metric"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      data["metric"] == "Conversion Rate"
                          ? "${(data["value"] as double).toStringAsFixed(1)}%"
                          : "${(data["value"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: trendColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${(data["change"] as double) >= 0 ? '+' : ''}${(data["change"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: trendColor,
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
    );
  }

  Widget _buildTrafficOverview() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Traffic Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: trafficMetrics.map((metric) {
            Color metricColor = Color(int.parse("0xFF${(metric["color"] as String).substring(1)}"));
            bool isPositive = (metric["change"] as double) >= 0;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: metricColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          metric["icon"] as IconData,
                          color: metricColor,
                          size: 20,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: isPositive ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isPositive ? Icons.trending_up : Icons.trending_down,
                              size: 12,
                              color: isPositive ? successColor : dangerColor,
                            ),
                            SizedBox(width: 2),
                            Text(
                              "${(metric["change"] as double).abs().toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: isPositive ? successColor : dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${metric["title"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    metric["isPercentage"] == true
                        ? "${(metric["value"] as double).toStringAsFixed(1)}%"
                        : metric.containsKey("suffix")
                            ? "${(metric["value"] as double).toStringAsFixed(2)}${metric["suffix"]}"
                            : "${(metric["value"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTrafficChart() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Traffic Trends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "↗ 12.5% increase",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.timeline,
                    size: 48,
                    color: disabledColor,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Traffic Analytics Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Visitors, Sessions & Page Views Over Time",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              _buildChartLegend("Visitors", Color(0xFF3B82F6)),
              SizedBox(width: spSm),
              _buildChartLegend("Sessions", Color(0xFF10B981)),
              SizedBox(width: spSm),
              _buildChartLegend("Page Views", Color(0xFFF59E0B)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTrafficSources() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: trafficSources.length,
            itemBuilder: (context, index) {
              final source = trafficSources[index];
              Color sourceColor = Color(int.parse("0xFF${(source["color"] as String).substring(1)}"));
              bool isPositive = (source["change"] as double) >= 0;
              
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: sourceColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${source["source"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: isPositive ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${isPositive ? '+' : ''}${(source["change"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isPositive ? successColor : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSourceStat("Visitors", "${(source["visitors"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}"),
                        ),
                        Expanded(
                          child: _buildSourceStat("Share", "${(source["percentage"] as double).toStringAsFixed(1)}%"),
                        ),
                        Expanded(
                          child: _buildSourceStat("Bounce Rate", "${(source["bounceRate"] as double).toStringAsFixed(1)}%"),
                        ),
                        Expanded(
                          child: _buildSourceStat("Avg. Duration", "${(source["avgDuration"] as double).toStringAsFixed(1)}m"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSourceStat(String label, String value) {
    return Column(
      spacing: 2,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTopPages() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Top Pages",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: topPages.length,
            itemBuilder: (context, index) {
              final page = topPages[index];
              
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${index + 1}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Column(
                            spacing: 2,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${page["title"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${page["page"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${(page["views"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} views",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildPageStat("Unique Views", "${(page["uniqueViews"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}"),
                        ),
                        Expanded(
                          child: _buildPageStat("Avg. Time", "${(page["avgTimeOnPage"] as double).toStringAsFixed(1)}m"),
                        ),
                        Expanded(
                          child: _buildPageStat("Bounce Rate", "${(page["bounceRate"] as double).toStringAsFixed(1)}%"),
                        ),
                        Expanded(
                          child: _buildPageStat("Exit Rate", "${(page["exitRate"] as double).toStringAsFixed(1)}%"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPageStat(String label, String value) {
    return Column(
      spacing: 2,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDeviceAnalytics() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
            children: deviceAnalytics.map((device) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _getDeviceIcon(device["device"]),
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${device["device"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${(device["percentage"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${(device["visitors"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} visitors",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDeviceStat("Bounce Rate", "${(device["bounceRate"] as double).toStringAsFixed(1)}%"),
                        ),
                        Expanded(
                          child: _buildDeviceStat("Duration", "${(device["avgDuration"] as double).toStringAsFixed(1)}m"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDeviceStat("Pages/Session", "${(device["pagesPerSession"] as double).toStringAsFixed(1)}"),
                        ),
                        Expanded(
                          child: _buildDeviceStat("Conversion", "${(device["conversionRate"] as double).toStringAsFixed(1)}%"),
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
    );
  }

  Widget _buildDeviceStat(String label, String value) {
    return Column(
      spacing: 2,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildGeographicAnalysis() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Geographic Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: geographicData.length,
            itemBuilder: (context, index) {
              final country = geographicData[index];
              
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Text(
                      "${index + 1}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${country["country"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    _buildGeoStat("Visitors", "${(country["visitors"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}"),
                    SizedBox(width: spSm),
                    _buildGeoStat("Share", "${(country["percentage"] as double).toStringAsFixed(1)}%"),
                    SizedBox(width: spSm),
                    _buildGeoStat("Sessions", "${(country["sessions"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}"),
                    SizedBox(width: spSm),
                    _buildGeoStat("Bounce", "${(country["bounceRate"] as double).toStringAsFixed(1)}%"),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGeoStat(String label, String value) {
    return Column(
      spacing: 2,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  IconData _getDeviceIcon(String device) {
    switch (device.toLowerCase()) {
      case "desktop":
        return Icons.computer;
      case "mobile":
        return Icons.smartphone;
      case "tablet":
        return Icons.tablet;
      default:
        return Icons.devices;
    }
  }
}
