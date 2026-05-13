import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlComment9View extends StatefulWidget {
  @override
  State<GrlComment9View> createState() => _GrlComment9ViewState();
}

class _GrlComment9ViewState extends State<GrlComment9View> {
  String comment = "";
  String selectedCategory = "All";
  List<String> categories = ["All", "General", "Help", "Feature Request", "Bug Report", "Feedback"];
  bool isLoading = false;
  
  List<Map<String, dynamic>> supportComments = [
    {
      "id": "1",
      "ticket": "TICKET-2024-001",
      "user": {
        "name": "Jennifer Walsh",
        "avatar": "https://picsum.photos/40/40?random=51",
        "email": "jennifer.walsh@company.com",
        "plan": "Enterprise",
        "joinDate": "Member since 2022",
      },
      "category": "Bug Report",
      "priority": "High",
      "status": "In Progress",
      "subject": "Payment processing issue with subscription renewal",
      "content": "I'm experiencing issues with my subscription renewal. The payment keeps failing despite having sufficient funds and a valid card. This is affecting our entire team's access to premium features.\n\nSteps I've already tried:\n1. Updated payment method\n2. Contacted my bank (no issues on their end)\n3. Cleared browser cache\n4. Tried different browsers\n\nUrgent assistance needed as this is impacting our business operations.",
      "likes": 12,
      "replies": 8,
      "views": 145,
      "isLiked": false,
      "timestamp": "2h ago",
      "lastActivity": "45m ago",
      "tags": ["payment", "subscription", "urgent", "enterprise"],
      "attachments": [
        {
          "name": "error_screenshot.png",
          "type": "image",
          "size": "2.4 MB"
        },
        {
          "name": "payment_logs.txt",
          "type": "document",
          "size": "45 KB"
        }
      ],
      "assignedTo": {
        "name": "Support Team Alpha",
        "avatar": "https://picsum.photos/40/40?random=101",
        "role": "Technical Support"
      },
      "solution": "",
      "satisfaction": null,
      "replies_list": [
        {
          "id": "1-1",
          "user": {
            "name": "Alex Thompson",
            "avatar": "https://picsum.photos/40/40?random=102",
            "role": "Support Specialist",
            "isStaff": true,
          },
          "content": "Hi Jennifer, thank you for the detailed report. I've escalated this to our billing team and they're investigating the payment gateway issue. We'll have an update for you within the next 2 hours.",
          "timestamp": "1h ago",
          "isStaff": true,
          "helpful": 15,
        }
      ]
    },
    {
      "id": "2",
      "ticket": "TICKET-2024-002",
      "user": {
        "name": "Michael Rodriguez",
        "avatar": "https://picsum.photos/40/40?random=52",
        "email": "m.rodriguez@startup.io",
        "plan": "Pro",
        "joinDate": "Member since 2023",
      },
      "category": "Feature Request",
      "priority": "Medium",
      "status": "Under Review",
      "subject": "API rate limiting customization for Pro plans",
      "content": "Would it be possible to add customizable API rate limits for Pro plan users? Our application has varying traffic patterns and the current fixed limits sometimes cause issues during peak hours.\n\nProposed features:\n• Custom rate limit configuration\n• Burst allowance settings\n• Real-time usage monitoring\n• Automatic scaling options\n\nThis would significantly improve our integration experience and allow for better resource planning.",
      "likes": 28,
      "replies": 15,
      "views": 234,
      "isLiked": true,
      "timestamp": "1d ago",
      "lastActivity": "3h ago",
      "tags": ["api", "rate-limiting", "pro-plan", "enhancement"],
      "attachments": [],
      "assignedTo": {
        "name": "Product Team",
        "avatar": "https://picsum.photos/40/40?random=103",
        "role": "Product Manager"
      },
      "solution": "",
      "satisfaction": null,
      "replies_list": []
    },
    {
      "id": "3",
      "ticket": "TICKET-2024-003",
      "user": {
        "name": "Sarah Chen",
        "avatar": "https://picsum.photos/40/40?random=53",
        "email": "sarah.chen@design.co",
        "plan": "Basic",
        "joinDate": "Member since 2024",
      },
      "category": "Help",
      "priority": "Low",
      "status": "Resolved",
      "subject": "How to export data in bulk format?",
      "content": "I need to export all my project data for backup purposes. I can't seem to find the bulk export option in the dashboard. Could someone guide me through the process?\n\nI'm looking to export:\n• Project files\n• User comments\n• Version history\n• Associated metadata\n\nAny help would be appreciated!",
      "likes": 8,
      "replies": 6,
      "views": 89,
      "isLiked": false,
      "timestamp": "2d ago",
      "lastActivity": "1d ago",
      "tags": ["export", "data", "backup", "help"],
      "attachments": [],
      "assignedTo": {
        "name": "Community Support",
        "avatar": "https://picsum.photos/40/40?random=104",
        "role": "Community Manager"
      },
      "solution": "Navigate to Settings > Data Management > Export. Select the data types you want to include and click 'Generate Export'. You'll receive an email with download links once processing is complete.",
      "satisfaction": 5,
      "replies_list": []
    },
    {
      "id": "4",
      "ticket": "TICKET-2024-004",
      "user": {
        "name": "David Kim",
        "avatar": "https://picsum.photos/40/40?random=54",
        "email": "david.kim@tech.com",
        "plan": "Enterprise",
        "joinDate": "Member since 2021",
      },
      "category": "Feedback",
      "priority": "Medium",
      "status": "Acknowledged",
      "subject": "Dashboard performance improvements suggestion",
      "content": "The new dashboard design looks great, but I've noticed some performance issues when loading large datasets. Here are some observations and suggestions:\n\nIssues:\n• Initial load takes 8-10 seconds for datasets with 10k+ records\n• Scrolling becomes laggy with complex visualizations\n• Memory usage increases significantly over time\n\nSuggestions:\n• Implement virtual scrolling for large lists\n• Add data pagination options\n• Optimize chart rendering for performance\n• Consider lazy loading for heavy components\n\nOverall, the functionality is excellent - just needs some performance optimization!",
      "likes": 34,
      "replies": 12,
      "views": 456,
      "isLiked": true,
      "timestamp": "3d ago",
      "lastActivity": "6h ago",
      "tags": ["performance", "dashboard", "optimization", "feedback"],
      "attachments": [
        {
          "name": "performance_analysis.pdf",
          "type": "document",
          "size": "1.2 MB"
        }
      ],
      "assignedTo": {
        "name": "Engineering Team",
        "avatar": "https://picsum.photos/40/40?random=105",
        "role": "Lead Developer"
      },
      "solution": "",
      "satisfaction": null,
      "replies_list": []
    }
  ];

