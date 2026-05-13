import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaEmailMarketingView extends StatefulWidget {
  const FmaEmailMarketingView({super.key});

  @override
  State<FmaEmailMarketingView> createState() => _FmaEmailMarketingViewState();
}

class _FmaEmailMarketingViewState extends State<FmaEmailMarketingView> {
  int currentTab = 0;
  
  // Campaign Management Variables
  String campaignName = "";
  String campaignSubject = "";
  String campaignContent = "";
  String selectedTemplate = "";
  String selectedSegment = "";
  String scheduleDate = "";
  String scheduleTime = "";
  bool isScheduled = false;
  
  // List Management Variables
  String listName = "";
  String listDescription = "";
  String importMethod = "manual";
  List<String> selectedTags = [];
  
  // Template Variables
  String templateName = "";
  String templateDescription = "";
  String templateHtml = "";
  String templateCategory = "promotional";
  
  // Automation Variables
  String automationName = "";
  String triggerType = "customer_signup";
  String delayAmount = "1";
  String delayUnit = "days";
  String automationTemplate = "";
  
  // Sample Data
  List<Map<String, dynamic>> campaigns = [
    {
      "id": 1,
      "name": "Weekly Menu Highlights",
      "subject": "This Week's Special Dishes",
      "status": "sent",
      "sent_date": "2024-06-15",
      "recipients": 2850,
      "open_rate": 34.2,
      "click_rate": 8.7,
      "revenue": 1250.00,
      "template": "menu_showcase"
    },
    {
      "id": 2,
      "name": "Summer Promotion",
      "subject": "Beat the Heat - 20% Off Cold Drinks",
      "status": "scheduled",
      "scheduled_date": "2024-06-20",
      "recipients": 3200,
      "open_rate": 0.0,
      "click_rate": 0.0,
      "revenue": 0.0,
      "template": "promotion"
    },
    {
      "id": 3,
      "name": "Customer Survey",
      "subject": "Help Us Serve You Better",
      "status": "draft",
      "recipients": 0,
      "open_rate": 0.0,
      "click_rate": 0.0,
      "revenue": 0.0,
      "template": "survey"
    },
    {
      "id": 4,
      "name": "New Location Opening",
      "subject": "We're Opening a New Branch!",
      "status": "sent",
      "sent_date": "2024-06-10",
      "recipients": 4100,
      "open_rate": 45.8,
      "click_rate": 12.3,
      "revenue": 2850.00,
      "template": "announcement"
    },
  ];

  List<Map<String, dynamic>> emailLists = [
    {
      "id": 1,
      "name": "All Customers",
      "subscribers": 4200,
      "active": 3850,
      "growth_rate": 12.5,
      "last_updated": "2024-06-18",
      "tags": ["general", "all"],
      "engagement": 42.3
    },
    {
      "id": 2,
      "name": "VIP Customers",
      "subscribers": 650,
      "active": 620,
      "growth_rate": 8.2,
      "last_updated": "2024-06-17",
      "tags": ["vip", "premium"],
      "engagement": 68.7
    },
    {
      "id": 3,
      "name": "Lunch Regulars",
      "subscribers": 1850,
      "active": 1720,
      "growth_rate": 15.3,
      "last_updated": "2024-06-18",
      "tags": ["lunch", "regular"],
      "engagement": 51.2
    },
    {
      "id": 4,
      "name": "Weekend Diners",
      "subscribers": 2100,
      "active": 1950,
      "growth_rate": 9.8,
      "last_updated": "2024-06-16",
      "tags": ["weekend", "casual"],
      "engagement": 38.9
    },
  ];

