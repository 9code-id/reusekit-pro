import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmCommunicationHubView extends StatefulWidget {
  const CrmCommunicationHubView({super.key});

  @override
  State<CrmCommunicationHubView> createState() => _CrmCommunicationHubViewState();
}

class _CrmCommunicationHubViewState extends State<CrmCommunicationHubView> {
  int selectedIndex = 0;
  bool loading = false;

  List<Map<String, dynamic>> communicationChannels = [
    {
      "type": "email",
      "title": "Email Center",
      "description": "Manage email campaigns and templates",
      "icon": Icons.email,
      "color": primaryColor,
      "total_sent": 12450,
      "pending": 234,
      "success_rate": 94.5,
      "last_activity": "2 minutes ago"
    },
    {
      "type": "sms",
      "title": "SMS Center",
      "description": "Send bulk SMS and manage campaigns",
      "icon": Icons.sms,
      "color": successColor,
      "total_sent": 8923,
      "pending": 56,
      "success_rate": 98.2,
      "last_activity": "15 minutes ago"
    },
    {
      "type": "call",
      "title": "Call Center",
      "description": "Manage calls and call campaigns",
      "icon": Icons.phone,
      "color": infoColor,
      "total_sent": 3456,
      "pending": 12,
      "success_rate": 87.3,
      "last_activity": "1 hour ago"
    },
    {
      "type": "social",
      "title": "Social Media",
      "description": "Connect with contacts on social platforms",
      "icon": Icons.share,
      "color": warningColor,
      "total_sent": 1890,
      "pending": 45,
      "success_rate": 76.8,
      "last_activity": "3 hours ago"
    }
  ];

  List<Map<String, dynamic>> recentCommunications = [
    {
      "id": "1",
      "type": "email",
      "subject": "Welcome to our service",
      "recipient": "john.doe@example.com",
      "status": "delivered",
      "timestamp": "2024-06-19T10:30:00",
      "open_rate": 85.2,
      "click_rate": 12.4
    },
    {
      "id": "2",
      "type": "sms",
      "subject": "Appointment reminder",
      "recipient": "+1 (555) 0123",
      "status": "delivered",
      "timestamp": "2024-06-19T09:15:00",
      "read_rate": 92.1
    },
    {
      "id": "3",
      "type": "call",
      "subject": "Follow-up call",
      "recipient": "Sarah Wilson",
      "status": "completed",
      "timestamp": "2024-06-19T08:45:00",
      "duration": "12:34"
    },
    {
      "id": "4",
      "type": "email",
      "subject": "Product update notification",
      "recipient": "team@company.com",
      "status": "bounced",
      "timestamp": "2024-06-18T16:20:00",
      "bounce_reason": "Invalid email address"
    }
  ];

