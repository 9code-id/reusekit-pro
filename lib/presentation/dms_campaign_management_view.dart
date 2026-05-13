import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsCampaignManagementView extends StatefulWidget {
  const DmsCampaignManagementView({super.key});

  @override
  State<DmsCampaignManagementView> createState() => _DmsCampaignManagementViewState();
}

class _DmsCampaignManagementViewState extends State<DmsCampaignManagementView> {
  int currentTab = 0;
  String selectedStatus = "All";
  String selectedPlatform = "All Platforms";
  String selectedCampaignType = "All Types";
  String searchQuery = "";
  String dateRange = "Last 30 Days";
  String sortBy = "Date Created";

  List<Map<String, dynamic>> campaigns = [
    {
      "id": "CMP001",
      "name": "Q1 Brand Awareness Campaign",
      "platform": "Multi-Platform",
      "platforms": ["Google Ads", "Facebook", "LinkedIn"],
      "type": "Brand Awareness",
      "status": "Active",
      "startDate": "2024-01-01",
      "endDate": "2024-03-31",
      "budget": 5000.0,
      "spent": 3245.80,
      "impressions": 125000,
      "clicks": 3250,
      "conversions": 156,
      "ctr": 2.6,
      "cpc": 1.00,
      "conversionRate": 4.8,
      "roas": 4.2,
      "owner": "Sarah Johnson",
      "lastModified": "2024-01-15",
      "tags": ["Brand", "Awareness", "Q1"],
      "priority": "High"
    },
    {
      "id": "CMP002",
      "name": "Lead Generation - B2B Professionals",
      "platform": "LinkedIn",
      "platforms": ["LinkedIn"],
      "type": "Lead Generation",
      "status": "Active",
      "startDate": "2024-01-15",
      "endDate": "2024-04-15",
      "budget": 3000.0,
      "spent": 1890.50,
      "impressions": 45000,
      "clicks": 1125,
      "conversions": 89,
      "ctr": 2.5,
      "cpc": 1.68,
      "conversionRate": 7.9,
      "roas": 5.6,
      "owner": "Michael Chen",
      "lastModified": "2024-01-14",
      "tags": ["B2B", "Lead Gen", "LinkedIn"],
      "priority": "High"
    },
    {
      "id": "CMP003",
      "name": "Product Launch - New Feature",
      "platform": "Multi-Platform",
      "platforms": ["Google Ads", "Facebook"],
      "type": "Product Launch",
      "status": "Paused",
      "startDate": "2024-01-10",
      "endDate": "2024-02-10",
      "budget": 2500.0,
      "spent": 1245.30,
      "impressions": 78000,
      "clicks": 1950,
      "conversions": 67,
      "ctr": 2.5,
      "cpc": 0.64,
      "conversionRate": 3.4,
      "roas": 3.8,
      "owner": "Emily Rodriguez",
      "lastModified": "2024-01-12",
      "tags": ["Product", "Launch", "Feature"],
      "priority": "Medium"
    },
    {
      "id": "CMP004",
      "name": "Holiday Sale Campaign",
      "platform": "Google Ads",
      "platforms": ["Google Ads"],
      "type": "Sales",
      "status": "Completed",
      "startDate": "2023-12-01",
      "endDate": "2023-12-31",
      "budget": 4000.0,
      "spent": 3987.50,
      "impressions": 156000,
      "clicks": 4680,
      "conversions": 234,
      "ctr": 3.0,
      "cpc": 0.85,
      "conversionRate": 5.0,
      "roas": 6.2,
      "owner": "David Kim",
      "lastModified": "2023-12-31",
      "tags": ["Holiday", "Sale", "Seasonal"],
      "priority": "High"
    },
    {
      "id": "CMP005",
      "name": "Video Marketing Campaign",
      "platform": "Facebook",
      "platforms": ["Facebook"],
      "type": "Video Marketing",
      "status": "Draft",
      "startDate": "2024-02-01",
      "endDate": "2024-03-01",
      "budget": 1500.0,
      "spent": 0.0,
      "impressions": 0,
      "clicks": 0,
      "conversions": 0,
      "ctr": 0.0,
      "cpc": 0.0,
      "conversionRate": 0.0,
      "roas": 0.0,
      "owner": "Lisa Wang",
      "lastModified": "2024-01-16",
      "tags": ["Video", "Content", "Facebook"],
      "priority": "Low"
    }
  ];

