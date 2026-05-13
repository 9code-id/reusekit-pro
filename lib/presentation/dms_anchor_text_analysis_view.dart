import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsAnchorTextAnalysisView extends StatefulWidget {
  const DmsAnchorTextAnalysisView({super.key});

  @override
  State<DmsAnchorTextAnalysisView> createState() => _DmsAnchorTextAnalysisViewState();
}

class _DmsAnchorTextAnalysisViewState extends State<DmsAnchorTextAnalysisView> {
  String domain = "";
  String selectedTimeframe = "3months";
  int currentTab = 0;
  bool loading = false;

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 30 Days", "value": "30days"},
    {"label": "Last 3 Months", "value": "3months"},
    {"label": "Last 6 Months", "value": "6months"},
    {"label": "Last Year", "value": "12months"},
  ];

  List<Map<String, dynamic>> anchorTextData = [
    {
      "text": "digital marketing",
      "frequency": 45,
      "percentage": 18.2,
      "type": "Exact Match",
      "power": 85,
      "domains": 23,
      "first_seen": "2024-01-15",
      "trend": "up"
    },
    {
      "text": "best digital marketing agency",
      "frequency": 32,
      "percentage": 12.9,
      "type": "Phrase Match",
      "power": 78,
      "domains": 18,
      "first_seen": "2024-02-03",
      "trend": "stable"
    },
    {
      "text": "click here",
      "frequency": 28,
      "percentage": 11.3,
      "type": "Generic",
      "power": 25,
      "domains": 15,
      "first_seen": "2024-01-20",
      "trend": "down"
    },
    {
      "text": "marketing solutions",
      "frequency": 24,
      "percentage": 9.7,
      "type": "Partial Match",
      "power": 65,
      "domains": 12,
      "first_seen": "2024-02-18",
      "trend": "up"
    },
    {
      "text": "example.com",
      "frequency": 19,
      "percentage": 7.7,
      "type": "URL/Brand",
      "power": 55,
      "domains": 9,
      "first_seen": "2024-01-08",
      "trend": "stable"
    }
  ];

  List<Map<String, dynamic>> anchorDistribution = [
    {"type": "Exact Match", "count": 67, "percentage": 27.1, "color": successColor},
    {"type": "Phrase Match", "count": 52, "percentage": 21.0, "color": infoColor},
    {"type": "Partial Match", "count": 41, "percentage": 16.6, "color": warningColor},
    {"type": "Brand/URL", "count": 38, "percentage": 15.3, "color": primaryColor},
    {"type": "Generic", "count": 35, "percentage": 14.2, "color": dangerColor},
    {"type": "Other", "count": 15, "percentage": 6.1, "color": disabledBoldColor},
  ];

  List<Map<String, dynamic>> competitorAnchors = [
    {
      "competitor": "competitor1.com",
      "top_anchors": [
        {"text": "online marketing", "frequency": 34},
        {"text": "digital solutions", "frequency": 28},
        {"text": "marketing agency", "frequency": 22}
      ],
      "total_backlinks": 145,
      "brand_ratio": 32.4
    },
    {
      "competitor": "competitor2.com",
      "top_anchors": [
        {"text": "seo services", "frequency": 41},
        {"text": "search optimization", "frequency": 33},
        {"text": "competitor2.com", "frequency": 29}
      ],
      "total_backlinks": 198,
      "brand_ratio": 24.7
    }
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "issue": "High Generic Anchor Ratio",
      "description": "11.3% of your anchors are generic terms like 'click here'",
      "recommendation": "Focus on getting more keyword-rich anchor texts",
      "priority": "High",
      "impact": "Medium"
    },
    {
      "issue": "Low Brand Anchor Percentage",
      "description": "Only 15.3% of anchors contain your brand or URL",
      "recommendation": "Increase brand mentions in anchor texts for better brand authority",
      "priority": "Medium",
      "impact": "High"
    },
    {
      "issue": "Anchor Text Concentration",
      "description": "Top 3 anchors account for 42.4% of all anchor texts",
      "recommendation": "Diversify anchor text portfolio to avoid over-optimization",
      "priority": "Medium",
      "impact": "Medium"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Anchor Text Analysis",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.analytics)),
        Tab(text: "Distribution", icon: Icon(Icons.pie_chart)),
        Tab(text: "Competitors", icon: Icon(Icons.business)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildDistributionTab(),
        _buildCompetitorsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalysisForm(),
          if (domain.isNotEmpty) ...[
            _buildOverviewMetrics(),
            _buildAnchorTextList(),
            _buildRecommendations(),
          ]
        ],
      ),
    );
  }

  Widget _buildAnalysisForm() {
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
          Text(
            "Anchor Text Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Domain",
                  value: domain,
                  hint: "example.com",
                  onChanged: (value) {
                    domain = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Analyze Anchor Texts",
              size: bs.md,
              onPressed: () => _analyzeAnchors(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewMetrics() {
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
          Text(
            "Anchor Text Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard("Total Anchors", "247", primaryColor, Icons.link),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("Unique Anchors", "189", successColor, Icons.rule),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("Avg. Power", "62.4", warningColor, Icons.power),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("Diversity", "Good", infoColor, Icons.diversity_3),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnchorTextList() {
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
              Text(
                "Top Anchor Texts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Export",
                size: bs.sm,
                icon: Icons.download,
                onPressed: () {},
              ),
            ],
          ),
          ...anchorTextData.map((anchor) {
            return Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${anchor["text"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getTypeColor("${anchor["type"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${anchor["type"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: _getTypeColor("${anchor["type"]}"),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(
                        _getTrendIcon("${anchor["trend"]}"),
                        color: _getTrendColor("${anchor["trend"]}"),
                        size: 16,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildAnchorMetric("Frequency", "${anchor["frequency"]}", Icons.repeat),
                      ),
                      Expanded(
                        child: _buildAnchorMetric("Percentage", "${(anchor["percentage"] as double).toStringAsFixed(1)}%", Icons.pie_chart),
                      ),
                      Expanded(
                        child: _buildAnchorMetric("Power", "${anchor["power"]}", Icons.power),
                      ),
                      Expanded(
                        child: _buildAnchorMetric("Domains", "${anchor["domains"]}", Icons.domain),
                      ),
                    ],
                  ),
                  Text(
                    "First seen: ${anchor["first_seen"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
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

  Widget _buildAnchorMetric(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
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
      ],
    );
  }

  Widget _buildDistributionTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildDistributionChart(),
          _buildDistributionList(),
        ],
      ),
    );
  }

  Widget _buildDistributionChart() {
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
          Text(
            "Anchor Text Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.donut_small,
                    size: 48,
                    color: primaryColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Anchor Text Distribution Chart",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Visual breakdown by anchor text types",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistributionList() {
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
          Text(
            "Distribution Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...anchorDistribution.map((item) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: (item["color"] as Color).withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: (item["color"] as Color).withAlpha(20)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: item["color"] as Color,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Text(
                      "${item["type"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    "${item["count"]} ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "(${(item["percentage"] as double).toStringAsFixed(1)}%)",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Container(
                    width: 100,
                    height: 6,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: ((item["percentage"] as double) / 100) * 100,
                        height: 6,
                        decoration: BoxDecoration(
                          color: item["color"] as Color,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
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

  Widget _buildCompetitorsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCompetitorHeader(),
          _buildCompetitorList(),
        ],
      ),
    );
  }

  Widget _buildCompetitorHeader() {
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
          Text(
            "Competitor Anchor Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Compare your anchor text strategy with competitors to identify opportunities and gaps.",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompetitorList() {
    return Column(
      spacing: spMd,
      children: competitorAnchors.map((competitor) {
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
                  Expanded(
                    child: Text(
                      "${competitor["competitor"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  QButton(
                    label: "Analyze",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildCompetitorMetric("Total Backlinks", "${competitor["total_backlinks"]}", Icons.link),
                  ),
                  Expanded(
                    child: _buildCompetitorMetric("Brand Ratio", "${(competitor["brand_ratio"] as double).toStringAsFixed(1)}%", Icons.business),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Top Anchor Texts:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    ...(competitor["top_anchors"] as List).map((anchor) {
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${anchor["text"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "${anchor["frequency"]} uses",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCompetitorMetric(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        SizedBox(width: spSm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecommendations() {
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
          Text(
            "Recommendations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...recommendations.map((recommendation) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: _getPriorityColor("${recommendation["priority"]}").withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: _getPriorityColor("${recommendation["priority"]}").withAlpha(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${recommendation["issue"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getPriorityColor("${recommendation["priority"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${recommendation["priority"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: _getPriorityColor("${recommendation["priority"]}"),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${recommendation["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${recommendation["recommendation"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
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

  Color _getTypeColor(String type) {
    switch (type) {
      case "Exact Match":
        return successColor;
      case "Phrase Match":
        return infoColor;
      case "Partial Match":
        return warningColor;
      case "URL/Brand":
        return primaryColor;
      case "Generic":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "up":
        return successColor;
      case "down":
        return dangerColor;
      case "stable":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "up":
        return Icons.trending_up;
      case "down":
        return Icons.trending_down;
      case "stable":
        return Icons.trending_flat;
      default:
        return Icons.remove;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return infoColor;
    }
  }

  void _analyzeAnchors() {
    if (domain.isEmpty) {
      se("Please enter a domain");
      return;
    }
    
    loading = true;
    setState(() {});
    
    // Simulate analysis
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Anchor text analysis completed successfully");
    });
  }
}
