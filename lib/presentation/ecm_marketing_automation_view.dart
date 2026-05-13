import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmMarketingAutomationView extends StatefulWidget {
  const EcmMarketingAutomationView({super.key});

  @override
  State<EcmMarketingAutomationView> createState() => _EcmMarketingAutomationViewState();
}

class _EcmMarketingAutomationViewState extends State<EcmMarketingAutomationView> {
  bool automationEnabled = true;
  int selectedTab = 0;
  
  // Email Campaign Stats
  Map<String, dynamic> emailStats = {
    "totalCampaigns": 45,
    "activeCampaigns": 8,
    "totalSent": 125430,
    "openRate": 24.5,
    "clickRate": 3.2,
    "conversionRate": 1.8,
  };

  List<Map<String, dynamic>> automationTabs = [
    {"title": "Campaigns", "icon": Icons.campaign},
    {"title": "Workflows", "icon": Icons.account_tree},
    {"title": "Triggers", "icon": Icons.flash_on},
    {"title": "Analytics", "icon": Icons.analytics},
  ];

  List<Map<String, dynamic>> emailCampaigns = [
    {
      "name": "Welcome Series",
      "type": "Automated",
      "status": "Active",
      "sent": 2450,
      "openRate": 32.1,
      "clickRate": 4.8,
      "revenue": 15600.0,
      "lastRun": "2 hours ago",
      "nextRun": "Continuous",
      "icon": Icons.waving_hand,
      "color": "#4CAF50",
    },
    {
      "name": "Cart Abandonment",
      "type": "Triggered",
      "status": "Active",
      "sent": 890,
      "openRate": 28.3,
      "clickRate": 6.2,
      "revenue": 8750.0,
      "lastRun": "15 minutes ago",
      "nextRun": "As triggered",
      "icon": Icons.shopping_cart,
      "color": "#FF9800",
    },
    {
      "name": "Product Launch",
      "type": "Scheduled",
      "status": "Scheduled",
      "sent": 0,
      "openRate": 0.0,
      "clickRate": 0.0,
      "revenue": 0.0,
      "lastRun": "Not sent",
      "nextRun": "Tomorrow 9:00 AM",
      "icon": Icons.rocket_launch,
      "color": "#2196F3",
    },
    {
      "name": "Birthday Wishes",
      "type": "Automated",
      "status": "Active",
      "sent": 156,
      "openRate": 45.2,
      "clickRate": 8.9,
      "revenue": 2340.0,
      "lastRun": "1 day ago",
      "nextRun": "Daily at 10:00 AM",
      "icon": Icons.cake,
      "color": "#E91E63",
    },
    {
      "name": "Re-engagement",
      "type": "Automated",
      "status": "Paused",
      "sent": 1250,
      "openRate": 18.7,
      "clickRate": 2.1,
      "revenue": 3200.0,
      "lastRun": "3 days ago",
      "nextRun": "Paused",
      "icon": Icons.refresh,
      "color": "#757575",
    },
  ];

  List<Map<String, dynamic>> workflows = [
    {
      "name": "New Customer Onboarding",
      "steps": 5,
      "activeUsers": 245,
      "completionRate": 68.5,
      "status": "Active",
      "triggers": ["New account created"],
      "lastUpdated": "2 days ago",
    },
    {
      "name": "VIP Customer Journey",
      "steps": 8,
      "activeUsers": 89,
      "completionRate": 78.2,
      "status": "Active",
      "triggers": ["Purchase amount > \$500"],
      "lastUpdated": "1 week ago",
    },
    {
      "name": "Win-back Campaign",
      "steps": 3,
      "activeUsers": 567,
      "completionRate": 34.7,
      "status": "Active",
      "triggers": ["No purchase in 90 days"],
      "lastUpdated": "5 days ago",
    },
  ];

