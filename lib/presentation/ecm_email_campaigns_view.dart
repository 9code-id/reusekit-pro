import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmEmailCampaignsView extends StatefulWidget {
  const EcmEmailCampaignsView({super.key});

  @override
  State<EcmEmailCampaignsView> createState() => _EcmEmailCampaignsViewState();
}

class _EcmEmailCampaignsViewState extends State<EcmEmailCampaignsView> {
  int currentTab = 0;
  String selectedCampaignType = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> campaigns = [
    {
      "id": 1,
      "name": "Event Announcement - Tech Summit 2024",
      "type": "Announcement",
      "status": "Sent",
      "subject": "Join Us at Tech Summit 2024 - Early Bird Pricing Available",
      "recipients": 2847,
      "sentDate": "2024-06-15",
      "openRate": 68.5,
      "clickRate": 24.3,
      "unsubscribeRate": 0.8,
      "template": "Event Announcement Template",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=email",
      "description": "Initial event announcement with early bird registration pricing",
      "tags": ["announcement", "early-bird", "registration"],
      "bounceRate": 2.1,
    },
    {
      "id": 2,
      "name": "Speaker Spotlight - Dr. Sarah Chen",
      "type": "Speaker Highlight",
      "status": "Sent",
      "subject": "Meet Our Keynote Speaker: Dr. Sarah Chen - AI Innovation Pioneer",
      "recipients": 2654,
      "sentDate": "2024-06-12",
      "openRate": 72.3,
      "clickRate": 31.7,
      "unsubscribeRate": 0.5,
      "template": "Speaker Spotlight Template",
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=speaker",
      "description": "Highlighting keynote speaker Dr. Sarah Chen and her expertise",
      "tags": ["speaker", "keynote", "ai-innovation"],
      "bounceRate": 1.8,
    },
    {
      "id": 3,
      "name": "Registration Reminder",
      "type": "Reminder",
      "status": "Scheduled",
      "subject": "Don't Miss Out! Register for Tech Summit 2024 - 3 Days Left",
      "recipients": 1892,
      "sentDate": "2024-06-22",
      "openRate": 0,
      "clickRate": 0,
      "unsubscribeRate": 0,
      "template": "Reminder Template",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=reminder",
      "description": "Urgent reminder for registration deadline approaching",
      "tags": ["reminder", "urgency", "registration"],
      "bounceRate": 0,
    },
    {
      "id": 4,
      "name": "Agenda Released - Full Schedule",
      "type": "Update",
      "status": "Draft",
      "subject": "Complete Event Agenda Now Available - Plan Your Schedule",
      "recipients": 3156,
      "sentDate": "",
      "openRate": 0,
      "clickRate": 0,
      "unsubscribeRate": 0,
      "template": "Update Template",
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=agenda",
      "description": "Comprehensive event agenda and schedule information",
      "tags": ["agenda", "schedule", "planning"],
      "bounceRate": 0,
    },
    {
      "id": 5,
      "name": "Sponsor Showcase - Microsoft Partnership",
      "type": "Sponsor Content",
      "status": "Sent",
      "subject": "Proud to Partner with Microsoft - Exclusive Event Benefits",
      "recipients": 2543,
      "sentDate": "2024-06-08",
      "openRate": 65.2,
      "clickRate": 19.8,
      "unsubscribeRate": 1.2,
      "template": "Sponsor Showcase Template",
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=sponsor",
      "description": "Showcasing Microsoft partnership and exclusive benefits",
      "tags": ["sponsor", "partnership", "microsoft"],
      "bounceRate": 2.3,
    },
    {
      "id": 6,
      "name": "Post-Event Survey",
      "type": "Follow-up",
      "status": "Draft",
      "subject": "How Was Your Tech Summit Experience? Share Your Feedback",
      "recipients": 2100,
      "sentDate": "",
      "openRate": 0,
      "clickRate": 0,
      "unsubscribeRate": 0,
      "template": "Survey Template",
      "thumbnail": "https://picsum.photos/300/200?random=6&keyword=survey",
      "description": "Post-event feedback collection and satisfaction survey",
      "tags": ["survey", "feedback", "post-event"],
      "bounceRate": 0,
    },
    {
      "id": 7,
      "name": "Networking Lunch Details",
      "type": "Information",
      "status": "Scheduled",
      "subject": "Networking Lunch Info - Location & Menu Details",
      "recipients": 1876,
      "sentDate": "2024-06-20",
      "openRate": 0,
      "clickRate": 0,
      "unsubscribeRate": 0,
      "template": "Information Template",
      "thumbnail": "https://picsum.photos/300/200?random=7&keyword=networking",
      "description": "Details about networking lunch venue and menu options",
      "tags": ["networking", "lunch", "venue"],
      "bounceRate": 0,
    },
    {
      "id": 8,
      "name": "Thank You - Event Success",
      "type": "Thank You",
      "status": "Draft",
      "subject": "Thank You for Making Tech Summit 2024 a Success!",
      "recipients": 2400,
      "sentDate": "",
      "openRate": 0,
      "clickRate": 0,
      "unsubscribeRate": 0,
      "template": "Thank You Template",
      "thumbnail": "https://picsum.photos/300/200?random=8&keyword=thankyou",
      "description": "Gratitude message for event attendance and participation",
      "tags": ["thank-you", "success", "gratitude"],
      "bounceRate": 0,
    },
  ];

