import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMetric1View extends StatefulWidget {
  const GrlMetric1View({Key? key}) : super(key: key);

  @override
  State<GrlMetric1View> createState() => _GrlMetric1ViewState();
}

class _GrlMetric1ViewState extends State<GrlMetric1View> {
  String selectedMetric = "performance";
  List<Map<String, dynamic>> performanceMetrics = [
    {
      "title": "Website Traffic",
      "current": 45678,
      "previous": 42150,
      "target": 50000,
      "unit": "visitors",
      "trend": "up",
      "percentage": 8.4,
      "color": primaryColor,
      "icon": Icons.web
    },
    {
      "title": "Conversion Rate",
      "current": 3.8,
      "previous": 3.2,
      "target": 4.5,
      "unit": "percentage",
      "trend": "up",
      "percentage": 18.7,
      "color": successColor,
      "icon": Icons.trending_up
    },
    {
      "title": "Bounce Rate",
      "current": 28.5,
      "previous": 32.1,
      "target": 25.0,
      "unit": "percentage",
      "trend": "down",
      "percentage": -11.2,
      "color": warningColor,
      "icon": Icons.exit_to_app
    },
    {
      "title": "Page Load Time",
      "current": 1.2,
      "previous": 1.8,
      "target": 1.0,
      "unit": "seconds",
      "trend": "down",
      "percentage": -33.3,
      "color": infoColor,
      "icon": Icons.speed
    }
  ];

  List<Map<String, dynamic>> chartData = [
    {"month": "Jan", "value": 30000, "target": 35000},
    {"month": "Feb", "value": 35000, "target": 38000},
    {"month": "Mar", "value": 42000, "target": 40000},
    {"month": "Apr", "value": 38000, "target": 42000},
    {"month": "May", "value": 45000, "target": 45000},
    {"month": "Jun", "value": 48000, "target": 47000},
  ];

  Map<String, dynamic> insights = {
    "totalGrowth": 23.5,
    "bestPerforming": "Website Traffic",
    "needsImprovement": "Page Load Time",
    "forecast": 52000,
    "recommendations": [
      "Optimize server response time to improve page load speed",
      "Implement A/B testing for landing pages to boost conversion",
      "Focus on mobile optimization for better user experience",
      "Review content strategy to reduce bounce rate"
    ]
  };

  String _formatMetricValue(dynamic value, String unit) {
    switch (unit) {
      case "visitors":
        if ((value as num) >= 1000) {
          return "${((value as num) / 1000).toStringAsFixed(1)}K";
        }
        return "$value";
      case "percentage":
        return "${(value as num).toStringAsFixed(1)}%";
      case "seconds":
        return "${(value as num).toStringAsFixed(1)}s";
      default:
        return "$value";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Performance Metrics"),
        actions: [
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              _showMetricSettings();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Metric Selector
            QCategoryPicker(
              label: "Select Metric Category",
              items: const [
                {"label": "Performance", "value": "performance"},
                {"label": "Engagement", "value": "engagement"},
                {"label": "Conversion", "value": "conversion"},
                {"label": "Technical", "value": "technical"},
              ],
              value: selectedMetric,
              onChanged: (index, label, value, item) {
                selectedMetric = value;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Overview Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.dashboard,
                    color: primaryColor,
                    size: 28,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Metrics Dashboard",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Real-time performance tracking and analysis",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "+${insights["totalGrowth"]}%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Key Metrics Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: performanceMetrics.map((metric) {
                final isPositive = (metric["percentage"] as double) >= 0;
                final progressValue = ((metric["current"] as num) / (metric["target"] as num)).clamp(0.0, 1.0);
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border.all(color: (metric["color"] as Color).withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with icon and trend
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
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
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (isPositive ? successColor : dangerColor).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                                  size: 12,
                                  color: isPositive ? successColor : dangerColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${(metric["percentage"] as double).abs().toStringAsFixed(1)}%",
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
                      
                      SizedBox(height: spMd),
                      
                      // Current Value
                      Text(
                        _formatMetricValue(metric["current"], "${metric["unit"]}"),
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: metric["color"] as Color,
                        ),
                      ),
                      
                      SizedBox(height: spXs),
                      
                      // Title
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Progress to target
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Target: ${_formatMetricValue(metric["target"], "${metric["unit"]}")}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${(progressValue * 100).toStringAsFixed(0)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: metric["color"] as Color,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Container(
                            width: double.infinity,
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progressValue,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: metric["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Chart Visualization
            Container(
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
                      Text(
                        "Performance Trend",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Last 6 months",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spLg),
                  
                  // Simple chart representation
                  Container(
                    height: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: chartData.map((data) {
                        final maxValue = chartData.map((d) => d["target"] as int).reduce((a, b) => a > b ? a : b);
                        final currentHeight = ((data["value"] as int) / maxValue * 160).toDouble();
                        final targetHeight = ((data["target"] as int) / maxValue * 160).toDouble();
                        
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Values
                                Text(
                                  "${((data["value"] as int) / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                
                                // Bars
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    // Target bar (background)
                                    Container(
                                      width: 20,
                                      height: targetHeight,
                                      decoration: BoxDecoration(
                                        color: disabledColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                    // Current value bar
                                    Container(
                                      width: 20,
                                      height: currentHeight,
                                      decoration: BoxDecoration(
                                        color: (data["value"] as int) >= (data["target"] as int) 
                                            ? successColor 
                                            : primaryColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spXs),
                                
                                // Month label
                                Text(
                                  "${data["month"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Insights and Recommendations
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Insights & Recommendations",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Quick insights
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Best Performing",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${insights["bestPerforming"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
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
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Needs Improvement",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${insights["needsImprovement"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Recommendations list
                  Text(
                    "Recommended Actions:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  ...(insights["recommendations"] as List<String>).map((recommendation) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              recommendation,
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMetricSettings() {
    // Show metric settings implementation
  }
}
