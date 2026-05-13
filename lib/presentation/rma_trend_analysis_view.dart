import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaTrendAnalysisView extends StatefulWidget {
  const RmaTrendAnalysisView({Key? key}) : super(key: key);

  @override
  State<RmaTrendAnalysisView> createState() => _RmaTrendAnalysisViewState();
}

class _RmaTrendAnalysisViewState extends State<RmaTrendAnalysisView> {
  String selectedAnalysisType = "seasonal";
  String selectedTimeRange = "12_months";
  bool loading = false;

  List<Map<String, dynamic>> analysisTypes = [
    {"label": "Seasonal Trends", "value": "seasonal"},
    {"label": "Product Trends", "value": "product"},
    {"label": "Customer Behavior", "value": "behavior"},
    {"label": "Financial Impact", "value": "financial"},
  ];

  List<Map<String, dynamic>> timeRanges = [
    {"label": "Last 6 Months", "value": "6_months"},
    {"label": "Last 12 Months", "value": "12_months"},
    {"label": "Last 2 Years", "value": "24_months"},
    {"label": "Last 3 Years", "value": "36_months"},
  ];

  List<Map<String, dynamic>> trendInsights = [
    {
      "title": "Holiday Season Returns",
      "description": "Returns spike 340% during December-January period",
      "impact": "high",
      "type": "seasonal",
      "trend": "increasing",
      "actionRequired": true,
      "recommendation": "Increase staff by 60% during peak season",
    },
    {
      "title": "Electronics Return Pattern",
      "description": "Electronics returns follow 30-day warranty cycles",
      "impact": "medium",
      "type": "product",
      "trend": "stable",
      "actionRequired": false,
      "recommendation": "Optimize quality control for electronics",
    },
    {
      "title": "First-Time Customer Returns",
      "description": "New customers 2.3x more likely to return items",
      "impact": "high",
      "type": "behavior",
      "trend": "increasing",
      "actionRequired": true,
      "recommendation": "Improve product descriptions and sizing guides",
    },
    {
      "title": "Weekend Processing Delays",
      "description": "Returns processed on weekends take 40% longer",
      "impact": "medium",
      "type": "operational",
      "trend": "stable",
      "actionRequired": true,
      "recommendation": "Implement weekend staffing adjustments",
    },
  ];

  List<Map<String, dynamic>> seasonalData = [
    {"month": "Jan 2024", "returns": 2400, "revenue": 185000, "rate": 1.3},
    {"month": "Feb 2024", "returns": 1800, "revenue": 195000, "rate": 0.92},
    {"month": "Mar 2024", "returns": 2100, "revenue": 220000, "rate": 0.95},
    {"month": "Apr 2024", "returns": 1650, "revenue": 205000, "rate": 0.81},
    {"month": "May 2024", "returns": 1900, "revenue": 215000, "rate": 0.88},
    {"month": "Jun 2024", "returns": 2200, "revenue": 240000, "rate": 0.92},
    {"month": "Jul 2024", "returns": 1750, "revenue": 200000, "rate": 0.88},
    {"month": "Aug 2024", "returns": 1850, "revenue": 210000, "rate": 0.88},
    {"month": "Sep 2024", "returns": 2000, "revenue": 225000, "rate": 0.89},
    {"month": "Oct 2024", "returns": 2300, "revenue": 250000, "rate": 0.92},
    {"month": "Nov 2024", "returns": 2800, "revenue": 285000, "rate": 0.98},
    {"month": "Dec 2024", "returns": 3200, "revenue": 320000, "rate": 1.0},
  ];

  List<Map<String, dynamic>> predictiveInsights = [
    {
      "prediction": "Q2 Return Volume",
      "forecast": "Expected 15% increase",
      "confidence": 87,
      "timeframe": "Next 3 months",
      "factors": ["Seasonal patterns", "Product launches", "Marketing campaigns"],
    },
    {
      "prediction": "Summer Processing Load",
      "forecast": "Peak in July (2.2K returns)",
      "confidence": 92,
      "timeframe": "July 2024",
      "factors": ["Historical data", "Vacation returns", "New product releases"],
    },
    {
      "prediction": "Customer Satisfaction Trend",
      "forecast": "Slight decline to 4.4/5",
      "confidence": 78,
      "timeframe": "Next 6 months",
      "factors": ["Processing delays", "Volume increase", "Staff training gaps"],
    },
  ];

