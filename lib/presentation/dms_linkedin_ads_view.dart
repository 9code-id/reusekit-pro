import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsLinkedinAdsView extends StatefulWidget {
  const DmsLinkedinAdsView({super.key});

  @override
  State<DmsLinkedinAdsView> createState() => _DmsLinkedinAdsViewState();
}

class _DmsLinkedinAdsViewState extends State<DmsLinkedinAdsView> {
  int currentTab = 0;
  String selectedCampaign = "All Campaigns";
  String selectedAccount = "Company LinkedIn Ads";
  String searchQuery = "";
  String dateRange = "Last 30 Days";
  String campaignObjective = "All";
  String adFormat = "All";

  List<Map<String, dynamic>> campaigns = [
    {
      "name": "Lead Generation - B2B Professionals",
      "objective": "Lead Generation",
      "status": "Active",
      "budget": 300.0,
      "spent": 245.80,
      "impressions": 56789,
      "clicks": 1234,
      "ctr": 2.2,
      "cpc": 0.20,
      "leads": 89,
      "costPerLead": 2.76,
      "socialActions": 456,
      "videoViews": 0,
      "completion_rate": 0.0
    },
    {
      "name": "Brand Awareness - Tech Industry",
      "objective": "Brand Awareness",
      "status": "Active",
      "budget": 200.0,
      "spent": 167.50,
      "impressions": 123456,
      "clicks": 2345,
      "ctr": 1.9,
      "cpc": 0.07,
      "leads": 0,
      "costPerLead": 0.0,
      "socialActions": 1234,
      "videoViews": 0,
      "completion_rate": 0.0
    },
    {
      "name": "Video Views - Product Demo",
      "objective": "Video Views",
      "status": "Active",
      "budget": 150.0,
      "spent": 142.30,
      "impressions": 89234,
      "clicks": 1567,
      "ctr": 1.8,
      "cpc": 0.09,
      "leads": 0,
      "costPerLead": 0.0,
      "socialActions": 567,
      "videoViews": 12456,
      "completion_rate": 75.5
    },
    {
      "name": "Website Traffic - Landing Page",
      "objective": "Website Traffic",
      "status": "Paused",
      "budget": 100.0,
      "spent": 0.0,
      "impressions": 0,
      "clicks": 0,
      "ctr": 0.0,
      "cpc": 0.0,
      "leads": 0,
      "costPerLead": 0.0,
      "socialActions": 0,
      "videoViews": 0,
      "completion_rate": 0.0
    }
  ];

  List<Map<String, dynamic>> adFormats = [
    {
      "name": "Sponsored Content",
      "description": "Native ads in LinkedIn feed",
      "campaigns": 8,
      "avgCTR": 1.8,
      "avgCPC": 0.15,
      "performance": "Excellent"
    },
    {
      "name": "Message Ads",
      "description": "Direct messages to LinkedIn members", 
      "campaigns": 3,
      "avgCTR": 12.5,
      "avgCPC": 0.45,
      "performance": "Good"
    },
    {
      "name": "Dynamic Ads",
      "description": "Personalized ads using LinkedIn profile data",
      "campaigns": 2,
      "avgCTR": 0.6,
      "avgCPC": 0.35,
      "performance": "Average"
    },
    {
      "name": "Text Ads",
      "description": "Simple text-based ads on sidebar",
      "campaigns": 1,
      "avgCTR": 0.3,
      "avgCPC": 0.25,
      "performance": "Below Average"
    }
  ];

  List<Map<String, dynamic>> targetingOptions = [
    {
      "category": "Job Title",
      "options": ["Marketing Manager", "VP Marketing", "CMO", "Digital Marketing Manager"],
      "reach": "2.5M",
      "active": true
    },
    {
      "category": "Company Size",
      "options": ["51-200 employees", "201-500 employees", "501-1000 employees"],
      "reach": "1.8M",
      "active": true
    },
    {
      "category": "Industry",
      "options": ["Technology", "Marketing & Advertising", "Software Development"],
      "reach": "3.2M",
      "active": true
    },
    {
      "category": "Skills",
      "options": ["Digital Marketing", "Content Marketing", "SEO", "Social Media"],
      "reach": "4.1M",
      "active": false
    },
    {
      "category": "Seniority",
      "options": ["Manager", "Director", "VP", "C-Level"],
      "reach": "1.2M",
      "active": true
    }
  ];

