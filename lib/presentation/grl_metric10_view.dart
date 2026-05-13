import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMetric10View extends StatefulWidget {
  @override
  State<GrlMetric10View> createState() => _GrlMetric10ViewState();
}

class _GrlMetric10ViewState extends State<GrlMetric10View> {
  String selectedRegion = "Global";
  String selectedTimeframe = "Last 30 Days";
  
  List<Map<String, dynamic>> marketingMetrics = [
    {
      "channel": "Social Media",
      "impressions": 2847590,
      "clicks": 142380,
      "ctr": 5.0,
      "conversions": 8543,
      "cpa": 12.45,
      "roas": 4.2,
      "color": Color(0xFF3B82F6),
      "trend": "up",
      "change": 15.3,
    },
    {
      "channel": "Google Ads",
      "impressions": 1923640,
      "clicks": 96182,
      "ctr": 5.0,
      "conversions": 7235,
      "cpa": 16.78,
      "roas": 3.8,
      "color": Color(0xFF22C55E),
      "trend": "up",
      "change": 8.7,
    },
    {
      "channel": "Email Marketing",
      "impressions": 567890,
      "clicks": 45431,
      "ctr": 8.0,
      "conversions": 5467,
      "cpa": 8.92,
      "roas": 6.1,
      "color": Color(0xFF8B5CF6),
      "trend": "up",
      "change": 22.1,
    },
    {
      "channel": "Display Ads",
      "impressions": 3456780,
      "clicks": 69136,
      "ctr": 2.0,
      "conversions": 3457,
      "cpa": 28.56,
      "roas": 2.1,
      "color": Color(0xFFF59E0B),
      "trend": "down",
      "change": -3.4,
    },
    {
      "channel": "Content Marketing",
      "impressions": 892340,
      "clicks": 62464,
      "ctr": 7.0,
      "conversions": 4372,
      "cpa": 11.23,
      "roas": 5.3,
      "color": Color(0xFFEF4444),
      "trend": "up",
      "change": 18.9,
    },
  ];

  List<Map<String, dynamic>> campaignPerformance = [
    {
      "name": "Summer Sale 2024",
      "status": "active",
      "budget": 25000,
      "spent": 18750,
      "impressions": 1247890,
      "clicks": 62395,
      "conversions": 4987,
      "roas": 4.8,
    },
    {
      "name": "Brand Awareness Q2",
      "status": "paused",
      "budget": 15000,
      "spent": 14200,
      "impressions": 2156780,
      "clicks": 43136,
      "conversions": 2154,
      "roas": 2.3,
    },
    {
      "name": "Product Launch",
      "status": "active",
      "budget": 35000,
      "spent": 28900,
      "impressions": 3456780,
      "clicks": 138271,
      "conversions": 8276,
      "roas": 5.2,
    },
    {
      "name": "Holiday Special",
      "status": "completed",
      "budget": 20000,
      "spent": 19800,
      "impressions": 1876540,
      "clicks": 75062,
      "conversions": 6754,
      "roas": 6.1,
    },
  ];

  List<Map<String, dynamic>> audienceInsights = [
    {
      "segment": "18-24 Female",
      "size": 145670,
      "engagement": 8.5,
      "conversionRate": 3.2,
      "avgOrderValue": 78.45,
      "color": Color(0xFF22C55E),
    },
    {
      "segment": "25-34 Male",
      "size": 198230,
      "engagement": 6.8,
      "conversionRate": 4.1,
      "avgOrderValue": 124.67,
      "color": Color(0xFF3B82F6),
    },
    {
      "segment": "35-44 Female",
      "size": 167540,
      "engagement": 9.2,
      "conversionRate": 5.8,
      "avgOrderValue": 156.23,
      "color": Color(0xFF8B5CF6),
    },
    {
      "segment": "45-54 Male",
      "size": 123890,
      "engagement": 7.1,
      "conversionRate": 4.7,
      "avgOrderValue": 189.34,
      "color": Color(0xFFF59E0B),
    },
  ];

