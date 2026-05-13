import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaEmailCampaignsView extends StatefulWidget {
  const CmaEmailCampaignsView({super.key});

  @override
  State<CmaEmailCampaignsView> createState() => _CmaEmailCampaignsViewState();
}

class _CmaEmailCampaignsViewState extends State<CmaEmailCampaignsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedTemplate = "welcome";
  
  List<Map<String, dynamic>> emailCampaigns = [
    {
      "id": 1,
      "name": "Welcome Series",
      "subject": "Welcome to Our Platform!",
      "recipients": 1250,
      "sent": 1150,
      "opened": 892,
      "clicked": 234,
      "status": "completed",
      "created_at": DateTime.now().subtract(Duration(days: 2)),
      "template": "welcome",
      "open_rate": 77.6,
      "click_rate": 20.3,
    },
    {
      "id": 2,
      "name": "Product Launch",
      "subject": "Introducing Our Latest Feature",
      "recipients": 2800,
      "sent": 2800,
      "opened": 1960,
      "clicked": 588,
      "status": "active",
      "created_at": DateTime.now().subtract(Duration(days: 1)),
      "template": "product",
      "open_rate": 70.0,
      "click_rate": 21.0,
    },
    {
      "id": 3,
      "name": "Newsletter March",
      "subject": "Monthly Updates & News",
      "recipients": 5200,
      "sent": 0,
      "opened": 0,
      "clicked": 0,
      "status": "draft",
      "created_at": DateTime.now(),
      "template": "newsletter",
      "open_rate": 0.0,
      "click_rate": 0.0,
    },
    {
      "id": 4,
      "name": "Flash Sale Alert",
      "subject": "24-Hour Flash Sale - 50% Off!",
      "recipients": 3400,
      "sent": 3400,
      "opened": 2720,
      "clicked": 1020,
      "status": "completed",
      "created_at": DateTime.now().subtract(Duration(days: 5)),
      "template": "promotion",
      "open_rate": 80.0,
      "click_rate": 30.0,
    },
    {
      "id": 5,
      "name": "Customer Survey",
      "subject": "Help Us Improve - Quick Survey",
      "recipients": 1800,
      "sent": 1650,
      "opened": 1155,
      "clicked": 462,
      "status": "paused",
      "created_at": DateTime.now().subtract(Duration(hours: 8)),
      "template": "survey",
      "open_rate": 70.0,
      "click_rate": 25.6,
    },
  ];

  List<Map<String, dynamic>> emailTemplates = [
    {"label": "Welcome Template", "value": "welcome"},
    {"label": "Product Launch", "value": "product"},
    {"label": "Newsletter", "value": "newsletter"},
    {"label": "Promotion", "value": "promotion"},
    {"label": "Survey", "value": "survey"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Campaigns", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Completed", "value": "completed"},
    {"label": "Draft", "value": "draft"},
    {"label": "Paused", "value": "paused"},
  ];

  String campaignName = "";
  String campaignSubject = "";
  String campaignContent = "";
  int targetRecipients = 0;

  List<Map<String, dynamic>> get filteredCampaigns {
    return emailCampaigns.where((campaign) {
      bool matchesSearch = searchQuery.isEmpty || 
          (campaign["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (campaign["subject"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || campaign["status"] == selectedStatus;
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "completed":
        return primaryColor;
      case "draft":
        return warningColor;
      case "paused":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      spacing: spMd,
      children: [
        // Quick Stats
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildStatCard("Total Campaigns", "${emailCampaigns.length}", Icons.campaign, primaryColor),
            _buildStatCard("Active Campaigns", "${emailCampaigns.where((c) => c["status"] == "active").length}", Icons.play_circle, successColor),
            _buildStatCard("Total Recipients", "${emailCampaigns.fold(0, (sum, c) => sum + (c["recipients"] as int))}", Icons.people, infoColor),
            _buildStatCard("Avg Open Rate", "${((emailCampaigns.fold(0.0, (sum, c) => sum + (c["open_rate"] as double)) / emailCampaigns.length)).toStringAsFixed(1)}%", Icons.mark_email_read, warningColor),
          ],
        ),

        // Search and Filter
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search campaigns...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Filter by Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),

        // Campaigns List
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Icon(Icons.campaign, color: primaryColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Email Campaigns",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "New Campaign",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () {
                        currentTab = 1;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredCampaigns.length,
                separatorBuilder: (context, index) => Divider(height: 1),
                itemBuilder: (context, index) {
                  final campaign = filteredCampaigns[index];
                  return _buildCampaignCard(campaign);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCreateTab() {
    return Column(
      spacing: spMd,
      children: [
        Container(
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
                  Icon(Icons.add_circle, color: primaryColor, size: 24),
                  SizedBox(width: spSm),
                  Text(
                    "Create New Email Campaign",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              
              QTextField(
                label: "Campaign Name",
                value: campaignName,
                hint: "Enter campaign name",
                onChanged: (value) {
                  campaignName = value;
                  setState(() {});
                },
              ),
              
              QTextField(
                label: "Email Subject",
                value: campaignSubject,
                hint: "Enter email subject line",
                onChanged: (value) {
                  campaignSubject = value;
                  setState(() {});
                },
              ),
              
              QDropdownField(
                label: "Email Template",
                items: emailTemplates,
                value: selectedTemplate,
                onChanged: (value, label) {
                  selectedTemplate = value;
                  setState(() {});
                },
              ),
              
              QMemoField(
                label: "Email Content",
                value: campaignContent,
                hint: "Write your email content here...",
                onChanged: (value) {
                  campaignContent = value;
                  setState(() {});
                },
              ),
              
              QNumberField(
                label: "Target Recipients",
                value: targetRecipients.toString(),
                hint: "Number of recipients",
                onChanged: (value) {
                  targetRecipients = int.tryParse(value) ?? 0;
                  setState(() {});
                },
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save as Draft",
                      color: disabledBoldColor,
                      size: bs.md,
                      onPressed: () {
                        ss("Campaign saved as draft");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Send Campaign",
                      size: bs.md,
                      onPressed: () {
                        ss("Email campaign sent successfully");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    return Column(
      spacing: spMd,
      children: [
        // Performance Metrics
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildMetricCard("Emails Sent", "${emailCampaigns.fold(0, (sum, c) => sum + (c["sent"] as int))}", Icons.send, primaryColor),
            _buildMetricCard("Emails Opened", "${emailCampaigns.fold(0, (sum, c) => sum + (c["opened"] as int))}", Icons.mark_email_read, successColor),
            _buildMetricCard("Emails Clicked", "${emailCampaigns.fold(0, (sum, c) => sum + (c["clicked"] as int))}", Icons.touch_app, infoColor),
            _buildMetricCard("Bounce Rate", "2.3%", Icons.trending_down, warningColor),
          ],
        ),

        // Top Performing Campaigns
        Container(
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
                "Top Performing Campaigns",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...emailCampaigns
                  .where((c) => (c["open_rate"] as double) > 70)
                  .map((campaign) => _buildPerformanceRow(campaign)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
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

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
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
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignCard(Map<String, dynamic> campaign) {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
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
                    Text(
                      "${campaign["subject"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: getStatusColor("${campaign["status"]}").withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${campaign["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: getStatusColor("${campaign["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              _buildCampaignStat("Recipients", "${campaign["recipients"]}"),
              SizedBox(width: spMd),
              _buildCampaignStat("Opened", "${campaign["opened"]}"),
              SizedBox(width: spMd),
              _buildCampaignStat("Clicked", "${campaign["clicked"]}"),
              Spacer(),
              Text(
                "${(campaign["created_at"] as DateTime).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          if ((campaign["sent"] as int) > 0)
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: (campaign["open_rate"] as double) / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(successColor),
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "${(campaign["open_rate"] as double).toStringAsFixed(1)}% open rate",
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

  Widget _buildCampaignStat(String label, String value) {
    return Column(
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
    );
  }

  Widget _buildPerformanceRow(Map<String, dynamic> campaign) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                "${campaign["recipients"]} recipients",
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
              "${(campaign["open_rate"] as double).toStringAsFixed(1)}%",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: successColor,
              ),
            ),
            Text(
              "Open Rate",
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Email Campaigns",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Create", icon: Icon(Icons.add)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildOverviewTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildCreateTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildAnalyticsTab(),
        ),
      ],
      onInit: (tabController) {},
    );
  }
}