  List<Map<String, dynamic>> emailTemplates = [
    {
      "id": 1,
      "name": "Menu Showcase",
      "category": "promotional",
      "usage_count": 15,
      "last_used": "2024-06-15",
      "open_rate": 36.4,
      "click_rate": 9.2,
      "description": "Highlight featured menu items"
    },
    {
      "id": 2,
      "name": "Welcome Series",
      "category": "automation",
      "usage_count": 8,
      "last_used": "2024-06-12",
      "open_rate": 52.1,
      "click_rate": 15.7,
      "description": "New customer welcome sequence"
    },
    {
      "id": 3,
      "name": "Promotion Alert",
      "category": "promotional",
      "usage_count": 22,
      "last_used": "2024-06-18",
      "open_rate": 41.8,
      "click_rate": 11.3,
      "description": "Special offers and discounts"
    },
    {
      "id": 4,
      "name": "Event Invitation",
      "category": "event",
      "usage_count": 6,
      "last_used": "2024-06-08",
      "open_rate": 58.3,
      "click_rate": 18.9,
      "description": "Special events and tastings"
    },
  ];

  List<Map<String, dynamic>> automationRules = [
    {
      "id": 1,
      "name": "Welcome Series",
      "trigger": "Customer Signup",
      "status": "active",
      "emails_sent": 127,
      "conversion_rate": 23.6,
      "revenue": 890.50,
      "last_triggered": "2024-06-18",
      "sequence_count": 3
    },
    {
      "id": 2,
      "name": "Birthday Greetings",
      "trigger": "Customer Birthday",
      "status": "active",
      "emails_sent": 45,
      "conversion_rate": 18.2,
      "revenue": 320.75,
      "last_triggered": "2024-06-17",
      "sequence_count": 1
    },
    {
      "id": 3,
      "name": "Win-Back Campaign",
      "trigger": "30 Days Inactive",
      "status": "paused",
      "emails_sent": 89,
      "conversion_rate": 12.4,
      "revenue": 450.25,
      "last_triggered": "2024-06-10",
      "sequence_count": 2
    },
    {
      "id": 4,
      "name": "Order Follow-up",
      "trigger": "Order Completed",
      "status": "active",
      "emails_sent": 203,
      "conversion_rate": 31.8,
      "revenue": 1250.00,
      "last_triggered": "2024-06-18",
      "sequence_count": 2
    },
  ];

  List<Map<String, dynamic>> campaignTemplates = [
    {"label": "Menu Showcase", "value": "menu_showcase"},
    {"label": "Promotion Alert", "value": "promotion"},
    {"label": "Welcome Email", "value": "welcome"},
    {"label": "Event Invitation", "value": "event"},
    {"label": "Survey Request", "value": "survey"},
    {"label": "Newsletter", "value": "newsletter"},
  ];

  List<Map<String, dynamic>> segmentOptions = [
    {"label": "All Customers", "value": "all"},
    {"label": "VIP Customers", "value": "vip"},
    {"label": "Lunch Regulars", "value": "lunch"},
    {"label": "Weekend Diners", "value": "weekend"},
    {"label": "New Customers", "value": "new"},
    {"label": "Inactive Customers", "value": "inactive"},
  ];

  List<Map<String, dynamic>> importOptions = [
    {"label": "Manual Entry", "value": "manual"},
    {"label": "CSV Upload", "value": "csv"},
    {"label": "CRM Integration", "value": "crm"},
    {"label": "POS Integration", "value": "pos"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Promotional", "value": "promotional"},
    {"label": "Automation", "value": "automation"},
    {"label": "Event", "value": "event"},
    {"label": "Newsletter", "value": "newsletter"},
    {"label": "Survey", "value": "survey"},
    {"label": "Announcement", "value": "announcement"},
  ];

  List<Map<String, dynamic>> triggerOptions = [
    {"label": "Customer Signup", "value": "customer_signup"},
    {"label": "Order Completed", "value": "order_completed"},
    {"label": "Customer Birthday", "value": "customer_birthday"},
    {"label": "30 Days Inactive", "value": "inactive_30"},
    {"label": "VIP Status Achieved", "value": "vip_achieved"},
    {"label": "Cart Abandoned", "value": "cart_abandoned"},
  ];

  List<Map<String, dynamic>> delayUnits = [
    {"label": "Minutes", "value": "minutes"},
    {"label": "Hours", "value": "hours"},
    {"label": "Days", "value": "days"},
    {"label": "Weeks", "value": "weeks"},
  ];

  void _sendCampaign() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Campaign sent successfully to ${(segmentOptions.firstWhere((s) => s["value"] == selectedSegment)["label"])}");
    
    // Reset form
    campaignName = "";
    campaignSubject = "";
    campaignContent = "";
    selectedTemplate = "";
    selectedSegment = "";
    scheduleDate = "";
    scheduleTime = "";
    isScheduled = false;
    setState(() {});
  }