  List<Map<String, dynamic>> templates = [
    {
      "name": "Brand Awareness Template",
      "description": "Standard template for brand awareness campaigns",
      "type": "Brand Awareness",
      "platforms": ["Google Ads", "Facebook", "LinkedIn"],
      "defaultBudget": 2000.0,
      "duration": 30,
      "usageCount": 12,
      "lastUsed": "2024-01-10"
    },
    {
      "name": "Lead Generation Template",
      "description": "Optimized template for B2B lead generation",
      "type": "Lead Generation",
      "platforms": ["LinkedIn", "Google Ads"],
      "defaultBudget": 1500.0,
      "duration": 45,
      "usageCount": 8,
      "lastUsed": "2024-01-15"
    },
    {
      "name": "E-commerce Sales Template",
      "description": "Template for product sales and promotions",
      "type": "Sales",
      "platforms": ["Google Ads", "Facebook"],
      "defaultBudget": 3000.0,
      "duration": 21,
      "usageCount": 15,
      "lastUsed": "2024-01-08"
    },
    {
      "name": "Video Content Template",
      "description": "Template for video marketing campaigns",
      "type": "Video Marketing",
      "platforms": ["Facebook", "LinkedIn"],
      "defaultBudget": 1200.0,
      "duration": 14,
      "usageCount": 5,
      "lastUsed": "2024-01-05"
    }
  ];

