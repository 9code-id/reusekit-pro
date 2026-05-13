import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmTicketDetailView extends StatefulWidget {
  const CrmTicketDetailView({super.key});

  @override
  State<CrmTicketDetailView> createState() => _CrmTicketDetailViewState();
}

class _CrmTicketDetailViewState extends State<CrmTicketDetailView> {
  int selectedTabIndex = 0;
  String newComment = "";
  bool isWatching = false;
  
  Map<String, dynamic> ticket = {
    "id": "TKT-001",
    "subject": "Unable to login to account",
    "description": "Customer cannot access their account after password reset. They have tried multiple times but keep getting error message 'Invalid credentials'. This is affecting their ability to access important documents and complete time-sensitive tasks.",
    "customer": "John Smith",
    "email": "john.smith@example.com",
    "phone": "+1 234 567 8901",
    "priority": "high",
    "status": "open",
    "category": "technical",
    "assignee": "Sarah Johnson",
    "reporter": "Customer Service",
    "created": "2024-06-19 09:00:00",
    "updated": "2024-06-19 10:30:00",
    "dueDate": "2024-06-20 17:00:00",
    "tags": ["login", "password", "urgent"],
    "resolution": "",
    "timeSpent": "2.5 hours",
    "estimatedTime": "4 hours"
  };

  List<Map<String, dynamic>> comments = [
    {
      "id": "1",
      "author": "Sarah Johnson",
      "role": "Support Agent",
      "content": "I've received this ticket and am investigating the login issue. Will check the authentication logs and get back with an update.",
      "timestamp": "2024-06-19 09:15:00",
      "type": "comment",
      "isInternal": false
    },
    {
      "id": "2",
      "author": "System",
      "role": "System",
      "content": "Ticket status changed from 'new' to 'open'",
      "timestamp": "2024-06-19 09:16:00",
      "type": "status_change",
      "isInternal": true
    },
    {
      "id": "3",
      "author": "John Smith",
      "role": "Customer",
      "content": "I've tried clearing my browser cache and cookies as suggested, but still cannot login. This is urgent as I need to access my account for a presentation today.",
      "timestamp": "2024-06-19 10:00:00",
      "type": "customer_reply",
      "isInternal": false
    },
    {
      "id": "4",
      "author": "Sarah Johnson",
      "role": "Support Agent",
      "content": "Found the issue in the authentication service. There was a configuration error after the recent update. Working on a fix now.",
      "timestamp": "2024-06-19 10:30:00",
      "type": "comment",
      "isInternal": true
    }
  ];

  List<Map<String, dynamic>> attachments = [
    {
      "id": "1",
      "name": "error_screenshot.png",
      "size": "245 KB",
      "type": "image",
      "uploadedBy": "John Smith",
      "uploadedAt": "2024-06-19 09:05:00"
    },
    {
      "id": "2",
      "name": "browser_console_log.txt",
      "size": "12 KB",
      "type": "text",
      "uploadedBy": "John Smith",
      "uploadedAt": "2024-06-19 09:06:00"
    }
  ];