  List<Map<String, dynamic>> templates = [
    {
      "id": 1,
      "name": "Event Announcement",
      "category": "Announcement",
      "preview": "https://picsum.photos/200/300?random=10&keyword=announcement",
      "description": "Professional template for event announcements and launches",
      "features": ["Responsive Design", "Call-to-Action Button", "Social Links", "Branding"],
      "lastUsed": "2024-06-15",
      "usageCount": 12,
    },
    {
      "id": 2,
      "name": "Speaker Spotlight",
      "category": "Speaker",
      "preview": "https://picsum.photos/200/300?random=11&keyword=speaker",
      "description": "Elegant template for highlighting keynote speakers and presenters",
      "features": ["Speaker Photo", "Bio Section", "Social Media", "Session Details"],
      "lastUsed": "2024-06-12",
      "usageCount": 8,
    },
    {
      "id": 3,
      "name": "Registration Reminder",
      "category": "Reminder",
      "preview": "https://picsum.photos/200/300?random=12&keyword=reminder",
      "description": "Urgent design template for registration deadlines and reminders",
      "features": ["Countdown Timer", "Urgent Messaging", "Quick Registration", "Pricing"],
      "lastUsed": "2024-06-10",
      "usageCount": 15,
    },
    {
      "id": 4,
      "name": "Newsletter Update",
      "category": "Newsletter",
      "preview": "https://picsum.photos/200/300?random=13&keyword=newsletter",
      "description": "Clean template for regular updates and news distribution",
      "features": ["Article Sections", "Image Gallery", "Links", "Subscription"],
      "lastUsed": "2024-06-08",
      "usageCount": 6,
    },
    {
      "id": 5,
      "name": "Thank You Message",
      "category": "Thank You",
      "preview": "https://picsum.photos/200/300?random=14&keyword=gratitude",
      "description": "Warm template for expressing gratitude and appreciation",
      "features": ["Personal Touch", "Event Highlights", "Future Events", "Contact Info"],
      "lastUsed": "2024-06-05",
      "usageCount": 4,
    },
  ];

  List<String> campaignTypes = [
    "All", "Announcement", "Speaker Highlight", "Reminder", 
    "Update", "Sponsor Content", "Follow-up", "Information", "Thank You"
  ];

