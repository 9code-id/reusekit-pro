import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmEmailCenterView extends StatefulWidget {
  const CrmEmailCenterView({super.key});

  @override
  State<CrmEmailCenterView> createState() => _CrmEmailCenterViewState();
}

class _CrmEmailCenterViewState extends State<CrmEmailCenterView> {
  int selectedIndex = 0;
  String searchQuery = "";
  String selectedFolder = "inbox";
  bool loading = false;

  List<Map<String, dynamic>> emails = [
    {
      "id": "1",
      "from": "john.doe@example.com",
      "to": "support@company.com",
      "subject": "Product inquiry - Enterprise plan",
      "content": "I'm interested in learning more about your enterprise plan and pricing options...",
      "timestamp": "2024-06-19T10:30:00",
      "status": "unread",
      "priority": "high",
      "tags": ["prospect", "enterprise"],
      "attachments": 0,
      "folder": "inbox"
    },
    {
      "id": "2",
      "from": "sarah.wilson@company.com",
      "to": "sales@company.com",
      "subject": "Meeting follow-up",
      "content": "Thank you for the productive meeting yesterday. As discussed, I'm attaching the requirements document...",
      "timestamp": "2024-06-19T09:15:00",
      "status": "read",
      "priority": "normal",
      "tags": ["follow-up", "meeting"],
      "attachments": 2,
      "folder": "inbox"
    },
    {
      "id": "3",
      "from": "marketing@company.com",
      "to": "newsletter@subscribers.com",
      "subject": "Weekly Product Updates",
      "content": "This week's product updates include new features, bug fixes, and performance improvements...",
      "timestamp": "2024-06-19T08:00:00",
      "status": "sent",
      "priority": "low",
      "tags": ["newsletter", "marketing"],
      "attachments": 1,
      "folder": "sent"
    },
    {
      "id": "4",
      "from": "noreply@bounce.com",
      "to": "customer@invalid.com",
      "subject": "Welcome to our service",
      "content": "Email delivery failed due to invalid recipient address",
      "timestamp": "2024-06-18T16:45:00",
      "status": "bounced",
      "priority": "normal",
      "tags": ["bounce", "failed"],
      "attachments": 0,
      "folder": "bounced"
    },
    {
      "id": "5",
      "from": "admin@company.com",
      "to": "team@company.com",
      "subject": "Team meeting scheduled",
      "content": "Monthly team meeting has been scheduled for next Friday at 2 PM...",
      "timestamp": "2024-06-18T14:20:00",
      "status": "draft",
      "priority": "normal",
      "tags": ["internal", "meeting"],
      "attachments": 0,
      "folder": "drafts"
    }
  ];

  List<Map<String, dynamic>> get filteredEmails {
    return emails.where((email) {
      final matchesSearch = "${email["subject"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                           "${email["from"]}".toLowerCase().contains(searchQuery.toLowerCase());
      final matchesFolder = selectedFolder == "all" || "${email["folder"]}" == selectedFolder;
      return matchesSearch && matchesFolder;
    }).toList()..sort((a, b) => DateTime.parse("${b["timestamp"]}").compareTo(DateTime.parse("${a["timestamp"]}")));
  }