  List<Map<String, dynamic>> regionItems = [
    {"label": "Global", "value": "Global"},
    {"label": "North America", "value": "North America"},
    {"label": "Europe", "value": "Europe"},
    {"label": "Asia Pacific", "value": "Asia Pacific"},
    {"label": "Latin America", "value": "Latin America"},
  ];

  List<Map<String, dynamic>> timeframeItems = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
    {"label": "This Year", "value": "This Year"},
  ];

  @override
  Widget build(BuildContext context) {
    double totalImpressions = marketingMetrics.fold(0.0, (sum, item) => sum + (item["impressions"] as int));
    double totalClicks = marketingMetrics.fold(0.0, (sum, item) => sum + (item["clicks"] as int));
    double totalConversions = marketingMetrics.fold(0.0, (sum, item) => sum + (item["conversions"] as int));
    double avgCTR = marketingMetrics.fold(0.0, (sum, item) => sum + (item["ctr"] as double)) / marketingMetrics.length;
    double avgROAS = marketingMetrics.fold(0.0, (sum, item) => sum + (item["roas"] as double)) / marketingMetrics.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Marketing Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.campaign),
            onPressed: () {
              ss("Campaign optimization suggestions available");
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
                    label: "Region",
                    items: regionItems,
                    value: selectedRegion,
                    onChanged: (value, label) {
                      selectedRegion = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
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

            // Key Marketing Metrics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 140,
              children: [
                _buildMetricCard(
                  "Impressions",
                  "${(totalImpressions / 1000000).toStringAsFixed(1)}M",
                  Icons.visibility,
                  primaryColor,
                  "+12.5% vs last month",
                ),
                _buildMetricCard(
                  "Click Rate",
                  "${avgCTR.toStringAsFixed(1)}%",
                  Icons.ads_click,
                  successColor,
                  "Above industry avg",
                ),
                _buildMetricCard(
                  "Conversions",
                  "${(totalConversions / 1000).toStringAsFixed(1)}K",
                  Icons.trending_up,
                  infoColor,
                  "+18.7% improvement",
                ),
                _buildMetricCard(
                  "Avg ROAS",
                  "${avgROAS.toStringAsFixed(1)}x",
                  Icons.attach_money,
                  warningColor,
                  "Return on ad spend",
                ),
              ],
            ),

            // Channel Performance
            Text(
              "Channel Performance",
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
                children: marketingMetrics.map((channel) => _buildChannelItem(channel)).toList(),
              ),
            ),

            // Campaign Performance
            Text(
              "Active Campaigns",
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
                children: campaignPerformance.map((campaign) => _buildCampaignItem(campaign)).toList(),
              ),
            ),

            // Audience Insights
            Text(
              "Audience Insights",
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
                children: audienceInsights.map((audience) => _buildAudienceItem(audience)).toList(),
              ),
            ),

            // ROAS Comparison Chart
            Text(
              "ROAS by Channel",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              height: 200,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Return on Ad Spend Comparison",
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
                          "Avg: ${avgROAS.toStringAsFixed(1)}x",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: marketingMetrics.map((channel) {
                        double roas = channel["roas"] as double;
                        double height = (roas / 7) * 120; // Scale to chart height
                        Color barColor = roas >= 4 ? successColor : roas >= 2.5 ? warningColor : dangerColor;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${roas.toStringAsFixed(1)}x",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              width: 25,
                              height: height.clamp(10, 120),
                              decoration: BoxDecoration(
                                color: barColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${channel["channel"]}".split(' ')[0].substring(0, 3).toUpperCase(),
                              style: TextStyle(
                                fontSize: 9,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Marketing Insights
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
                        Icons.insights,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Marketing Insights",
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
                      children: [
                        _buildInsightItem(
                          Icons.email,
                          "Email Marketing shows highest ROAS (6.1x)",
                          successColor,
                        ),
                        _buildInsightItem(
                          Icons.trending_up,
                          "Content Marketing growing rapidly (+18.9%)",
                          infoColor,
                        ),
                        _buildInsightItem(
                          Icons.warning,
                          "Display Ads performance declining (-3.4%)",
                          warningColor,
                        ),
                        _buildInsightItem(
                          Icons.people,
                          "35-44 Female segment has highest conversion rate",
                          primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Optimization Recommendations
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
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Optimization Recommendations",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: [
                      _buildRecommendationItem(
                        "Increase email marketing budget allocation",
                        successColor,
                        "High ROI",
                      ),
                      _buildRecommendationItem(
                        "Optimize display ad targeting and creative",
                        dangerColor,
                        "Performance Issue",
                      ),
                      _buildRecommendationItem(
                        "Scale content marketing investment",
                        infoColor,
                        "Growth Opportunity",
                      ),
                      _buildRecommendationItem(
                        "Test new audience segments similar to 35-44 Female",
                        warningColor,
                        "Expansion Strategy",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String subtitle) {
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
              ),
              Icon(
                Icons.trending_up,
                color: color,
                size: 14,
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
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

  Widget _buildChannelItem(Map<String, dynamic> channel) {
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
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: (channel["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getChannelIcon("${channel["channel"]}"),
                  color: channel["color"] as Color,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${channel["channel"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${((channel["impressions"] as int) / 1000000).toStringAsFixed(1)}M impressions",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          "${channel["trend"]}" == "up" ? Icons.arrow_upward : Icons.arrow_downward,
                          color: "${channel["trend"]}" == "up" ? successColor : dangerColor,
                          size: 12,
                        ),
                        Text(
                          "${(channel["change"] as double).abs().toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: "${channel["trend"]}" == "up" ? successColor : dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 80,
            children: [
              _buildChannelMetric("CTR", "${(channel["ctr"] as double).toStringAsFixed(1)}%"),
              _buildChannelMetric("Conversions", "${(channel["conversions"] as int)}"),
              _buildChannelMetric("CPA", "\$${(channel["cpa"] as double).toStringAsFixed(2)}"),
              _buildChannelMetric("ROAS", "${(channel["roas"] as double).toStringAsFixed(1)}x"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChannelMetric(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignItem(Map<String, dynamic> campaign) {
    Color statusColor = _getStatusColor("${campaign["status"]}");
    double spentPercentage = ((campaign["spent"] as int) / (campaign["budget"] as int)) * 100;

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
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.campaign,
                  color: statusColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${campaign["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${campaign["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${spentPercentage.toStringAsFixed(0)}% spent",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${(campaign["roas"] as double).toStringAsFixed(1)}x",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "ROAS",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 90,
            children: [
              _buildCampaignMetric("Budget", "\$${((campaign["budget"] as int) / 1000).toInt()}K"),
              _buildCampaignMetric("Spent", "\$${((campaign["spent"] as int) / 1000).toInt()}K"),
              _buildCampaignMetric("Clicks", "${((campaign["clicks"] as int) / 1000).toInt()}K"),
              _buildCampaignMetric("Conversions", "${campaign["conversions"]}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignMetric(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudienceItem(Map<String, dynamic> audience) {
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
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: (audience["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.people,
              color: audience["color"] as Color,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${audience["segment"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${((audience["size"] as int) / 1000).toInt()}K audience size",
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
                "${(audience["conversionRate"] as double).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "conversion rate",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 16,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationItem(String text, Color color, String priority) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Text(
            priority,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  IconData _getChannelIcon(String channel) {
    switch (channel) {
      case "Social Media":
        return Icons.share;
      case "Google Ads":
        return Icons.search;
      case "Email Marketing":
        return Icons.email;
      case "Display Ads":
        return Icons.web;
      case "Content Marketing":
        return Icons.article;
      default:
        return Icons.campaign;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "paused":
        return warningColor;
      case "completed":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
