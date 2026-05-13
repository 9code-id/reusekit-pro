import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsPaidAdvertisingView extends StatefulWidget {
  const DmsPaidAdvertisingView({super.key});

  @override
  State<DmsPaidAdvertisingView> createState() => _DmsPaidAdvertisingViewState();
}

class _DmsPaidAdvertisingViewState extends State<DmsPaidAdvertisingView> {
  String selectedPlatform = "All";
  String selectedStatus = "All";
  String selectedPeriod = "7d";
  bool isLoading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> platforms = [
    {"label": "All Platforms", "value": "All"},
    {"label": "Google Ads", "value": "google"},
    {"label": "Facebook Ads", "value": "facebook"},
    {"label": "Instagram Ads", "value": "instagram"},
    {"label": "LinkedIn Ads", "value": "linkedin"},
    {"label": "Twitter Ads", "value": "twitter"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Active", "value": "active"},
    {"label": "Paused", "value": "paused"},
    {"label": "Completed", "value": "completed"},
    {"label": "Draft", "value": "draft"},
  ];

  List<Map<String, dynamic>> periods = [
    {"label": "Last 7 Days", "value": "7d"},
    {"label": "Last 30 Days", "value": "30d"},
    {"label": "Last 90 Days", "value": "90d"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> campaigns = [
    {
      "id": "1",
      "name": "Summer Sale 2024",
      "platform": "google",
      "status": "active",
      "budget": 5000,
      "spent": 3245,
      "impressions": 1234567,
      "clicks": 8945,
      "conversions": 234,
      "ctr": 0.72,
      "cpc": 0.36,
      "roas": 4.2,
      "start_date": DateTime.now().subtract(Duration(days: 15)),
      "end_date": DateTime.now().add(Duration(days: 15)),
      "objective": "conversions",
    },
    {
      "id": "2",
      "name": "Brand Awareness Campaign",
      "platform": "facebook",
      "status": "active",
      "budget": 3000,
      "spent": 1875,
      "impressions": 987654,
      "clicks": 5673,
      "conversions": 156,
      "ctr": 0.57,
      "cpc": 0.33,
      "roas": 3.8,
      "start_date": DateTime.now().subtract(Duration(days: 20)),
      "end_date": DateTime.now().add(Duration(days: 10)),
      "objective": "awareness",
    },
    {
      "id": "3",
      "name": "Product Launch",
      "platform": "instagram",
      "status": "paused",
      "budget": 2500,
      "spent": 2100,
      "impressions": 654321,
      "clicks": 4234,
      "conversions": 89,
      "ctr": 0.65,
      "cpc": 0.50,
      "roas": 2.1,
      "start_date": DateTime.now().subtract(Duration(days: 30)),
      "end_date": DateTime.now().subtract(Duration(days: 5)),
      "objective": "traffic",
    },
    {
      "id": "4",
      "name": "LinkedIn B2B Campaign",
      "platform": "linkedin",
      "status": "active",
      "budget": 4000,
      "spent": 2890,
      "impressions": 345678,
      "clicks": 2145,
      "conversions": 78,
      "ctr": 0.62,
      "cpc": 1.35,
      "roas": 5.6,
      "start_date": DateTime.now().subtract(Duration(days: 25)),
      "end_date": DateTime.now().add(Duration(days: 5)),
      "objective": "leads",
    },
  ];

  List<Map<String, dynamic>> adSets = [
    {
      "id": "1",
      "campaign_id": "1",
      "name": "Desktop Users - 25-45",
      "platform": "google",
      "status": "active",
      "budget": 100,
      "spent": 67,
      "impressions": 89456,
      "clicks": 623,
      "ctr": 0.70,
      "cpc": 0.11,
    },
    {
      "id": "2",
      "campaign_id": "1",
      "name": "Mobile Users - 18-35",
      "platform": "google",
      "status": "active",
      "budget": 150,
      "spent": 142,
      "impressions": 134567,
      "clicks": 1234,
      "ctr": 0.92,
      "cpc": 0.12,
    },
    {
      "id": "3",
      "campaign_id": "2",
      "name": "Interest: Technology",
      "platform": "facebook",
      "status": "active",
      "budget": 80,
      "spent": 56,
      "impressions": 76543,
      "clicks": 445,
      "ctr": 0.58,
      "cpc": 0.13,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Paid Advertising",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Campaigns", icon: Icon(Icons.campaign)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Optimization", icon: Icon(Icons.tune)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCampaignsTab(),
        _buildAnalyticsTab(),
        _buildOptimizationTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildOverviewMetrics(),
          _buildPlatformPerformance(),
          _buildRecentActivity(),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildOverviewMetrics() {
    int totalSpent = campaigns.map((c) => c["spent"] as int).reduce((a, b) => a + b);
    int totalImpressions = campaigns.map((c) => c["impressions"] as int).reduce((a, b) => a + b);
    int totalClicks = campaigns.map((c) => c["clicks"] as int).reduce((a, b) => a + b);
    int totalConversions = campaigns.map((c) => c["conversions"] as int).reduce((a, b) => a + b);
    double avgCTR = campaigns.map((c) => c["ctr"] as double).reduce((a, b) => a + b) / campaigns.length;
    double avgCPC = campaigns.map((c) => c["cpc"] as double).reduce((a, b) => a + b) / campaigns.length;

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
            "Campaign Performance Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard(
                "Total Spent",
                "\$${(totalSpent / 1000).toStringAsFixed(1)}K",
                Icons.monetization_on,
                dangerColor,
                "+8.5%",
              ),
              _buildMetricCard(
                "Impressions",
                "${(totalImpressions / 1000000).toStringAsFixed(1)}M",
                Icons.visibility,
                infoColor,
                "+12.3%",
              ),
              _buildMetricCard(
                "Clicks",
                "${(totalClicks / 1000).toStringAsFixed(1)}K",
                Icons.mouse,
                warningColor,
                "+15.7%",
              ),
              _buildMetricCard(
                "Conversions",
                "$totalConversions",
                Icons.track_changes,
                successColor,
                "+22.1%",
              ),
              _buildMetricCard(
                "Avg CTR",
                "${avgCTR.toStringAsFixed(2)}%",
                Icons.touch_app,
                primaryColor,
                "+0.12%",
              ),
              _buildMetricCard(
                "Avg CPC",
                "\$${avgCPC.toStringAsFixed(2)}",
                Icons.attach_money,
                infoColor,
                "-\$0.04",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String change) {
    bool isPositive = !change.startsWith('-');
    if (title == "Avg CPC") isPositive = change.startsWith('-'); // Lower CPC is better

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive ? successColor : dangerColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformPerformance() {
    Map<String, Map<String, dynamic>> platformStats = {};
    
    for (var campaign in campaigns) {
      String platform = campaign["platform"];
      if (!platformStats.containsKey(platform)) {
        platformStats[platform] = {
          "spent": 0,
          "impressions": 0,
          "clicks": 0,
          "conversions": 0,
          "campaigns": 0,
        };
      }
      platformStats[platform]!["spent"] += campaign["spent"] as int;
      platformStats[platform]!["impressions"] += campaign["impressions"] as int;
      platformStats[platform]!["clicks"] += campaign["clicks"] as int;
      platformStats[platform]!["conversions"] += campaign["conversions"] as int;
      platformStats[platform]!["campaigns"] += 1;
    }

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
            "Platform Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...platformStats.entries.map((entry) {
            return _buildPlatformCard(entry.key, entry.value);
          }),
        ],
      ),
    );
  }

  Widget _buildPlatformCard(String platform, Map<String, dynamic> stats) {
    IconData platformIcon = _getPlatformIcon(platform);
    double ctr = (stats["clicks"] as int) / (stats["impressions"] as int) * 100;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  platformIcon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${platform.toUpperCase()} ADS",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${stats["campaigns"]} campaigns",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildPlatformMetric(
                  "Spent",
                  "\$${((stats["spent"] as int) / 1000).toStringAsFixed(1)}K",
                ),
              ),
              Expanded(
                child: _buildPlatformMetric(
                  "Impressions",
                  "${((stats["impressions"] as int) / 1000000).toStringAsFixed(1)}M",
                ),
              ),
              Expanded(
                child: _buildPlatformMetric(
                  "Clicks",
                  "${((stats["clicks"] as int) / 1000).toStringAsFixed(1)}K",
                ),
              ),
              Expanded(
                child: _buildPlatformMetric(
                  "CTR",
                  "${ctr.toStringAsFixed(2)}%",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformMetric(String label, String value) {
    return Column(
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
    );
  }

  Widget _buildRecentActivity() {
    List<Map<String, dynamic>> activities = [
      {
        "type": "campaign_created",
        "title": "New campaign created",
        "description": "Summer Sale 2024 campaign launched on Google Ads",
        "timestamp": DateTime.now().subtract(Duration(hours: 2)),
        "icon": Icons.add_circle,
        "color": successColor,
      },
      {
        "type": "budget_alert",
        "title": "Budget alert",
        "description": "Product Launch campaign reached 80% of budget",
        "timestamp": DateTime.now().subtract(Duration(hours: 6)),
        "icon": Icons.warning,
        "color": warningColor,
      },
      {
        "type": "performance",
        "title": "Performance milestone",
        "description": "LinkedIn B2B Campaign achieved 5x ROAS target",
        "timestamp": DateTime.now().subtract(Duration(hours: 12)),
        "icon": Icons.trending_up,
        "color": primaryColor,
      },
    ];

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
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...activities.map((activity) => _buildActivityItem(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (activity["color"] as Color).withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: activity["color"],
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              activity["icon"],
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${activity["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${(activity["timestamp"] as DateTime).dMMMy}",
            style: TextStyle(
              fontSize: 10,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    List<Map<String, dynamic>> quickActions = [
      {
        "title": "Create Campaign",
        "description": "Launch a new advertising campaign",
        "icon": Icons.add_circle,
        "color": primaryColor,
        "action": "create_campaign",
      },
      {
        "title": "Optimize Bids",
        "description": "Auto-optimize bidding strategies",
        "icon": Icons.tune,
        "color": successColor,
        "action": "optimize_bids",
      },
      {
        "title": "Generate Report",
        "description": "Create performance report",
        "icon": Icons.assessment,
        "color": infoColor,
        "action": "generate_report",
      },
      {
        "title": "A/B Test",
        "description": "Start new A/B testing",
        "icon": Icons.science,
        "color": warningColor,
        "action": "ab_test",
      },
    ];

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
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: quickActions.map((action) {
              return _buildQuickActionCard(action);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(Map<String, dynamic> action) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (action["color"] as Color).withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            action["icon"],
            color: action["color"],
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            "${action["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${action["description"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Execute",
              size: bs.sm,
              onPressed: () {
                _executeQuickAction(action["action"]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCampaignsHeader(),
          _buildCampaignsFilters(),
          _buildCampaignsList(),
        ],
      ),
    );
  }

  Widget _buildCampaignsHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Advertising Campaigns",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${campaigns.length} campaigns active",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              _createNewCampaign();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignsFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QDropdownField(
              label: "Platform",
              items: platforms,
              value: selectedPlatform,
              onChanged: (value, label) {
                selectedPlatform = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QDropdownField(
              label: "Status",
              items: statusOptions,
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QDropdownField(
              label: "Period",
              items: periods,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignsList() {
    List<Map<String, dynamic>> filteredCampaigns = campaigns.where((campaign) {
      bool matchesPlatform = selectedPlatform == "All" || campaign["platform"] == selectedPlatform;
      bool matchesStatus = selectedStatus == "All" || campaign["status"] == selectedStatus;
      return matchesPlatform && matchesStatus;
    }).toList();

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      spacing: spSm,
      children: filteredCampaigns.map((campaign) {
        return _buildCampaignCard(campaign);
      }).toList(),
    );
  }

  Widget _buildCampaignCard(Map<String, dynamic> campaign) {
    IconData platformIcon = _getPlatformIcon(campaign["platform"]);
    Color statusColor = _getStatusColor(campaign["status"]);
    double budgetUsed = ((campaign["spent"] as int) / (campaign["budget"] as int)) * 100;

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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  platformIcon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${campaign["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${campaign["platform"]}".toUpperCase(),
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
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${campaign["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildCampaignMetric(
                        "Budget",
                        "\$${((campaign["budget"] as int) / 1000).toStringAsFixed(1)}K",
                        Icons.monetization_on,
                      ),
                    ),
                    Expanded(
                      child: _buildCampaignMetric(
                        "Spent",
                        "\$${((campaign["spent"] as int) / 1000).toStringAsFixed(1)}K",
                        Icons.trending_down,
                      ),
                    ),
                    Expanded(
                      child: _buildCampaignMetric(
                        "Impressions",
                        "${((campaign["impressions"] as int) / 1000000).toStringAsFixed(1)}M",
                        Icons.visibility,
                      ),
                    ),
                    Expanded(
                      child: _buildCampaignMetric(
                        "Clicks",
                        "${((campaign["clicks"] as int) / 1000).toStringAsFixed(1)}K",
                        Icons.mouse,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildCampaignMetric(
                        "CTR",
                        "${(campaign["ctr"] as double).toStringAsFixed(2)}%",
                        Icons.touch_app,
                      ),
                    ),
                    Expanded(
                      child: _buildCampaignMetric(
                        "CPC",
                        "\$${(campaign["cpc"] as double).toStringAsFixed(2)}",
                        Icons.attach_money,
                      ),
                    ),
                    Expanded(
                      child: _buildCampaignMetric(
                        "ROAS",
                        "${(campaign["roas"] as double).toStringAsFixed(1)}x",
                        Icons.trending_up,
                      ),
                    ),
                    Expanded(
                      child: _buildCampaignMetric(
                        "Conversions",
                        "${campaign["conversions"]}",
                        Icons.track_changes,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Budget Usage: ${budgetUsed.toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: budgetUsed / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: budgetUsed > 80 ? dangerColor : primaryColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        _editCampaign(campaign);
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.analytics,
                      size: bs.sm,
                      onPressed: () {
                        _viewCampaignAnalytics(campaign);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${(campaign["start_date"] as DateTime).dMMMy} - ${(campaign["end_date"] as DateTime).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "Objective: ${campaign["objective"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignMetric(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 16,
        ),
        SizedBox(height: spXs),
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
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsOverview(),
          _buildPerformanceTrends(),
          _buildAudienceInsights(),
          _buildConversionFunnel(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsOverview() {
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
            "Analytics Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.show_chart,
                    color: primaryColor,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Performance Analytics Chart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Visual representation of campaign performance over time",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
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

  Widget _buildPerformanceTrends() {
    List<Map<String, dynamic>> trends = [
      {
        "metric": "Click-through Rate",
        "current": 0.68,
        "previous": 0.54,
        "trend": "up",
      },
      {
        "metric": "Cost per Click",
        "current": 0.42,
        "previous": 0.48,
        "trend": "down",
      },
      {
        "metric": "Conversion Rate",
        "current": 2.8,
        "previous": 2.1,
        "trend": "up",
      },
      {
        "metric": "Return on Ad Spend",
        "current": 4.2,
        "previous": 3.8,
        "trend": "up",
      },
    ];

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
            "Performance Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...trends.map((trend) => _buildTrendItem(trend)),
        ],
      ),
    );
  }

  Widget _buildTrendItem(Map<String, dynamic> trend) {
    bool isUp = trend["trend"] == "up";
    double change = ((trend["current"] as double) - (trend["previous"] as double)) / (trend["previous"] as double) * 100;
    bool isPositive = (trend["metric"] == "Cost per Click") ? !isUp : isUp;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${trend["metric"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Current: ${trend["current"]}${trend["metric"].contains("Rate") || trend["metric"].contains("Conversion") ? "%" : trend["metric"].contains("Return") ? "x" : trend["metric"].contains("Cost") ? "" : ""}",
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
              color: isPositive ? successColor : dangerColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isUp ? Icons.trending_up : Icons.trending_down,
                  color: Colors.white,
                  size: 12,
                ),
                SizedBox(width: 2),
                Text(
                  "${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}%",
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
    );
  }

  Widget _buildAudienceInsights() {
    List<Map<String, dynamic>> insights = [
      {
        "title": "Top Age Group",
        "value": "25-34 years",
        "percentage": 34.2,
        "icon": Icons.people,
      },
      {
        "title": "Primary Gender",
        "value": "Female",
        "percentage": 58.7,
        "icon": Icons.person,
      },
      {
        "title": "Top Location",
        "value": "United States",
        "percentage": 42.3,
        "icon": Icons.location_on,
      },
      {
        "title": "Peak Hour",
        "value": "8:00 PM",
        "percentage": 15.6,
        "icon": Icons.schedule,
      },
    ];

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
            "Audience Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: insights.map((insight) {
              return _buildInsightCard(insight);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(Map<String, dynamic> insight) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            insight["icon"],
            color: primaryColor,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            "${insight["value"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${insight["title"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${(insight["percentage"] as double).toStringAsFixed(1)}%",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: successColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversionFunnel() {
    List<Map<String, dynamic>> funnelSteps = [
      {"step": "Impressions", "count": 3456789, "percentage": 100.0},
      {"step": "Clicks", "count": 23456, "percentage": 0.68},
      {"step": "Landing Page Views", "count": 21234, "percentage": 0.61},
      {"step": "Add to Cart", "count": 3456, "percentage": 0.10},
      {"step": "Conversions", "count": 567, "percentage": 0.016},
    ];

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
          ...funnelSteps.map((step) => _buildFunnelStep(step)),
        ],
      ),
    );
  }

  Widget _buildFunnelStep(Map<String, dynamic> step) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${step["step"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${((step["count"] as int) > 1000000) ? ((step["count"] as int) / 1000000).toStringAsFixed(1) + "M" : ((step["count"] as int) > 1000) ? ((step["count"] as int) / 1000).toStringAsFixed(1) + "K" : "${step["count"]}"}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${(step["percentage"] as double).toStringAsFixed(2)}%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptimizationTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildOptimizationOverview(),
          _buildRecommendations(),
          _buildABTests(),
          _buildBiddingStrategies(),
        ],
      ),
    );
  }

  Widget _buildOptimizationOverview() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Optimization Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "AI-powered insights and recommendations to improve your campaign performance",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    List<Map<String, dynamic>> recommendations = [
      {
        "title": "Increase Budget for High-Performing Ad Set",
        "description": "Desktop Users - 25-45 ad set is performing 35% above average. Consider increasing budget by \$50/day.",
        "impact": "High",
        "type": "budget",
        "icon": Icons.trending_up,
      },
      {
        "title": "Pause Underperforming Keywords",
        "description": "3 keywords have CTR below 0.2%. Pausing them could save \$120/day without significant impact.",
        "impact": "Medium",
        "type": "keywords",
        "icon": Icons.pause_circle,
      },
      {
        "title": "Optimize Ad Schedule",
        "description": "Your ads perform 25% better between 6-9 PM. Consider bid adjustments for these hours.",
        "impact": "Medium",
        "type": "schedule",
        "icon": Icons.schedule,
      },
      {
        "title": "Test New Ad Creative",
        "description": "Current ad creative has been running for 30+ days. Testing new creative could improve performance.",
        "impact": "High",
        "type": "creative",
        "icon": Icons.image,
      },
    ];

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
            "AI Recommendations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...recommendations.map((rec) => _buildRecommendationCard(rec)),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(Map<String, dynamic> recommendation) {
    Color impactColor = _getImpactColor(recommendation["impact"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: impactColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                recommendation["icon"],
                color: impactColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${recommendation["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: impactColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${recommendation["impact"]} IMPACT",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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
          Row(
            children: [
              Spacer(),
              QButton(
                label: "Apply",
                size: bs.sm,
                onPressed: () {
                  _applyRecommendation(recommendation);
                },
              ),
              SizedBox(width: spXs),
              QButton(
                label: "Dismiss",
                size: bs.sm,
                onPressed: () {
                  _dismissRecommendation(recommendation);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildABTests() {
    List<Map<String, dynamic>> abTests = [
      {
        "name": "Headline Variation Test",
        "status": "running",
        "progress": 65,
        "start_date": DateTime.now().subtract(Duration(days: 8)),
        "estimated_completion": DateTime.now().add(Duration(days: 7)),
        "variants": 2,
      },
      {
        "name": "CTA Button Color Test",
        "status": "completed",
        "progress": 100,
        "start_date": DateTime.now().subtract(Duration(days: 21)),
        "estimated_completion": DateTime.now().subtract(Duration(days: 7)),
        "variants": 3,
        "winner": "Variant B (+15% CTR)",
      },
    ];

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
                "A/B Tests",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "New Test",
                size: bs.sm,
                onPressed: () {
                  _createABTest();
                },
              ),
            ],
          ),
          ...abTests.map((test) => _buildABTestCard(test)),
        ],
      ),
    );
  }

  Widget _buildABTestCard(Map<String, dynamic> test) {
    Color statusColor = test["status"] == "running" ? warningColor : successColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${test["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${test["status"]}".toUpperCase(),
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
              Text(
                "${test["variants"]} variants",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              if (test["status"] == "running") ...[
                Text(
                  "Progress: ${test["progress"]}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
              if (test["winner"] != null) ...[
                Text(
                  "Winner: ${test["winner"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ],
            ],
          ),
          if (test["status"] == "running") ...[
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (test["progress"] as int) / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                ),
              ),
            ),
            Text(
              "Estimated completion: ${(test["estimated_completion"] as DateTime).dMMMy}",
              style: TextStyle(
                fontSize: 10,
                color: disabledColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBiddingStrategies() {
    List<Map<String, dynamic>> strategies = [
      {
        "name": "Target CPA",
        "description": "Automatically set bids to help get as many conversions as possible at target cost-per-acquisition",
        "campaigns": 2,
        "performance": "Good",
        "icon": Icons.gps_fixed,
      },
      {
        "name": "Maximize Conversions",
        "description": "Automatically set bids to help get the most conversions for your campaign",
        "campaigns": 1,
        "performance": "Excellent",
        "icon": Icons.trending_up,
      },
      {
        "name": "Manual CPC",
        "description": "Set your own maximum cost-per-click bids for your ads",
        "campaigns": 1,
        "performance": "Average",
        "icon": Icons.settings,
      },
    ];

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
            "Bidding Strategies",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...strategies.map((strategy) => _buildBiddingStrategyCard(strategy)),
        ],
      ),
    );
  }

  Widget _buildBiddingStrategyCard(Map<String, dynamic> strategy) {
    Color performanceColor = _getPerformanceColor(strategy["performance"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: performanceColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            strategy["icon"],
            color: performanceColor,
            size: 24,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${strategy["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${strategy["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${strategy["campaigns"]} campaigns",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: performanceColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${strategy["performance"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case "google":
        return Icons.search;
      case "facebook":
        return Icons.facebook;
      case "instagram":
        return Icons.camera_alt;
      case "linkedin":
        return Icons.business;
      case "twitter":
        return Icons.alternate_email;
      default:
        return Icons.public;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "paused":
        return warningColor;
      case "completed":
        return primaryColor;
      case "draft":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getImpactColor(String impact) {
    switch (impact.toLowerCase()) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPerformanceColor(String performance) {
    switch (performance.toLowerCase()) {
      case "excellent":
        return successColor;
      case "good":
        return primaryColor;
      case "average":
        return warningColor;
      case "poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _executeQuickAction(String action) {
    ss("Executing $action...");
  }

  void _createNewCampaign() {
    si("Opening new campaign wizard");
  }

  void _editCampaign(Map<String, dynamic> campaign) {
    si("Editing ${campaign["name"]}");
  }

  void _viewCampaignAnalytics(Map<String, dynamic> campaign) {
    si("Viewing analytics for ${campaign["name"]}");
  }

  void _applyRecommendation(Map<String, dynamic> recommendation) {
    ss("Applied recommendation: ${recommendation["title"]}");
  }

  void _dismissRecommendation(Map<String, dynamic> recommendation) {
    si("Dismissed recommendation");
  }

  void _createABTest() {
    si("Creating new A/B test");
  }
}
