import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHistory10View extends StatefulWidget {
  @override
  State<GrlHistory10View> createState() => _GrlHistory10ViewState();
}

class _GrlHistory10ViewState extends State<GrlHistory10View> {
  String searchQuery = "";
  String selectedChannel = "All";
  String selectedType = "All";

  List<Map<String, dynamic>> communicationHistory = [
    {
      "messageId": "MSG-001",
      "sender": "John Smith",
      "receiver": "Sarah Johnson",
      "channel": "Email",
      "type": "Business",
      "subject": "Project Update - Q4 Review",
      "content": "Please find attached the Q4 project review document for your approval.",
      "timestamp": "2024-12-20 14:30",
      "status": "Read",
      "priority": "High",
      "attachments": ["Q4_Review.pdf", "Budget_Analysis.xlsx"],
      "tags": ["Project", "Review", "Q4"],
    },
    {
      "messageId": "MSG-002",
      "sender": "System Admin",
      "receiver": "All Users",
      "channel": "Notification",
      "type": "System Alert",
      "subject": "Server Maintenance Scheduled",
      "content": "System maintenance is scheduled for Dec 22, 2024 from 2 AM to 4 AM.",
      "timestamp": "2024-12-19 16:45",
      "status": "Delivered",
      "priority": "Medium",
      "attachments": [],
      "tags": ["Maintenance", "System", "Alert"],
    },
    {
      "messageId": "MSG-003",
      "sender": "Mike Wilson",
      "receiver": "Development Team",
      "channel": "Slack",
      "type": "Team Communication",
      "subject": "Code Review Request",
      "content": "Please review the new authentication module. PR #145 is ready for review.",
      "timestamp": "2024-12-19 11:20",
      "status": "Read",
      "priority": "Medium",
      "attachments": ["code_changes.patch"],
      "tags": ["Code Review", "Authentication", "Development"],
    },
    {
      "messageId": "MSG-004",
      "sender": "Lisa Chen",
      "receiver": "HR Department",
      "channel": "Internal Chat",
      "type": "HR Communication",
      "subject": "Leave Application Approval",
      "content": "Your leave application for Dec 25-27 has been approved. Enjoy your holidays!",
      "timestamp": "2024-12-18 09:15",
      "status": "Read",
      "priority": "Low",
      "attachments": [],
      "tags": ["Leave", "Approval", "HR"],
    },
    {
      "messageId": "MSG-005",
      "sender": "David Brown",
      "receiver": "Finance Team",
      "channel": "SMS",
      "type": "Urgent Alert",
      "subject": "Payment Authorization Required",
      "content": "Payment of \$15,000 to vendor ABC Corp requires immediate authorization.",
      "timestamp": "2024-12-17 17:30",
      "status": "Pending",
      "priority": "Critical",
      "attachments": ["invoice_12345.pdf"],
      "tags": ["Payment", "Authorization", "Urgent"],
    },
  ];

  List<Map<String, dynamic>> get filteredCommunications {
    return communicationHistory.where((comm) {
      final matchesSearch = comm["subject"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          comm["sender"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          comm["receiver"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          comm["content"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      final matchesChannel = selectedChannel == "All" || comm["channel"] == selectedChannel;
      final matchesType = selectedType == "All" || comm["type"] == selectedType;
      return matchesSearch && matchesChannel && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Communication History"),
        actions: [
          IconButton(
            icon: Icon(Icons.mark_chat_read),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilters(),
            _buildCommunicationStats(),
            _buildCommunicationList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search communications",
                value: searchQuery,
                hint: "Search by subject, sender, receiver...",
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
              onPressed: () {},
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Channel",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Email", "value": "Email"},
                  {"label": "Slack", "value": "Slack"},
                  {"label": "SMS", "value": "SMS"},
                  {"label": "Notification", "value": "Notification"},
                  {"label": "Internal Chat", "value": "Internal Chat"},
                ],
                value: selectedChannel,
                onChanged: (value, label) {
                  selectedChannel = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Type",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Business", "value": "Business"},
                  {"label": "System Alert", "value": "System Alert"},
                  {"label": "Team Communication", "value": "Team Communication"},
                  {"label": "HR Communication", "value": "HR Communication"},
                  {"label": "Urgent Alert", "value": "Urgent Alert"},
                ],
                value: selectedType,
                onChanged: (value, label) {
                  selectedType = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCommunicationStats() {
    final readCount = communicationHistory.where((c) => c["status"] == "Read").length;
    final pendingCount = communicationHistory.where((c) => c["status"] == "Pending").length;
    final criticalCount = communicationHistory.where((c) => c["priority"] == "Critical").length;
    final totalAttachments = communicationHistory.fold(0, (sum, c) => sum + (c["attachments"] as List).length);

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            "Read",
            readCount.toString(),
            Icons.mark_chat_read,
            successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Pending",
            pendingCount.toString(),
            Icons.schedule,
            warningColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Critical",
            criticalCount.toString(),
            Icons.priority_high,
            dangerColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Attachments",
            totalAttachments.toString(),
            Icons.attach_file,
            infoColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunicationList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Communications (${filteredCommunications.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredCommunications.length,
          itemBuilder: (context, index) {
            final communication = filteredCommunications[index];
            return _buildCommunicationCard(communication);
          },
        ),
      ],
    );
  }

  Widget _buildCommunicationCard(Map<String, dynamic> communication) {
    final attachments = communication["attachments"] as List;
    final hasAttachments = attachments.isNotEmpty;
    final tags = communication["tags"] as List;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor(communication["priority"]),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${communication["messageId"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${communication["subject"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
                      color: _getChannelColor(communication["channel"]).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${communication["channel"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _getChannelColor(communication["channel"]),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor(communication["status"]).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${communication["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(communication["status"]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "From: ${communication["sender"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "To: ${communication["receiver"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${communication["content"]}",
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
              ),
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${communication["timestamp"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getPriorityColor(communication["priority"]).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${communication["priority"]} Priority",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor(communication["priority"]),
                  ),
                ),
              ),
            ],
          ),
          if (hasAttachments) ...[
            Row(
              children: [
                Icon(
                  Icons.attach_file,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Attachments: ${attachments.join(", ")}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (tags.isNotEmpty) ...[
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: tags.map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: secondaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "#$tag",
                    style: TextStyle(
                      fontSize: 10,
                      color: secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          Row(
            children: [
              Text(
                "${communication["type"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Spacer(),
              QButton(
                label: "View Full",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Read":
        return successColor;
      case "Delivered":
        return infoColor;
      case "Pending":
        return warningColor;
      case "Failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getChannelColor(String channel) {
    switch (channel) {
      case "Email":
        return infoColor;
      case "Slack":
        return successColor;
      case "SMS":
        return warningColor;
      case "Notification":
        return secondaryColor;
      case "Internal Chat":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }
}
