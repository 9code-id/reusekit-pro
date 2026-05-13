import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaClientCommunicationView extends StatefulWidget {
  const LcaClientCommunicationView({super.key});

  @override
  State<LcaClientCommunicationView> createState() => _LcaClientCommunicationViewState();
}

class _LcaClientCommunicationViewState extends State<LcaClientCommunicationView> {
  int selectedTab = 0;
  bool loading = false;
  String newMessage = "";
  String selectedClient = "all";
  String communicationType = "all";

  List<Map<String, dynamic>> clientOptions = [
    {"label": "All Clients", "value": "all"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Michael Chen", "value": "michael_chen"},
    {"label": "Emma Wilson", "value": "emma_wilson"},
    {"label": "David Rodriguez", "value": "david_rodriguez"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Email", "value": "email"},
    {"label": "Phone Call", "value": "phone"},
    {"label": "Meeting", "value": "meeting"},
    {"label": "SMS", "value": "sms"},
  ];

  List<Map<String, dynamic>> communications = [
    {
      "id": "1",
      "clientName": "Sarah Johnson",
      "clientId": "sarah_johnson",
      "type": "email",
      "subject": "Contract Review Update",
      "content": "Hi Sarah, I've completed the initial review of your contract. There are a few clauses that need clarification...",
      "timestamp": "2024-06-19 10:30",
      "direction": "outgoing",
      "status": "sent",
      "priority": "normal",
      "attachments": ["contract_review.pdf"],
    },
    {
      "id": "2",
      "clientName": "Michael Chen",
      "clientId": "michael_chen",
      "type": "phone",
      "subject": "IP Protection Consultation",
      "content": "30-minute consultation call regarding patent filing process. Discussed timeline and requirements.",
      "timestamp": "2024-06-19 09:15",
      "direction": "incoming",
      "status": "completed",
      "priority": "high",
      "attachments": [],
    },
    {
      "id": "3",
      "clientName": "Emma Wilson",
      "clientId": "emma_wilson",
      "type": "meeting",
      "subject": "Employment Law Strategy Session",
      "content": "In-person meeting to discuss employee handbook review and policy updates.",
      "timestamp": "2024-06-19 14:00",
      "direction": "scheduled",
      "status": "pending",
      "priority": "normal",
      "attachments": ["agenda.pdf", "current_handbook.docx"],
    },
    {
      "id": "4",
      "clientName": "Sarah Johnson",
      "clientId": "sarah_johnson",
      "type": "email",
      "subject": "Re: Contract Questions",
      "content": "Thank you for the quick review. I have a few follow-up questions about clauses 7 and 12...",
      "timestamp": "2024-06-18 16:45",
      "direction": "incoming",
      "status": "read",
      "priority": "normal",
      "attachments": [],
    },
    {
      "id": "5",
      "clientName": "David Rodriguez",
      "clientId": "david_rodriguez",
      "type": "sms",
      "subject": "Appointment Reminder",
      "content": "Reminder: Your consultation is scheduled for tomorrow at 2 PM. Please bring requested documents.",
      "timestamp": "2024-06-18 15:00",
      "direction": "outgoing",
      "status": "delivered",
      "priority": "low",
      "attachments": [],
    },
  ];

  List<Map<String, dynamic>> templates = [
    {
      "name": "Initial Consultation Follow-up",
      "subject": "Thank you for your consultation",
      "content": "Dear [CLIENT_NAME],\n\nThank you for taking the time to meet with us today. We appreciate the opportunity to discuss your legal needs...",
      "category": "consultation",
    },
    {
      "name": "Document Request",
      "subject": "Required Documents for Your Case",
      "content": "Dear [CLIENT_NAME],\n\nTo proceed with your case, we will need the following documents...",
      "category": "documents",
    },
    {
      "name": "Case Update",
      "subject": "Update on Your Case",
      "content": "Dear [CLIENT_NAME],\n\nI wanted to provide you with an update on the progress of your case...",
      "category": "updates",
    },
    {
      "name": "Appointment Reminder",
      "subject": "Appointment Reminder - [DATE]",
      "content": "Dear [CLIENT_NAME],\n\nThis is a reminder of your upcoming appointment scheduled for [DATE] at [TIME]...",
      "category": "appointments",
    },
  ];

  List<Map<String, dynamic>> get filteredCommunications {
    List<Map<String, dynamic>> filtered = communications;
    
    if (selectedClient != "all") {
      filtered = filtered.where((comm) => comm["clientId"] == selectedClient).toList();
    }
    
    if (communicationType != "all") {
      filtered = filtered.where((comm) => comm["type"] == communicationType).toList();
    }
    
    return filtered..sort((a, b) => b["timestamp"].compareTo(a["timestamp"]));
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Client Communication",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Messages", icon: Icon(Icons.message)),
        Tab(text: "Compose", icon: Icon(Icons.edit)),
        Tab(text: "Templates", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildMessagesTab(),
        _buildComposeTab(),
        _buildTemplatesTab(),
      ],
    );
  }