  Map<String, int> get folderCounts {
    return {
      "inbox": emails.where((e) => e["folder"] == "inbox").length,
      "sent": emails.where((e) => e["folder"] == "sent").length,
      "drafts": emails.where((e) => e["folder"] == "drafts").length,
      "bounced": emails.where((e) => e["folder"] == "bounced").length,
      "archived": emails.where((e) => e["folder"] == "archived").length,
    };
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Email Center",
      selectedIndex: selectedIndex,
      tabs: [
        Tab(text: "Inbox", icon: Icon(Icons.inbox)),
        Tab(text: "Compose", icon: Icon(Icons.edit)),
        Tab(text: "Campaigns", icon: Icon(Icons.campaign)),
        Tab(text: "Templates", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildInboxTab(),
        _buildComposeTab(),
        _buildCampaignsTab(),
        _buildTemplatesTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }

  Widget _buildInboxTab() {
    return Column(
      children: [
        // Search and filters
        Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search emails...",
                      value: searchQuery,
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
                      _showFilterDialog();
                    },
                  ),
                ],
              ),
              
              // Folder tabs
              QHorizontalScroll(
                children: [
                  _buildFolderChip("All", "all", folderCounts.values.fold(0, (sum, count) => sum + count)),
                  _buildFolderChip("Inbox", "inbox", folderCounts["inbox"] ?? 0),
                  _buildFolderChip("Sent", "sent", folderCounts["sent"] ?? 0),
                  _buildFolderChip("Drafts", "drafts", folderCounts["drafts"] ?? 0),
                  _buildFolderChip("Bounced", "bounced", folderCounts["bounced"] ?? 0),
                ],
              ),
            ],
          ),
        ),

        // Email stats
        Container(
          padding: EdgeInsets.symmetric(horizontal: spMd),
          child: ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildStatCard("Unread", "${emails.where((e) => e["status"] == "unread").length}", dangerColor, Icons.mark_email_unread),
              _buildStatCard("High Priority", "${emails.where((e) => e["priority"] == "high").length}", warningColor, Icons.priority_high),
              _buildStatCard("With Attachments", "${emails.where((e) => (e["attachments"] as int) > 0).length}", infoColor, Icons.attach_file),
              _buildStatCard("Today", "${emails.where((e) => _isToday(e["timestamp"] as String)).length}", successColor, Icons.today),
            ],
          ),
        ),

        // Email list
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spSm,
              children: [
                if (loading)
                  Center(child: CircularProgressIndicator())
                else if (filteredEmails.isEmpty)
                  Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      children: [
                        Icon(Icons.email, size: 64, color: disabledColor),
                        SizedBox(height: spSm),
                        Text(
                          "No emails found",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...filteredEmails.map((email) => _buildEmailCard(email)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComposeTab() {
    String to = "";
    String cc = "";
    String subject = "";
    String content = "";
    String selectedTemplate = "";

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Template selector
          QDropdownField(
            label: "Use Template (Optional)",
            items: [
              {"label": "None", "value": ""},
              {"label": "Welcome Email", "value": "welcome"},
              {"label": "Follow-up Email", "value": "followup"},
              {"label": "Thank You Email", "value": "thankyou"},
            ],
            value: selectedTemplate,
            onChanged: (value, label) {
              selectedTemplate = value;
              if (value.isNotEmpty) {
                _loadTemplate(value);
              }
            },
          ),

          // Recipients
          QTextField(
            label: "To",
            value: to,
            hint: "Enter email addresses separated by commas",
            onChanged: (value) => to = value,
          ),

          QTextField(
            label: "CC (Optional)",
            value: cc,
            hint: "Enter CC email addresses",
            onChanged: (value) => cc = value,
          ),

          // Subject
          QTextField(
            label: "Subject",
            value: subject,
            hint: "Enter email subject",
            onChanged: (value) => subject = value,
          ),

          // Content
          QMemoField(
            label: "Email Content",
            value: content,
            hint: "Write your email content here...",
            onChanged: (value) => content = value,
          ),

          // Attachments
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
                  "Attachments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                QButton(
                  label: "Add Attachment",
                  size: bs.sm,
                  icon: Icons.attach_file,
                  onPressed: () {
                    ss("Attachment picker would open here");
                  },
                ),
              ],
            ),
          ),

          // Actions
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save as Draft",
                  size: bs.sm,
                  onPressed: () {
                    _saveDraft(to, subject, content);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Send Email",
                  size: bs.sm,
                  onPressed: () {
                    if (to.isNotEmpty && subject.isNotEmpty && content.isNotEmpty) {
                      _sendEmail(to, cc, subject, content);
                    } else {
                      se("Please fill in all required fields");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Campaign stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 140,
            children: [
              _buildStatCard("Active Campaigns", "5", successColor, Icons.campaign),
              _buildStatCard("Total Sent", "12,450", primaryColor, Icons.send),
              _buildStatCard("Open Rate", "68.5%", infoColor, Icons.mark_email_read),
              _buildStatCard("Click Rate", "12.3%", warningColor, Icons.mouse),
            ],
          ),

          // Recent campaigns
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
                      "Recent Campaigns",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Create Campaign",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('CrmEmailCampaignCreateView');
                      },
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ..._getCampaigns().map((campaign) => _buildCampaignCard(campaign)),
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
          ..._getEmailTemplates().map((template) => _buildTemplateCard(template)),
        ],
      ),
    );
  }

  Widget _buildFolderChip(String label, String value, int count) {
    final isSelected = selectedFolder == value;
    return GestureDetector(
      onTap: () {
        selectedFolder = value;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : disabledBoldColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (count > 0) ...[
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white.withAlpha(40) : primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$count",
                  style: TextStyle(
                    color: isSelected ? Colors.white : primaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
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

  Widget _buildEmailCard(Map<String, dynamic> email) {
    final isUnread = email["status"] == "unread";
    final hasAttachments = (email["attachments"] as int) > 0;
    final priority = "${email["priority"]}";

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isUnread ? primaryColor.withAlpha(5) : Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor(priority),
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
                        Expanded(
                          child: Text(
                            "${email["from"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isUnread ? FontWeight.bold : FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (hasAttachments)
                          Icon(Icons.attach_file, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          _formatTimestamp("${email["timestamp"]}"),
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${email["subject"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: isUnread ? FontWeight.bold : FontWeight.w500,
                        color: isUnread ? primaryColor : Colors.black,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${email["content"]}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor("${email["status"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${email["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor("${email["status"]}"),
                      ),
                    ),
                  ),
                  if (priority != "normal") ...[
                    SizedBox(height: spXs),
                    Icon(
                      priority == "high" ? Icons.priority_high : Icons.expand_less,
                      color: _getPriorityColor(priority),
                      size: 16,
                    ),
                  ],
                ],
              ),
            ],
          ),
          if ((email["tags"] as List).isNotEmpty) ...[
            SizedBox(height: spSm),
            Wrap(
              spacing: spXs,
              children: (email["tags"] as List).map((tag) => Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$tag",
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList(),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View",
                  size: bs.sm,
                  onPressed: () {
                    _viewEmail(email);
                  },
                ),
              ),
              SizedBox(width: spSm),
              if (email["status"] == "unread")
                QButton(
                  icon: Icons.mark_email_read,
                  size: bs.sm,
                  onPressed: () {
                    _markAsRead(email);
                  },
                ),
              QButton(
                icon: Icons.reply,
                size: bs.sm,
                onPressed: () {
                  _replyToEmail(email);
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showEmailOptions(email);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignCard(Map<String, dynamic> campaign) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
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
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${campaign["description"]}",
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
                  color: _getCampaignStatusColor("${campaign["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${campaign["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getCampaignStatusColor("${campaign["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.people, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text("${campaign["recipients"]} recipients", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
              SizedBox(width: spSm),
              Icon(Icons.open_in_new, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text("${campaign["open_rate"]}% open rate", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
            ],
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
              QButton(
                label: "Use",
                size: bs.sm,
                onPressed: () {
                  _useTemplate("${template["id"]}");
                },
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
              Spacer(),
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

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "low":
        return successColor;
      default:
        return infoColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "unread":
        return dangerColor;
      case "read":
        return successColor;
      case "sent":
        return infoColor;
      case "bounced":
        return warningColor;
      case "draft":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  Color _getCampaignStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "paused":
        return warningColor;
      case "completed":
        return infoColor;
      case "draft":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  bool _isToday(String timestamp) {
    try {
      final date = DateTime.parse(timestamp);
      final now = DateTime.now();
      return date.day == now.day && date.month == now.month && date.year == now.year;
    } catch (e) {
      return false;
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

  List<Map<String, dynamic>> _getCampaigns() {
    return [
      {
        "id": "1",
        "name": "Summer Sale 2024",
        "description": "Promotional campaign for summer collection",
        "recipients": 5240,
        "open_rate": 72.5,
        "status": "active"
      },
      {
        "id": "2",
        "name": "Welcome Series",
        "description": "Automated welcome emails for new customers",
        "recipients": 1890,
        "open_rate": 85.2,
        "status": "active"
      },
      {
        "id": "3",
        "name": "Product Update Newsletter",
        "description": "Monthly product updates and feature announcements",
        "recipients": 8750,
        "open_rate": 68.9,
        "status": "completed"
      }
    ];
  }

  List<Map<String, dynamic>> _getEmailTemplates() {
    return [
      {
        "id": "1",
        "name": "Welcome Email",
        "description": "Welcome message for new customers",
        "usage_count": 1245,
        "subject": "Welcome to {{company_name}}!",
        "content": "Thank you for joining us..."
      },
      {
        "id": "2",
        "name": "Follow-up Email",
        "description": "Follow-up message for prospects",
        "usage_count": 892,
        "subject": "Following up on our conversation",
        "content": "I wanted to follow up on our recent discussion..."
      },
      {
        "id": "3",
        "name": "Thank You Email",
        "description": "Thank you message after purchase",
        "usage_count": 567,
        "subject": "Thank you for your order!",
        "content": "We appreciate your business..."
      }
    ];
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Emails"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: Text("Unread only"),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text("High priority"),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text("With attachments"),
              value: false,
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _viewEmail(Map<String, dynamic> email) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${email["subject"]}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("From: ${email["from"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("To: ${email["to"]}"),
              SizedBox(height: spSm),
              Text("${email["content"]}"),
            ],
          ),
        ),
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

  void _markAsRead(Map<String, dynamic> email) {
    email["status"] = "read";
    setState(() {});
    ss("Email marked as read");
  }

  void _replyToEmail(Map<String, dynamic> email) {
    // Set compose tab with reply prefilled
    selectedIndex = 1;
    setState(() {});
    ss("Reply composer opened");
  }

  void _showEmailOptions(Map<String, dynamic> email) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.forward),
              title: Text("Forward"),
              onTap: () {
                Navigator.pop(context);
                ss("Forward functionality would be implemented here");
              },
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text("Archive"),
              onTap: () {
                Navigator.pop(context);
                _archiveEmail(email);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete", style: TextStyle(color: dangerColor)),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Are you sure you want to delete this email?");
                if (isConfirmed) {
                  _deleteEmail(email);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _loadTemplate(String templateId) {
    ss("Template loaded: $templateId");
  }

  void _saveDraft(String to, String subject, String content) {
    final draft = {
      "id": "${emails.length + 1}",
      "from": "me@company.com",
      "to": to,
      "subject": subject,
      "content": content,
      "timestamp": DateTime.now().toString(),
      "status": "draft",
      "priority": "normal",
      "tags": ["draft"],
      "attachments": 0,
      "folder": "drafts"
    };
    
    emails.insert(0, draft);
    setState(() {});
    ss("Email saved as draft");
  }

  void _sendEmail(String to, String cc, String subject, String content) {
    final sentEmail = {
      "id": "${emails.length + 1}",
      "from": "me@company.com",
      "to": to,
      "subject": subject,
      "content": content,
      "timestamp": DateTime.now().toString(),
      "status": "sent",
      "priority": "normal",
      "tags": ["sent"],
      "attachments": 0,
      "folder": "sent"
    };
    
    emails.insert(0, sentEmail);
    setState(() {});
    ss("Email sent successfully");
  }

  void _archiveEmail(Map<String, dynamic> email) {
    email["folder"] = "archived";
    setState(() {});
    ss("Email archived");
  }

  void _deleteEmail(Map<String, dynamic> email) {
    emails.removeWhere((e) => e["id"] == email["id"]);
    setState(() {});
    ss("Email deleted");
  }

  void _showCreateTemplateDialog() {
    String templateName = "";
    String templateSubject = "";
    String templateContent = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Email Template"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Template Name",
              value: templateName,
              onChanged: (value) => templateName = value,
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Subject",
              value: templateSubject,
              onChanged: (value) => templateSubject = value,
            ),
            SizedBox(height: spSm),
            QMemoField(
              label: "Content",
              value: templateContent,
              onChanged: (value) => templateContent = value,
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
              if (templateName.isNotEmpty && templateSubject.isNotEmpty) {
                Navigator.pop(context);
                ss("Template created successfully");
              }
            },
          ),
        ],
      ),
    );
  }

  void _useTemplate(String templateId) {
    selectedIndex = 1; // Switch to compose tab
    setState(() {});
    ss("Template loaded in composer");
  }

  void _editTemplate(Map<String, dynamic> template) {
    ss("Template editor would open here");
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
                ss("Template duplicated");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Template", style: TextStyle(color: dangerColor)),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Are you sure you want to delete this template?");
                if (isConfirmed) {
                  ss("Template deleted");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
