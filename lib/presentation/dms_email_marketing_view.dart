import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsEmailMarketingView extends StatefulWidget {
  const DmsEmailMarketingView({super.key});

  @override
  State<DmsEmailMarketingView> createState() => _DmsEmailMarketingViewState();
}

class _DmsEmailMarketingViewState extends State<DmsEmailMarketingView> {
  String selectedTimeframe = "30d";
  String selectedCampaign = "all";
  int currentTab = 0;

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 7 Days", "value": "7d"},
    {"label": "Last 30 Days", "value": "30d"},
    {"label": "Last 90 Days", "value": "90d"},
    {"label": "This Year", "value": "year"}
  ];

  List<Map<String, dynamic>> campaignOptions = [
    {"label": "All Campaigns", "value": "all"},
    {"label": "Newsletter", "value": "newsletter"},
    {"label": "Promotional", "value": "promotional"},
    {"label": "Welcome Series", "value": "welcome"},
    {"label": "Abandoned Cart", "value": "cart"}
  ];

  List<Map<String, dynamic>> emailMetrics = [
    {
      "title": "Total Sent",
      "value": "45.2K",
      "change": "+12.3%",
      "trend": "up",
      "icon": Icons.send
    },
    {
      "title": "Open Rate",
      "value": "24.8%",
      "change": "+2.1%",
      "trend": "up",
      "icon": Icons.mark_email_read
    },
    {
      "title": "Click Rate",
      "value": "3.7%",
      "change": "+0.5%",
      "trend": "up",
      "icon": Icons.mouse
    },
    {
      "title": "Unsubscribe Rate",
      "value": "0.2%",
      "change": "-0.1%",
      "trend": "down",
      "icon": Icons.unsubscribe
    }
  ];

  List<Map<String, dynamic>> recentCampaigns = [
    {
      "id": "camp1",
      "name": "Summer Sale Newsletter",
      "type": "Newsletter",
      "status": "Sent",
      "sentDate": "2024-06-18",
      "recipients": 15420,
      "delivered": 15180,
      "opened": 3760,
      "clicked": 570,
      "unsubscribed": 12,
      "openRate": 24.7,
      "clickRate": 3.8,
      "unsubscribeRate": 0.08,
      "revenue": 12500.00
    },
    {
      "id": "camp2", 
      "name": "Product Launch Announcement",
      "type": "Promotional",
      "status": "Sent",
      "sentDate": "2024-06-15",
      "recipients": 8750,
      "delivered": 8690,
      "opened": 2170,
      "clicked": 435,
      "unsubscribed": 5,
      "openRate": 25.0,
      "clickRate": 5.0,
      "unsubscribeRate": 0.06,
      "revenue": 18750.00
    },
    {
      "id": "camp3",
      "name": "Welcome Series - Day 1",
      "type": "Welcome Series",
      "status": "Active",
      "sentDate": "2024-06-17",
      "recipients": 2340,
      "delivered": 2320,
      "opened": 880,
      "clicked": 156,
      "unsubscribed": 3,
      "openRate": 37.9,
      "clickRate": 6.7,
      "unsubscribeRate": 0.13,
      "revenue": 3200.00
    },
    {
      "id": "camp4",
      "name": "Abandoned Cart Recovery",
      "type": "Automated",
      "status": "Active",
      "sentDate": "2024-06-18",
      "recipients": 1890,
      "delivered": 1875,
      "opened": 420,
      "clicked": 89,
      "unsubscribed": 2,
      "openRate": 22.4,
      "clickRate": 4.7,
      "unsubscribeRate": 0.11,
      "revenue": 5600.00
    }
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Create Campaign",
      "description": "Design and send new email campaign",
      "icon": Icons.campaign,
      "color": primaryColor
    },
    {
      "title": "Manage Templates",
      "description": "Create and edit email templates",
      "icon": Icons.design_services,
      "color": infoColor
    },
    {
      "title": "Subscriber Lists",
      "description": "Manage your subscriber database",
      "icon": Icons.people,
      "color": successColor
    },
    {
      "title": "Automation",
      "description": "Set up automated email sequences",
      "icon": Icons.auto_mode,
      "color": warningColor
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Marketing"),
        actions: [
          IconButton(
            icon: Icon(Icons.campaign),
            onPressed: () {
              ss("Creating new email campaign");
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              ss("Opening email analytics");
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
            _buildQuickActions(),
            _buildPerformanceOverview(),
            _buildRecentCampaigns(),
            _buildInsightsAndTips(),
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
                Icons.email,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email Marketing Dashboard",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Connect with your audience through targeted email campaigns",
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
                child: _buildMetricCard("Active Subscribers", "28.4K", Icons.people),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("This Month", "45.2K Sent", Icons.send),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("Revenue", "\$39.9K", Icons.attach_money),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon) {
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

  Widget _buildQuickActions() {
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
                Icons.flash_on,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
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
          ResponsiveGridView(
            minItemWidth: 200,
            children: quickActions.map((action) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (action["color"] as Color).withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: (action["color"] as Color).withAlpha(51),
                    width: 1,
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      action["icon"] as IconData,
                      color: action["color"] as Color,
                      size: 32,
                    ),
                    Text(
                      "${action["title"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${action["description"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Open",
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening ${action["title"]}");
                        },
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
                Icons.analytics,
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
                  label: "Campaign Type",
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
          ResponsiveGridView(
            minItemWidth: 200,
            children: emailMetrics.map((metric) {
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

  Widget _buildRecentCampaigns() {
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
                Icons.campaign,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Recent Campaigns",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...recentCampaigns.map((campaign) {
            return Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: campaign["status"] == "Sent" 
                      ? successColor 
                      : infoColor,
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
                              "${campaign["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${campaign["type"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "•",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${campaign["sentDate"]}",
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
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: campaign["status"] == "Sent" 
                              ? successColor 
                              : infoColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${campaign["status"]}",
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
                        child: _buildCampaignMetric(
                          "Recipients", 
                          "${((campaign["recipients"] as int) / 1000).toStringAsFixed(1)}K"
                        ),
                      ),
                      Expanded(
                        child: _buildCampaignMetric(
                          "Delivered", 
                          "${((campaign["delivered"] as int) / 1000).toStringAsFixed(1)}K"
                        ),
                      ),
                      Expanded(
                        child: _buildCampaignMetric(
                          "Open Rate", 
                          "${(campaign["openRate"] as double).toStringAsFixed(1)}%"
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCampaignMetric(
                          "Clicked", 
                          "${campaign["clicked"]}"
                        ),
                      ),
                      Expanded(
                        child: _buildCampaignMetric(
                          "Click Rate", 
                          "${(campaign["clickRate"] as double).toStringAsFixed(1)}%"
                        ),
                      ),
                      Expanded(
                        child: _buildCampaignMetric(
                          "Revenue", 
                          "\$${((campaign["revenue"] as double) / 1000).toStringAsFixed(1)}K"
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Report",
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening report for ${campaign["name"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Duplicate",
                          size: bs.sm,
                          onPressed: () {
                            si("Duplicating ${campaign["name"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () {
                          si("More options for ${campaign["name"]}");
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

  Widget _buildCampaignMetric(String label, String value) {
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

  Widget _buildInsightsAndTips() {
    List<Map<String, dynamic>> insights = [
      {
        "title": "Best Performing Campaign",
        "description": "Welcome Series shows 37.9% open rate - 13% above average",
        "type": "success",
        "recommendation": "Apply welcome series format to other onboarding emails"
      },
      {
        "title": "Optimization Opportunity",
        "description": "Newsletter open rates declined 2% this month",
        "type": "warning",
        "recommendation": "A/B test subject lines and send times"
      },
      {
        "title": "Subscriber Growth",
        "description": "1,240 new subscribers added this month",
        "type": "info",
        "recommendation": "Consider increasing email frequency for engaged segments"
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
                Icons.lightbulb,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Insights & Recommendations",
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
                                : Icons.info,
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
                    "Recommendation: ${insight["recommendation"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: insightColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Apply Suggestion",
                          size: bs.sm,
                          onPressed: () {
                            ss("Applying: ${insight["title"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Learn More",
                        size: bs.sm,
                        onPressed: () {
                          si("Learning more about: ${insight["title"]}");
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
}