  List<Map<String, dynamic>> get filteredCampaigns {
    return campaigns.where((campaign) {
      bool matchesType = selectedCampaignType == "All" || campaign["type"] == selectedCampaignType;
      bool matchesSearch = searchQuery.isEmpty || 
          campaign["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          campaign["subject"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesType && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Email Campaigns",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Campaigns", icon: Icon(Icons.campaign)),
        Tab(text: "Templates", icon: Icon(Icons.email)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildCampaignsTab(),
        _buildTemplatesTab(),
        _buildAnalyticsTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildCampaignsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          _buildSearchAndFilters(),
          SizedBox(height: spMd),
          _buildCampaignStats(),
          SizedBox(height: spMd),
          _buildCampaignsList(),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create New Campaign",
              size: bs.md,
              onPressed: () {
                ss("Create new email campaign");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      children: [
        QTextField(
          label: "Search Campaigns",
          value: searchQuery,
          hint: "Enter campaign name or subject...",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        QCategoryPicker(
          label: "Campaign Type",
          items: campaignTypes.map((type) => {
            "label": type,
            "value": type,
          }).toList(),
          value: selectedCampaignType,
          onChanged: (index, label, value, item) {
            selectedCampaignType = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildCampaignStats() {
    int totalCampaigns = campaigns.length;
    int sentCampaigns = campaigns.where((c) => c["status"] == "Sent").length;
    int scheduledCampaigns = campaigns.where((c) => c["status"] == "Scheduled").length;
    double avgOpenRate = campaigns.where((c) => c["status"] == "Sent").fold(0.0, (sum, c) => sum + (c["openRate"] as double)) / sentCampaigns;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Total", "$totalCampaigns", primaryColor),
              ),
              Container(width: 1, height: 40, color: primaryColor.withAlpha(100)),
              Expanded(
                child: _buildStatCard("Sent", "$sentCampaigns", successColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Scheduled", "$scheduledCampaigns", warningColor),
              ),
              Container(width: 1, height: 40, color: primaryColor.withAlpha(100)),
              Expanded(
                child: _buildStatCard("Avg Open Rate", "${avgOpenRate.toStringAsFixed(1)}%", infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCampaignsList() {
    return Column(
      children: filteredCampaigns.map((campaign) {
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              _buildCampaignHeader(campaign),
              _buildCampaignContent(campaign),
              if (campaign["status"] == "Sent") _buildCampaignMetrics(campaign),
              _buildCampaignActions(campaign),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCampaignHeader(Map<String, dynamic> campaign) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: _getStatusColor(campaign["status"]).withAlpha(100),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusMd),
          topRight: Radius.circular(radiusMd),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${campaign["thumbnail"]}",
              width: 60,
              height: 40,
              fit: BoxFit.cover,
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
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    _buildHeaderBadge(campaign["type"]),
                    SizedBox(width: spXs),
                    _buildStatusBadge(campaign["status"]),
                  ],
                ),
              ],
            ),
          ),
          if (campaign["sentDate"].isNotEmpty)
            Text(
              "${campaign["sentDate"]}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withAlpha(200),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeaderBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(200),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 9,
          color: primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: _getStatusColor(status),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 9,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Sent":
        return successColor;
      case "Scheduled":
        return warningColor;
      case "Draft":
        return disabledColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildCampaignContent(Map<String, dynamic> campaign) {
    return Padding(
      padding: EdgeInsets.all(spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Subject: ${campaign["subject"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${campaign["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.people, color: infoColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${campaign["recipients"]} recipients",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: infoColor,
                ),
              ),
              Spacer(),
              Text(
                "Template: ${campaign["template"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if ((campaign["tags"] as List).isNotEmpty) ...[
            SizedBox(height: spSm),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (campaign["tags"] as List).map<Widget>((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: secondaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                    border: Border.all(color: secondaryColor.withAlpha(100)),
                  ),
                  child: Text(
                    "#$tag",
                    style: TextStyle(
                      fontSize: 10,
                      color: secondaryColor,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCampaignMetrics(Map<String, dynamic> campaign) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spSm),
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: successColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildMetricItem("Open Rate", "${campaign["openRate"]}%", successColor),
          ),
          Container(width: 1, height: 30, color: successColor.withAlpha(100)),
          Expanded(
            child: _buildMetricItem("Click Rate", "${campaign["clickRate"]}%", infoColor),
          ),
          Container(width: 1, height: 30, color: successColor.withAlpha(100)),
          Expanded(
            child: _buildMetricItem("Unsubscribe", "${campaign["unsubscribeRate"]}%", warningColor),
          ),
          Container(width: 1, height: 30, color: successColor.withAlpha(100)),
          Expanded(
            child: _buildMetricItem("Bounce", "${campaign["bounceRate"]}%", dangerColor),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
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

  Widget _buildCampaignActions(Map<String, dynamic> campaign) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(20),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radiusMd),
          bottomRight: Radius.circular(radiusMd),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "View",
              size: bs.sm,
              onPressed: () {
                ss("Viewing ${campaign["name"]}");
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Edit",
              size: bs.sm,
              onPressed: () {
                ss("Editing ${campaign["name"]}");
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: campaign["status"] == "Draft" ? "Send" : "Duplicate",
              size: bs.sm,
              onPressed: () {
                if (campaign["status"] == "Draft") {
                  ss("Sending ${campaign["name"]}");
                } else {
                  ss("Duplicating ${campaign["name"]}");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Email Templates",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Create Template",
                size: bs.sm,
                onPressed: () {
                  ss("Create new email template");
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: templates.map((template) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                      child: Image.network(
                        "${template["preview"]}",
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${template["name"]}",
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
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(color: infoColor.withAlpha(100)),
                                ),
                                child: Text(
                                  "${template["usageCount"]} uses",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${template["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: secondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${template["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Features:",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (template["features"] as List).map<Widget>((feature) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  feature,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: primaryColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Last used: ${template["lastUsed"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Preview",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Previewing ${template["name"]} template");
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Use Template",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Using ${template["name"]} template");
                                  },
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
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          _buildOverallPerformance(),
          SizedBox(height: spMd),
          _buildCampaignComparison(),
          SizedBox(height: spMd),
          _buildEngagementTrends(),
        ],
      ),
    );
  }

  Widget _buildOverallPerformance() {
    List<Map<String, dynamic>> sentCampaigns = campaigns.where((c) => c["status"] == "Sent").toList();
    double totalOpenRate = sentCampaigns.fold(0.0, (sum, c) => sum + (c["openRate"] as double)) / sentCampaigns.length;
    double totalClickRate = sentCampaigns.fold(0.0, (sum, c) => sum + (c["clickRate"] as double)) / sentCampaigns.length;
    double totalUnsubscribeRate = sentCampaigns.fold(0.0, (sum, c) => sum + (c["unsubscribeRate"] as double)) / sentCampaigns.length;
    int totalRecipients = sentCampaigns.fold(0, (sum, c) => sum + (c["recipients"] as int));

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
            "Overall Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildPerformanceCard("Total Recipients", "${(totalRecipients / 1000).toStringAsFixed(1)}K", primaryColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildPerformanceCard("Avg Open Rate", "${totalOpenRate.toStringAsFixed(1)}%", successColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildPerformanceCard("Avg Click Rate", "${totalClickRate.toStringAsFixed(1)}%", infoColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildPerformanceCard("Unsubscribe Rate", "${totalUnsubscribeRate.toStringAsFixed(1)}%", warningColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignComparison() {
    List<Map<String, dynamic>> topCampaigns = campaigns
        .where((c) => c["status"] == "Sent")
        .toList()
      ..sort((a, b) => (b["openRate"] as double).compareTo(a["openRate"] as double));

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
            "Top Performing Campaigns",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...topCampaigns.take(5).map((campaign) {
            return Container(
              margin: EdgeInsets.only(bottom: spXs),
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${campaign["name"]}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${campaign["type"]}",
                          style: TextStyle(
                            fontSize: 10,
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
                        "${campaign["openRate"]}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Open Rate",
                        style: TextStyle(
                          fontSize: 9,
                          color: disabledBoldColor,
                        ),
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

  Widget _buildEngagementTrends() {
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
            "Engagement Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            width: double.infinity,
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
                    size: 32,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Engagement Trends Chart",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          _buildSenderSettings(),
          SizedBox(height: spMd),
          _buildDefaultSettings(),
          SizedBox(height: spMd),
          _buildIntegrationSettings(),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Settings",
              size: bs.md,
              onPressed: () {
                ss("Email campaign settings saved");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSenderSettings() {
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
            "Sender Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "From Name",
            value: "Tech Summit 2024",
            onChanged: (value) {},
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "From Email",
            value: "noreply@techsummit2024.com",
            onChanged: (value) {},
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Reply-to Email",
            value: "support@techsummit2024.com",
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultSettings() {
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
            "Default Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Default Template",
            items: [
              {"label": "Event Announcement", "value": "announcement"},
              {"label": "Newsletter Update", "value": "newsletter"},
              {"label": "Registration Reminder", "value": "reminder"},
            ],
            value: "announcement",
            onChanged: (value, label) {},
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Send Time Zone",
            items: [
              {"label": "UTC", "value": "utc"},
              {"label": "PST (Pacific)", "value": "pst"},
              {"label": "EST (Eastern)", "value": "est"},
            ],
            value: "pst",
            onChanged: (value, label) {},
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
            "Integration Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          _buildIntegrationItem("MailChimp", "Connected", true),
          SizedBox(height: spSm),
          _buildIntegrationItem("SendGrid", "Not Connected", false),
          SizedBox(height: spSm),
          _buildIntegrationItem("Constant Contact", "Not Connected", false),
        ],
      ),
    );
  }

  Widget _buildIntegrationItem(String name, String status, bool isConnected) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isConnected ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isConnected ? successColor.withAlpha(50) : disabledColor.withAlpha(50),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isConnected ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isConnected ? successColor : disabledColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    color: isConnected ? successColor : disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: isConnected ? "Disconnect" : "Connect",
            size: bs.sm,
            onPressed: () {
              ss("${isConnected ? 'Disconnecting' : 'Connecting'} $name");
            },
          ),
        ],
      ),
    );
  }
}
