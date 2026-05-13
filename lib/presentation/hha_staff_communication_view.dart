import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaStaffCommunicationView extends StatefulWidget {
  const HhaStaffCommunicationView({super.key});

  @override
  State<HhaStaffCommunicationView> createState() => _HhaStaffCommunicationViewState();
}

class _HhaStaffCommunicationViewState extends State<HhaStaffCommunicationView> {
  String selectedChannel = "All";
  String message = "";
  
  List<Map<String, dynamic>> communications = [
    {
      "id": 1,
      "type": "Announcement",
      "title": "System Maintenance Scheduled",
      "message": "Home automation system maintenance will be performed on Sunday 10 PM - 2 AM. Please prepare for temporary system downtime.",
      "sender": "Admin Team",
      "timestamp": "2024-06-15 14:30",
      "priority": "High",
      "read": false,
      "channel": "System",
      "recipients": 25,
    },
    {
      "id": 2,
      "type": "Alert",
      "title": "Patient Care Update Required",
      "message": "Please update care protocols for Room 204. New medication schedule needs immediate attention.",
      "sender": "Nurse Manager",
      "timestamp": "2024-06-15 11:15",
      "priority": "Urgent",
      "read": true,
      "channel": "Healthcare",
      "recipients": 8,
    },
    {
      "id": 3,
      "type": "Message",
      "title": "Team Meeting Tomorrow",
      "message": "Weekly team meeting scheduled for tomorrow at 9 AM in Conference Room B. Please review agenda attached.",
      "sender": "Dr. Sarah Johnson",
      "timestamp": "2024-06-14 16:45",
      "priority": "Medium",
      "read": true,
      "channel": "General",
      "recipients": 15,
    },
    {
      "id": 4,
      "type": "Emergency",
      "title": "Emergency Protocol Activated",
      "message": "Emergency situation in Building A. All available staff report to stations immediately. Follow emergency procedures.",
      "sender": "Emergency Coordinator",
      "timestamp": "2024-06-14 08:22",
      "priority": "Emergency",
      "read": true,
      "channel": "Emergency",
      "recipients": 50,
    },
  ];

  List<String> channels = ["All", "General", "Healthcare", "System", "Emergency"];
  List<String> priorities = ["Low", "Medium", "High", "Urgent", "Emergency"];

  List<Map<String, dynamic>> get filteredCommunications {
    if (selectedChannel == "All") {
      return communications;
    }
    return communications.where((comm) => comm["channel"] == selectedChannel).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Communication"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              _showNewMessageDialog();
            },
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Communication Stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "${communications.where((c) => c["read"] == false).length}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Unread",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Container(width: 1, height: 30, color: Colors.white.withAlpha(100)),
                  Column(
                    children: [
                      Text(
                        "${communications.where((c) => c["priority"] == "Emergency" || c["priority"] == "Urgent").length}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Priority",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Container(width: 1, height: 30, color: Colors.white.withAlpha(100)),
                  Column(
                    children: [
                      Text(
                        "${communications.length}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Total",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Channel Filter
            Text(
              "Channels",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            QCategoryPicker(
              items: channels.map((channel) => {"label": channel, "value": channel}).toList(),
              value: selectedChannel,
              onChanged: (index, label, value, item) {
                selectedChannel = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),

            // Communications List
            Text(
              "Messages",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Column(
              children: filteredCommunications.map((comm) {
                bool isRead = comm["read"] as bool;
                Color priorityColor = _getPriorityColor(comm["priority"]);
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isRead ? Colors.white : primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border(
                      left: BorderSide(color: priorityColor, width: 4),
                    ),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Message Header
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: _getTypeColor(comm["type"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              _getTypeIcon(comm["type"]),
                              color: _getTypeColor(comm["type"]),
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: priorityColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${comm["priority"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: priorityColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getChannelColor(comm["channel"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${comm["channel"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: _getChannelColor(comm["channel"]),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    if (!isRead) ...[
                                      SizedBox(width: spXs),
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: dangerColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${comm["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${DateTime.parse(comm["timestamp"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),

                      // Message Content
                      Text(
                        "${comm["message"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: spMd),

                      // Message Footer
                      Row(
                        children: [
                          Icon(Icons.person, color: disabledBoldColor, size: 14),
                          SizedBox(width: spXs),
                          Text(
                            "${comm["sender"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.group, color: disabledBoldColor, size: 14),
                          SizedBox(width: spXs),
                          Text(
                            "${comm["recipients"]} recipients",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),

                      // Action Buttons
                      Row(
                        children: [
                          if (!isRead) ...[
                            Expanded(
                              child: QButton(
                                label: "Mark Read",
                                icon: Icons.done,
                                size: bs.sm,
                                onPressed: () {
                                  comm["read"] = true;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                          ],
                          Expanded(
                            child: QButton(
                              label: "Reply",
                              icon: Icons.reply,
                              size: bs.sm,
                              onPressed: () {
                                // Reply to message
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Forward",
                              icon: Icons.forward,
                              size: bs.sm,
                              onPressed: () {
                                // Forward message
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showNewMessageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("New Message"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Subject",
              value: "",
              onChanged: (value) {},
            ),
            SizedBox(height: spSm),
            QMemoField(
              label: "Message",
              value: message,
              onChanged: (value) {
                message = value;
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
          QButton(
            label: "Send",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Message sent successfully");
            },
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Emergency":
        return Colors.red[800]!;
      case "Urgent":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return primaryColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Emergency":
        return Colors.red;
      case "Alert":
        return Colors.orange;
      case "Announcement":
        return Colors.blue;
      case "Message":
        return Colors.green;
      default:
        return primaryColor;
    }
  }

  Color _getChannelColor(String channel) {
    switch (channel) {
      case "Emergency":
        return Colors.red;
      case "Healthcare":
        return Colors.green;
      case "System":
        return Colors.blue;
      case "General":
        return Colors.purple;
      default:
        return primaryColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Emergency":
        return Icons.emergency;
      case "Alert":
        return Icons.warning;
      case "Announcement":
        return Icons.campaign;
      case "Message":
        return Icons.message;
      default:
        return Icons.info;
    }
  }
}