  List<Map<String, dynamic>> relatedTickets = [
    {
      "id": "TKT-045",
      "subject": "Password reset not working",
      "status": "resolved",
      "priority": "medium"
    },
    {
      "id": "TKT-023",
      "subject": "Login page loading slowly",
      "status": "closed",
      "priority": "low"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticket ${ticket["id"]}"),
        actions: [
          QButton(
            icon: isWatching ? Icons.notifications_active : Icons.notifications_none,
            size: bs.sm,
            onPressed: () {
              isWatching = !isWatching;
              setState(() {});
              ss(isWatching ? "Now watching ticket" : "Stopped watching ticket");
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              _showTicketActions();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          _buildTicketHeader(),
          Expanded(
            child: QTabBar(
              withoutAppBar: true,
              selectedIndex: selectedTabIndex,
              tabs: [
                Tab(text: "Details", icon: Icon(Icons.info)),
                Tab(text: "Comments", icon: Icon(Icons.comment)),
                Tab(text: "History", icon: Icon(Icons.history)),
                Tab(text: "Related", icon: Icon(Icons.link)),
              ],
              tabChildren: [
                _buildDetailsTab(),
                _buildCommentsTab(),
                _buildHistoryTab(),
                _buildRelatedTab(),
              ],
              onInit: (tabController) {
                // Optional: Access to TabController
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketHeader() {
    Color priorityColor = _getPriorityColor(ticket["priority"]);
    Color statusColor = _getStatusColor(ticket["status"]);

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: priorityColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${ticket["subject"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${ticket["status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${ticket["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: priorityColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Due: ${DateTime.parse(ticket["dueDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 14,
                  color: dangerColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "Created: ${DateTime.parse(ticket["created"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Customer: ${ticket["customer"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.assignment_ind, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Assigned: ${ticket["assignee"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTicketInfo(),
          _buildCustomerInfo(),
          _buildTicketProgress(),
          _buildAttachments(),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildCommentsTab() {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.all(spMd),
            itemCount: comments.length,
            separatorBuilder: (context, index) => SizedBox(height: spMd),
            itemBuilder: (context, index) {
              final comment = comments[index];
              return _buildCommentItem(comment);
            },
          ),
        ),
        _buildCommentInput(),
      ],
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTimeTracking(),
          _buildActivityLog(),
        ],
      ),
    );
  }

  Widget _buildRelatedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRelatedTickets(),
          _buildKnowledgeBase(),
        ],
      ),
    );
  }

  Widget _buildTicketInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Description",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${ticket["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),
          if (ticket["tags"] != null) ...[
            Text(
              "Tags",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Wrap(
              spacing: spSm,
              children: (ticket["tags"] as List).map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "$tag",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.bold,
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

  Widget _buildCustomerInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Customer Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${ticket["customer"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${ticket["email"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${ticket["phone"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.email,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTicketProgress() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Time Spent",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${ticket["timeSpent"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Estimated Time",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${ticket["estimatedTime"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.65,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          Text(
            "65% complete",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachments() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Attachments",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add File",
                size: bs.sm,
                icon: Icons.attach_file,
                onPressed: () {},
              ),
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: attachments.length,
            separatorBuilder: (context, index) => SizedBox(height: spSm),
            itemBuilder: (context, index) {
              final attachment = attachments[index];
              return _buildAttachmentItem(attachment);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem(Map<String, dynamic> attachment) {
    IconData iconData = attachment["type"] == "image" 
        ? Icons.image 
        : attachment["type"] == "text"
        ? Icons.description
        : Icons.attach_file;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: infoColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(iconData, color: infoColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${attachment["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${attachment["size"]} • ${attachment["uploadedBy"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Take Ownership",
                  size: bs.sm,
                  icon: Icons.assignment_ind,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Escalate",
                  size: bs.sm,
                  icon: Icons.arrow_upward,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Mark Resolved",
                  size: bs.sm,
                  icon: Icons.check_circle,
                  color: successColor,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Close Ticket",
                  size: bs.sm,
                  icon: Icons.close,
                  color: dangerColor,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> comment) {
    bool isCustomer = comment["role"] == "Customer";
    bool isSystem = comment["role"] == "System";
    Color backgroundColor = isCustomer 
        ? infoColor.withAlpha(10) 
        : isSystem 
        ? warningColor.withAlpha(10)
        : Colors.grey.withAlpha(10);

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isCustomer 
              ? infoColor.withAlpha(30) 
              : isSystem 
              ? warningColor.withAlpha(30)
              : Colors.grey.withAlpha(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isCustomer ? infoColor : primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCustomer ? Icons.person : isSystem ? Icons.settings : Icons.support_agent,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${comment["author"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${comment["role"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${DateTime.parse(comment["timestamp"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            "${comment["content"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.4,
            ),
          ),
          if (comment["isInternal"] == true)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "INTERNAL",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QMemoField(
            label: "Add comment",
            value: newComment,
            hint: "Type your comment here...",
            onChanged: (value) {
              newComment = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              QButton(
                icon: Icons.attach_file,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Add Comment",
                  size: bs.sm,
                  icon: Icons.send,
                  onPressed: () {
                    if (newComment.isNotEmpty) {
                      comments.add({
                        "id": "${comments.length + 1}",
                        "author": "Current User",
                        "role": "Support Agent",
                        "content": newComment,
                        "timestamp": DateTime.now().toString(),
                        "type": "comment",
                        "isInternal": false
                      });
                      newComment = "";
                      setState(() {});
                      ss("Comment added successfully");
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

  Widget _buildTimeTracking() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Time Tracking",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Start Timer",
                  size: bs.sm,
                  icon: Icons.play_arrow,
                  color: successColor,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Log Time",
                  size: bs.sm,
                  icon: Icons.access_time,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityLog() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Activity Log",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Complete history of all ticket activities",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedTickets() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Related Tickets",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: relatedTickets.length,
            separatorBuilder: (context, index) => SizedBox(height: spSm),
            itemBuilder: (context, index) {
              final relatedTicket = relatedTickets[index];
              return _buildRelatedTicketItem(relatedTicket);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedTicketItem(Map<String, dynamic> relatedTicket) {
    Color statusColor = _getStatusColor(relatedTicket["status"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey.withAlpha(30)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${relatedTicket["id"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${relatedTicket["subject"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${relatedTicket["status"]}".toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKnowledgeBase() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Knowledge Base",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Suggested articles that might help resolve this issue",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          QButton(
            label: "Search Knowledge Base",
            size: bs.sm,
            icon: Icons.search,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "open":
        return dangerColor;
      case "in_progress":
        return warningColor;
      case "pending":
        return infoColor;
      case "resolved":
        return successColor;
      case "closed":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showTicketActions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Ticket Actions"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QButton(
              label: "Edit Ticket",
              size: bs.sm,
              icon: Icons.edit,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            QButton(
              label: "Duplicate",
              size: bs.sm,
              icon: Icons.copy,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            QButton(
              label: "Print",
              size: bs.sm,
              icon: Icons.print,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            QButton(
              label: "Delete",
              size: bs.sm,
              icon: Icons.delete,
              color: dangerColor,
              onPressed: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Delete this ticket?");
                if (isConfirmed) {
                  ss("Ticket deleted successfully");
                }
              },
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
