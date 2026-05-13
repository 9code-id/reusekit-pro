import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsGoogleAdsView extends StatefulWidget {
  const DmsGoogleAdsView({super.key});

  @override
  State<DmsGoogleAdsView> createState() => _DmsGoogleAdsViewState();
}

class _DmsGoogleAdsViewState extends State<DmsGoogleAdsView> {
  int currentTab = 0;
  String selectedCampaign = "All Campaigns";
  String selectedAccount = "main@company.com";
  String searchQuery = "";
  String dateRange = "Last 30 Days";
  String campaignStatus = "All";
  String bidStrategy = "Maximize Clicks";

  List<Map<String, dynamic>> campaigns = [
    {
      "name": "Search Campaign - Best Products",
      "status": "Active",
      "budget": 500.0,
      "spent": 342.50,
      "impressions": 45678,
      "clicks": 1234,
      "ctr": 2.7,
      "cpc": 0.28,
      "conversions": 67,
      "conversionRate": 5.4,
      "roas": 4.2,
      "keywords": 45,
      "adGroups": 8,
      "quality_score": 7.2
    },
    {
      "name": "Display Campaign - Brand Awareness",
      "status": "Active",
      "budget": 300.0,
      "spent": 256.80,
      "impressions": 89234,
      "clicks": 567,
      "ctr": 0.6,
      "cpc": 0.45,
      "conversions": 23,
      "conversionRate": 4.1,
      "roas": 3.8,
      "keywords": 0,
      "adGroups": 5,
      "quality_score": 6.8
    },
    {
      "name": "Shopping Campaign - Product Catalog",
      "status": "Paused",
      "budget": 800.0,
      "spent": 0.0,
      "impressions": 0,
      "clicks": 0,
      "ctr": 0.0,
      "cpc": 0.0,
      "conversions": 0,
      "conversionRate": 0.0,
      "roas": 0.0,
      "keywords": 0,
      "adGroups": 12,
      "quality_score": 0.0
    },
    {
      "name": "Video Campaign - YouTube Ads",
      "status": "Active",
      "budget": 400.0,
      "spent": 298.75,
      "impressions": 123456,
      "clicks": 2345,
      "ctr": 1.9,
      "cpc": 0.13,
      "conversions": 89,
      "conversionRate": 3.8,
      "roas": 5.1,
      "keywords": 0,
      "adGroups": 3,
      "quality_score": 8.1
    }
  ];

  List<Map<String, dynamic>> keywords = [
    {
      "keyword": "digital marketing tools",
      "campaign": "Search Campaign - Best Products",
      "matchType": "Exact",
      "status": "Active",
      "impressions": 12345,
      "clicks": 567,
      "ctr": 4.6,
      "cpc": 0.85,
      "quality_score": 8,
      "position": 2.3,
      "conversions": 23
    },
    {
      "keyword": "social media management",
      "campaign": "Search Campaign - Best Products",
      "matchType": "Phrase",
      "status": "Active",
      "impressions": 8967,
      "clicks": 234,
      "ctr": 2.6,
      "cpc": 1.25,
      "quality_score": 7,
      "position": 3.1,
      "conversions": 12
    },
    {
      "keyword": "marketing automation",
      "campaign": "Search Campaign - Best Products",
      "matchType": "Broad",
      "status": "Paused",
      "impressions": 5432,
      "clicks": 89,
      "ctr": 1.6,
      "cpc": 2.10,
      "quality_score": 5,
      "position": 4.2,
      "conversions": 3
    }
  ];

