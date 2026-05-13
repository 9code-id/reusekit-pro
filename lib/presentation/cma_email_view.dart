import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaEmailView extends StatefulWidget {
  const CmaEmailView({super.key});

  @override
  State<CmaEmailView> createState() => _CmaEmailViewState();
}

class _CmaEmailViewState extends State<CmaEmailView> {
  int selectedTabIndex = 0;
  String searchQuery = "";
  String selectedFolder = "inbox";
  String selectedPriority = "";
  bool showUnreadOnly = false;
  
  List<Map<String, dynamic>> folderOptions = [
    {"label": "Inbox", "value": "inbox"},
    {"label": "Sent", "value": "sent"},
    {"label": "Drafts", "value": "drafts"},
    {"label": "Starred", "value": "starred"},
    {"label": "Trash", "value": "trash"},
  ];
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": ""},
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Urgent", "value": "urgent"},
  ];

  List<Map<String, dynamic>> emails = [
    {
      "id": "1",
      "folder": "inbox",
      "from": "michael.johnson@johnsoncorp.com",
      "fromName": "Michael Johnson",
      "to": ["john.smith@company.com"],
      "cc": [],
      "bcc": [],
      "subject": "Q4 Performance Review - Action Items",
      "body": "Hi John,\n\nThank you for the comprehensive Q4 review presentation today. I'm impressed with the team's performance and the strategic initiatives outlined for 2025.\n\nKey action items from our discussion:\n1. Finalize budget allocation for new projects\n2. Schedule team expansion planning meeting\n3. Review and update service level agreements\n\nPlease let me know your availability for a follow-up meeting next week.\n\nBest regards,\nMichael Johnson\nCEO, Johnson Corp",
      "date": "2024-12-22",
      "time": "10:15",
      "isRead": false,
      "isStarred": true,
      "priority": "high",
      "hasAttachments": true,
      "attachments": ["Q4_ActionItems.pdf", "Budget_Proposal.xlsx"],
      "labels": ["client", "review", "action-items"],
      "threadId": "thread_001",
      "clientName": "Johnson Corp",
    },
    {
      "id": "2",
      "folder": "sent",
      "from": "john.smith@company.com",
      "fromName": "John Smith",
      "to": ["sarah.wilson@abcindustries.com"],
      "cc": ["emily.davis@company.com"],
      "bcc": [],
      "subject": "Project Timeline Update - ABC Industries",
      "body": "Dear Sarah,\n\nI hope this email finds you well. I wanted to provide you with an update on the project timeline and address the concerns you raised during our call yesterday.\n\nAfter reviewing our resources and current commitments, I'm pleased to inform you that we can accommodate the accelerated timeline you requested. Here's our revised schedule:\n\n- Phase 1: Complete by January 15, 2025\n- Phase 2: Complete by February 28, 2025\n- Final delivery: March 15, 2025\n\nThis represents a 2-week acceleration from our original timeline. To achieve this, we'll be assigning additional team members to your project.\n\nPlease review the attached revised project plan and let me know if you have any questions.\n\nBest regards,\nJohn Smith\nProject Manager",
      "date": "2024-12-21",
      "time": "16:30",
      "isRead": true,
      "isStarred": false,
      "priority": "urgent",
      "hasAttachments": true,
      "attachments": ["Revised_Project_Plan.pdf"],
      "labels": ["project", "timeline", "client-update"],
      "threadId": "thread_002",
      "clientName": "ABC Industries",
    },
    {
      "id": "3",
      "folder": "inbox",
      "from": "mark.davis@techstart.com",
      "fromName": "Mark Davis",
      "to": ["david.brown@company.com"],
      "cc": [],
      "bcc": [],
      "subject": "Implementation Feedback - Thank You!",
      "body": "Hi David,\n\nI wanted to personally thank you and your team for the excellent implementation support over the past month. The new system is working perfectly, and our team has adapted to it much faster than expected.\n\nSome highlights:\n- 98% system uptime since go-live\n- 30% improvement in processing efficiency\n- Positive feedback from all department heads\n\nWe're particularly impressed with the automation features you configured. They've saved us countless hours of manual work.\n\nI'd like to schedule a call to discuss potential expansion opportunities. Are you available sometime next week?\n\nWarm regards,\nMark Davis\nCTO, TechStart LLC",
      "date": "2024-12-20",
      "time": "14:20",
      "isRead": false,
      "isStarred": false,
      "priority": "medium",
      "hasAttachments": false,
      "attachments": [],
      "labels": ["feedback", "implementation", "success"],
      "threadId": "thread_003",
      "clientName": "TechStart LLC",
    },
    {
      "id": "4",
      "folder": "drafts",
      "from": "emily.davis@company.com",
      "fromName": "Emily Davis",
      "to": ["lisa.thompson@globalsolutions.com"],
      "cc": [],
      "bcc": [],
      "subject": "Contract Amendment Proposal - Draft",
      "body": "Dear Lisa,\n\nThank you for your email regarding the contract amendments. I've reviewed your requests with our legal team and management, and I'm pleased to present our proposal.\n\n[DRAFT - TO BE COMPLETED]\n\n- Payment terms adjustment\n- Service level modifications\n- Pricing structure updates\n\nI'll complete this draft and send it by end of week.\n\nBest regards,\nEmily Davis",
      "date": "2024-12-19",
      "time": "11:45",
      "isRead": true,
      "isStarred": false,
      "priority": "high",
      "hasAttachments": false,
      "attachments": [],
      "labels": ["contract", "draft", "amendment"],
      "threadId": "thread_004",
      "clientName": "Global Solutions",
    },
    {
      "id": "5",
      "folder": "inbox",
      "from": "robert.kim@innovate.com",
      "fromName": "Robert Kim",
      "to": ["sarah.wilson@company.com"],
      "cc": [],
      "bcc": [],
      "subject": "Demo Follow-up and Next Steps",
      "body": "Hi Sarah,\n\nI hope you're doing well. I wanted to follow up on the product demo we had last week. The team was very impressed with the capabilities you demonstrated, especially the reporting features.\n\nWe've had some internal discussions and would like to move forward with a pilot program. Could we schedule a meeting to discuss:\n\n1. Pilot program scope and timeline\n2. Pricing for the pilot phase\n3. Training requirements for our team\n4. Technical requirements and integration\n\nWe're targeting a January 2025 start date if possible. Please let me know your availability for a detailed discussion.\n\nLooking forward to hearing from you.\n\nBest regards,\nRobert Kim\nOperations Director, Innovate Inc",
      "date": "2024-12-18",
      "time": "09:30",
      "isRead": true,
      "isStarred": true,
      "priority": "medium",
      "hasAttachments": false,
      "attachments": [],
      "labels": ["demo", "follow-up", "pilot-program"],
      "threadId": "thread_005",
      "clientName": "Innovate Inc",
    },
  ];

  List<Map<String, dynamic>> get filteredEmails {
    return emails.where((email) {
      bool matchesFolder = email["folder"] == selectedFolder;
      
      bool matchesSearch = searchQuery.isEmpty ||
          (email["subject"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (email["fromName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (email["body"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesPriority = selectedPriority.isEmpty || email["priority"] == selectedPriority;
      bool matchesReadStatus = !showUnreadOnly || !(email["isRead"] as bool);
      
      return matchesFolder && matchesSearch && matchesPriority && matchesReadStatus;
    }).toList()
      ..sort((a, b) => "${b["date"]} ${b["time"]}".compareTo("${a["date"]} ${a["time"]}"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              _refreshEmails();
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Navigate to compose email
            },
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          _buildFilters(),
          Expanded(
            child: _buildEmailsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    int totalEmails = emails.where((e) => e["folder"] == selectedFolder).length;
    int unreadEmails = emails.where((e) => e["folder"] == selectedFolder && !(e["isRead"] as bool)).length;
    int starredEmails = emails.where((e) => e["folder"] == selectedFolder && (e["isStarred"] as bool)).length;
    int attachmentEmails = emails.where((e) => e["folder"] == selectedFolder && (e["hasAttachments"] as bool)).length;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "${selectedFolder.toUpperCase()} Overview",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Total", totalEmails, Colors.white),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Unread", unreadEmails, warningColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Starred", starredEmails, dangerColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Attachments", attachmentEmails, infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int count, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Text(
            "$count",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowXs],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QCategoryPicker(
            items: folderOptions,
            value: selectedFolder,
            onChanged: (index, label, value, item) {
              setState(() {
                selectedFolder = value;
              });
            },
          ),
          QTextField(
            label: "Search Emails",
            value: searchQuery,
            hint: "Search by subject, sender, or content",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: priorityOptions,
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Unread only",
                      "value": true,
                      "checked": showUnreadOnly,
                    }
                  ],
                  value: [
                    if (showUnreadOnly)
                      {
                        "label": "Unread only",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    setState(() {
                      showUnreadOnly = values.isNotEmpty;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmailsList() {
    if (filteredEmails.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spSm,
          children: [
            Icon(
              Icons.email,
              size: 64,
              color: disabledColor,
            ),
            Text(
              "No emails found",
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
              ),
            ),
            Text(
              selectedFolder == "inbox" ? "Your inbox is empty" : "No emails in ${selectedFolder}",
              style: TextStyle(
                fontSize: 14,
                color: disabledColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredEmails.length,
      itemBuilder: (context, index) {
        final email = filteredEmails[index];
        return _buildEmailCard(email, index);
      },
    );
  }

  Widget _buildEmailCard(Map<String, dynamic> email, int index) {
    Color priorityColor = _getPriorityColor(email["priority"]);
    bool isUnread = !(email["isRead"] as bool);
    bool isStarred = email["isStarred"] as bool;
    bool hasAttachments = email["hasAttachments"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isUnread ? primaryColor.withAlpha(10) : Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isUnread ? primaryColor : priorityColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              if (isUnread)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              if (isUnread)
                SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${email["fromName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              if (hasAttachments)
                Icon(
                  Icons.attach_file,
                  size: 16,
                  color: disabledBoldColor,
                ),
              if (hasAttachments)
                SizedBox(width: spXs),
              if (isStarred)
                GestureDetector(
                  onTap: () => _toggleStar(email["id"]),
                  child: Icon(
                    Icons.star,
                    size: 16,
                    color: warningColor,
                  ),
                ),
              if (!isStarred)
                GestureDetector(
                  onTap: () => _toggleStar(email["id"]),
                  child: Icon(
                    Icons.star_border,
                    size: 16,
                    color: disabledBoldColor,
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
                  "${email["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: priorityColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${email["subject"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
              color: isUnread ? primaryColor : disabledBoldColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "${email["body"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${email["date"]} at ${email["time"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if ((email["labels"] as List).isNotEmpty)
                Text(
                  "#${(email["labels"] as List).first}",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
            ],
          ),
          if ((email["labels"] as List).length > 1)
            Wrap(
              spacing: spXs,
              children: (email["labels"] as List).skip(1).map((label) => Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "#$label",
                  style: TextStyle(
                    fontSize: 10,
                    color: infoColor,
                  ),
                ),
              )).toList(),
            ),
          Row(
            children: [
              QButton(
                icon: Icons.reply,
                size: bs.sm,
                onPressed: () {
                  _replyToEmail(email);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.forward,
                size: bs.sm,
                onPressed: () {
                  _forwardEmail(email);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: isUnread ? Icons.mark_email_read : Icons.mark_email_unread,
                size: bs.sm,
                onPressed: () {
                  _toggleReadStatus(email["id"]);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () {
                  _deleteEmail(email["id"]);
                },
              ),
              Spacer(),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {
                  _viewEmailDetails(email);
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
      case "urgent":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _refreshEmails() {
    // Simulate refresh
    ss("Emails refreshed");
  }

  void _toggleStar(String emailId) {
    setState(() {
      int index = emails.indexWhere((e) => e["id"] == emailId);
      if (index != -1) {
        emails[index]["isStarred"] = !(emails[index]["isStarred"] as bool);
      }
    });
  }

  void _toggleReadStatus(String emailId) {
    setState(() {
      int index = emails.indexWhere((e) => e["id"] == emailId);
      if (index != -1) {
        emails[index]["isRead"] = !(emails[index]["isRead"] as bool);
      }
    });
  }

  void _replyToEmail(Map<String, dynamic> email) {
    ss("Reply to ${email["fromName"]} opened");
  }

  void _forwardEmail(Map<String, dynamic> email) {
    ss("Forward email opened");
  }

  void _deleteEmail(String emailId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this email?");
    if (isConfirmed) {
      setState(() {
        int index = emails.indexWhere((e) => e["id"] == emailId);
        if (index != -1) {
          emails[index]["folder"] = "trash";
        }
      });
      ss("Email moved to trash");
    }
  }

  void _viewEmailDetails(Map<String, dynamic> email) {
    // Mark as read when viewing
    setState(() {
      int index = emails.indexWhere((e) => e["id"] == email["id"]);
      if (index != -1) {
        emails[index]["isRead"] = true;
      }
    });
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${email["subject"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                QButton(
                  icon: Icons.close,
                  size: bs.sm,
                  onPressed: () => back(),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "From: ${email["fromName"]} <${email["from"]}>",
                    style: TextStyle(fontSize: 14, color: disabledBoldColor),
                  ),
                  Text(
                    "To: ${(email["to"] as List).join(", ")}",
                    style: TextStyle(fontSize: 14, color: disabledBoldColor),
                  ),
                  if ((email["cc"] as List).isNotEmpty)
                    Text(
                      "CC: ${(email["cc"] as List).join(", ")}",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                  Text(
                    "Date: ${email["date"]} at ${email["time"]}",
                    style: TextStyle(fontSize: 14, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            if ((email["attachments"] as List).isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Attachments:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                    ...(email["attachments"] as List).map((attachment) => Text(
                      "• $attachment",
                      style: TextStyle(fontSize: 13, color: infoColor),
                    )).toList(),
                  ],
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  "${email["body"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