  void _createList() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Email list '${listName}' created successfully");
    
    // Reset form
    listName = "";
    listDescription = "";
    importMethod = "manual";
    selectedTags = [];
    setState(() {});
  }

  void _saveTemplate() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Email template '${templateName}' saved successfully");
    
    // Reset form
    templateName = "";
    templateDescription = "";
    templateHtml = "";
    templateCategory = "promotional";
    setState(() {});
  }

  void _createAutomation() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Email automation '${automationName}' created successfully");
    
    // Reset form
    automationName = "";
    triggerType = "customer_signup";
    delayAmount = "1";
    delayUnit = "days";
    automationTemplate = "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Email Marketing",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Campaigns", icon: Icon(Icons.campaign)),
        Tab(text: "Lists", icon: Icon(Icons.list)),
        Tab(text: "Templates", icon: Icon(Icons.design_services)),
        Tab(text: "Automation", icon: Icon(Icons.auto_awesome)),
      ],
      tabChildren: [
        _buildCampaignsTab(),
        _buildListsTab(),
        _buildTemplatesTab(),
        _buildAutomationTab(),
      ],
    );
  }

  Widget _buildCampaignsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Campaign Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Campaigns", "${campaigns.length}", Icons.campaign, primaryColor),
              _buildStatCard("Total Sent", "${campaigns.fold(0, (sum, c) => sum + (c["recipients"] as int))}", Icons.send, successColor),
              _buildStatCard("Avg. Open Rate", "${(campaigns.fold(0.0, (sum, c) => sum + (c["open_rate"] as double)) / campaigns.length).toStringAsFixed(1)}%", Icons.mark_email_read, infoColor),
              _buildStatCard("Total Revenue", "\$${(campaigns.fold(0.0, (sum, c) => sum + (c["revenue"] as double))).currency}", Icons.attach_money, warningColor),
            ],
          ),

          // Create Campaign Form
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Create New Campaign",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Campaign Name",
                        value: campaignName,
                        hint: "Enter campaign name",
                        onChanged: (value) {
                          campaignName = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Email Subject",
                        value: campaignSubject,
                        hint: "Enter email subject",
                        onChanged: (value) {
                          campaignSubject = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Template",
                        items: campaignTemplates,
                        value: selectedTemplate,
                        onChanged: (value, label) {
                          selectedTemplate = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Audience Segment",
                        items: segmentOptions,
                        value: selectedSegment,
                        onChanged: (value, label) {
                          selectedSegment = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Email Content",
                  value: campaignContent,
                  hint: "Enter email content or preview will be loaded from template",
                  onChanged: (value) {
                    campaignContent = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Schedule for later",
                            "value": true,
                            "checked": isScheduled,
                          }
                        ],
                        value: [
                          if (isScheduled)
                            {
                              "label": "Schedule for later",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          isScheduled = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                if (isScheduled) ...[
                  Row(
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: "Schedule Date",
                          value: scheduleDate.isNotEmpty 
                              ? DateTime.parse(scheduleDate) 
                              : DateTime.now(),
                          onChanged: (value) {
                            scheduleDate = value.toString().split(' ')[0];
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTimePicker(
                          label: "Schedule Time",
                          value: scheduleTime.isNotEmpty 
                              ? scheduleTime.timeOfDay 
                              : TimeOfDay.now(),
                          onChanged: (value) {
                            scheduleTime = value!.kkmm;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: isScheduled ? "Schedule Campaign" : "Send Now",
                        icon: isScheduled ? Icons.schedule : Icons.send,
                        onPressed: _sendCampaign,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Campaigns List
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Recent Campaigns",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...campaigns.map((campaign) {
                  Color statusColor = campaign["status"] == "sent" 
                      ? successColor 
                      : campaign["status"] == "scheduled"
                          ? warningColor 
                          : disabledBoldColor;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
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
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${campaign["status"]}".toUpperCase(),
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Text(
                          "${campaign["subject"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Recipients: ${(campaign["recipients"] as int).toString()}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                            ),
                            if (campaign["status"] == "sent") ...[
                              Text(
                                "Open: ${(campaign["open_rate"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Click: ${(campaign["click_rate"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "\$${(campaign["revenue"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),

                        Row(
                          children: [
                            Spacer(),
                            QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () => si("Campaign details: ${campaign["name"]}"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.copy,
                              size: bs.sm,
                              onPressed: () => si("Campaign duplicated"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // List Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Lists", "${emailLists.length}", Icons.list, primaryColor),
              _buildStatCard("Total Subscribers", "${emailLists.fold(0, (sum, l) => sum + (l["subscribers"] as int))}", Icons.people, successColor),
              _buildStatCard("Active Subscribers", "${emailLists.fold(0, (sum, l) => sum + (l["active"] as int))}", Icons.person_outline, infoColor),
              _buildStatCard("Avg. Engagement", "${(emailLists.fold(0.0, (sum, l) => sum + (l["engagement"] as double)) / emailLists.length).toStringAsFixed(1)}%", Icons.trending_up, warningColor),
            ],
          ),

          // Create List Form
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Create New Email List",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "List Name",
                        value: listName,
                        hint: "Enter list name",
                        onChanged: (value) {
                          listName = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Import Method",
                        items: importOptions,
                        value: importMethod,
                        onChanged: (value, label) {
                          importMethod = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "List Description",
                  value: listDescription,
                  hint: "Describe the purpose of this list",
                  onChanged: (value) {
                    listDescription = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Create List",
                        icon: Icons.add,
                        onPressed: _createList,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Email Lists
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Email Lists",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...emailLists.map((list) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${list["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              "${(list["engagement"] as double).toStringAsFixed(1)}% engaged",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.people, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${(list["subscribers"] as int).toString()} subscribers",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.trending_up, size: 16, color: successColor),
                            SizedBox(width: spXs),
                            Text(
                              "+${(list["growth_rate"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        Wrap(
                          spacing: spXs,
                          children: (list["tags"] as List).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${tag}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        Row(
                          children: [
                            Spacer(),
                            QButton(
                              label: "Manage",
                              size: bs.sm,
                              onPressed: () => si("Managing list: ${list["name"]}"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.download,
                              size: bs.sm,
                              onPressed: () => si("Exporting list data"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
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
        spacing: spMd,
        children: [
          // Template Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Templates", "${emailTemplates.length}", Icons.design_services, primaryColor),
              _buildStatCard("Most Used", "${emailTemplates.map((t) => t["usage_count"] as int).reduce((a, b) => a > b ? a : b)} times", Icons.star, successColor),
              _buildStatCard("Avg. Open Rate", "${(emailTemplates.fold(0.0, (sum, t) => sum + (t["open_rate"] as double)) / emailTemplates.length).toStringAsFixed(1)}%", Icons.mark_email_read, infoColor),
              _buildStatCard("Avg. Click Rate", "${(emailTemplates.fold(0.0, (sum, t) => sum + (t["click_rate"] as double)) / emailTemplates.length).toStringAsFixed(1)}%", Icons.mouse, warningColor),
            ],
          ),

          // Create Template Form
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Create New Template",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Template Name",
                        value: templateName,
                        hint: "Enter template name",
                        onChanged: (value) {
                          templateName = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryOptions,
                        value: templateCategory,
                        onChanged: (value, label) {
                          templateCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Template Description",
                  value: templateDescription,
                  hint: "Describe the template purpose",
                  onChanged: (value) {
                    templateDescription = value;
                    setState(() {});
                  },
                ),

                QMemoField(
                  label: "HTML Content",
                  value: templateHtml,
                  hint: "Enter HTML content or use visual editor",
                  onChanged: (value) {
                    templateHtml = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Save Template",
                        icon: Icons.save,
                        onPressed: _saveTemplate,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Preview",
                        icon: Icons.visibility,
                        onPressed: () => si("Template preview opened"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Email Templates
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Email Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: emailTemplates.map((template) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${template["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${template["category"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          Text(
                            "${template["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),

                          Row(
                            children: [
                              Icon(Icons.bar_chart, size: 12, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${(template["usage_count"] as int).toString()} uses",
                                style: TextStyle(fontSize: 11, color: disabledBoldColor),
                              ),
                              Spacer(),
                              Text(
                                "${(template["open_rate"] as double).toStringAsFixed(1)}% open",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Use",
                                  size: bs.sm,
                                  onPressed: () => si("Using template: ${template["name"]}"),
                                ),
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () => si("Editing template"),
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
          ),
        ],
      ),
    );
  }

  Widget _buildAutomationTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Automation Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Active Rules", "${automationRules.where((r) => r["status"] == "active").length}", Icons.auto_awesome, primaryColor),
              _buildStatCard("Emails Sent", "${automationRules.fold(0, (sum, r) => sum + (r["emails_sent"] as int))}", Icons.send, successColor),
              _buildStatCard("Avg. Conversion", "${(automationRules.fold(0.0, (sum, r) => sum + (r["conversion_rate"] as double)) / automationRules.length).toStringAsFixed(1)}%", Icons.trending_up, infoColor),
              _buildStatCard("Total Revenue", "\$${(automationRules.fold(0.0, (sum, r) => sum + (r["revenue"] as double))).currency}", Icons.attach_money, warningColor),
            ],
          ),

          // Create Automation Form
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Create Email Automation",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Automation Name",
                        value: automationName,
                        hint: "Enter automation name",
                        onChanged: (value) {
                          automationName = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Trigger Event",
                        items: triggerOptions,
                        value: triggerType,
                        onChanged: (value, label) {
                          triggerType = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: QNumberField(
                        label: "Delay",
                        value: delayAmount,
                        onChanged: (value) {
                          delayAmount = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      flex: 2,
                      child: QDropdownField(
                        label: "Time Unit",
                        items: delayUnits,
                        value: delayUnit,
                        onChanged: (value, label) {
                          delayUnit = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      flex: 2,
                      child: QDropdownField(
                        label: "Email Template",
                        items: campaignTemplates,
                        value: automationTemplate,
                        onChanged: (value, label) {
                          automationTemplate = value;
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
                        label: "Create Automation",
                        icon: Icons.auto_awesome,
                        onPressed: _createAutomation,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Automation Rules
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Email Automation Rules",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...automationRules.map((rule) {
                  Color statusColor = rule["status"] == "active" 
                      ? successColor 
                      : rule["status"] == "paused"
                          ? warningColor 
                          : disabledBoldColor;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${rule["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${rule["status"]}".toUpperCase(),
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Text(
                          "Trigger: ${rule["trigger"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),

                        Row(
                          children: [
                            Icon(Icons.send, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${(rule["emails_sent"] as int).toString()} sent",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.trending_up, size: 16, color: successColor),
                            SizedBox(width: spXs),
                            Text(
                              "${(rule["conversion_rate"] as double).toStringAsFixed(1)}% conversion",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${(rule["revenue"] as double).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Spacer(),
                            QButton(
                              label: rule["status"] == "active" ? "Pause" : "Activate",
                              size: bs.sm,
                              onPressed: () => si("${rule["status"] == "active" ? "Paused" : "Activated"} automation"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.edit,
                              size: bs.sm,
                              onPressed: () => si("Editing automation: ${rule["name"]}"),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.analytics,
                              size: bs.sm,
                              onPressed: () => si("Viewing automation analytics"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
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
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
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
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