  List<Map<String, dynamic>> leadFormFields = [
    {
      "field": "First Name",
      "type": "Text",
      "required": true,
      "completion_rate": 98.5
    },
    {
      "field": "Last Name", 
      "type": "Text",
      "required": true,
      "completion_rate": 98.2
    },
    {
      "field": "Email",
      "type": "Email",
      "required": true,
      "completion_rate": 97.8
    },
    {
      "field": "Company",
      "type": "Text",
      "required": true,
      "completion_rate": 95.3
    },
    {
      "field": "Job Title",
      "type": "Text",
      "required": false,
      "completion_rate": 87.6
    },
    {
      "field": "Phone Number",
      "type": "Phone",
      "required": false,
      "completion_rate": 72.4
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "LinkedIn Ads Manager",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Campaigns", icon: Icon(Icons.campaign)),
        Tab(text: "Ad Formats", icon: Icon(Icons.format_list_bulleted)),
        Tab(text: "Targeting", icon: Icon(Icons.gps_fixed)),
        Tab(text: "Lead Forms", icon: Icon(Icons.assignment)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCampaignsTab(),
        _buildAdFormatsTab(),
        _buildTargetingTab(),
        _buildLeadFormsTab(),
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
          _buildAccountHeader(),
          _buildPerformanceMetrics(),
          _buildQuickActions(),
          _buildRecentActivity(),
          _buildLinkedInInsights(),
        ],
      ),
    );
  }

  Widget _buildAccountHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF0077B5).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(Icons.business, color: Color(0xFF0077B5), size: 24),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "LinkedIn Campaign Manager",
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
                Text(
                  "Active since: January 2024",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.sync,
            size: bs.sm,
            onPressed: () {
              ss("LinkedIn account synced");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
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
              Text(
                "Performance Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Last 30 Days",
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
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Total Spend", "\$${campaigns.fold(0.0, (sum, c) => sum + (c["spent"] as double)).toStringAsFixed(2)}", Icons.payments, successColor),
              _buildMetricCard("Total Impressions", "${campaigns.fold(0, (sum, c) => sum + (c["impressions"] as int))}", Icons.visibility, infoColor),
              _buildMetricCard("Total Clicks", "${campaigns.fold(0, (sum, c) => sum + (c["clicks"] as int))}", Icons.mouse, warningColor),
              _buildMetricCard("Total Leads", "${campaigns.fold(0, (sum, c) => sum + (c["leads"] as int))}", Icons.person_add, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "+18%",
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
                ss("LinkedIn campaign creation started");
              }),
              _buildActionCard("Audience Insights", Icons.insights, () {
                ss("LinkedIn audience insights opened");
              }),
              _buildActionCard("Lead Gen Forms", Icons.assignment, () {
                ss("Lead generation forms opened");
              }),
              _buildActionCard("Conversion Tracking", Icons.track_changes, () {
                ss("Conversion tracking setup opened");
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
          color: Color(0xFF0077B5).withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: Color(0xFF0077B5).withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(icon, color: Color(0xFF0077B5), size: 32),
            SizedBox(height: spXs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0077B5),
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
              _buildActivityItem("New lead form submission from 'B2B Professionals' campaign", "1 hour ago", Icons.person_add, successColor),
              _buildActivityItem("Campaign 'Tech Industry' budget increased to \$200", "3 hours ago", Icons.trending_up, infoColor),
              _buildActivityItem("Sponsored content ad approved and live", "5 hours ago", Icons.check_circle, successColor),
              _buildActivityItem("Message ad reached 1,000 professionals", "8 hours ago", Icons.message, warningColor),
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

  Widget _buildLinkedInInsights() {
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
              Icon(Icons.lightbulb, color: Color(0xFF0077B5), size: 20),
              SizedBox(width: spXs),
              Text(
                "LinkedIn Professional Insights",
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
              _buildInsightItem("B2B professionals are 3x more likely to engage on weekdays", Icons.business, Color(0xFF0077B5)),
              _buildInsightItem("Video content gets 5x more engagement than static posts", Icons.play_circle, successColor),
              _buildInsightItem("Lead gen forms perform best with 4-5 fields maximum", Icons.assignment, warningColor),
              _buildInsightItem("Job title targeting shows highest conversion rates", Icons.work, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String insight, IconData icon, Color color) {
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
          child: Text(
            insight,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
        ),
      ],
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
                label: "Create Campaign",
                size: bs.sm,
                onPressed: () {
                  ss("LinkedIn campaign creation wizard opened");
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Objective",
                  items: [
                    {"label": "All", "value": "All"},
                    {"label": "Brand Awareness", "value": "Brand Awareness"},
                    {"label": "Lead Generation", "value": "Lead Generation"},
                    {"label": "Website Traffic", "value": "Website Traffic"},
                    {"label": "Video Views", "value": "Video Views"},
                  ],
                  value: campaignObjective,
                  onChanged: (value, label) {
                    campaignObjective = value;
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
    Color statusColor = (campaign["status"] as String) == "Active" ? successColor : warningColor;
    String objective = campaign["objective"] as String;
    
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
                            color: Color(0xFF0077B5).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            objective,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF0077B5),
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
                  _showCampaignActions(campaign);
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: _buildCampaignMetrics(campaign),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCampaignMetrics(Map<String, dynamic> campaign) {
    List<Widget> metrics = [
      _buildCampaignMetric("Spent", "\$${(campaign["spent"] as double).toStringAsFixed(2)}", Icons.payments),
      _buildCampaignMetric("Impressions", "${campaign["impressions"]}", Icons.visibility),
      _buildCampaignMetric("Clicks", "${campaign["clicks"]}", Icons.mouse),
      _buildCampaignMetric("CTR", "${(campaign["ctr"] as double).toStringAsFixed(2)}%", Icons.trending_up),
    ];

    String objective = campaign["objective"] as String;
    if (objective == "Lead Generation" && (campaign["leads"] as int) > 0) {
      metrics.addAll([
        _buildCampaignMetric("Leads", "${campaign["leads"]}", Icons.person_add),
        _buildCampaignMetric("Cost/Lead", "\$${(campaign["costPerLead"] as double).toStringAsFixed(2)}", Icons.attach_money),
      ]);
    } else if (objective == "Video Views" && (campaign["videoViews"] as int) > 0) {
      metrics.addAll([
        _buildCampaignMetric("Video Views", "${campaign["videoViews"]}", Icons.play_circle),
        _buildCampaignMetric("Completion Rate", "${(campaign["completion_rate"] as double).toStringAsFixed(1)}%", Icons.check_circle),
      ]);
    } else {
      metrics.addAll([
        _buildCampaignMetric("Social Actions", "${campaign["socialActions"]}", Icons.thumb_up),
        _buildCampaignMetric("CPC", "\$${(campaign["cpc"] as double).toStringAsFixed(2)}", Icons.attach_money),
      ]);
    }

    return metrics;
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
            _buildActionButton("View in LinkedIn", Icons.launch, () {
              Navigator.pop(context);
              ss("Opening in LinkedIn Campaign Manager");
            }),
            _buildActionButton("Duplicate Campaign", Icons.copy, () {
              Navigator.pop(context);
              ss("Campaign duplicated");
            }),
            _buildActionButton("Download Leads", Icons.download, () {
              Navigator.pop(context);
              ss("Lead export started");
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

  Widget _buildAdFormatsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAdFormatsHeader(),
          _buildAdFormatsList(),
        ],
      ),
    );
  }

  Widget _buildAdFormatsHeader() {
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
            "LinkedIn Ad Formats",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Choose the right ad format to reach your professional audience",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdFormatsList() {
    return Column(
      spacing: spSm,
      children: adFormats.map((format) => _buildAdFormatCard(format)).toList(),
    );
  }

  Widget _buildAdFormatCard(Map<String, dynamic> format) {
    Color performanceColor = (format["performance"] as String) == "Excellent" ? successColor :
                            (format["performance"] as String) == "Good" ? infoColor :
                            (format["performance"] as String) == "Average" ? warningColor : dangerColor;

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
                      "${format["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${format["description"]}",
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
                            color: performanceColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${format["performance"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: performanceColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${format["campaigns"]} campaigns",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Use Format",
                size: bs.sm,
                onPressed: () {
                  ss("Creating ${format["name"]} campaign");
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildFormatMetric("Avg CTR", "${(format["avgCTR"] as double).toStringAsFixed(2)}%", Icons.trending_up),
              _buildFormatMetric("Avg CPC", "\$${(format["avgCPC"] as double).toStringAsFixed(2)}", Icons.attach_money),
              _buildFormatMetric("Campaigns", "${format["campaigns"]}", Icons.campaign),
              _buildFormatMetric("Performance", "${format["performance"]}", Icons.star),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormatMetric(String label, String value, IconData icon) {
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

  Widget _buildTargetingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTargetingHeader(),
          _buildTargetingOptions(),
        ],
      ),
    );
  }

  Widget _buildTargetingHeader() {
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
                  "Professional Targeting Options",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Target the right professionals with LinkedIn's unique data",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Create Audience",
            size: bs.sm,
            onPressed: () {
              ss("Create custom audience dialog opened");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTargetingOptions() {
    return Column(
      spacing: spSm,
      children: targetingOptions.map((option) => _buildTargetingCard(option)).toList(),
    );
  }

  Widget _buildTargetingCard(Map<String, dynamic> option) {
    bool isActive = option["active"] as bool;
    Color statusColor = isActive ? successColor : disabledBoldColor;

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
                      "${option["category"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Potential reach: ${option["reach"]} professionals",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QSwitch(
                items: [
                  {
                    "label": "Active",
                    "value": true,
                    "checked": isActive,
                  }
                ],
                value: isActive ? [{"label": "Active", "value": true, "checked": true}] : [],
                onChanged: (values, ids) {
                  setState(() {
                    option["active"] = values.isNotEmpty;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (option["options"] as List<String>).map((opt) => Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFF0077B5).withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: Color(0xFF0077B5).withAlpha(30)),
              ),
              child: Text(
                opt,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF0077B5),
                  fontWeight: FontWeight.w600,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadFormsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildLeadFormHeader(),
          _buildLeadFormFields(),
          _buildLeadFormTips(),
        ],
      ),
    );
  }

  Widget _buildLeadFormHeader() {
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
                  "Lead Generation Forms",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Pre-filled forms make it easy for professionals to share their info",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Create Form",
            size: bs.sm,
            onPressed: () {
              ss("Lead form builder opened");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLeadFormFields() {
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
            "Form Field Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            spacing: spXs,
            children: leadFormFields.map((field) => _buildFieldCard(field)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldCard(Map<String, dynamic> field) {
    bool isRequired = field["required"] as bool;
    double completionRate = field["completion_rate"] as double;
    Color rateColor = completionRate >= 95 ? successColor :
                     completionRate >= 85 ? infoColor :
                     completionRate >= 75 ? warningColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: rateColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: rateColor.withAlpha(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${field["field"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    if (isRequired)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Required",
                          style: TextStyle(
                            fontSize: 9,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  "${field["type"]} field",
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
                "${completionRate.toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: rateColor,
                ),
              ),
              Text(
                "Completion",
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

  Widget _buildLeadFormTips() {
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
              Icon(Icons.tips_and_updates, color: warningColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Lead Form Best Practices",
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
              _buildTipItem("Keep forms short - 4-5 fields max for best completion rates"),
              _buildTipItem("Use LinkedIn's pre-filled data to reduce friction"),
              _buildTipItem("Make your value proposition clear in the form header"),
              _buildTipItem("Test different field combinations to optimize conversions"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 6),
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: warningColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            tip,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
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
          _buildAnalyticsFilters(),
          _buildPerformanceCharts(),
          _buildDetailedAnalytics(),
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
                "LinkedIn Performance Trends",
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
                  color: Color(0xFF0077B5).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.trending_up, color: Color(0xFF0077B5), size: 48),
                      Text(
                        "Professional Engagement Trends",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF0077B5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Impressions, clicks, and lead generation over time",
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
                "Professional Demographics",
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
                        "Audience Breakdown",
                        style: TextStyle(
                          fontSize: 16,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Job titles, seniority, and industry distribution",
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

  Widget _buildDetailedAnalytics() {
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
            "LinkedIn-Specific Metrics",
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
              _buildAnalyticsCard("Cost per Lead", "\$2.76", Icons.person_add, successColor),
              _buildAnalyticsCard("Lead Form Completion", "87%", Icons.assignment, infoColor),
              _buildAnalyticsCard("Professional CTR", "2.1%", Icons.business, warningColor),
              _buildAnalyticsCard("Social Actions", "1,234", Icons.thumb_up, dangerColor),
              _buildAnalyticsCard("Video Completion", "75%", Icons.play_circle, primaryColor),
              _buildAnalyticsCard("Message Open Rate", "45%", Icons.message, Color(0xFF0077B5)),
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
                "+15%",
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