  List<Map<String, dynamic>> impactAnalysis = [
    {
      "factor": "Product Quality Issues",
      "currentImpact": 34.2,
      "trendDirection": "increasing",
      "annualCost": 285000,
      "improvement": "Quality control enhancement",
    },
    {
      "factor": "Sizing/Fit Problems",
      "currentImpact": 28.7,
      "trendDirection": "stable",
      "annualCost": 195000,
      "improvement": "Better size charts",
    },
    {
      "factor": "Customer Expectations",
      "currentImpact": 18.9,
      "trendDirection": "increasing",
      "annualCost": 125000,
      "improvement": "Enhanced product descriptions",
    },
    {
      "factor": "Shipping Damage",
      "currentImpact": 12.1,
      "trendDirection": "decreasing",
      "annualCost": 85000,
      "improvement": "Improved packaging",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trend Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.psychology),
            onPressed: () => _generatePredictions(),
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () => _exportTrendReport(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            SizedBox(height: spLg),
            _buildTrendOverview(),
            SizedBox(height: spLg),
            _buildSeasonalTrends(),
            SizedBox(height: spLg),
            _buildKeyInsights(),
            SizedBox(height: spLg),
            _buildPredictiveAnalysis(),
            SizedBox(height: spLg),
            _buildImpactAnalysis(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
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
          Text(
            "Trend Analysis Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Analysis Type",
                  items: analysisTypes,
                  value: selectedAnalysisType,
                  onChanged: (value, label) {
                    selectedAnalysisType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendOverview() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildOverviewCard(
          "Trend Direction",
          "Upward",
          Icons.trending_up,
          successColor,
          "+12% YoY growth",
        ),
        _buildOverviewCard(
          "Seasonal Peak",
          "December",
          Icons.ac_unit,
          infoColor,
          "340% increase",
        ),
        _buildOverviewCard(
          "Prediction Accuracy",
          "89%",
          Icons.psychology,
          primaryColor,
          "Model confidence",
        ),
        _buildOverviewCard(
          "Cost Impact",
          "\$690K",
          Icons.monetization_on,
          warningColor,
          "Annual projection",
        ),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color, String subtitle) {
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
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonalTrends() {
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
          Text(
            "12-Month Seasonal Trend",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 300,
            child: Column(
              children: seasonalData.map((data) => _buildSeasonalRow(data)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonalRow(Map<String, dynamic> data) {
    double maxReturns = 3200.0;
    double returnsWidth = ((data["returns"] as int) / maxReturns) * 200;
    double revenueWidth = ((data["revenue"] as int) / 320000) * 150;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              "${data["month"]}",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: returnsWidth,
                      height: 8,
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${data["returns"]} returns",
                      style: TextStyle(
                        fontSize: 11,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Container(
                      width: revenueWidth,
                      height: 4,
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "\$${((data["revenue"] as int) / 1000).toInt()}K revenue",
                      style: TextStyle(
                        fontSize: 10,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "${(data["rate"] as double).toStringAsFixed(2)}%",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Key Trend Insights",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...trendInsights.map((insight) => _buildInsightCard(insight)).toList(),
      ],
    );
  }

  Widget _buildInsightCard(Map<String, dynamic> insight) {
    Color impactColor = _getImpactColor(insight["impact"] as String);
    Color trendColor = _getTrendColor(insight["trend"] as String);
    bool actionRequired = insight["actionRequired"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
              Expanded(
                child: Text(
                  "${insight["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                decoration: BoxDecoration(
                  color: impactColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${insight["impact"]} impact",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: impactColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${insight["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                decoration: BoxDecoration(
                  color: trendColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${insight["trend"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: trendColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${insight["type"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (actionRequired)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Action Required",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: dangerColor,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb, color: infoColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${insight["recommendation"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getImpactColor(String impact) {
    switch (impact) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      default:
        return successColor;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "increasing":
        return dangerColor;
      case "decreasing":
        return successColor;
      default:
        return infoColor;
    }
  }

  Widget _buildPredictiveAnalysis() {
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
          Text(
            "Predictive Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...predictiveInsights.map((prediction) => _buildPredictionItem(prediction)).toList(),
        ],
      ),
    );
  }

  Widget _buildPredictionItem(Map<String, dynamic> prediction) {
    int confidence = prediction["confidence"] as int;
    Color confidenceColor = confidence >= 80 ? successColor : confidence >= 60 ? warningColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${prediction["prediction"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                decoration: BoxDecoration(
                  color: confidenceColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${confidence}% confident",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: confidenceColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${prediction["forecast"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: warningColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Timeframe: ${prediction["timeframe"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Key factors:",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          ...(prediction["factors"] as List<String>).map((factor) {
            return Padding(
              padding: EdgeInsets.only(left: spSm, bottom: 2),
              child: Text(
                "• $factor",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildImpactAnalysis() {
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
          Text(
            "Return Factor Impact Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...impactAnalysis.map((factor) => _buildImpactItem(factor)).toList(),
        ],
      ),
    );
  }

  Widget _buildImpactItem(Map<String, dynamic> factor) {
    double percentage = (factor["currentImpact"] as double) / 100;
    Color trendColor = _getTrendColor(factor["trendDirection"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${factor["factor"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "\$${((factor["annualCost"] as int) / 1000).toInt()}K",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "${(factor["currentImpact"] as double).toStringAsFixed(1)}% of returns",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                decoration: BoxDecoration(
                  color: trendColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${factor["trendDirection"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: trendColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            height: 6,
            child: Row(
              children: [
                Expanded(
                  flex: (percentage * 1000).toInt(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                ),
                Expanded(
                  flex: ((1 - percentage) * 1000).toInt(),
                  child: Container(),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Improvement: ${factor["improvement"]}",
            style: TextStyle(
              fontSize: 11,
              color: successColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  void _generatePredictions() {
    loading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 3), () {
      loading = false;
      setState(() {});
      ss("AI predictions generated successfully");
    });
  }

  void _exportTrendReport() {
    ss("Trend analysis report exported successfully");
  }
}