  List<Map<String, dynamic>> get filteredComments {
    if (selectedCategory == "All") {
      return supportComments;
    }
    return supportComments.where((comment) => comment["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Support Center"),
        actions: [
          QButton(
            icon: Icons.search,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.help_outline,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Support Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              border: Border(
                bottom: BorderSide(color: disabledColor, width: 1),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.support_agent,
                      color: primaryColor,
                      size: 28,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Customer Support Portal",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Get help, report issues, and share feedback",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: successColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Support Online",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildSupportMetric("Open Tickets", "${filteredComments.where((c) => c["status"] != "Resolved").length}", Icons.assignment, primaryColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildSupportMetric("Avg Response", "2.3h", Icons.schedule, successColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildSupportMetric("Satisfaction", "4.8★", Icons.star, warningColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Category Filter
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Icon(
                  Icons.filter_alt,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QCategoryPicker(
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: filteredComments.map((comment) => _buildSupportTicket(comment)).toList(),
              ),
            ),
          ),

          // Support Comment Input
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowLg],
              border: Border(
                top: BorderSide(color: disabledColor, width: 1),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.support_agent,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Describe your issue or question...",
                        value: comment,
                        hint: "Provide as much detail as possible for faster resolution",
                        onChanged: (value) {
                          comment = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: primaryColor.withAlpha(30)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.priority_high,
                            size: 12,
                            color: primaryColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Normal Priority",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.attach_file,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.screenshot,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    Spacer(),
                    QButton(
                      label: "Submit Ticket",
                      size: bs.sm,
                      onPressed: comment.isNotEmpty ? () {
                        _submitTicket();
                      } : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowXs],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
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

  Widget _buildSupportTicket(Map<String, dynamic> ticket) {
    final user = ticket["user"];
    final attachments = ticket["attachments"] as List;
    final tags = ticket["tags"] as List;
    final assignedTo = ticket["assignedTo"];
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
        border: Border(
          left: BorderSide(
            color: _getPriorityColor(ticket["priority"]),
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ticket Header
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("${user["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${user["name"]}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPlanColor(user["plan"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${user["plan"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getPlanColor(user["plan"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${user["email"]} • ${user["joinDate"]}",
                      style: TextStyle(
                        fontSize: 11,
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
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor(ticket["status"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${ticket["status"]}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(ticket["status"]),
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "${ticket["ticket"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                      fontFamily: "monospace",
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Ticket Info
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getCategoryColor(ticket["category"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${ticket["category"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _getCategoryColor(ticket["category"]),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getPriorityColor(ticket["priority"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.flag,
                      size: 10,
                      color: _getPriorityColor(ticket["priority"]),
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${ticket["priority"]}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _getPriorityColor(ticket["priority"]),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                "${ticket["timestamp"]} • Last: ${ticket["lastActivity"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          SizedBox(height: spSm),

          // Subject
          Text(
            "${ticket["subject"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          SizedBox(height: spSm),

          // Content
          Text(
            "${ticket["content"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.5,
            ),
          ),

          // Tags
          if (tags.isNotEmpty) ...[
            SizedBox(height: spSm),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: tags.map((tag) => Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "#$tag",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              )).toList(),
            ),
          ],

          // Attachments
          if (attachments.isNotEmpty) ...[
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.attach_file,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Attachments (${attachments.length})",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...attachments.map((attachment) => Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Row(
                      children: [
                        Icon(
                          _getFileIcon(attachment["type"]),
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${attachment["name"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${attachment["size"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ],

          // Solution (if resolved)
          if (ticket["solution"] != "") ...[
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: successColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Solution",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${ticket["solution"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],

          SizedBox(height: spMd),

          // Assigned To & Actions
          Container(
            padding: EdgeInsets.symmetric(vertical: spSm),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: disabledColor, width: 1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("${assignedTo["avatar"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${assignedTo["name"]}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${assignedTo["role"]}",
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
                    Icon(
                      Icons.visibility,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${ticket["views"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.reply,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${ticket["replies"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: spSm),
                if (ticket["satisfaction"] != null) ...[
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: warningColor,
                      ),
                      SizedBox(width: 2),
                      Text(
                        "${ticket["satisfaction"]}/5",
                        style: TextStyle(
                          fontSize: 11,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High": return dangerColor;
      case "Medium": return warningColor;
      case "Low": return successColor;
      default: return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Progress": return infoColor;
      case "Under Review": return warningColor;
      case "Resolved": return successColor;
      case "Acknowledged": return primaryColor;
      default: return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Bug Report": return dangerColor;
      case "Feature Request": return infoColor;
      case "Help": return successColor;
      case "Feedback": return warningColor;
      default: return primaryColor;
    }
  }

  Color _getPlanColor(String plan) {
    switch (plan) {
      case "Enterprise": return dangerColor;
      case "Pro": return warningColor;
      case "Basic": return successColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getFileIcon(String type) {
    switch (type) {
      case "image": return Icons.image;
      case "document": return Icons.description;
      case "video": return Icons.video_library;
      default: return Icons.attach_file;
    }
  }

  void _submitTicket() {
    if (comment.trim().isEmpty) return;
    
    isLoading = true;
    setState(() {});
    
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      final newTicket = {
        "id": "${supportComments.length + 1}",
        "ticket": "TICKET-2024-${(supportComments.length + 1).toString().padLeft(3, '0')}",
        "user": {
          "name": "You",
          "avatar": "https://picsum.photos/40/40?random=100",
          "email": "you@company.com",
          "plan": "Pro",
          "joinDate": "Member since 2024",
        },
        "category": "General",
        "priority": "Medium",
        "status": "Open",
        "subject": comment.length > 50 ? "${comment.substring(0, 50)}..." : comment,
        "content": comment,
        "likes": 0,
        "replies": 0,
        "views": 1,
        "isLiked": false,
        "timestamp": "now",
        "lastActivity": "now",
        "tags": ["user-submitted"],
        "attachments": [],
        "assignedTo": {
          "name": "Support Team",
          "avatar": "https://picsum.photos/40/40?random=106",
          "role": "Technical Support"
        },
        "solution": "",
        "satisfaction": null,
        "replies_list": [],
      };
      
      supportComments.insert(0, newTicket);
      comment = "";
      isLoading = false;
      setState(() {});
      
      ss("Support ticket submitted successfully! Ticket ID: ${newTicket["ticket"]}");
    });
  }
}
