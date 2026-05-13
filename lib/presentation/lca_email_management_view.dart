import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaEmailManagementView extends StatefulWidget {
  const LcaEmailManagementView({super.key});

  @override
  State<LcaEmailManagementView> createState() => _LcaEmailManagementViewState();
}

class _LcaEmailManagementViewState extends State<LcaEmailManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedPriority = "all";
  
  List<Map<String, dynamic>> emails = [
    {
      "id": 1,
      "subject": "Contract Review - Smith vs. Johnson",
      "sender": "john.smith@lawfirm.com",
      "recipient": "litigation@ourlaw.com",
      "timestamp": "2024-03-20T10:30:00Z",
      "priority": "high",
      "category": "litigation",
      "status": "unread",
      "hasAttachment": true,
      "body": "Please review the attached contract terms for the Smith vs. Johnson case. We need your expertise on the liability clauses mentioned in section 4.2.",
      "caseNumber": "LIT-2024-001",
      "clientName": "John Smith"
    },
    {
      "id": 2,
      "subject": "Deposition Schedule Update",
      "sender": "admin@courtservices.gov",
      "recipient": "legal@ourlaw.com",
      "timestamp": "2024-03-20T09:15:00Z",
      "priority": "medium",
      "category": "court",
      "status": "read",
      "hasAttachment": false,
      "body": "The deposition scheduled for March 25th has been moved to March 27th at 2:00 PM. Please confirm your availability.",
      "caseNumber": "FAM-2024-003",
      "clientName": "Sarah Wilson"
    },
    {
      "id": 3,
      "subject": "Client Meeting Follow-up",
      "sender": "client@business.com",
      "recipient": "counsel@ourlaw.com",
      "timestamp": "2024-03-19T16:45:00Z",
      "priority": "low",
      "category": "client",
      "status": "read",
      "hasAttachment": true,
      "body": "Thank you for the productive meeting yesterday. As discussed, I'm attaching the additional documents you requested.",
      "caseNumber": "COR-2024-007",
      "clientName": "ABC Corporation"
    },
    {
      "id": 4,
      "subject": "Settlement Proposal - Davis Case",
      "sender": "opposing@lawfirm.net",
      "recipient": "negotiation@ourlaw.com",
      "timestamp": "2024-03-19T14:20:00Z",
      "priority": "high",
      "category": "settlement",
      "status": "unread",
      "hasAttachment": true,
      "body": "We are prepared to offer a settlement of \$50,000 to resolve the Davis matter. Please review with your client and respond by end of week.",
      "caseNumber": "PER-2024-012",
      "clientName": "Michael Davis"
    }
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "all"},
    {"label": "Litigation", "value": "litigation"},
    {"label": "Court Communications", "value": "court"},
    {"label": "Client Correspondence", "value": "client"},
    {"label": "Settlement", "value": "settlement"},
    {"label": "Discovery", "value": "discovery"}
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priorities", "value": "all"},
    {"label": "High Priority", "value": "high"},
    {"label": "Medium Priority", "value": "medium"},
    {"label": "Low Priority", "value": "low"}
  ];

  List<Map<String, dynamic>> get filteredEmails {
    return emails.where((email) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${email["subject"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${email["sender"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${email["clientName"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" || email["category"] == selectedCategory;
      bool matchesPriority = selectedPriority == "all" || email["priority"] == selectedPriority;
      
      return matchesSearch && matchesCategory && matchesPriority;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Email Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Inbox", icon: Icon(Icons.inbox)),
        Tab(text: "Sent", icon: Icon(Icons.send)),
        Tab(text: "Drafts", icon: Icon(Icons.drafts)),
        Tab(text: "Archive", icon: Icon(Icons.archive)),
      ],
      tabChildren: [
        _buildInboxTab(),
        _buildSentTab(),
        _buildDraftsTab(),
        _buildArchiveTab(),
      ],
    );
  }

  Widget _buildInboxTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filters
          _buildSearchAndFilters(),
          
          SizedBox(height: spLg),
          
          // Quick Stats
          _buildQuickStats(),
          
          SizedBox(height: spLg),
          
          // Email List
          _buildEmailList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
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
            "Search & Filter",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          // Search Field
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search emails...",
                  value: searchQuery,
                  hint: "Subject, sender, client name",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {
                  // Search functionality
                },
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Filter Row
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryItems,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: priorityItems,
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
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

  Widget _buildQuickStats() {
    int unreadCount = emails.where((email) => email["status"] == "unread").length;
    int highPriorityCount = emails.where((email) => email["priority"] == "high").length;
    int attachmentCount = emails.where((email) => email["hasAttachment"] == true).length;
    
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            "Unread",
            "$unreadCount",
            Icons.mark_email_unread,
            dangerColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "High Priority",
            "$highPriorityCount",
            Icons.priority_high,
            warningColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Attachments",
            "$attachmentCount",
            Icons.attach_file,
            infoColor,
          ),
        ),
      ],
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
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
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

  Widget _buildEmailList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Emails (${filteredEmails.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        ...filteredEmails.map((email) => _buildEmailCard(email)).toList(),
      ],
    );
  }

  Widget _buildEmailCard(Map<String, dynamic> email) {
    Color priorityColor = email["priority"] == "high" ? dangerColor :
                         email["priority"] == "medium" ? warningColor : successColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: email["status"] == "unread" ? primaryColor.withAlpha(20) : Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: priorityColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${email["subject"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: email["status"] == "unread" ? FontWeight.bold : FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "From: ${email["sender"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${email["priority"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: priorityColor,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    DateTime.parse("${email["timestamp"]}").dMMMy,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Case Info
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${email["caseNumber"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${email["clientName"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              if (email["hasAttachment"])
                Padding(
                  padding: EdgeInsets.only(left: spSm),
                  child: Icon(
                    Icons.attach_file,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Email Preview
          Text(
            "${email["body"]}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Action Buttons
          Row(
            children: [
              QButton(
                label: "Reply",
                icon: Icons.reply,
                size: bs.sm,
                onPressed: () {
                  _showReplyDialog(email);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Forward",
                icon: Icons.forward,
                size: bs.sm,
                onPressed: () {
                  _showForwardDialog(email);
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  _showEmailActions(email);
                },
                child: Icon(
                  Icons.more_vert,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSentTab() {
    return Center(
      child: Text(
        "Sent emails will be displayed here",
        style: TextStyle(
          fontSize: 16,
          color: disabledBoldColor,
        ),
      ),
    );
  }

  Widget _buildDraftsTab() {
    return Center(
      child: Text(
        "Draft emails will be displayed here",
        style: TextStyle(
          fontSize: 16,
          color: disabledBoldColor,
        ),
      ),
    );
  }

  Widget _buildArchiveTab() {
    return Center(
      child: Text(
        "Archived emails will be displayed here",
        style: TextStyle(
          fontSize: 16,
          color: disabledBoldColor,
        ),
      ),
    );
  }

  void _showReplyDialog(Map<String, dynamic> email) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reply to Email"),
        content: Text("Reply functionality for: ${email["subject"]}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Send Reply"),
          ),
        ],
      ),
    );
  }

  void _showForwardDialog(Map<String, dynamic> email) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Forward Email"),
        content: Text("Forward functionality for: ${email["subject"]}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Forward"),
          ),
        ],
      ),
    );
  }

  void _showEmailActions(Map<String, dynamic> email) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.mark_email_read),
              title: Text("Mark as Read"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text("Archive"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
