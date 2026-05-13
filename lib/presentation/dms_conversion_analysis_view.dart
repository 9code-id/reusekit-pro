import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsConversionAnalysisView extends StatefulWidget {
  const DmsConversionAnalysisView({super.key});

  @override
  State<DmsConversionAnalysisView> createState() => _DmsConversionAnalysisViewState();
}

class _DmsConversionAnalysisViewState extends State<DmsConversionAnalysisView> {
  int selectedTimeframe = 1;
  String selectedGoal = "all";
  String selectedChannel = "all";
  bool showMicroConversions = true;

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 7 Days", "value": 0},
    {"label": "Last 30 Days", "value": 1},
    {"label": "Last 90 Days", "value": 2},
    {"label": "Last 12 Months", "value": 3},
  ];

  List<Map<String, dynamic>> goalOptions = [
    {"label": "All Goals", "value": "all"},
    {"label": "Purchase", "value": "purchase"},
    {"label": "Lead Generation", "value": "lead"},
    {"label": "Newsletter Signup", "value": "newsletter"},
    {"label": "Download", "value": "download"},
  ];

  List<Map<String, dynamic>> channelOptions = [
    {"label": "All Channels", "value": "all"},
    {"label": "Organic Search", "value": "organic"},
    {"label": "Paid Search", "value": "paid"},
    {"label": "Social Media", "value": "social"},
    {"label": "Email", "value": "email"},
    {"label": "Direct", "value": "direct"},
  ];

  List<Map<String, dynamic>> conversionMetrics = [
    {
      "title": "Overall Conversion Rate",
      "value": 3.24,
      "change": 0.18,
      "icon": Icons.trending_up,
      "color": "#10B981"
    },
    {
      "title": "Total Conversions",
      "value": 2847,
      "change": 12.5,
      "icon": Icons.check_circle,
      "color": "#3B82F6"
    },
    {
      "title": "Conversion Value",
      "value": 284750.0,
      "change": 15.3,
      "icon": Icons.attach_money,
      "color": "#F59E0B",
      "isCurrency": true
    },
    {
      "title": "Cost per Conversion",
      "value": 45.60,
      "change": -8.2,
      "icon": Icons.account_balance_wallet,
      "color": "#8B5CF6",
      "isCurrency": true
    },
    {
      "title": "Return on Ad Spend",
      "value": 4.85,
      "change": 0.35,
      "icon": Icons.trending_up,
      "color": "#EC4899",
      "suffix": "x"
    },
    {
      "title": "Avg. Time to Convert",
      "value": 7.2,
      "change": -1.8,
      "icon": Icons.schedule,
      "color": "#EF4444",
      "suffix": " days"
    },
  ];

  List<Map<String, dynamic>> conversionFunnel = [
    {
      "stage": "Visitors",
      "count": 87654,
      "percentage": 100.0,
      "dropOff": 0.0,
      "color": "#3B82F6"
    },
    {
      "stage": "Product Views",
      "count": 34562,
      "percentage": 39.4,
      "dropOff": 60.6,
      "color": "#10B981"
    },
    {
      "stage": "Add to Cart",
      "count": 12890,
      "percentage": 14.7,
      "dropOff": 62.7,
      "color": "#F59E0B"
    },
    {
      "stage": "Checkout Started",
      "count": 5678,
      "percentage": 6.5,
      "dropOff": 55.9,
      "color": "#8B5CF6"
    },
    {
      "stage": "Purchase Complete",
      "count": 2847,
      "percentage": 3.2,
      "dropOff": 49.9,
      "color": "#10B981"
    },
  ];

  List<Map<String, dynamic>> goalPerformance = [
    {
      "goal": "Purchase",
      "conversions": 2847,
      "rate": 3.24,
      "value": 284750.0,
      "change": 12.5,
      "trend": "up"
    },
    {
      "goal": "Lead Generation",
      "conversions": 1243,
      "rate": 8.7,
      "value": 62150.0,
      "change": 18.3,
      "trend": "up"
    },
    {
      "goal": "Newsletter Signup",
      "conversions": 4567,
      "rate": 15.2,
      "value": 22835.0,
      "change": -2.1,
      "trend": "down"
    },
    {
      "goal": "Download",
      "conversions": 892,
      "rate": 12.8,
      "value": 8920.0,
      "change": 5.7,
      "trend": "up"
    },
  ];

  List<Map<String, dynamic>> channelConversions = [
    {
      "channel": "Organic Search",
      "conversions": 1248,
      "rate": 4.2,
      "cost": 0.0,
      "cpa": 0.0,
      "roas": 0.0,
      "revenue": 124800.0
    },
    {
      "channel": "Paid Search",
      "conversions": 892,
      "rate": 2.8,
      "cost": 40680.0,
      "cpa": 45.60,
      "roas": 3.8,
      "revenue": 89200.0
    },
    {
      "channel": "Social Media",
      "conversions": 456,
      "rate": 1.9,
      "cost": 18240.0,
      "cpa": 40.0,
      "roas": 2.5,
      "revenue": 45600.0
    },
    {
      "channel": "Email Marketing",
      "conversions": 156,
      "rate": 6.8,
      "cost": 2340.0,
      "cpa": 15.0,
      "roas": 6.7,
      "revenue": 15600.0
    },
    {
      "channel": "Direct",
      "conversions": 95,
      "rate": 2.1,
      "cost": 0.0,
      "cpa": 0.0,
      "roas": 0.0,
      "revenue": 9500.0
    },
  ];

  List<Map<String, dynamic>> topLandingPages = [
    {
      "page": "/products/smartphone",
      "title": "Smartphone Collection",
      "visitors": 12450,
      "conversions": 389,
      "rate": 3.1,
      "revenue": 77800.0
    },
    {
      "page": "/products/laptop",
      "title": "Laptop Series",
      "visitors": 8960,
      "conversions": 295,
      "rate": 3.3,
      "revenue": 59000.0
    },
    {
      "page": "/sale",
      "title": "Special Offers",
      "visitors": 15670,
      "conversions": 469,
      "rate": 3.0,
      "revenue": 46900.0
    },
    {
      "page": "/products/accessories",
      "title": "Accessories",
      "visitors": 6780,
      "conversions": 189,
      "rate": 2.8,
      "revenue": 18900.0
    },
    {
      "page": "/",
      "title": "Homepage",
      "visitors": 25670,
      "conversions": 512,
      "rate": 2.0,
      "revenue": 51200.0
    },
  ];

  List<Map<String, dynamic>> conversionPath = [
    {
      "path": "Organic Search → Product Page → Cart → Purchase",
      "conversions": 847,
      "percentage": 29.7,
      "avgTimeToConvert": 2.5,
      "touchpoints": 4
    },
    {
      "path": "Direct → Homepage → Product Page → Cart → Purchase",
      "conversions": 456,
      "percentage": 16.0,
      "avgTimeToConvert": 5.2,
      "touchpoints": 5
    },
    {
      "path": "Paid Search → Landing Page → Cart → Purchase",
      "conversions": 389,
      "percentage": 13.7,
      "avgTimeToConvert": 1.8,
      "touchpoints": 4
    },
    {
      "path": "Social Media → Product Page → Wishlist → Cart → Purchase",
      "conversions": 234,
      "percentage": 8.2,
      "avgTimeToConvert": 8.7,
      "touchpoints": 5
    },
    {
      "path": "Email → Product Page → Purchase",
      "conversions": 156,
      "percentage": 5.5,
      "avgTimeToConvert": 1.2,
      "touchpoints": 3
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversion Analysis"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.analytics),
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
            _buildConversionOverview(),
            _buildConversionFunnel(),
            _buildConversionChart(),
            _buildGoalPerformance(),
            _buildChannelConversions(),
            _buildTopLandingPages(),
            _buildConversionPaths(),
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
            "Conversion Analysis Filters",
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
                  label: "Goal Type",
                  items: goalOptions,
                  value: selectedGoal,
                  onChanged: (value, label) {
                    selectedGoal = value;
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
                  label: "Channel",
                  items: channelOptions,
                  value: selectedChannel,
                  onChanged: (value, label) {
                    selectedChannel = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Include Micro-conversions",
                      "value": true,
                      "checked": showMicroConversions,
                    }
                  ],
                  value: [
                    if (showMicroConversions)
                      {
                        "label": "Include Micro-conversions",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showMicroConversions = values.isNotEmpty;
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

  Widget _buildConversionOverview() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Conversion Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: conversionMetrics.map((metric) {
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
                    _formatMetricValue(metric),
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

  String _formatMetricValue(Map<String, dynamic> metric) {
    if (metric["isCurrency"] == true) {
      if (metric["value"] is int) {
        return "\$${((metric["value"] as int).toDouble()).currency}";
      } else {
        return "\$${(metric["value"] as double).currency}";
      }
    } else if (metric.containsKey("suffix")) {
      return "${(metric["value"] as double).toStringAsFixed(2)}${metric["suffix"]}";
    } else if (metric["title"].contains("Rate")) {
      return "${(metric["value"] as double).toStringAsFixed(2)}%";
    } else {
      return "${(metric["value"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}";
    }
  }

  Widget _buildConversionFunnel() {
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
            "Conversion Funnel",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: conversionFunnel.length,
            itemBuilder: (context, index) {
              final stage = conversionFunnel[index];
              Color stageColor = Color(int.parse("0xFF${(stage["color"] as String).substring(1)}"));
              bool isFirstStage = index == 0;
              
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                child: Column(
                  spacing: spXs,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: stageColor.withAlpha(10),
                        border: Border.all(color: stageColor, width: 2),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: stageColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              spacing: 2,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${stage["stage"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${(stage["count"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} users",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            spacing: 2,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${(stage["percentage"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: stageColor,
                                ),
                              ),
                              if (!isFirstStage)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: dangerColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "-${(stage["dropOff"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: dangerColor,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (index < conversionFunnel.length - 1)
                      Container(
                        width: 2,
                        height: 20,
                        color: disabledOutlineBorderColor,
                        margin: EdgeInsets.symmetric(horizontal: 11),
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

  Widget _buildConversionChart() {
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
                "Conversion Trends",
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
                  "↗ 12.5% improvement",
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
                    Icons.trending_up,
                    size: 48,
                    color: disabledColor,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Conversion Rate Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Conversion Rate & Volume Over Time",
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
              _buildChartLegend("Conversion Rate", Color(0xFF10B981)),
              SizedBox(width: spSm),
              _buildChartLegend("Conversion Volume", Color(0xFF3B82F6)),
              SizedBox(width: spSm),
              _buildChartLegend("Revenue", Color(0xFFF59E0B)),
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

  Widget _buildGoalPerformance() {
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
            "Goal Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: goalPerformance.map((goal) {
              Color trendColor = goal["trend"] == "up" ? successColor : goal["trend"] == "down" ? dangerColor : disabledBoldColor;
              IconData trendIcon = goal["trend"] == "up" ? Icons.trending_up : goal["trend"] == "down" ? Icons.trending_down : Icons.trending_flat;
              
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
                        Text(
                          "${goal["goal"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: trendColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                trendIcon,
                                size: 12,
                                color: trendColor,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${(goal["change"] as double).abs().toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: trendColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildGoalStat("Conversions", "${(goal["conversions"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}"),
                        ),
                        Expanded(
                          child: _buildGoalStat("Rate", "${(goal["rate"] as double).toStringAsFixed(1)}%"),
                        ),
                      ],
                    ),
                    _buildGoalStat("Value", "\$${((goal["value"] as double) / 1000).toStringAsFixed(1)}K"),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalStat(String label, String value) {
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

  Widget _buildChannelConversions() {
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
            "Conversion by Channel",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: channelConversions.length,
            itemBuilder: (context, index) {
              final channel = channelConversions[index];
              bool hasCost = (channel["cost"] as double) > 0;
              
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
                        Expanded(
                          child: Text(
                            "${channel["channel"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getChannelColor(index).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(channel["rate"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getChannelColor(index),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildChannelStat("Conversions", "${(channel["conversions"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}"),
                        ),
                        Expanded(
                          child: _buildChannelStat("Revenue", "\$${((channel["revenue"] as double) / 1000).toStringAsFixed(1)}K"),
                        ),
                        if (hasCost) ...[
                          Expanded(
                            child: _buildChannelStat("CPA", "\$${(channel["cpa"] as double).toStringAsFixed(0)}"),
                          ),
                          Expanded(
                            child: _buildChannelStat("ROAS", "${(channel["roas"] as double).toStringAsFixed(1)}x"),
                          ),
                        ] else ...[
                          Expanded(
                            child: _buildChannelStat("Cost", "Free"),
                          ),
                          Expanded(
                            child: _buildChannelStat("Type", "Organic"),
                          ),
                        ],
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

  Widget _buildChannelStat(String label, String value) {
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

  Widget _buildTopLandingPages() {
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
                "Top Converting Landing Pages",
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
            itemCount: topLandingPages.length,
            itemBuilder: (context, index) {
              final page = topLandingPages[index];
              
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(page["rate"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildPageStat("Visitors", "${(page["visitors"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}"),
                        ),
                        Expanded(
                          child: _buildPageStat("Conversions", "${(page["conversions"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}"),
                        ),
                        Expanded(
                          child: _buildPageStat("Revenue", "\$${((page["revenue"] as double) / 1000).toStringAsFixed(1)}K"),
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

  Widget _buildConversionPaths() {
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
            "Top Conversion Paths",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: conversionPath.length,
            itemBuilder: (context, index) {
              final path = conversionPath[index];
              
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(path["percentage"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${(path["conversions"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} conversions",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${path["path"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        _buildPathStat("Touchpoints", "${(path["touchpoints"] as int)}"),
                        SizedBox(width: spSm),
                        _buildPathStat("Avg. Time", "${(path["avgTimeToConvert"] as double).toStringAsFixed(1)} days"),
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

  Widget _buildPathStat(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        "$label: $value",
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: successColor,
        ),
      ),
    );
  }

  Color _getChannelColor(int index) {
    List<Color> colors = [
      Color(0xFF10B981),
      Color(0xFF3B82F6),
      Color(0xFFF59E0B),
      Color(0xFF8B5CF6),
      Color(0xFFEC4899),
    ];
    return colors[index % colors.length];
  }
}
