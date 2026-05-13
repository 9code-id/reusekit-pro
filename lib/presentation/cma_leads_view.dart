import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaLeadsView extends StatefulWidget {
  const CmaLeadsView({super.key});

  @override
  State<CmaLeadsView> createState() => _CmaLeadsViewState();
}

class _CmaLeadsViewState extends State<CmaLeadsView> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Leads Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Pipeline", icon: Icon(Icons.trending_up)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Activities", icon: Icon(Icons.history)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildPipelineTab(),
        _buildAnalyticsTab(),
        _buildActivitiesTab(),
        _buildSettingsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }

  Widget _buildPipelineTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildPipelineStats(),
          _buildLeadStages(),
          _buildQuickActions(),
          _buildRecentLeads(),
        ],
      ),
    );
  }

  Widget _buildPipelineStats() {
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
            "Pipeline Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard("Total Leads", "1,245", primaryColor),
              _buildStatCard("Hot Leads", "156", dangerColor),
              _buildStatCard("Converted", "89", successColor),
              _buildStatCard("This Month", "234", warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadStages() {
    List<Map<String, dynamic>> stages = [
      {
        "name": "New Leads",
        "count": 89,
        "value": 125000,
        "color": infoColor,
        "icon": Icons.new_releases
      },
      {
        "name": "Qualified",
        "count": 67,
        "value": 195000,
        "color": warningColor,
        "icon": Icons.verified
      },
      {
        "name": "Proposal",
        "count": 45,
        "value": 245000,
        "color": primaryColor,
        "icon": Icons.description
      },
      {
        "name": "Negotiation",
        "count": 23,
        "value": 178000,
        "color": dangerColor,
        "icon": Icons.handshake
      },
      {
        "name": "Closed Won",
        "count": 89,
        "value": 456000,
        "color": successColor,
        "icon": Icons.check_circle
      }
    ];

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
            "Sales Pipeline",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ...stages.map((stage) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: (stage["color"] as Color).withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: stage["color"],
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: (stage["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      stage["icon"],
                      color: stage["color"],
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${stage["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${stage["count"]} leads • \$${((stage["value"] as int).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: disabledColor,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    List<Map<String, dynamic>> actions = [
      {
        "title": "Add New Lead",
        "icon": Icons.person_add,
        "color": primaryColor,
        "action": "add_lead"
      },
      {
        "title": "Import Leads",
        "icon": Icons.file_upload,
        "color": infoColor,
        "action": "import_leads"
      },
      {
        "title": "Lead Scoring",
        "icon": Icons.star,
        "color": warningColor,
        "action": "lead_scoring"
      },
      {
        "title": "Follow Up Tasks",
        "icon": Icons.task,
        "color": successColor,
        "action": "follow_up"
      }
    ];

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
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: actions.map((action) {
              return GestureDetector(
                onTap: () {
                  _handleQuickAction(action["action"]);
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: (action["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: action["color"],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          action["icon"],
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${action["title"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: action["color"],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentLeads() {
    List<Map<String, dynamic>> recentLeads = [
      {
        "name": "Sarah Johnson",
        "company": "Tech Solutions Inc",
        "email": "sarah.j@techsolutions.com",
        "phone": "+1 (555) 123-4567",
        "stage": "Qualified",
        "score": 85,
        "value": 45000,
        "source": "Website",
        "date": "2024-12-18"
      },
      {
        "name": "Mike Chen",
        "company": "Digital Marketing Pro",
        "email": "mike@digitalmp.com",
        "phone": "+1 (555) 234-5678",
        "stage": "Proposal",
        "score": 92,
        "value": 78000,
        "source": "LinkedIn",
        "date": "2024-12-17"
      },
      {
        "name": "Emily Rodriguez",
        "company": "Creative Agency",
        "email": "emily@creativeagency.com",
        "phone": "+1 (555) 345-6789",
        "stage": "New Lead",
        "score": 67,
        "value": 32000,
        "source": "Referral",
        "date": "2024-12-16"
      }
    ];

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Leads",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  //navigateTo('CmaLeadListView')
                },
                child: Text("View All"),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...recentLeads.map((lead) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: primaryColor.withAlpha(20),
                    child: Text(
                      "${lead["name"].toString().split(' ').map((n) => n[0]).join('')}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${lead["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "${lead["company"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              "Score: ${lead["score"]} • ",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledColor,
                              ),
                            ),
                            Text(
                              "\$${((lead["value"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 10,
                                color: successColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getStageColor(lead["stage"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${lead["stage"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: _getStageColor(lead["stage"]),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
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
          _buildConversionMetrics(),
          _buildSourceAnalysis(),
          _buildPerformanceTrends(),
        ],
      ),
    );
  }

  Widget _buildConversionMetrics() {
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
            "Conversion Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMetricCard("Conversion Rate", "18.5%", successColor),
              _buildMetricCard("Avg. Deal Size", "\$52K", primaryColor),
              _buildMetricCard("Sales Cycle", "34 days", warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSourceAnalysis() {
    List<Map<String, dynamic>> sources = [
      {"source": "Website", "leads": 345, "percentage": 35},
      {"source": "LinkedIn", "leads": 234, "percentage": 24},
      {"source": "Referrals", "leads": 189, "percentage": 19},
      {"source": "Email Campaign", "leads": 156, "percentage": 16},
      {"source": "Trade Shows", "leads": 61, "percentage": 6},
    ];

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
            "Lead Sources",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ...sources.map((source) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "${source["source"]}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${source["leads"]} leads",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "${source["percentage"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        LinearProgressIndicator(
                          value: (source["percentage"] as int) / 100,
                          backgroundColor: Colors.grey.withAlpha(30),
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPerformanceTrends() {
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
            "Performance Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.trending_up, size: 48, color: primaryColor),
                  SizedBox(height: spSm),
                  Text(
                    "Performance Chart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Chart visualization will be displayed here",
                    style: TextStyle(
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

  Widget _buildActivitiesTab() {
    List<Map<String, dynamic>> activities = [
      {
        "type": "call",
        "title": "Follow-up Call",
        "lead": "Sarah Johnson",
        "description": "Discussed pricing and timeline",
        "date": "2024-12-18 14:30",
        "icon": Icons.phone,
        "color": Colors.green
      },
      {
        "type": "email",
        "title": "Proposal Sent",
        "lead": "Mike Chen",
        "description": "Sent detailed proposal for digital marketing package",
        "date": "2024-12-18 11:15",
        "icon": Icons.email,
        "color": Colors.blue
      },
      {
        "type": "meeting",
        "title": "Demo Meeting",
        "lead": "Emily Rodriguez",
        "description": "Product demonstration scheduled",
        "date": "2024-12-17 16:00",
        "icon": Icons.event,
        "color": Colors.orange
      },
      {
        "type": "note",
        "title": "Lead Updated",
        "lead": "David Kim",
        "description": "Updated lead score and qualification status",
        "date": "2024-12-17 09:30",
        "icon": Icons.note,
        "color": Colors.purple
      }
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Container(
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
              "Recent Activities",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ...activities.map((activity) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      width: 3,
                      color: activity["color"],
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: (activity["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        activity["icon"],
                        size: 16,
                        color: activity["color"],
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
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Lead: ${activity["lead"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${activity["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${DateTime.parse(activity["date"]).dMMMykkss}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildLeadScoringSettings(),
          _buildPipelineSettings(),
          _buildNotificationSettings(),
        ],
      ),
    );
  }

  Widget _buildLeadScoringSettings() {
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
            "Lead Scoring Rules",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          _buildScoringRule("Email Opened", "+5 points"),
          _buildScoringRule("Website Visit", "+10 points"),
          _buildScoringRule("Downloaded Content", "+15 points"),
          _buildScoringRule("Requested Demo", "+25 points"),
          _buildScoringRule("Replied to Email", "+20 points"),
          SizedBox(height: spSm),
          QButton(
            label: "Customize Scoring",
            size: bs.sm,
            onPressed: () {
              si("Lead scoring customization opened");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScoringRule(String action, String points) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            action,
            style: TextStyle(fontSize: 14),
          ),
          Text(
            points,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineSettings() {
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
            "Pipeline Configuration",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          QButton(
            label: "Manage Pipeline Stages",
            size: bs.sm,
            onPressed: () {
              si("Pipeline stage manager opened");
            },
          ),
          SizedBox(height: spSm),
          QButton(
            label: "Set Stage Automations",
            size: bs.sm,
            onPressed: () {
              si("Stage automation settings opened");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
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
            "Notification Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          CheckboxListTile(
            title: Text("New Lead Notifications"),
            value: true,
            onChanged: (value) {},
          ),
          CheckboxListTile(
            title: Text("Stage Change Alerts"),
            value: true,
            onChanged: (value) {},
          ),
          CheckboxListTile(
            title: Text("Follow-up Reminders"),
            value: false,
            onChanged: (value) {},
          ),
          CheckboxListTile(
            title: Text("Weekly Reports"),
            value: true,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Color _getStageColor(String stage) {
    switch (stage.toLowerCase()) {
      case "new lead":
        return infoColor;
      case "qualified":
        return warningColor;
      case "proposal":
        return primaryColor;
      case "negotiation":
        return dangerColor;
      case "closed won":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case "add_lead":
        //navigateTo('CmaAddContactView')
        break;
      case "import_leads":
        //navigateTo('CmaContactImportView')
        break;
      case "lead_scoring":
        si("Lead scoring configuration opened");
        break;
      case "follow_up":
        si("Follow-up task manager opened");
        break;
    }
  }
}
