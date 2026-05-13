import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsAdPerformanceView extends StatefulWidget {
  const DmsAdPerformanceView({super.key});

  @override
  State<DmsAdPerformanceView> createState() => _DmsAdPerformanceViewState();
}

class _DmsAdPerformanceViewState extends State<DmsAdPerformanceView> {
  String selectedTimeRange = "7d";
  String selectedCampaign = "all";
  String selectedMetric = "impressions";
  int currentTab = 0;

  List<Map<String, dynamic>> timeRangeOptions = [
    {"label": "Last 7 Days", "value": "7d"},
    {"label": "Last 30 Days", "value": "30d"},
    {"label": "Last 90 Days", "value": "90d"},
    {"label": "Custom Range", "value": "custom"}
  ];

  List<Map<String, dynamic>> campaignOptions = [
    {"label": "All Campaigns", "value": "all"},
    {"label": "Summer Sale Campaign", "value": "campaign1"},
    {"label": "Brand Awareness Drive", "value": "campaign2"},
    {"label": "Product Launch", "value": "campaign3"}
  ];

  List<Map<String, dynamic>> metricOptions = [
    {"label": "Impressions", "value": "impressions"},
    {"label": "Clicks", "value": "clicks"},
    {"label": "Conversions", "value": "conversions"},
    {"label": "Spend", "value": "spend"}
  ];

  List<Map<String, dynamic>> adPerformanceData = [
    {
      "id": "ad1",
      "name": "Summer Collection Ad",
      "campaign": "Summer Sale Campaign",
      "status": "Active",
      "impressions": 125000,
      "clicks": 3200,
      "conversions": 84,
      "spend": 6800.50,
      "ctr": 2.56,
      "cpc": 2.13,
      "cpa": 80.96,
      "roas": 385,
      "reach": 89000,
      "frequency": 1.4,
      "type": "Image",
      "createdDate": "2024-05-15"
    },
    {
      "id": "ad2",
      "name": "Brand Story Video",
      "campaign": "Brand Awareness Drive",
      "status": "Active",
      "impressions": 98000,
      "clicks": 2850,
      "conversions": 76,
      "spend": 5270.25,
      "ctr": 2.91,
      "cpc": 1.85,
      "cpa": 69.35,
      "roas": 420,
      "reach": 72000,
      "frequency": 1.36,
      "type": "Video",
      "createdDate": "2024-05-10"
    },
    {
      "id": "ad3",
      "name": "Product Demo Carousel",
      "campaign": "Product Launch",
      "status": "Paused",
      "impressions": 45000,
      "clicks": 980,
      "conversions": 18,
      "spend": 3136.00,
      "ctr": 2.18,
      "cpc": 3.20,
      "cpa": 174.22,
      "roas": 180,
      "reach": 38000,
      "frequency": 1.18,
      "type": "Carousel",
      "createdDate": "2024-05-08"
    },
    {
      "id": "ad4",
      "name": "Limited Time Offer",
      "campaign": "Summer Sale Campaign",
      "status": "Active",
      "impressions": 156000,
      "clicks": 4100,
      "conversions": 128,
      "spend": 8200.75,
      "ctr": 2.63,
      "cpc": 2.00,
      "cpa": 64.07,
      "roas": 450,
      "reach": 112000,
      "frequency": 1.39,
      "type": "Image",
      "createdDate": "2024-05-12"
    }
  ];

