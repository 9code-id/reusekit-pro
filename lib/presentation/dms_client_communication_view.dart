import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsClientCommunicationView extends StatefulWidget {
  const DmsClientCommunicationView({super.key});

  @override
  State<DmsClientCommunicationView> createState() => _DmsClientCommunicationViewState();
}

class _DmsClientCommunicationViewState extends State<DmsClientCommunicationView> {
  String selectedClient = "all";
  String selectedChannel = "all";
  String searchQuery = "";
  bool loading = false;
  String newMessage = "";
  List<String> messageAttachments = [];

  List<Map<String, dynamic>> clients = [
    {"label": "All Clients", "value": "all"},
    {"label": "TechCorp Solutions", "value": "1"},
    {"label": "Global Marketing Inc", "value": "2"},
    {"label": "StartupXYZ", "value": "3"},
    {"label": "Enterprise Corp", "value": "4"},
  ];

  List<Map<String, dynamic>> communications = [
    {
      "id": 1,
      "clientId": 1,
      "clientName": "TechCorp Solutions",
      "contactPerson": "John Smith",
      "channel": "email",
      "subject": "Project Update - Q2 Review",
      "message": "Hi John, I wanted to provide you with an update on the Q2 project progress. We've completed 80% of the planned deliverables...",
      "timestamp": "2024-06-19 14:30",
      "status": "sent",
      "priority": "high",
      "attachments": 2,
      "avatar": "https://picsum.photos/100/100?random=1&keyword=business",
    },
    {
      "id": 2,
      "clientId": 2,
      "clientName": "Global Marketing Inc",
      "contactPerson": "Sarah Johnson",
      "channel": "phone",
      "subject": "Campaign Strategy Discussion",
      "message": "Discussed new marketing campaign strategies for Q3. Key points covered: target audience, budget allocation, timeline...",
      "timestamp": "2024-06-19 10:15",
      "status": "completed",
      "priority": "medium",
      "attachments": 0,
      "avatar": "https://picsum.photos/100/100?random=2&keyword=marketing",
    },
    {
      "id": 3,
      "clientId": 1,
      "clientName": "TechCorp Solutions",
      "contactPerson": "John Smith",
      "channel": "video",
      "subject": "Weekly Standup Meeting",
      "message": "Weekly project review meeting. Discussed current progress, upcoming milestones, and resource requirements...",
      "timestamp": "2024-06-18 16:00",
      "status": "completed",
      "priority": "low",
      "attachments": 1,
      "avatar": "https://picsum.photos/100/100?random=1&keyword=business",
    },
    {
      "id": 4,
      "clientId": 3,
      "clientName": "StartupXYZ",
      "contactPerson": "Mike Chen",
      "channel": "chat",
      "subject": "Quick Status Update",
      "message": "Just wanted to check in on the mobile app development progress. Any blockers we need to address?",
      "timestamp": "2024-06-18 09:45",
      "status": "pending",
      "priority": "medium",
      "attachments": 0,
      "avatar": "https://picsum.photos/100/100?random=3&keyword=startup",
    },
  ];