  List<Map<String, dynamic>> triggers = [
    {
      "name": "Purchase Completed",
      "description": "Trigger when customer completes a purchase",
      "campaigns": 8,
      "status": "Active",
      "icon": Icons.shopping_bag,
      "color": "#4CAF50",
    },
    {
      "name": "Cart Abandoned",
      "description": "Trigger 1 hour after cart abandonment",
      "campaigns": 3,
      "status": "Active",
      "icon": Icons.remove_shopping_cart,
      "color": "#FF9800",
    },
    {
      "name": "Account Created",
      "description": "Trigger immediately after account registration",
      "campaigns": 5,
      "status": "Active",
      "icon": Icons.person_add,
      "color": "#2196F3",
    },
    {
      "name": "Birthday Date",
      "description": "Trigger on customer's birthday",
      "campaigns": 2,
      "status": "Active",
      "icon": Icons.cake,
      "color": "#E91E63",
    },
    {
      "name": "Product Review",
      "description": "Trigger 7 days after product delivery",
      "campaigns": 4,
      "status": "Active",
      "icon": Icons.star_rate,
      "color": "#9C27B0",
    },
  ];

  Widget _buildStatsOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Marketing Overview",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard(
                "Total Campaigns",
                "${emailStats["totalCampaigns"]}",
                Icons.campaign,
                primaryColor,
              ),
              _buildStatCard(
                "Active Campaigns",
                "${emailStats["activeCampaigns"]}",
                Icons.play_circle,
                successColor,
              ),
              _buildStatCard(
                "Emails Sent",
                "${(emailStats["totalSent"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                Icons.mail,
                infoColor,
              ),
              _buildStatCard(
                "Open Rate",
                "${emailStats["openRate"]}%",
                Icons.mark_email_read,
                warningColor,
              ),
              _buildStatCard(
                "Click Rate",
                "${emailStats["clickRate"]}%",
                Icons.mouse,
                secondaryColor,
              ),
              _buildStatCard(
                "Conversion Rate",
                "${emailStats["conversionRate"]}%",
                Icons.trending_up,
                Color(0xFF9C27B0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Email Campaigns",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "Create Campaign",
              size: bs.sm,
              onPressed: () {
                si("Creating new email campaign...");
              },
            ),
          ],
        ),
        SizedBox(height: spMd),
        ...emailCampaigns.map((campaign) {
          final statusColor = campaign["status"] == "Active" ? successColor :
                            campaign["status"] == "Scheduled" ? infoColor :
                            campaign["status"] == "Paused" ? warningColor : dangerColor;
          
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border.all(color: statusColor.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(int.parse("0xFF${campaign["color"].substring(1)}")).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        campaign["icon"],
                        color: Color(int.parse("0xFF${campaign["color"].substring(1)}")),
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${campaign["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${campaign["status"]}",
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${campaign["type"]}",
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
                SizedBox(height: spMd),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildCampaignMetric("Sent", "${campaign["sent"]}", Icons.send),
                    _buildCampaignMetric("Open Rate", "${campaign["openRate"]}%", Icons.mark_email_read),
                    _buildCampaignMetric("Click Rate", "${campaign["clickRate"]}%", Icons.mouse),
                    _buildCampaignMetric("Revenue", "\$${((campaign["revenue"] as double)).currency}", Icons.attach_money),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Last Run: ${campaign["lastRun"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Next Run: ${campaign["nextRun"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            si("Editing ${campaign["name"]}...");
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: campaign["status"] == "Active" ? Icons.pause : Icons.play_arrow,
                          size: bs.sm,
                          onPressed: () {
                            if (campaign["status"] == "Active") {
                              si("Pausing ${campaign["name"]}...");
                            } else {
                              si("Starting ${campaign["name"]}...");
                            }
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.analytics,
                          size: bs.sm,
                          onPressed: () {
                            si("Viewing ${campaign["name"]} analytics...");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildCampaignMetric(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 14),
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

  Widget _buildWorkflowsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Automation Workflows",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "Create Workflow",
              size: bs.sm,
              onPressed: () {
                si("Creating new automation workflow...");
              },
            ),
          ],
        ),
        SizedBox(height: spMd),
        ...workflows.map((workflow) {
          final statusColor = workflow["status"] == "Active" ? successColor : warningColor;
          
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${workflow["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${workflow["status"]}",
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${workflow["steps"]} steps",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${workflow["activeUsers"]} active users",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${workflow["completionRate"]}% completion",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Triggers: ${(workflow["triggers"] as List<String>).join(", ")}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Last updated: ${workflow["lastUpdated"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: (workflow["completionRate"] as double) / 100,
                        backgroundColor: disabledColor.withAlpha(50),
                        valueColor: AlwaysStoppedAnimation<Color>(successColor),
                      ),
                    ),
                    SizedBox(width: spMd),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        si("Editing ${workflow["name"]}...");
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTriggersTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Automation Triggers",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Events that automatically start marketing campaigns",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: triggers.map((trigger) {
            final statusColor = trigger["status"] == "Active" ? successColor : disabledColor;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(color: statusColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(int.parse("0xFF${trigger["color"].substring(1)}")).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          trigger["icon"],
                          color: Color(int.parse("0xFF${trigger["color"].substring(1)}")),
                          size: 20,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${trigger["status"]}",
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${trigger["name"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${trigger["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${trigger["campaigns"]} campaigns using this trigger",
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Marketing Analytics",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Container(
          padding: EdgeInsets.all(spMd),
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
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.show_chart,
                        color: primaryColor,
                        size: 40,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Analytics Chart",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Campaign performance over time",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildAnalyticsCard("Revenue Generated", "\$45,230", "+12.5%", successColor),
            _buildAnalyticsCard("New Subscribers", "1,847", "+8.3%", primaryColor),
            _buildAnalyticsCard("Unsubscribe Rate", "2.1%", "-0.4%", successColor),
            _buildAnalyticsCard("Avg. Order Value", "\$89.50", "+5.2%", successColor),
          ],
        ),
      ],
    );
  }

  Widget _buildAnalyticsCard(String title, String value, String change, Color changeColor) {
    final isPositive = change.startsWith('+') || change.startsWith('-') && changeColor == successColor;
    
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
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: changeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      color: changeColor,
                      size: 12,
                    ),
                    Text(
                      change,
                      style: TextStyle(
                        color: changeColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
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
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildCampaignsTab();
      case 1:
        return _buildWorkflowsTab();
      case 2:
        return _buildTriggersTab();
      case 3:
        return _buildAnalyticsTab();
      default:
        return _buildCampaignsTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marketing Automation"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              si("Marketing automation settings");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Automation Toggle
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      automationEnabled ? Icons.auto_awesome : Icons.auto_awesome_outlined,
                      color: automationEnabled ? primaryColor : warningColor,
                      size: 30,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Marketing Automation",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: automationEnabled ? primaryColor : warningColor,
                            ),
                          ),
                          Text(
                            automationEnabled 
                                ? "Automated campaigns are running"
                                : "Marketing automation is disabled",
                            style: TextStyle(
                              fontSize: 12,
                              color: automationEnabled ? primaryColor : warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: automationEnabled,
                      onChanged: (value) {
                        automationEnabled = value;
                        setState(() {});
                        if (value) {
                          ss("Marketing automation enabled");
                        } else {
                          sw("Marketing automation disabled");
                        }
                      },
                      activeColor: primaryColor,
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                QHorizontalScroll(
                  children: List.generate(automationTabs.length, (index) {
                    final tab = automationTabs[index];
                    final isActive = index == selectedTab;
                    
                    return GestureDetector(
                      onTap: () {
                        selectedTab = index;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: spMd),
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: isActive ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isActive ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              tab["icon"],
                              color: isActive ? Colors.white : disabledBoldColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${tab["title"]}",
                              style: TextStyle(
                                color: isActive ? Colors.white : disabledBoldColor,
                                fontSize: 12,
                                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          
          // Stats Overview
          if (selectedTab == 0) ...[
            Container(
              padding: EdgeInsets.all(spMd),
              child: _buildStatsOverview(),
            ),
          ],
          
          // Tab Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildTabContent(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedTab == 0) {
            si("Creating quick email campaign...");
          } else if (selectedTab == 1) {
            si("Creating quick workflow...");
          } else {
            si("Quick automation setup...");
          }
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