  Widget _buildMessagesTab() {
    return loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCommunicationStats(),
                _buildFilters(),
                _buildMessagesList(),
              ],
            ),
          );
  }

  Widget _buildComposeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildComposeForm(),
          _buildQuickActions(),
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
          _buildTemplatesList(),
        ],
      ),
    );
  }

  Widget _buildCommunicationStats() {
    int totalMessages = communications.length;
    int unreadMessages = communications.where((c) => c["status"] == "pending" || c["status"] == "received").length;
    int todayMessages = communications.where((c) => c["timestamp"].startsWith("2024-06-19")).length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Total Communications", totalMessages.toString(), Icons.message, primaryColor),
        _buildStatCard("Pending Actions", unreadMessages.toString(), Icons.notification_important, warningColor),
        _buildStatCard("Today's Activity", todayMessages.toString(), Icons.today, successColor),
        _buildStatCard("Response Rate", "94.2%", Icons.trending_up, infoColor),
      ],
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
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
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
              Icon(Icons.filter_list, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Communication Filters",
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
                child: QDropdownField(
                  label: "Select Client",
                  items: clientOptions,
                  value: selectedClient,
                  onChanged: (value, label) {
                    selectedClient = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Communication Type",
                  items: typeOptions,
                  value: communicationType,
                  onChanged: (value, label) {
                    communicationType = value;
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

  Widget _buildMessagesList() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.chat, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Communication History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredCommunications.length} messages",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          ...filteredCommunications.map((comm) => _buildCommunicationItem(comm)).toList(),
        ],
      ),
    );
  }

  Widget _buildCommunicationItem(Map<String, dynamic> comm) {
    IconData typeIcon;
    Color typeColor;
    
    switch (comm["type"]) {
      case "email":
        typeIcon = Icons.email;
        typeColor = primaryColor;
        break;
      case "phone":
        typeIcon = Icons.phone;
        typeColor = successColor;
        break;
      case "meeting":
        typeIcon = Icons.meeting_room;
        typeColor = warningColor;
        break;
      case "sms":
        typeIcon = Icons.sms;
        typeColor = infoColor;
        break;
      default:
        typeIcon = Icons.message;
        typeColor = disabledBoldColor;
    }

    Color directionColor = comm["direction"] == "incoming" ? successColor : 
                          comm["direction"] == "outgoing" ? primaryColor : warningColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: typeColor.withAlpha(13),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: directionColor,
          ),
        ),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(typeIcon, color: typeColor, size: 16),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${comm["subject"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${comm["clientName"]} • ${comm["timestamp"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: directionColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${comm["direction"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getStatusColor(comm["status"]).withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${comm["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(comm["status"]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(128),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${comm["content"]}",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if ((comm["attachments"] as List).isNotEmpty)
            Wrap(
              spacing: spXs,
              children: (comm["attachments"] as List).map((attachment) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.attach_file, color: infoColor, size: 12),
                      SizedBox(width: 2),
                      Text(
                        "$attachment",
                        style: TextStyle(
                          fontSize: 11,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Reply",
                  icon: Icons.reply,
                  size: bs.sm,
                  onPressed: () {
                    si("Replying to ${comm["clientName"]}");
                  },
                ),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.forward,
                size: bs.sm,
                onPressed: () {
                  si("Forwarding message");
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showMessageMenu(comm);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComposeForm() {
    String recipient = "";
    String subject = "";
    String messageContent = "";
    String messageType = "email";

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.edit, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Compose New Message",
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
                child: QDropdownField(
                  label: "Recipient",
                  items: clientOptions.where((item) => item["value"] != "all").toList(),
                  value: recipient,
                  onChanged: (value, label) {
                    recipient = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Message Type",
                  items: typeOptions.where((item) => item["value"] != "all").toList(),
                  value: messageType,
                  onChanged: (value, label) {
                    messageType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Subject",
            value: subject,
            validator: Validator.required,
            onChanged: (value) {
              subject = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Message Content",
            value: messageContent,
            validator: Validator.required,
            hint: "Type your message here...",
            onChanged: (value) {
              messageContent = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Send Message",
                  icon: Icons.send,
                  size: bs.md,
                  onPressed: () {
                    if (recipient.isNotEmpty && subject.isNotEmpty && messageContent.isNotEmpty) {
                      ss("Message sent successfully");
                      // Clear form
                      setState(() {});
                    } else {
                      se("Please fill in all required fields");
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Save Draft",
                icon: Icons.drafts,
                size: bs.md,
                onPressed: () {
                  si("Draft saved");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildQuickActionCard("Schedule Meeting", Icons.event, successColor),
              _buildQuickActionCard("Send Document Request", Icons.request_page, warningColor),
              _buildQuickActionCard("Case Update Notification", Icons.update, infoColor),
              _buildQuickActionCard("Appointment Reminder", Icons.alarm, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        si("Quick action: $title");
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(26),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(51)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: spXs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplatesList() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.description, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Message Templates",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  si("Create new template");
                },
              ),
            ],
          ),
          ...templates.map((template) => _buildTemplateItem(template)).toList(),
        ],
      ),
    );
  }

  Widget _buildTemplateItem(Map<String, dynamic> template) {
    Color categoryColor = _getCategoryColor(template["category"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: categoryColor.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: categoryColor,
          ),
        ),
      ),
      child: Column(
        spacing: spXs,
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${template["subject"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${template["category"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(128),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${template["content"]}",
              style: TextStyle(
                fontSize: 13,
                color: primaryColor,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Use Template",
                  icon: Icons.check,
                  size: bs.sm,
                  onPressed: () {
                    setState(() {
                      selectedTab = 1; // Switch to compose tab
                    });
                    si("Template applied to compose form");
                  },
                ),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  si("Editing template: ${template["name"]}");
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.copy,
                size: bs.sm,
                onPressed: () {
                  si("Template copied");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "sent":
      case "delivered":
      case "completed":
        return successColor;
      case "pending":
      case "scheduled":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return infoColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "consultation":
        return primaryColor;
      case "documents":
        return warningColor;
      case "updates":
        return infoColor;
      case "appointments":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showMessageMenu(Map<String, dynamic> message) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 200, 0, 0),
      items: [
        PopupMenuItem(
          value: "important",
          child: Text("Mark as Important"),
        ),
        PopupMenuItem(
          value: "archive",
          child: Text("Archive"),
        ),
        PopupMenuItem(
          value: "delete",
          child: Text("Delete"),
        ),
        PopupMenuItem(
          value: "print",
          child: Text("Print"),
        ),
      ],
    ).then((value) {
      if (value != null) {
        si("Action: $value for message");
      }
    });
  }
}