  List<Map<String, dynamic>> ads = [
    {
      "headline": "Best Digital Marketing Suite | Free Trial",
      "description": "Boost your marketing ROI with our comprehensive suite. Analytics, automation & more.",
      "campaign": "Search Campaign - Best Products",
      "adGroup": "Digital Marketing Tools",
      "status": "Active",
      "impressions": 23456,
      "clicks": 789,
      "ctr": 3.4,
      "conversions": 34,
      "type": "Text Ad"
    },
    {
      "headline": "Transform Your Marketing Strategy",
      "description": "All-in-one platform for modern marketers. Start your journey today.",
      "campaign": "Display Campaign - Brand Awareness",
      "adGroup": "Brand Awareness",
      "status": "Active",
      "impressions": 45678,
      "clicks": 234,
      "ctr": 0.5,
      "conversions": 12,
      "type": "Display Ad"
    },
    {
      "headline": "Premium Marketing Tools",
      "description": "Professional-grade tools for serious marketers. 30-day money back guarantee.",
      "campaign": "Video Campaign - YouTube Ads",
      "adGroup": "Premium Tools",
      "status": "Active",
      "impressions": 67890,
      "clicks": 1234,
      "ctr": 1.8,
      "conversions": 56,
      "type": "Video Ad"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Google Ads Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Campaigns", icon: Icon(Icons.campaign)),
        Tab(text: "Keywords", icon: Icon(Icons.search)),
        Tab(text: "Ads", icon: Icon(Icons.ads_click)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCampaignsTab(),
        _buildKeywordsTab(),
        _buildAdsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAccountSelector(),
          _buildPerformanceCards(),
          _buildQuickActions(),
          _buildRecentActivity(),
          _buildRecommendations(),
        ],
      ),
    );
  }

  Widget _buildAccountSelector() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(Icons.account_circle, color: primaryColor, size: 32),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Google Ads Account",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  selectedAccount,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.sync,
            size: bs.sm,
            onPressed: () {
              ss("Account synced successfully");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCards() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildMetricCard("Total Spend", "\$${campaigns.fold(0.0, (sum, c) => sum + (c["spent"] as double)).toStringAsFixed(2)}", Icons.payments, successColor),
        _buildMetricCard("Total Impressions", "${campaigns.fold(0, (sum, c) => sum + (c["impressions"] as int))}", Icons.visibility, infoColor),
        _buildMetricCard("Total Clicks", "${campaigns.fold(0, (sum, c) => sum + (c["clicks"] as int))}", Icons.mouse, warningColor),
        _buildMetricCard("Avg CTR", "${(campaigns.fold(0.0, (sum, c) => sum + (c["ctr"] as double)) / campaigns.length).toStringAsFixed(2)}%", Icons.trending_up, dangerColor),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
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
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "+12%",
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
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
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
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
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildActionCard("Create Campaign", Icons.add_circle, () {
                ss("Navigate to campaign creation");
              }),
              _buildActionCard("Import Keywords", Icons.file_upload, () {
                ss("Keyword import started");
              }),
              _buildActionCard("Bulk Edit", Icons.edit, () {
                ss("Bulk edit mode activated");
              }),
              _buildActionCard("Generate Reports", Icons.assessment, () {
                ss("Report generation started");
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: primaryColor.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryColor, size: 32),
            SizedBox(height: spXs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
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
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            spacing: spXs,
            children: [
              _buildActivityItem("Campaign 'Best Products' budget increased to \$500", "2 hours ago", Icons.trending_up, successColor),
              _buildActivityItem("New keyword 'marketing automation' added", "4 hours ago", Icons.add, infoColor),
              _buildActivityItem("Ad 'Transform Your Marketing' paused", "6 hours ago", Icons.pause, warningColor),
              _buildActivityItem("Quality score improved for 12 keywords", "1 day ago", Icons.star, successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String activity, String time, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity,
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendations() {
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
          Row(
            children: [
              Icon(Icons.lightbulb, color: warningColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Optimization Recommendations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            spacing: spXs,
            children: [
              _buildRecommendationItem("Increase budget for high-performing campaigns", "Potential 25% more conversions"),
              _buildRecommendationItem("Add negative keywords to reduce irrelevant clicks", "Save up to \$50/month"),
              _buildRecommendationItem("Optimize ad copy for better CTR", "Improve performance by 15%"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(String title, String description) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: warningColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () {
              ss("Recommendation applied");
            },
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
          _buildCampaignFilters(),
          _buildCampaignsList(),
        ],
      ),
    );
  }

  Widget _buildCampaignFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Campaigns",
                  value: searchQuery,
                  hint: "Enter campaign name...",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {
                  ss("Search executed");
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: [
                    {"label": "All", "value": "All"},
                    {"label": "Active", "value": "Active"},
                    {"label": "Paused", "value": "Paused"},
                    {"label": "Removed", "value": "Removed"},
                  ],
                  value: campaignStatus,
                  onChanged: (value, label) {
                    campaignStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Date Range",
                  items: [
                    {"label": "Last 7 Days", "value": "Last 7 Days"},
                    {"label": "Last 30 Days", "value": "Last 30 Days"},
                    {"label": "Last 90 Days", "value": "Last 90 Days"},
                    {"label": "This Year", "value": "This Year"},
                  ],
                  value: dateRange,
                  onChanged: (value, label) {
                    dateRange = value;
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

  Widget _buildCampaignsList() {
    return Column(
      spacing: spSm,
      children: campaigns.map((campaign) => _buildCampaignCard(campaign)).toList(),
    );
  }

  Widget _buildCampaignCard(Map<String, dynamic> campaign) {
    Color statusColor = (campaign["status"] as String) == "Active" ? successColor : 
                       (campaign["status"] as String) == "Paused" ? warningColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
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
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${campaign["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Budget: \$${(campaign["budget"] as double).toStringAsFixed(0)}/day",
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
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showCampaignActions(campaign);
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildCampaignMetric("Spent", "\$${(campaign["spent"] as double).toStringAsFixed(2)}", Icons.payments),
              _buildCampaignMetric("Impressions", "${campaign["impressions"]}", Icons.visibility),
              _buildCampaignMetric("Clicks", "${campaign["clicks"]}", Icons.mouse),
              _buildCampaignMetric("CTR", "${(campaign["ctr"] as double).toStringAsFixed(2)}%", Icons.trending_up),
              _buildCampaignMetric("CPC", "\$${(campaign["cpc"] as double).toStringAsFixed(2)}", Icons.attach_money),
              _buildCampaignMetric("ROAS", "${(campaign["roas"] as double).toStringAsFixed(1)}x", Icons.trending_up),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignMetric(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 16),
        SizedBox(width: spXs),
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
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showCampaignActions(Map<String, dynamic> campaign) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "Campaign Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            _buildActionButton("Edit Campaign", Icons.edit, () {
              Navigator.pop(context);
              ss("Edit campaign: ${campaign["name"]}");
            }),
            _buildActionButton("Pause/Resume", Icons.play_arrow, () {
              Navigator.pop(context);
              ss("Campaign status changed");
            }),
            _buildActionButton("Duplicate", Icons.copy, () {
              Navigator.pop(context);
              ss("Campaign duplicated");
            }),
            _buildActionButton("View Details", Icons.info, () {
              Navigator.pop(context);
              ss("Campaign details opened");
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: primaryColor.withAlpha(30)),
        ),
        child: Row(
          children: [
            Icon(icon, color: primaryColor, size: 20),
            SizedBox(width: spSm),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeywordsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildKeywordFilters(),
          _buildKeywordsList(),
        ],
      ),
    );
  }

  Widget _buildKeywordFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Keywords",
                  value: searchQuery,
                  hint: "Enter keyword...",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Add Keyword",
                size: bs.sm,
                onPressed: () {
                  ss("Add keyword dialog opened");
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Campaign",
                  items: [
                    {"label": "All Campaigns", "value": "All Campaigns"},
                    ...campaigns.map((c) => {"label": c["name"], "value": c["name"]}).toList(),
                  ],
                  value: selectedCampaign,
                  onChanged: (value, label) {
                    selectedCampaign = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Match Type",
                  items: [
                    {"label": "All Types", "value": "All Types"},
                    {"label": "Exact", "value": "Exact"},
                    {"label": "Phrase", "value": "Phrase"},
                    {"label": "Broad", "value": "Broad"},
                  ],
                  value: "All Types",
                  onChanged: (value, label) {
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

  Widget _buildKeywordsList() {
    return Column(
      spacing: spSm,
      children: keywords.map((keyword) => _buildKeywordCard(keyword)).toList(),
    );
  }

  Widget _buildKeywordCard(Map<String, dynamic> keyword) {
    Color statusColor = (keyword["status"] as String) == "Active" ? successColor : warningColor;
    Color qualityColor = (keyword["quality_score"] as int) >= 7 ? successColor :
                        (keyword["quality_score"] as int) >= 5 ? warningColor : dangerColor;

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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${keyword["keyword"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${keyword["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${keyword["matchType"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: qualityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "QS: ${keyword["quality_score"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: qualityColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  ss("Keyword actions: ${keyword["keyword"]}");
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildKeywordMetric("Impressions", "${keyword["impressions"]}", Icons.visibility),
              _buildKeywordMetric("Clicks", "${keyword["clicks"]}", Icons.mouse),
              _buildKeywordMetric("CTR", "${(keyword["ctr"] as double).toStringAsFixed(2)}%", Icons.trending_up),
              _buildKeywordMetric("CPC", "\$${(keyword["cpc"] as double).toStringAsFixed(2)}", Icons.attach_money),
              _buildKeywordMetric("Position", "${(keyword["position"] as double).toStringAsFixed(1)}", Icons.format_list_numbered),
              _buildKeywordMetric("Conversions", "${keyword["conversions"]}", Icons.track_changes),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeywordMetric(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 16),
        SizedBox(width: spXs),
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
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAdsFilters(),
          _buildAdsList(),
        ],
      ),
    );
  }

  Widget _buildAdsFilters() {
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
            child: QTextField(
              label: "Search Ads",
              value: searchQuery,
              hint: "Enter ad headline...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            label: "Create Ad",
            size: bs.sm,
            onPressed: () {
              ss("Create ad dialog opened");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdsList() {
    return Column(
      spacing: spSm,
      children: ads.map((ad) => _buildAdCard(ad)).toList(),
    );
  }

  Widget _buildAdCard(Map<String, dynamic> ad) {
    Color statusColor = (ad["status"] as String) == "Active" ? successColor : warningColor;
    Color typeColor = (ad["type"] as String) == "Text Ad" ? infoColor :
                     (ad["type"] as String) == "Display Ad" ? warningColor : successColor;

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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${ad["headline"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${ad["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${ad["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: typeColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${ad["type"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: typeColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  ss("Ad actions: ${ad["headline"]}");
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAdMetric("Impressions", "${ad["impressions"]}", Icons.visibility),
              _buildAdMetric("Clicks", "${ad["clicks"]}", Icons.mouse),
              _buildAdMetric("CTR", "${(ad["ctr"] as double).toStringAsFixed(2)}%", Icons.trending_up),
              _buildAdMetric("Conversions", "${ad["conversions"]}", Icons.track_changes),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdMetric(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 16),
        SizedBox(width: spXs),
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
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
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
          _buildAnalyticsFilters(),
          _buildPerformanceCharts(),
          _buildDetailedMetrics(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsFilters() {
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
              label: "Date Range",
              items: [
                {"label": "Last 7 Days", "value": "Last 7 Days"},
                {"label": "Last 30 Days", "value": "Last 30 Days"},
                {"label": "Last 90 Days", "value": "Last 90 Days"},
                {"label": "This Year", "value": "This Year"},
              ],
              value: dateRange,
              onChanged: (value, label) {
                dateRange = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QDropdownField(
              label: "Campaign",
              items: [
                {"label": "All Campaigns", "value": "All Campaigns"},
                ...campaigns.map((c) => {"label": c["name"], "value": c["name"]}).toList(),
              ],
              value: selectedCampaign,
              onChanged: (value, label) {
                selectedCampaign = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCharts() {
    return Column(
      spacing: spSm,
      children: [
        Container(
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
                "Performance Trends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
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
                      Icon(Icons.trending_up, color: primaryColor, size: 48),
                      Text(
                        "Performance Chart",
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Impressions, Clicks, Conversions over time",
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
        ),
        Container(
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
                "Budget Utilization",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.pie_chart, color: successColor, size: 48),
                      Text(
                        "Budget Distribution",
                        style: TextStyle(
                          fontSize: 16,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Spend across campaigns",
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
        ),
      ],
    );
  }

  Widget _buildDetailedMetrics() {
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
            "Detailed Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAnalyticsCard("Cost per Acquisition", "\$42.50", Icons.attach_money, successColor),
              _buildAnalyticsCard("Quality Score Avg", "7.2", Icons.star, warningColor),
              _buildAnalyticsCard("Search Impression Share", "67%", Icons.visibility, infoColor),
              _buildAnalyticsCard("Conversion Rate", "4.8%", Icons.track_changes, dangerColor),
              _buildAnalyticsCard("Cost per Click", "\$0.85", Icons.mouse, primaryColor),
              _buildAnalyticsCard("Revenue per Click", "\$3.60", Icons.trending_up, successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              Spacer(),
              Text(
                "+8%",
                style: TextStyle(
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
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
}