  List<Map<String, dynamic>> schedules = [
    {
      "campaign": "Q1 Brand Awareness Campaign",
      "task": "Budget Review",
      "date": "2024-01-20",
      "time": "10:00 AM",
      "status": "Upcoming",
      "type": "Review",
      "assignee": "Sarah Johnson"
    },
    {
      "campaign": "Lead Generation - B2B Professionals",
      "task": "Performance Analysis",
      "date": "2024-01-18",
      "time": "2:00 PM",
      "status": "In Progress",
      "type": "Analysis",
      "assignee": "Michael Chen"
    },
    {
      "campaign": "Product Launch - New Feature",
      "task": "Campaign Optimization",
      "date": "2024-01-17",
      "time": "11:30 AM",
      "status": "Completed",
      "type": "Optimization",
      "assignee": "Emily Rodriguez"
    },
    {
      "campaign": "All Campaigns",
      "task": "Monthly Report Generation",
      "date": "2024-01-31",
      "time": "5:00 PM",
      "status": "Scheduled",
      "type": "Report",
      "assignee": "Marketing Team"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Campaign Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Campaigns", icon: Icon(Icons.campaign)),
        Tab(text: "Templates", icon: Icon(Icons.library_books)),
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildCampaignsTab(),
        _buildTemplatesTab(),
        _buildScheduleTab(),
        _buildAnalyticsTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildCampaignsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCampaignHeader(),
          _buildCampaignFilters(),
          _buildCampaignsList(),
        ],
      ),
    );
  }

  Widget _buildCampaignHeader() {
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
                  "Campaign Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Manage and monitor all your marketing campaigns in one place",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Create Campaign",
            size: bs.sm,
            onPressed: () {
              ss("Create new campaign wizard opened");
            },
          ),
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
                  hint: "Enter campaign name or ID...",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {
                  _showAdvancedFilters();
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
                    {"label": "Completed", "value": "Completed"},
                    {"label": "Draft", "value": "Draft"},
                  ],
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
                  label: "Platform",
                  items: [
                    {"label": "All Platforms", "value": "All Platforms"},
                    {"label": "Google Ads", "value": "Google Ads"},
                    {"label": "Facebook", "value": "Facebook"},
                    {"label": "LinkedIn", "value": "LinkedIn"},
                    {"label": "Multi-Platform", "value": "Multi-Platform"},
                  ],
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
                  label: "Type",
                  items: [
                    {"label": "All Types", "value": "All Types"},
                    {"label": "Brand Awareness", "value": "Brand Awareness"},
                    {"label": "Lead Generation", "value": "Lead Generation"},
                    {"label": "Sales", "value": "Sales"},
                    {"label": "Product Launch", "value": "Product Launch"},
                    {"label": "Video Marketing", "value": "Video Marketing"},
                  ],
                  value: selectedCampaignType,
                  onChanged: (value, label) {
                    selectedCampaignType = value;
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
    Color statusColor = _getStatusColor(campaign["status"] as String);
    Color priorityColor = _getPriorityColor(campaign["priority"] as String);

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
                    Row(
                      children: [
                        Text(
                          "${campaign["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${campaign["id"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${campaign["type"]}",
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
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${campaign["priority"]} Priority",
                            style: TextStyle(
                              fontSize: 10,
                              color: priorityColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Owner: ${campaign["owner"]} • Last modified: ${campaign["lastModified"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
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
          Row(
            children: [
              Expanded(
                child: Text(
                  "Platforms: ${(campaign["platforms"] as List<String>).join(", ")}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "${campaign["startDate"]} - ${campaign["endDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildCampaignMetric("Budget", "\$${(campaign["budget"] as double).toStringAsFixed(0)}", Icons.account_balance_wallet),
              _buildCampaignMetric("Spent", "\$${(campaign["spent"] as double).toStringAsFixed(2)}", Icons.payments),
              _buildCampaignMetric("Impressions", "${campaign["impressions"]}", Icons.visibility),
              _buildCampaignMetric("Clicks", "${campaign["clicks"]}", Icons.mouse),
              _buildCampaignMetric("Conversions", "${campaign["conversions"]}", Icons.track_changes),
              _buildCampaignMetric("ROAS", "${(campaign["roas"] as double).toStringAsFixed(1)}x", Icons.trending_up),
            ],
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (campaign["tags"] as List<String>).map((tag) => Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: secondaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  fontSize: 10,
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )).toList(),
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Paused":
        return warningColor;
      case "Completed":
        return infoColor;
      case "Draft":
        return disabledBoldColor;
      default:
        return primaryColor;
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
        return primaryColor;
    }
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
            _buildActionButton("Duplicate Campaign", Icons.copy, () {
              Navigator.pop(context);
              ss("Campaign duplicated");
            }),
            _buildActionButton("View Analytics", Icons.analytics, () {
              Navigator.pop(context);
              ss("Analytics opened for: ${campaign["name"]}");
            }),
            _buildActionButton("Export Data", Icons.download, () {
              Navigator.pop(context);
              ss("Data export started");
            }),
            _buildActionButton("Archive Campaign", Icons.archive, () {
              Navigator.pop(context);
              ss("Campaign archived");
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

  void _showAdvancedFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Advanced Filters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: spSm,
                  children: [
                    QDropdownField(
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
                    QDropdownField(
                      label: "Sort By",
                      items: [
                        {"label": "Date Created", "value": "Date Created"},
                        {"label": "Budget", "value": "Budget"},
                        {"label": "Performance", "value": "Performance"},
                        {"label": "Status", "value": "Status"},
                      ],
                      value: sortBy,
                      onChanged: (value, label) {
                        sortBy = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Reset Filters",
                            size: bs.sm,
                            onPressed: () {
                              Navigator.pop(context);
                              ss("Filters reset");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Apply Filters",
                            size: bs.sm,
                            onPressed: () {
                              Navigator.pop(context);
                              ss("Filters applied");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTemplatesHeader(),
          _buildTemplatesList(),
        ],
      ),
    );
  }

  Widget _buildTemplatesHeader() {
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
                  "Campaign Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Use pre-built templates to quickly create campaigns",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Create Template",
            size: bs.sm,
            onPressed: () {
              ss("Create template wizard opened");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesList() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: templates.map((template) => _buildTemplateCard(template)).toList(),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
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
                child: Text(
                  "${template["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  ss("Template actions: ${template["name"]}");
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${template["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${template["type"]}",
              style: TextStyle(
                fontSize: 10,
                color: infoColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: spSm),
          Column(
            spacing: spXs,
            children: [
              Row(
                children: [
                  Icon(Icons.account_balance_wallet, color: primaryColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Default Budget: \$${(template["defaultBudget"] as double).toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.schedule, color: primaryColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Duration: ${template["duration"]} days",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.analytics, color: primaryColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Used ${template["usageCount"]} times",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Use Template",
              size: bs.sm,
              onPressed: () {
                ss("Creating campaign from template: ${template["name"]}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildScheduleHeader(),
          _buildSchedulesList(),
        ],
      ),
    );
  }

  Widget _buildScheduleHeader() {
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
                  "Campaign Schedule",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Manage scheduled tasks and campaign milestones",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Add Task",
            size: bs.sm,
            onPressed: () {
              ss("Add scheduled task dialog opened");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSchedulesList() {
    return Column(
      spacing: spSm,
      children: schedules.map((schedule) => _buildScheduleCard(schedule)).toList(),
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> schedule) {
    Color statusColor = _getScheduleStatusColor(schedule["status"] as String);
    Color typeColor = _getScheduleTypeColor(schedule["type"] as String);

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
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: typeColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(_getScheduleTypeIcon(schedule["type"] as String), color: typeColor, size: 24),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${schedule["task"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Campaign: ${schedule["campaign"]}",
                  style: TextStyle(
                    fontSize: 12,
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
                        "${schedule["status"]}",
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
                        "${schedule["type"]}",
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${schedule["date"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${schedule["time"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${schedule["assignee"]}",
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

  Color _getScheduleStatusColor(String status) {
    switch (status) {
      case "Upcoming":
        return infoColor;
      case "In Progress":
        return warningColor;
      case "Completed":
        return successColor;
      case "Scheduled":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getScheduleTypeColor(String type) {
    switch (type) {
      case "Review":
        return infoColor;
      case "Analysis":
        return warningColor;
      case "Optimization":
        return successColor;
      case "Report":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getScheduleTypeIcon(String type) {
    switch (type) {
      case "Review":
        return Icons.rate_review;
      case "Analysis":
        return Icons.analytics;
      case "Optimization":
        return Icons.tune;
      case "Report":
        return Icons.assessment;
      default:
        return Icons.task;
    }
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsOverview(),
          _buildPerformanceComparison(),
          _buildCampaignInsights(),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Campaign Analytics Overview",
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
              _buildAnalyticsCard("Total Campaigns", "${campaigns.length}", Icons.campaign, primaryColor),
              _buildAnalyticsCard("Active Campaigns", "${campaigns.where((c) => c["status"] == "Active").length}", Icons.play_circle, successColor),
              _buildAnalyticsCard("Total Budget", "\$${campaigns.fold(0.0, (sum, c) => sum + (c["budget"] as double)).toStringAsFixed(0)}", Icons.account_balance_wallet, infoColor),
              _buildAnalyticsCard("Total Spent", "\$${campaigns.fold(0.0, (sum, c) => sum + (c["spent"] as double)).toStringAsFixed(2)}", Icons.payments, warningColor),
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
                "+12%",
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

  Widget _buildPerformanceComparison() {
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
            "Platform Performance Comparison",
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
                  Icon(Icons.bar_chart, color: primaryColor, size: 48),
                  Text(
                    "Performance Comparison Chart",
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Compare campaign performance across platforms",
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

  Widget _buildCampaignInsights() {
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
              Icon(Icons.insights, color: infoColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Campaign Insights",
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
              _buildInsightItem("Multi-platform campaigns show 35% better ROAS", Icons.trending_up, successColor),
              _buildInsightItem("Lead generation campaigns have highest conversion rates", Icons.person_add, infoColor),
              _buildInsightItem("Video marketing campaigns need budget optimization", Icons.video_library, warningColor),
              _buildInsightItem("Q1 campaigns are performing above industry average", Icons.assessment, primaryColor),
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

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildGeneralSettings(),
          _buildNotificationSettings(),
          _buildIntegrationSettings(),
        ],
      ),
    );
  }

  Widget _buildGeneralSettings() {
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
            "General Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Default Campaign Duration",
                items: [
                  {"label": "7 days", "value": "7"},
                  {"label": "14 days", "value": "14"},
                  {"label": "30 days", "value": "30"},
                  {"label": "60 days", "value": "60"},
                  {"label": "90 days", "value": "90"},
                ],
                value: "30",
                onChanged: (value, label) {
                  ss("Default duration updated to $label");
                },
              ),
              QDropdownField(
                label: "Default Budget Currency",
                items: [
                  {"label": "USD (\$)", "value": "USD"},
                  {"label": "EUR (€)", "value": "EUR"},
                  {"label": "GBP (£)", "value": "GBP"},
                ],
                value: "USD",
                onChanged: (value, label) {
                  ss("Currency updated to $label");
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Auto-pause low performing campaigns",
                    "value": true,
                    "checked": true,
                  }
                ],
                value: [{"label": "Auto-pause low performing campaigns", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  ss("Auto-pause setting updated");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
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
            "Notification Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            spacing: spSm,
            children: [
              QSwitch(
                items: [
                  {
                    "label": "Email notifications for campaign alerts",
                    "value": true,
                    "checked": true,
                  }
                ],
                value: [{"label": "Email notifications for campaign alerts", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  ss("Email notifications updated");
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Weekly performance reports",
                    "value": true,
                    "checked": false,
                  }
                ],
                value: [],
                onChanged: (values, ids) {
                  ss("Weekly reports setting updated");
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Budget threshold alerts",
                    "value": true,
                    "checked": true,
                  }
                ],
                value: [{"label": "Budget threshold alerts", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  ss("Budget alerts updated");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationSettings() {
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
            "Platform Integrations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            spacing: spSm,
            children: [
              _buildIntegrationItem("Google Ads", "Connected", successColor, true),
              _buildIntegrationItem("Facebook Ads", "Connected", successColor, true),
              _buildIntegrationItem("LinkedIn Ads", "Connected", successColor, true),
              _buildIntegrationItem("Twitter Ads", "Not Connected", disabledBoldColor, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationItem(String platform, String status, Color statusColor, bool isConnected) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(
            isConnected ? Icons.check_circle : Icons.error,
            color: statusColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  platform,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: isConnected ? "Manage" : "Connect",
            size: bs.sm,
            onPressed: () {
              ss("${isConnected ? 'Managing' : 'Connecting'} $platform integration");
            },
          ),
        ],
      ),
    );
  }
}