  List<Map<String, dynamic>> performanceMetrics = [
    {
      "title": "Total Impressions",
      "value": "424K",
      "change": "+12.3%",
      "trend": "up",
      "icon": Icons.visibility
    },
    {
      "title": "Total Clicks",
      "value": "11.1K",
      "change": "+8.7%",
      "trend": "up",
      "icon": Icons.mouse
    },
    {
      "title": "Total Conversions",
      "value": "306",
      "change": "+15.2%",
      "trend": "up",
      "icon": Icons.trending_up
    },
    {
      "title": "Total Spend",
      "value": "\$23.4K",
      "change": "+5.1%",
      "trend": "up",
      "icon": Icons.attach_money
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ad Performance"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Performance report downloaded");
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Performance data refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildHeader(),
            _buildFilters(),
            _buildPerformanceOverview(),
            _buildAdPerformanceList(),
            _buildPerformanceInsights(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ad Performance Analytics",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Track and optimize your advertising performance",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(230),
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
                child: _buildHeaderMetric("Active Ads", "4", Icons.ads_click),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildHeaderMetric("Avg. CTR", "2.57%", Icons.mouse),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildHeaderMetric("Avg. CPA", "\$87.15", Icons.paid),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderMetric(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withAlpha(204),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.filter_list,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Performance Filters",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Range",
                  items: timeRangeOptions,
                  value: selectedTimeRange,
                  onChanged: (value, label) {
                    selectedTimeRange = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Campaign",
                  items: campaignOptions,
                  value: selectedCampaign,
                  onChanged: (value, label) {
                    selectedCampaign = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Primary Metric",
            items: metricOptions,
            value: selectedMetric,
            onChanged: (value, label) {
              selectedMetric = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.dashboard,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Performance Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: performanceMetrics.map((metric) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          metric["icon"] as IconData,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${metric["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${metric["value"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: metric["trend"] == "up" ? successColor : dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                metric["trend"] == "up" ? Icons.arrow_upward : Icons.arrow_downward,
                                color: Colors.white,
                                size: 12,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${metric["change"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
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
    );
  }

  Widget _buildAdPerformanceList() {
    List<Map<String, dynamic>> filteredAds = selectedCampaign == "all" 
        ? adPerformanceData 
        : adPerformanceData.where((ad) => ad["campaign"].toString().toLowerCase().contains(selectedCampaign)).toList();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.list,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Ad Performance Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...filteredAds.map((ad) {
            return Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: ad["status"] == "Active" 
                      ? successColor 
                      : disabledColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${ad["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${ad["campaign"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: ad["status"] == "Active" 
                              ? successColor 
                              : warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${ad["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: infoColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${ad["type"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricItem(
                          "Impressions", 
                          "${((ad["impressions"] as int) / 1000).toStringAsFixed(0)}K"
                        ),
                      ),
                      Expanded(
                        child: _buildMetricItem(
                          "Clicks", 
                          "${((ad["clicks"] as int) / 1000).toStringAsFixed(1)}K"
                        ),
                      ),
                      Expanded(
                        child: _buildMetricItem(
                          "CTR", 
                          "${(ad["ctr"] as double).toStringAsFixed(2)}%"
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricItem(
                          "Conversions", 
                          "${ad["conversions"]}"
                        ),
                      ),
                      Expanded(
                        child: _buildMetricItem(
                          "CPC", 
                          "\$${(ad["cpc"] as double).toStringAsFixed(2)}"
                        ),
                      ),
                      Expanded(
                        child: _buildMetricItem(
                          "ROAS", 
                          "${ad["roas"]}%"
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricItem(
                          "Spend", 
                          "\$${((ad["spend"] as double) / 1000).toStringAsFixed(1)}K"
                        ),
                      ),
                      Expanded(
                        child: _buildMetricItem(
                          "CPA", 
                          "\$${(ad["cpa"] as double).toStringAsFixed(2)}"
                        ),
                      ),
                      Expanded(
                        child: _buildMetricItem(
                          "Reach", 
                          "${((ad["reach"] as int) / 1000).toStringAsFixed(0)}K"
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening details for ${ad["name"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Edit Ad",
                          size: bs.sm,
                          onPressed: () {
                            si("Editing ${ad["name"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () {
                          si("More options for ${ad["name"]}");
                        },
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

  Widget _buildMetricItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceInsights() {
    List<Map<String, dynamic>> insights = [
      {
        "title": "Best Performing Ad",
        "description": "Limited Time Offer shows highest ROAS at 450%",
        "type": "success",
        "action": "Scale this ad format across other campaigns"
      },
      {
        "title": "Underperforming Ad",
        "description": "Product Demo Carousel has high CPA at \$174.22",
        "type": "warning",
        "action": "Review targeting and creative elements"
      },
      {
        "title": "Opportunity",
        "description": "Video ads show 15% better engagement than images",
        "type": "info",
        "action": "Consider creating more video content"
      }
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.psychology,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Performance Insights",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...insights.map((insight) {
            Color insightColor = insight["type"] == "success" 
                ? successColor 
                : insight["type"] == "warning" 
                    ? warningColor 
                    : infoColor;

            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: insightColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: insightColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        insight["type"] == "success" 
                            ? Icons.trending_up 
                            : insight["type"] == "warning" 
                                ? Icons.warning 
                                : Icons.lightbulb,
                        color: insightColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${insight["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${insight["description"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Recommendation: ${insight["action"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: insightColor,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Take Action",
                      size: bs.sm,
                      onPressed: () {
                        ss("Taking action on: ${insight["title"]}");
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
