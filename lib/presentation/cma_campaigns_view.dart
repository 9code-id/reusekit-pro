import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCampaignsView extends StatefulWidget {
  const CmaCampaignsView({super.key});

  @override
  State<CmaCampaignsView> createState() => _CmaCampaignsViewState();
}

class _CmaCampaignsViewState extends State<CmaCampaignsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "";
  String selectedType = "";

  List<Map<String, dynamic>> campaigns = [
    {
      "id": "1",
      "name": "Spring Product Launch",
      "type": "email",
      "status": "active",
      "budget": 15000.0,
      "spent": 8750.0,
      "leads": 342,
      "conversions": 89,
      "roi": 245.8,
      "start_date": "2024-03-01",
      "end_date": "2024-04-30",
      "target_audience": 25000,
      "reached": 18500,
      "engagement_rate": 12.5,
      "click_rate": 8.3,
      "conversion_rate": 3.6,
      "description": "Launch campaign for new spring collection targeting millennials",
      "channels": ["Email", "Social Media", "Google Ads"],
      "manager": "Sarah Johnson",
      "created_at": "2024-02-15",
    },
    {
      "id": "2",
      "name": "Holiday Sale Promotion",
      "type": "sms",
      "status": "completed",
      "budget": 8000.0,
      "spent": 7850.0,
      "leads": 189,
      "conversions": 67,
      "roi": 198.2,
      "start_date": "2024-11-15",
      "end_date": "2024-12-31",
      "target_audience": 15000,
      "reached": 14200,
      "engagement_rate": 18.7,
      "click_rate": 15.2,
      "conversion_rate": 4.7,
      "description": "Holiday season promotional campaign with special discounts",
      "channels": ["SMS", "Push Notifications"],
      "manager": "Mike Chen",
      "created_at": "2024-10-30",
    },
    {
      "id": "3",
      "name": "Brand Awareness Drive",
      "type": "social",
      "status": "draft",
      "budget": 12000.0,
      "spent": 0.0,
      "leads": 0,
      "conversions": 0,
      "roi": 0.0,
      "start_date": "2024-06-01",
      "end_date": "2024-07-31",
      "target_audience": 50000,
      "reached": 0,
      "engagement_rate": 0.0,
      "click_rate": 0.0,
      "conversion_rate": 0.0,
      "description": "Brand awareness campaign focusing on social media presence",
      "channels": ["Facebook", "Instagram", "LinkedIn"],
      "manager": "Emma Wilson",
      "created_at": "2024-05-10",
    },
    {
      "id": "4",
      "name": "Customer Retention Program",
      "type": "email",
      "status": "paused",
      "budget": 6000.0,
      "spent": 2100.0,
      "leads": 156,
      "conversions": 34,
      "roi": 167.3,
      "start_date": "2024-01-15",
      "end_date": "2024-12-31",
      "target_audience": 8000,
      "reached": 3200,
      "engagement_rate": 14.8,
      "click_rate": 9.7,
      "conversion_rate": 2.1,
      "description": "Long-term retention campaign for existing customers",
      "channels": ["Email", "Direct Mail"],
      "manager": "David Lee",
      "created_at": "2024-01-01",
    },
    {
      "id": "5",
      "name": "New Customer Acquisition",
      "type": "paid_ads",
      "status": "active",
      "budget": 20000.0,
      "spent": 12340.0,
      "leads": 567,
      "conversions": 123,
      "roi": 312.5,
      "start_date": "2024-04-01",
      "end_date": "2024-06-30",
      "target_audience": 100000,
      "reached": 75000,
      "engagement_rate": 8.9,
      "click_rate": 6.2,
      "conversion_rate": 2.8,
      "description": "Aggressive acquisition campaign targeting new market segments",
      "channels": ["Google Ads", "Facebook Ads", "YouTube"],
      "manager": "Lisa Garcia",
      "created_at": "2024-03-15",
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "active"},
    {"label": "Completed", "value": "completed"},
    {"label": "Paused", "value": "paused"},
    {"label": "Draft", "value": "draft"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": ""},
    {"label": "Email", "value": "email"},
    {"label": "SMS", "value": "sms"},
    {"label": "Social Media", "value": "social"},
    {"label": "Paid Ads", "value": "paid_ads"},
  ];

  List<Map<String, dynamic>> get filteredCampaigns {
    return campaigns.where((campaign) {
      final matchesSearch = campaign["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                           campaign["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      final matchesStatus = selectedStatus.isEmpty || campaign["status"] == selectedStatus;
      final matchesType = selectedType.isEmpty || campaign["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return successColor;
      case 'completed':
        return infoColor;
      case 'paused':
        return warningColor;
      case 'draft':
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'email':
        return primaryColor;
      case 'sms':
        return successColor;
      case 'social':
        return infoColor;
      case 'paid_ads':
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildOverviewTab() {
    final activeCampaigns = campaigns.where((c) => c["status"] == "active").length;
    final totalBudget = campaigns.fold(0.0, (sum, c) => sum + (c["budget"] as double));
    final totalSpent = campaigns.fold(0.0, (sum, c) => sum + (c["spent"] as double));
    final totalLeads = campaigns.fold(0, (sum, c) => sum + (c["leads"] as int));
    final totalConversions = campaigns.fold(0, (sum, c) => sum + (c["conversions"] as int));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Overview Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Active Campaigns", activeCampaigns.toString(), Icons.campaign, successColor),
              _buildStatCard("Total Budget", "\$${totalBudget.currency}", Icons.account_balance_wallet, primaryColor),
              _buildStatCard("Total Spent", "\$${totalSpent.currency}", Icons.trending_down, warningColor),
              _buildStatCard("Total Leads", totalLeads.toString(), Icons.person_add, infoColor),
              _buildStatCard("Conversions", totalConversions.toString(), Icons.check_circle, successColor),
              _buildStatCard("Avg ROI", "${(campaigns.fold(0.0, (sum, c) => sum + (c["roi"] as double)) / campaigns.length).toStringAsFixed(1)}%", Icons.trending_up, primaryColor),
            ],
          ),

          // Search and Filters
          Row(
            spacing: spSm,
            children: [
              Expanded(
                flex: 3,
                child: QTextField(
                  label: "Search campaigns...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
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
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Campaign List
          ...filteredCampaigns.map((campaign) => _buildCampaignCard(campaign)),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Campaign Analytics",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Performance Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Email Campaigns", "3", "68.5%", "avg engagement", primaryColor),
              _buildMetricCard("SMS Campaigns", "1", "18.7%", "avg engagement", successColor),
              _buildMetricCard("Social Media", "1", "0%", "avg engagement", infoColor),
              _buildMetricCard("Paid Ads", "1", "8.9%", "avg engagement", warningColor),
            ],
          ),

          // Top Performing Campaigns
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Top Performing Campaigns",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...campaigns
                    .where((c) => (c["roi"] as double) > 200)
                    .map((campaign) => _buildPerformanceItem(campaign)),
              ],
            ),
          ),

          // Budget Utilization
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Budget Utilization",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...campaigns.map((campaign) => _buildBudgetItem(campaign)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateTab() {
    String campaignName = "";
    String campaignDescription = "";
    String selectedCampaignType = "";
    String campaignBudget = "";
    String startDate = "";
    String endDate = "";
    String targetAudience = "";

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Create New Campaign",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
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
              spacing: spSm,
              children: [
                QTextField(
                  label: "Campaign Name",
                  value: campaignName,
                  hint: "Enter campaign name",
                  onChanged: (value) {
                    campaignName = value;
                    setState(() {});
                  },
                ),

                QMemoField(
                  label: "Campaign Description",
                  value: campaignDescription,
                  hint: "Describe your campaign objectives and target audience",
                  onChanged: (value) {
                    campaignDescription = value;
                    setState(() {});
                  },
                ),

                QDropdownField(
                  label: "Campaign Type",
                  items: [
                    {"label": "Email Marketing", "value": "email"},
                    {"label": "SMS Marketing", "value": "sms"},
                    {"label": "Social Media", "value": "social"},
                    {"label": "Paid Advertising", "value": "paid_ads"},
                  ],
                  value: selectedCampaignType,
                  onChanged: (value, label) {
                    selectedCampaignType = value;
                    setState(() {});
                  },
                ),

                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Budget (\$)",
                        value: campaignBudget,
                        hint: "0.00",
                        onChanged: (value) {
                          campaignBudget = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QNumberField(
                        label: "Target Audience",
                        value: targetAudience,
                        hint: "Number of people",
                        onChanged: (value) {
                          targetAudience = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Start Date",
                        value: startDate.isNotEmpty ? DateTime.parse(startDate) : DateTime.now(),
                        onChanged: (value) {
                          startDate = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QDatePicker(
                        label: "End Date",
                        value: endDate.isNotEmpty ? DateTime.parse(endDate) : DateTime.now().add(Duration(days: 30)),
                        onChanged: (value) {
                          endDate = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Create Campaign",
                    size: bs.md,
                    onPressed: () {
                      // Create campaign logic
                      ss("Campaign created successfully!");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Campaign Templates
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Campaign Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildTemplateItem("Product Launch", "email", "Perfect for new product announcements"),
                _buildTemplateItem("Seasonal Sale", "sms", "Ideal for holiday and seasonal promotions"),
                _buildTemplateItem("Brand Awareness", "social", "Build brand recognition and engagement"),
                _buildTemplateItem("Customer Retention", "email", "Keep existing customers engaged"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
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
                child: Icon(Icons.trending_up, color: color, size: 16),
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
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignCard(Map<String, dynamic> campaign) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
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
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${campaign["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(campaign["status"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${campaign["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(campaign["status"]),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getTypeColor(campaign["type"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${campaign["type"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getTypeColor(campaign["type"]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${(campaign["spent"] as double).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "of \$${(campaign["budget"] as double).currency}",
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
                  children: [
                    Text(
                      "${campaign["leads"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Leads",
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
                  children: [
                    Text(
                      "${campaign["conversions"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Conversions",
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
                  children: [
                    Text(
                      "${(campaign["roi"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "ROI",
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

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (campaign["spent"] as double) / (campaign["budget"] as double),
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {
                  // Navigate to campaign detail
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String count, String percentage, String subtitle, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          Text(
            count,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Row(
            children: [
              Text(
                percentage,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceItem(Map<String, dynamic> campaign) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(
                  "${campaign["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${campaign["type"]} • ${campaign["conversions"]} conversions",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${(campaign["roi"] as double).toStringAsFixed(1)}% ROI",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetItem(Map<String, dynamic> campaign) {
    final budgetUsed = (campaign["spent"] as double) / (campaign["budget"] as double);
    
    return Container(
      padding: EdgeInsets.all(spXs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${campaign["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "\$${(campaign["spent"] as double).currency} / \$${(campaign["budget"] as double).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: budgetUsed,
              child: Container(
                decoration: BoxDecoration(
                  color: budgetUsed > 0.8 ? warningColor : primaryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateItem(String name, String type, String description) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getTypeColor(type).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              type == 'email' ? Icons.email :
              type == 'sms' ? Icons.sms :
              type == 'social' ? Icons.share :
              Icons.ads_click,
              color: _getTypeColor(type),
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(
                  name,
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
            label: "Use Template",
            size: bs.sm,
            onPressed: () {
              // Use template logic
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Campaign Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Create", icon: Icon(Icons.add_circle)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAnalyticsTab(),
        _buildCreateTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}