  List<Map<String, dynamic>> templates = [
    {
      "id": 1,
      "name": "Project Update",
      "subject": "Project Progress Update",
      "content": "Hi [CLIENT_NAME],\n\nI wanted to provide you with an update on [PROJECT_NAME]...",
    },
    {
      "id": 2,
      "name": "Meeting Reminder",
      "subject": "Upcoming Meeting Reminder",
      "content": "Hi [CLIENT_NAME],\n\nThis is a reminder about our upcoming meeting...",
    },
    {
      "id": 3,
      "name": "Invoice Notification",
      "subject": "Invoice Ready for Review",
      "content": "Hi [CLIENT_NAME],\n\nYour invoice for [PERIOD] is ready for review...",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client Communication"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startNewCommunication(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCommunicationStats(),
                  SizedBox(height: spLg),
                  _buildQuickActions(),
                  SizedBox(height: spLg),
                  _buildFiltersAndSearch(),
                  SizedBox(height: spLg),
                  _buildCommunicationsList(),
                  SizedBox(height: spLg),
                  _buildQuickMessage(),
                ],
              ),
            ),
    );
  }

  Widget _buildCommunicationStats() {
    return Container(
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
            "Communication Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildStatCard("Total", "24", Icons.message, primaryColor),
              SizedBox(width: spSm),
              _buildStatCard("Pending", "6", Icons.schedule, warningColor),
              SizedBox(width: spSm),
              _buildStatCard("Completed", "18", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildStatCard("Response Rate", "94%", Icons.trending_up, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
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
          SizedBox(height: spSm),
          Row(
            children: [
              _buildActionButton("Send Email", Icons.email, primaryColor, () => _sendEmail()),
              SizedBox(width: spSm),
              _buildActionButton("Schedule Call", Icons.phone, successColor, () => _scheduleCall()),
              SizedBox(width: spSm),
              _buildActionButton("Video Meeting", Icons.videocam, infoColor, () => _startVideoMeeting()),
              SizedBox(width: spSm),
              _buildActionButton("Live Chat", Icons.chat, warningColor, () => _startLiveChat()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback onPressed) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: color.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: color.withAlpha(30)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(height: spXs),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFiltersAndSearch() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "Search communications...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Client",
                  items: clients,
                  value: selectedClient,
                  onChanged: (value, label) {
                    selectedClient = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QCategoryPicker(
            items: [
              {"label": "All", "value": "all"},
              {"label": "Email", "value": "email"},
              {"label": "Phone", "value": "phone"},
              {"label": "Video", "value": "video"},
              {"label": "Chat", "value": "chat"},
            ],
            value: selectedChannel,
            onChanged: (index, label, value, item) {
              selectedChannel = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCommunicationsList() {
    final filteredCommunications = _getFilteredCommunications();

    return Container(
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
            "Recent Communications (${filteredCommunications.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...filteredCommunications.map((comm) => _buildCommunicationCard(comm)).toList(),
        ],
      ),
    );
  }

  Widget _buildCommunicationCard(Map<String, dynamic> comm) {
    IconData channelIcon;
    Color channelColor;

    switch (comm["channel"]) {
      case "email":
        channelIcon = Icons.email;
        channelColor = primaryColor;
        break;
      case "phone":
        channelIcon = Icons.phone;
        channelColor = successColor;
        break;
      case "video":
        channelIcon = Icons.videocam;
        channelColor = infoColor;
        break;
      case "chat":
        channelIcon = Icons.chat;
        channelColor = warningColor;
        break;
      default:
        channelIcon = Icons.message;
        channelColor = disabledBoldColor;
    }

    Color priorityColor;
    switch (comm["priority"]) {
      case "high":
        priorityColor = dangerColor;
        break;
      case "medium":
        priorityColor = warningColor;
        break;
      default:
        priorityColor = successColor;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${comm["avatar"]}"),
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
                          "${comm["clientName"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: priorityColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${comm["contactPerson"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: channelColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(channelIcon, color: channelColor, size: 16),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${comm["subject"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${comm["message"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "${comm["timestamp"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                  if ((comm["attachments"] as int) > 0) ...[
                    SizedBox(width: spSm),
                    Icon(Icons.attach_file, size: 12, color: disabledBoldColor),
                    Text(
                      "${comm["attachments"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: comm["status"] == "completed"
                          ? successColor.withAlpha(20)
                          : comm["status"] == "pending"
                              ? warningColor.withAlpha(20)
                              : primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${comm["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: comm["status"] == "completed"
                            ? successColor
                            : comm["status"] == "pending"
                                ? warningColor
                                : primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.reply,
                    size: bs.sm,
                    onPressed: () => _replyToCommunication(comm),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickMessage() {
    return Container(
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
            "Quick Message",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Select Client",
                  items: clients.where((c) => c["value"] != "all").toList(),
                  value: selectedClient != "all" ? selectedClient : "",
                  onChanged: (value, label) {
                    selectedClient = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.bookmark,
                size: bs.sm,
                onPressed: () => _showTemplates(),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QChatField(
            label: "Message",
            value: newMessage,
            hint: "Type your message...",
            attachments: messageAttachments,
            showAttachmentButton: true,
            showEmojiButton: true,
            onChanged: (value) {
              newMessage = value;
              setState(() {});
            },
            onSend: () {
              if (newMessage.isNotEmpty && selectedClient != "all" && selectedClient.isNotEmpty) {
                _sendQuickMessage();
              } else {
                se("Please select a client and enter a message");
              }
            },
            onAttachmentsChanged: (value) {
              messageAttachments = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCommunications() {
    return communications.where((comm) {
      final matchesSearch = searchQuery.isEmpty ||
          comm["subject"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          comm["clientName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          comm["message"].toString().toLowerCase().contains(searchQuery.toLowerCase());

      final matchesClient = selectedClient == "all" ||
          comm["clientId"].toString() == selectedClient;

      final matchesChannel = selectedChannel == "all" ||
          comm["channel"] == selectedChannel;

      return matchesSearch && matchesClient && matchesChannel;
    }).toList();
  }

  void _startNewCommunication() {
    // navigateTo('NewCommunicationView')
  }

  void _sendEmail() {
    // navigateTo('ComposeEmailView')
  }

  void _scheduleCall() {
    // navigateTo('ScheduleCallView')
  }

  void _startVideoMeeting() {
    // navigateTo('VideoMeetingView')
  }

  void _startLiveChat() {
    // navigateTo('LiveChatView')
  }

  void _replyToCommunication(Map<String, dynamic> comm) {
    // navigateTo('ReplyView')
  }

  void _showTemplates() {
    // Show template selection dialog
  }

  void _sendQuickMessage() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));
    
    loading = false;
    newMessage = "";
    messageAttachments = [];
    setState(() {});
    
    ss("Message sent successfully!");
  }
}
