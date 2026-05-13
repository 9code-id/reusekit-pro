import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsEmailCampaignsView extends StatefulWidget {
  const DmsEmailCampaignsView({super.key});

  @override
  State<DmsEmailCampaignsView> createState() => _DmsEmailCampaignsViewState();
}

class _DmsEmailCampaignsViewState extends State<DmsEmailCampaignsView> {
  String campaignName = "";
  String selectedTemplate = "template1";
  String selectedList = "list1";
  String selectedSchedule = "now";
  String subject = "";
  String preheaderText = "";
  String fromName = "";
  String fromEmail = "";
  String replyTo = "";
  bool enableTracking = true;
  bool enableAutomation = false;
  String selectedCampaignType = "newsletter";
  String searchQuery = "";
  String filterStatus = "all";
  
  List<Map<String, dynamic>> campaignTypeOptions = [
    {"label": "Newsletter", "value": "newsletter"},
    {"label": "Promotional", "value": "promotional"},
    {"label": "Welcome Series", "value": "welcome"},
    {"label": "Abandoned Cart", "value": "cart"},
    {"label": "Re-engagement", "value": "reengagement"}
  ];

  List<Map<String, dynamic>> templateOptions = [
    {"label": "Summer Newsletter Template", "value": "template1"},
    {"label": "Product Launch Template", "value": "template2"},
    {"label": "Welcome Email Template", "value": "template3"},
    {"label": "Promotional Template", "value": "template4"}
  ];

  List<Map<String, dynamic>> listOptions = [
    {"label": "All Subscribers (28.4K)", "value": "list1"},
    {"label": "VIP Customers (5.2K)", "value": "list2"},
    {"label": "Newsletter Subscribers (15.8K)", "value": "list3"},
    {"label": "Recent Purchases (3.1K)", "value": "list4"}
  ];

