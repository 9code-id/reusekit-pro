import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMetric4View extends StatefulWidget {
  @override
  State<GrlMetric4View> createState() => _GrlMetric4ViewState();
}

class _GrlMetric4ViewState extends State<GrlMetric4View> {
  String selectedPeriod = "This Month";
  String selectedMetric = "Conversion Rate";
  
  List<Map<String, dynamic>> conversionData = [
    {
      "source": "Website",
      "visitors": 25430,
      "conversions": 1271,
      "rate": 5.0,
      "trend": "up",
      "change": 12.5,
      "color": Color(0xFF22C55E),
    },
    {
      "source": "Social Media",
      "visitors": 18950,
      "conversions": 758,
      "rate": 4.0,
      "trend": "up",
      "change": 8.3,
      "color": Color(0xFF3B82F6),
    },
    {
      "source": "Email Campaign",
      "visitors": 12600,
      "conversions": 945,
      "rate": 7.5,
      "trend": "up",
      "change": 15.2,
      "color": Color(0xFF8B5CF6),
    },
    {
      "source": "Paid Ads",
      "visitors": 22100,
      "conversions": 1547,
      "rate": 7.0,
      "trend": "down",
      "change": -2.1,
      "color": Color(0xFFF59E0B),
    },
    {
      "source": "Direct Traffic",
      "visitors": 8750,
      "conversions": 350,
      "rate": 4.0,
      "trend": "up",
      "change": 6.7,
      "color": Color(0xFFEF4444),
    },
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> metricItems = [
    {"label": "Conversion Rate", "value": "Conversion Rate"},
    {"label": "Click-through Rate", "value": "Click-through Rate"},
    {"label": "Cost per Conversion", "value": "Cost per Conversion"},
    {"label": "Return on Ad Spend", "value": "Return on Ad Spend"},
  ];

  @override
  Widget build(BuildContext context) {
    double totalConversions = conversionData.fold(0.0, (sum, item) => sum + (item["conversions"] as int));
    double averageRate = conversionData.fold(0.0, (sum, item) => sum + (item["rate"] as double)) / conversionData.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Conversion Metrics"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
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
                    items: periodItems,
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
                    items: metricItems,
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildSummaryCard(
                  "Total Conversions",
                  "${totalConversions.toInt()}",
                  Icons.trending_up,
                  successColor,
                  "+12.5%",
                ),
                _buildSummaryCard(
                  "Average Rate",
                  "${averageRate.toStringAsFixed(1)}%",
                  Icons.percent,
                  infoColor,
                  "+8.2%",
                ),
                _buildSummaryCard(
                  "Top Performer",
                  "Email Campaign",
                  Icons.email,
                  warningColor,
                  "7.5%",
                ),
                _buildSummaryCard(
                  "Improvement",
                  "+15.2%",
                  Icons.arrow_upward,
                  primaryColor,
                  "vs last period",
                ),
              ],
            ),

            // Conversion Sources
            Text(
              "Conversion by Source",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: conversionData.map((item) => _buildConversionItem(item)).toList(),
              ),
            ),

            // Performance Chart
            Text(
              "Performance Trends",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "7-Day Conversion Trend",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "+12.5%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(spMd),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(7, (index) {
                          double height = 20 + (index * 15) + ((index % 3) * 10);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 20,
                                height: height,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(150 + (index * 15)),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${5 + index}%",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Action Insights
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor.withAlpha(10),
                    successColor.withAlpha(10),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Optimization Insights",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "• Email campaigns show highest conversion rate (7.5%)",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "• Paid ads need optimization - consider A/B testing",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "• Social media conversions improving (+8.3%)",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
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
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  Icons.trending_up,
                  color: color,
                  size: 12,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
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
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversionItem(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (item["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getSourceIcon("${item["source"]}"),
              color: item["color"] as Color,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["source"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${(item["visitors"] as int).toString()} visitors",
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
                "${(item["rate"] as double).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    "${item["trend"]}" == "up" ? Icons.arrow_upward : Icons.arrow_downward,
                    color: "${item["trend"]}" == "up" ? successColor : dangerColor,
                    size: 12,
                  ),
                  Text(
                    "${(item["change"] as double).abs().toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: "${item["trend"]}" == "up" ? successColor : dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getSourceIcon(String source) {
    switch (source) {
      case "Website":
        return Icons.language;
      case "Social Media":
        return Icons.share;
      case "Email Campaign":
        return Icons.email;
      case "Paid Ads":
        return Icons.campaign;
      case "Direct Traffic":
        return Icons.trending_up;
      default:
        return Icons.source;
    }
  }
}