  List<Map<String, dynamic>> templates = [
    {
      "id": "1",
      "type": "email",
      "name": "Welcome Email",
      "description": "Welcome message for new customers",
      "usage_count": 1245,
      "last_used": "2024-06-19T10:30:00"
    },
    {
      "id": "2",
      "type": "sms",
      "name": "Appointment Reminder",
      "description": "SMS reminder for upcoming appointments",
      "usage_count": 892,
      "last_used": "2024-06-19T09:15:00"
    },
    {
      "id": "3",
      "type": "email",
      "name": "Follow-up Email",
      "description": "Follow-up message for prospects",
      "usage_count": 567,
      "last_used": "2024-06-18T15:45:00"
    },
    {
      "id": "4",
      "type": "call",
      "name": "Sales Call Script",
      "description": "Script for initial sales calls",
      "usage_count": 234,
      "last_used": "2024-06-18T11:20:00"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Communication Hub",
      selectedIndex: selectedIndex,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Channels", icon: Icon(Icons.chat)),
        Tab(text: "Templates", icon: Icon(Icons.description)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildChannelsTab(),
        _buildTemplatesTab(),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildStatCard("Total Sent", "24,719", primaryColor, Icons.send),
              _buildStatCard("Pending", "347", warningColor, Icons.schedule),
              _buildStatCard("Success Rate", "92.3%", successColor, Icons.check_circle),
              _buildStatCard("Active Templates", "${templates.length}", infoColor, Icons.description),
            ],
          ),

          // Communication Channels Quick Access
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
                  "Communication Channels",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...communicationChannels.map((channel) => _buildChannelQuickCard(channel)),
              ],
            ),
          ),

          // Recent Communications
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
                Row(
                  children: [
                    Text(
                      "Recent Communications",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('CrmCommunicationHistoryView');
                      },
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...recentCommunications.take(5).map((comm) => _buildRecentCommCard(comm)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ...communicationChannels.map((channel) => _buildChannelCard(channel)),
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
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search templates...",
                  value: "",
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  _showCreateTemplateDialog();
                },
              ),
            ],
          ),
          ...templates.map((template) => _buildTemplateCard(template)),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Performance Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: [
              _buildMetricCard("Email Open Rate", "68.5%", successColor, Icons.email),
              _buildMetricCard("SMS Read Rate", "94.2%", infoColor, Icons.sms),
              _buildMetricCard("Call Connection", "78.9%", warningColor, Icons.phone),
              _buildMetricCard("Overall Engagement", "80.8%", primaryColor, Icons.trending_up),
            ],
          ),

          // Channel Performance Chart
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
                  "Channel Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...communicationChannels.map((channel) => _buildPerformanceBar(channel)),
              ],
            ),
          ),

          // Time-based Analytics
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
                  "Best Time to Communicate",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                _buildTimeAnalytics(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
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
                value,
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelQuickCard(Map<String, dynamic> channel) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (channel["color"] as Color).withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (channel["color"] as Color).withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(
            channel["icon"] as IconData,
            color: channel["color"] as Color,
            size: 24,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${channel["title"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${channel["pending"]} pending",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Open",
            size: bs.sm,
            onPressed: () {
              _openChannel("${channel["type"]}");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChannelCard(Map<String, dynamic> channel) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: channel["color"] as Color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                channel["icon"] as IconData,
                color: channel["color"] as Color,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${channel["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${channel["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 100,
            children: [
              _buildChannelStat("Total Sent", "${channel["total_sent"]}", Icons.send),
              _buildChannelStat("Pending", "${channel["pending"]}", Icons.schedule),
              _buildChannelStat("Success Rate", "${channel["success_rate"]}%", Icons.check_circle),
              _buildChannelStat("Last Activity", "${channel["last_activity"]}", Icons.access_time),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Open ${channel["title"]}",
                  size: bs.sm,
                  onPressed: () {
                    _openChannel("${channel["type"]}");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.settings,
                size: bs.sm,
                onPressed: () {
                  _showChannelSettings("${channel["type"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChannelStat(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      child: Column(
        children: [
          Icon(icon, size: 16, color: disabledBoldColor),
          SizedBox(height: spXs),
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

  Widget _buildRecentCommCard(Map<String, dynamic> comm) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: _getCommTypeColor("${comm["type"]}").withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: _getCommTypeColor("${comm["type"]}").withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(
            _getCommTypeIcon("${comm["type"]}"),
            color: _getCommTypeColor("${comm["type"]}"),
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${comm["subject"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${comm["recipient"]} • ${_formatTimestamp("${comm["timestamp"]}")}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
            decoration: BoxDecoration(
              color: _getStatusColor("${comm["status"]}").withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${comm["status"]}".toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: _getStatusColor("${comm["status"]}"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getCommTypeColor("${template["type"]}"),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getCommTypeIcon("${template["type"]}"),
                color: _getCommTypeColor("${template["type"]}"),
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${template["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${template["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCommTypeColor("${template["type"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${template["type"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getCommTypeColor("${template["type"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.trending_up, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Used ${template["usage_count"]} times",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Last used ${_formatTimestamp("${template["last_used"]}")}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Use Template",
                  size: bs.sm,
                  onPressed: () {
                    _useTemplate(template);
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  _editTemplate(template);
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showTemplateOptions(template);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
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
                value,
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceBar(Map<String, dynamic> channel) {
    final successRate = (channel["success_rate"] as double) / 100;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                channel["icon"] as IconData,
                color: channel["color"] as Color,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${channel["title"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${channel["success_rate"]}%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: channel["color"] as Color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: successRate,
              child: Container(
                decoration: BoxDecoration(
                  color: channel["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeAnalytics() {
    final timeSlots = [
      {"time": "9:00 AM", "rate": 85.2},
      {"time": "11:00 AM", "rate": 92.5},
      {"time": "2:00 PM", "rate": 78.9},
      {"time": "4:00 PM", "rate": 88.7},
      {"time": "6:00 PM", "rate": 65.3},
    ];

    return Column(
      children: timeSlots.map((slot) {
        final rate = (slot["rate"] as double) / 100;
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  "${slot["time"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: rate,
                    child: Container(
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${slot["rate"]}%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  IconData _getCommTypeIcon(String type) {
    switch (type) {
      case "email":
        return Icons.email;
      case "sms":
        return Icons.sms;
      case "call":
        return Icons.phone;
      case "social":
        return Icons.share;
      default:
        return Icons.chat;
    }
  }

  Color _getCommTypeColor(String type) {
    switch (type) {
      case "email":
        return primaryColor;
      case "sms":
        return successColor;
      case "call":
        return infoColor;
      case "social":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "delivered":
      case "completed":
        return successColor;
      case "pending":
        return warningColor;
      case "bounced":
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatTimestamp(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);
      
      if (difference.inMinutes < 60) {
        return "${difference.inMinutes}m ago";
      } else if (difference.inHours < 24) {
        return "${difference.inHours}h ago";
      } else {
        return "${difference.inDays}d ago";
      }
    } catch (e) {
      return timestamp;
    }
  }

  void _openChannel(String type) {
    switch (type) {
      case "email":
        //navigateTo('CrmEmailCenterView');
        break;
      case "sms":
        //navigateTo('CrmSmsCampaignsView');
        break;
      case "call":
        //navigateTo('CrmCallCenterView');
        break;
      case "social":
        //navigateTo('CrmSocialMediaView');
        break;
    }
    ss("Opening ${type} center");
  }

  void _showChannelSettings(String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${type.toUpperCase()} Settings"),
        content: Text("Channel settings would be configured here"),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showCreateTemplateDialog() {
    String templateType = "email";
    String templateName = "";
    String templateDescription = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Template"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Template Type",
              items: [
                {"label": "Email", "value": "email"},
                {"label": "SMS", "value": "sms"},
                {"label": "Call Script", "value": "call"},
              ],
              value: templateType,
              onChanged: (value, label) => templateType = value,
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Template Name",
              value: templateName,
              onChanged: (value) => templateName = value,
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Description",
              value: templateDescription,
              onChanged: (value) => templateDescription = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Create",
            size: bs.sm,
            onPressed: () {
              if (templateName.isNotEmpty) {
                Navigator.pop(context);
                _createTemplate(templateType, templateName, templateDescription);
              }
            },
          ),
        ],
      ),
    );
  }

  void _useTemplate(Map<String, dynamic> template) {
    ss("Template '${template["name"]}' ready to use");
    // Navigate to appropriate composer based on template type
  }

  void _editTemplate(Map<String, dynamic> template) {
    ss("Edit template functionality would be implemented here");
  }

  void _showTemplateOptions(Map<String, dynamic> template) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.content_copy),
              title: Text("Duplicate Template"),
              onTap: () {
                Navigator.pop(context);
                _duplicateTemplate(template);
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share Template"),
              onTap: () {
                Navigator.pop(context);
                ss("Share functionality would be implemented here");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Template", style: TextStyle(color: dangerColor)),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Are you sure you want to delete this template?");
                if (isConfirmed) {
                  _deleteTemplate(template);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _createTemplate(String type, String name, String description) {
    final newTemplate = {
      "id": "${templates.length + 1}",
      "type": type,
      "name": name,
      "description": description,
      "usage_count": 0,
      "last_used": DateTime.now().toString()
    };
    
    templates.insert(0, newTemplate);
    setState(() {});
    ss("Template created successfully");
  }

  void _duplicateTemplate(Map<String, dynamic> template) {
    final duplicatedTemplate = Map<String, dynamic>.from(template);
    duplicatedTemplate["id"] = "${templates.length + 1}";
    duplicatedTemplate["name"] = "${template["name"]} (Copy)";
    duplicatedTemplate["usage_count"] = 0;
    
    templates.insert(0, duplicatedTemplate);
    setState(() {});
    ss("Template duplicated successfully");
  }

  void _deleteTemplate(Map<String, dynamic> template) {
    templates.removeWhere((t) => t["id"] == template["id"]);
    setState(() {});
    ss("Template deleted successfully");
  }
}