  List<Map<String, dynamic>> scheduleOptions = [
    {"label": "Send Now", "value": "now"},
    {"label": "Schedule for Later", "value": "scheduled"},
    {"label": "Save as Draft", "value": "draft"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Campaigns", "value": "all"},
    {"label": "Draft", "value": "draft"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "Sent", "value": "sent"},
    {"label": "Active", "value": "active"}
  ];

  List<Map<String, dynamic>> campaigns = [
    {
      "id": "camp1",
      "name": "Summer Sale Newsletter",
      "type": "Newsletter",
      "status": "Sent",
      "subject": "🌞 Summer Sale: Up to 70% Off Everything!",
      "createdDate": "2024-06-18",
      "sentDate": "2024-06-18",
      "recipients": 15420,
      "delivered": 15180,
      "opened": 3760,
      "clicked": 570,
      "openRate": 24.7,
      "clickRate": 3.8,
      "revenue": 12500.00,
      "template": "Summer Newsletter Template"
    },
    {
      "id": "camp2",
      "name": "Product Launch Announcement",
      "type": "Promotional",
      "status": "Sent",
      "subject": "Introducing Our Revolutionary New Product Line",
      "createdDate": "2024-06-15",
      "sentDate": "2024-06-15",
      "recipients": 8750,
      "delivered": 8690,
      "opened": 2170,
      "clicked": 435,
      "openRate": 25.0,
      "clickRate": 5.0,
      "revenue": 18750.00,
      "template": "Product Launch Template"
    },
    {
      "id": "camp3",
      "name": "Weekly Newsletter #24",
      "type": "Newsletter",
      "status": "Scheduled",
      "subject": "This Week's Top Stories and Exclusive Offers",
      "createdDate": "2024-06-17",
      "sentDate": "2024-06-20",
      "recipients": 14200,
      "delivered": 0,
      "opened": 0,
      "clicked": 0,
      "openRate": 0,
      "clickRate": 0,
      "revenue": 0,
      "template": "Summer Newsletter Template"
    },
    {
      "id": "camp4",
      "name": "VIP Customer Exclusive",
      "type": "Promotional",
      "status": "Draft",
      "subject": "VIP Early Access: New Collection Preview",
      "createdDate": "2024-06-16",
      "sentDate": null,
      "recipients": 0,
      "delivered": 0,
      "opened": 0,
      "clicked": 0,
      "openRate": 0,
      "clickRate": 0,
      "revenue": 0,
      "template": "Promotional Template"
    },
    {
      "id": "camp5",
      "name": "Abandoned Cart Recovery",
      "type": "Automated",
      "status": "Active",
      "subject": "You left something behind...",
      "createdDate": "2024-05-20",
      "sentDate": "Ongoing",
      "recipients": 1890,
      "delivered": 1875,
      "opened": 420,
      "clicked": 89,
      "openRate": 22.4,
      "clickRate": 4.7,
      "revenue": 5600.00,
      "template": "Abandoned Cart Template"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Campaigns"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Creating new email campaign");
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
            _buildCampaignCreator(),
            _buildCampaignFilters(),
            _buildCampaignsList(),
            _buildCampaignInsights(),
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
                Icons.campaign,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email Campaigns",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Create, manage and track your email campaigns",
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
                child: _buildMetricCard("Total Campaigns", "23", Icons.campaign),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("Active", "5", Icons.play_circle),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("This Month", "8 Sent", Icons.send),
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

  Widget _buildCampaignCreator() {
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
                Icons.add_circle,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Create New Campaign",
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
            hint: "Enter descriptive campaign name",
            onChanged: (value) {
              campaignName = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Campaign Type",
            items: campaignTypeOptions,
            value: selectedCampaignType,
            onChanged: (value, label) {
              selectedCampaignType = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Subject Line",
            value: subject,
            hint: "Compelling subject line for your email",
            onChanged: (value) {
              subject = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Preheader Text",
            value: preheaderText,
            hint: "Preview text that appears after subject",
            onChanged: (value) {
              preheaderText = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "From Name",
                  value: fromName,
                  hint: "Your Brand Name",
                  onChanged: (value) {
                    fromName = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "From Email",
                  value: fromEmail,
                  hint: "hello@yourbrand.com",
                  onChanged: (value) {
                    fromEmail = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Email Template",
            items: templateOptions,
            value: selectedTemplate,
            onChanged: (value, label) {
              selectedTemplate = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Recipient List",
            items: listOptions,
            value: selectedList,
            onChanged: (value, label) {
              selectedList = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Schedule",
            items: scheduleOptions,
            value: selectedSchedule,
            onChanged: (value, label) {
              selectedSchedule = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Enable Click Tracking",
                      "value": true,
                      "checked": enableTracking,
                    }
                  ],
                  value: [
                    if (enableTracking)
                      {
                        "label": "Enable Click Tracking",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    enableTracking = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Add to Automation Sequence",
                      "value": true,
                      "checked": enableAutomation,
                    }
                  ],
                  value: [
                    if (enableAutomation)
                      {
                        "label": "Add to Automation Sequence",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    enableAutomation = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: selectedSchedule == "now" ? "Send Campaign" : "Save Campaign",
                  size: bs.md,
                  onPressed: () {
                    if (campaignName.isNotEmpty && subject.isNotEmpty) {
                      String action = selectedSchedule == "now" ? "sent" : "saved";
                      ss("Campaign '$campaignName' $action successfully");
                      _resetForm();
                    } else {
                      se("Please fill in campaign name and subject");
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Preview",
                size: bs.md,
                onPressed: () {
                  si("Opening campaign preview");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignFilters() {
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
                "Filter Campaigns",
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
                child: QTextField(
                  label: "Search Campaigns",
                  value: searchQuery,
                  hint: "Search by name or subject",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: filterStatus,
                  onChanged: (value, label) {
                    filterStatus = value;
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
    List<Map<String, dynamic>> filteredCampaigns = campaigns.where((campaign) {
      bool matchesSearch = searchQuery.isEmpty || 
          campaign["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          campaign["subject"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = filterStatus == "all" || 
          campaign["status"].toString().toLowerCase() == filterStatus.toLowerCase();
      
      return matchesSearch && matchesStatus;
    }).toList();

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
                "Your Campaigns (${filteredCampaigns.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...filteredCampaigns.map((campaign) {
            return Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: _getStatusColor(campaign["status"]),
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
                            Text(
                              "${campaign["subject"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
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
                                  "${campaign["createdDate"]}",
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
                          color: _getStatusColor(campaign["status"]),
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
                  if (campaign["status"] == "Sent" || campaign["status"] == "Active") ...[
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
                            campaign["revenue"] > 0 
                                ? "\$${((campaign["revenue"] as double) / 1000).toStringAsFixed(1)}K"
                                : "\$0"
                          ),
                        ),
                      ],
                    ),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: campaign["status"] == "Draft" ? "Edit" : "View Report",
                          size: bs.sm,
                          onPressed: () {
                            String action = campaign["status"] == "Draft" ? "Editing" : "Opening report for";
                            ss("$action ${campaign["name"]}");
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

  Widget _buildCampaignInsights() {
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
                Icons.insights,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
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
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: successColor,
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
                      Icons.trending_up,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Best Performing Campaign",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Product Launch Announcement achieved 25% open rate and generated \$18.7K in revenue. Consider using similar subject line strategies.",
                  style: TextStyle(
                    fontSize: 13,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Analyze Strategy",
                        size: bs.sm,
                        onPressed: () {
                          ss("Analyzing campaign strategy");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Apply Template",
                      size: bs.sm,
                      onPressed: () {
                        si("Applying successful template");
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
                child: _buildInsightCard(
                  "Avg. Open Rate",
                  "24.9%",
                  "Industry: 21.3%",
                  Icons.mail,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildInsightCard(
                  "Best Send Time",
                  "Tue 10 AM",
                  "Highest engagement",
                  Icons.access_time,
                  infoColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(String title, String value, String description, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "sent":
        return successColor;
      case "active":
        return infoColor;
      case "scheduled":
        return warningColor;
      case "draft":
        return disabledColor;
      default:
        return primaryColor;
    }
  }

  void _resetForm() {
    campaignName = "";
    subject = "";
    preheaderText = "";
    fromName = "";
    fromEmail = "";
    replyTo = "";
    selectedTemplate = "template1";
    selectedList = "list1";
    selectedSchedule = "now";
    enableTracking = true;
    enableAutomation = false;
    setState(() {});
  }
}
