import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsQuickInsightsView extends StatefulWidget {
  const DmsQuickInsightsView({super.key});

  @override
  State<DmsQuickInsightsView> createState() => _DmsQuickInsightsViewState();
}

class _DmsQuickInsightsViewState extends State<DmsQuickInsightsView> {
  int selectedInsightType = 0;

  final List<Map<String, dynamic>> insightTypes = [
    {"label": "All Insights", "value": "all"},
    {"label": "Opportunities", "value": "opportunities"},
    {"label": "Alerts", "value": "alerts"},
    {"label": "Recommendations", "value": "recommendations"},
  ];

  final List<Map<String, dynamic>> insights = [
    {
      "id": 1,
      "type": "opportunity",
      "priority": "high",
      "title": "Increase Budget for Top Performing Campaign",
      "description": "Summer Sale 2024 campaign is performing 40% above target. Consider increasing budget by 25% to maximize returns.",
      "impact": "Potential +\$12,500 revenue",
      "action": "Increase Budget",
      "category": "Budget Optimization",
      "timeframe": "Immediate",
      "confidence": 92,
      "icon": Icons.trending_up,
      "color": "success",
      "relatedCampaign": "Summer Sale 2024",
    },
    {
      "id": 2,
      "type": "alert",
      "priority": "critical",
      "title": "Campaign Budget Nearly Exhausted",
      "description": "Google Ads - Electronics campaign has spent 95% of allocated budget with 12 days remaining.",
      "impact": "Campaign may stop running",
      "action": "Add Budget",
      "category": "Budget Alert",
      "timeframe": "Within 24 hours",
      "confidence": 100,
      "icon": Icons.warning,
      "color": "danger",
      "relatedCampaign": "Google Ads - Electronics",
    },
    {
      "id": 3,
      "type": "recommendation",
      "priority": "medium",
      "title": "Optimize Ad Schedule for Better Performance",
      "description": "Your ads perform 60% better between 2-6 PM. Consider adjusting ad schedule to focus on peak hours.",
      "impact": "Potential +15% CTR improvement",
      "action": "Adjust Schedule",
      "category": "Time Optimization",
      "timeframe": "This week",
      "confidence": 85,
      "icon": Icons.schedule,
      "color": "warning",
      "relatedCampaign": "Multiple campaigns",
    },
    {
      "id": 4,
      "type": "opportunity",
      "priority": "medium",
      "title": "Expand to New Keywords",
      "description": "Search terms analysis shows 5 high-potential keywords with low competition in your niche.",
      "impact": "Potential +20% reach",
      "action": "Add Keywords",
      "category": "Keyword Expansion",
      "timeframe": "Next week",
      "confidence": 78,
      "icon": Icons.search,
      "color": "info",
      "relatedCampaign": "Google Ads - Electronics",
    },
    {
      "id": 5,
      "type": "alert",
      "priority": "medium",
      "title": "Declining Click-Through Rate",
      "description": "CTR for Email Newsletter campaign has dropped 25% over the past week. Creative refresh recommended.",
      "impact": "Revenue impact: -\$2,400",
      "action": "Refresh Creative",
      "category": "Performance Alert",
      "timeframe": "Within 3 days",
      "confidence": 89,
      "icon": Icons.trending_down,
      "color": "warning",
      "relatedCampaign": "Email Newsletter",
    },
    {
      "id": 6,
      "type": "recommendation",
      "priority": "low",
      "title": "Consider A/B Testing New Ad Copy",
      "description": "Current ad copy has been running for 60 days. A/B test new variations to maintain engagement.",
      "impact": "Potential +10% engagement",
      "action": "Create A/B Test",
      "category": "Creative Testing",
      "timeframe": "Next month",
      "confidence": 72,
      "icon": Icons.science,
      "color": "info",
      "relatedCampaign": "Content Marketing",
    },
  ];

  final Map<String, dynamic> aiInsights = {
    "totalInsights": 6,
    "criticalAlerts": 1,
    "highOpportunities": 1,
    "potentialRevenue": 12500.0,
    "lastUpdated": "2 minutes ago",
    "confidenceScore": 85.5,
  };

  List<Map<String, dynamic>> get filteredInsights {
    if (selectedInsightType == 0) return insights;
    final type = insightTypes[selectedInsightType]["value"];
    return insights.where((insight) => insight["type"] == type).toList();
  }

  Color _getInsightColor(String colorType) {
    switch (colorType) {
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

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildInsightsSummaryCard() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology, color: primaryColor, size: 24),
              SizedBox(width: spXs),
              Text(
                "AI-Powered Insights",
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
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Live",
                  style: TextStyle(
                    fontSize: 10,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${aiInsights["totalInsights"]}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Icon(Icons.lightbulb, color: warningColor, size: 16),
                      ],
                    ),
                    Text(
                      "Total Insights",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${aiInsights["criticalAlerts"]}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Critical Alerts",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${(aiInsights["potentialRevenue"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Potential Revenue Impact",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${(aiInsights["confidenceScore"] as double).toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Icon(Icons.verified, color: infoColor, size: 14),
                      ],
                    ),
                    Text(
                      "Confidence Score",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.update, color: disabledBoldColor, size: 12),
              SizedBox(width: spXs),
              Text(
                "Last updated ${aiInsights["lastUpdated"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(Map<String, dynamic> insight) {
    final insightColor = _getInsightColor(insight["color"]);
    final priorityColor = _getPriorityColor(insight["priority"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
        border: Border(
          left: BorderSide(
            width: 4,
            color: insightColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                insight["icon"],
                color: insightColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${insight["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${insight["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    color: priorityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${insight["category"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified, size: 10, color: disabledBoldColor),
                    SizedBox(width: 2),
                    Text(
                      "${insight["confidence"]}%",
                      style: TextStyle(
                        fontSize: 9,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${insight["description"]}",
            style: TextStyle(
              fontSize: 13,
              color: primaryColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: insightColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.insights, color: insightColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${insight["impact"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: insightColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.campaign, color: disabledBoldColor, size: 14),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${insight["relatedCampaign"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Icon(Icons.schedule, color: disabledBoldColor, size: 14),
              SizedBox(width: spXs),
              Text(
                "${insight["timeframe"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "${insight["action"]}",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.flash_on, color: warningColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.trending_up, color: successColor, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "Optimize\nBudgets",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.auto_fix_high, color: infoColor, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "Auto Apply\nRecommendations",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.schedule_send, color: warningColor, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "Schedule\nReports",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quick Insights"),
        actions: [
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // AI Insights Summary
            _buildInsightsSummaryCard(),

            // Quick Actions
            _buildQuickActionsSection(),

            // Insight Type Filter
            QCategoryPicker(
              label: "Insight Type",
              items: insightTypes,
              value: insightTypes[selectedInsightType]["value"],
              onChanged: (index, label, value, item) {
                selectedInsightType = index;
                setState(() {});
              },
            ),

            // Insights List Header
            Row(
              children: [
                Text(
                  "Insights (${filteredInsights.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.sort,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Insights List
            if (filteredInsights.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.psychology,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No insights available",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Check back later for new AI-powered insights",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredInsights.map((insight) => _buildInsightCard(insight)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
