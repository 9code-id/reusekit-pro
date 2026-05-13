import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCommunicationView extends StatefulWidget {
  const CmaCommunicationView({super.key});

  @override
  State<CmaCommunicationView> createState() => _CmaCommunicationViewState();
}

class _CmaCommunicationViewState extends State<CmaCommunicationView> {
  int selectedTabIndex = 0;
  String searchQuery = "";
  String selectedType = "";
  String selectedClient = "";
  
  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": ""},
    {"label": "Email", "value": "email"},
    {"label": "Phone Call", "value": "phone"},
    {"label": "Video Call", "value": "video"},
    {"label": "Meeting", "value": "meeting"},
    {"label": "SMS", "value": "sms"},
    {"label": "WhatsApp", "value": "whatsapp"},
  ];
  
  List<Map<String, dynamic>> clientOptions = [
    {"label": "All Clients", "value": ""},
    {"label": "Johnson Corp", "value": "johnson_corp"},
    {"label": "ABC Industries", "value": "abc_industries"},
    {"label": "TechStart LLC", "value": "techstart_llc"},
    {"label": "Global Solutions", "value": "global_solutions"},
    {"label": "Innovate Inc", "value": "innovate_inc"},
  ];

  List<Map<String, dynamic>> communications = [
    {
      "id": "1",
      "type": "email",
      "direction": "outgoing",
      "clientName": "Johnson Corp",
      "contactPerson": "Michael Johnson",
      "subject": "Q4 Performance Review Results",
      "content": "Thank you for the productive meeting today. As discussed, I'm attaching the Q4 performance analysis...",
      "date": "2024-12-22",
      "time": "10:30",
      "status": "sent",
      "priority": "high",
      "attachments": ["Q4_Report.pdf", "Action_Plan.docx"],
      "tags": ["quarterly-review", "performance", "follow-up"],
      "duration": null,
      "assignedTo": "John Smith",
    },
    {
      "id": "2",
      "type": "phone",
      "direction": "incoming",
      "clientName": "ABC Industries",
      "contactPerson": "Sarah Wilson",
      "subject": "Project Timeline Discussion",
      "content": "Client called to discuss potential delays in project timeline due to resource constraints...",
      "date": "2024-12-21",
      "time": "14:15",
      "status": "completed",
      "priority": "urgent",
      "attachments": [],
      "tags": ["project-timeline", "delays", "resources"],
      "duration": 25,
      "assignedTo": "Emily Davis",
    },
    {
      "id": "3",
      "type": "video",
      "direction": "outgoing",
      "clientName": "TechStart LLC",
      "contactPerson": "Mark Davis",
      "subject": "Product Demo Session",
      "content": "Conducted comprehensive demo of new features. Client showed great interest in automation tools...",
      "date": "2024-12-20",
      "time": "11:00",
      "status": "completed",
      "priority": "medium",
      "attachments": ["Demo_Recording.mp4", "Feature_List.pdf"],
      "tags": ["product-demo", "features", "automation"],
      "duration": 60,
      "assignedTo": "David Brown",
    },
    {
      "id": "4",
      "type": "email",
      "direction": "incoming",
      "clientName": "Global Solutions",
      "contactPerson": "Lisa Thompson",
      "subject": "Contract Amendment Request",
      "content": "We would like to discuss some amendments to the current contract terms regarding payment schedules...",
      "date": "2024-12-19",
      "time": "16:45",
      "status": "pending_response",
      "priority": "high",
      "attachments": ["Contract_Notes.pdf"],
      "tags": ["contract", "amendment", "payment"],
      "duration": null,
      "assignedTo": "Michael Johnson",
    },
    {
      "id": "5",
      "type": "whatsapp",
      "direction": "outgoing",
      "clientName": "Innovate Inc",
      "contactPerson": "Robert Kim",
      "subject": "Quick Update on Implementation",
      "content": "Hi Robert! Quick update - the implementation is going smoothly. We're on track for Friday delivery...",
      "date": "2024-12-18",
      "time": "09:30",
      "status": "delivered",
      "priority": "low",
      "attachments": [],
      "tags": ["implementation", "update", "delivery"],
      "duration": null,
      "assignedTo": "Sarah Wilson",
    },
    {
      "id": "6",
      "type": "meeting",
      "direction": "scheduled",
      "clientName": "Johnson Corp",
      "contactPerson": "Michael Johnson",
      "subject": "Strategic Planning Session",
      "content": "Upcoming strategic planning session to discuss 2025 goals and initiatives...",
      "date": "2024-12-25",
      "time": "10:00",
      "status": "scheduled",
      "priority": "high",
      "attachments": ["Agenda.pdf", "Strategic_Plan_Draft.docx"],
      "tags": ["strategic-planning", "2025-goals", "initiatives"],
      "duration": 120,
      "assignedTo": "John Smith",
    },
  ];

  List<Map<String, dynamic>> get filteredCommunications {
    return communications.where((comm) {
      bool matchesSearch = searchQuery.isEmpty ||
          (comm["clientName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (comm["subject"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (comm["content"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedType.isEmpty || comm["type"] == selectedType;
      bool matchesClient = selectedClient.isEmpty || 
          (comm["clientName"] as String).toLowerCase().replaceAll(' ', '_') == selectedClient;
      
      return matchesSearch && matchesType && matchesClient;
    }).toList()
      ..sort((a, b) => (b["date"] as String).compareTo(a["date"] as String));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Communications"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              _showNewCommunicationOptions();
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
            child: _buildCommunicationsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    int totalCommunications = communications.length;
    int emailCount = communications.where((c) => c["type"] == "email").length;
    int callCount = communications.where((c) => c["type"] == "phone" || c["type"] == "video").length;
    int pendingCount = communications.where((c) => c["status"] == "pending_response").length;

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
            "Communication Overview",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Total", totalCommunications, Colors.white),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Emails", emailCount, infoColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Calls", callCount, successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Pending", pendingCount, warningColor),
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
          QTextField(
            label: "Search Communications",
            value: searchQuery,
            hint: "Search by client, subject, or content",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Client",
                  items: clientOptions,
                  value: selectedClient,
                  onChanged: (value, label) {
                    selectedClient = value;
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

  Widget _buildCommunicationsList() {
    if (filteredCommunications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spSm,
          children: [
            Icon(
              Icons.chat,
              size: 64,
              color: disabledColor,
            ),
            Text(
              "No communications found",
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your filters",
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
      itemCount: filteredCommunications.length,
      itemBuilder: (context, index) {
        final communication = filteredCommunications[index];
        return _buildCommunicationCard(communication, index);
      },
    );
  }

  Widget _buildCommunicationCard(Map<String, dynamic> communication, int index) {
    Color typeColor = _getTypeColor(communication["type"]);
    Color statusColor = _getStatusColor(communication["status"]);
    Color directionColor = _getDirectionColor(communication["direction"]);
    
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
            color: typeColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                _getTypeIcon(communication["type"]),
                size: 20,
                color: typeColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${communication["subject"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${communication["status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${communication["clientName"]} • ${communication["contactPerson"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${communication["content"]}",
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
                "${communication["date"]} at ${communication["time"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              if (communication["duration"] != null)
                Row(
                  children: [
                    SizedBox(width: spSm),
                    Icon(
                      Icons.timer,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${communication["duration"]} min",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              Spacer(),
              Icon(
                _getDirectionIcon(communication["direction"]),
                size: 16,
                color: directionColor,
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
                "By: ${communication["assignedTo"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor(communication["priority"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${communication["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor(communication["priority"]),
                  ),
                ),
              ),
            ],
          ),
          if ((communication["attachments"] as List).isNotEmpty)
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
                    "Attachments: ${(communication["attachments"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          if ((communication["tags"] as List).isNotEmpty)
            Wrap(
              spacing: spXs,
              children: (communication["tags"] as List).map((tag) => Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "#$tag",
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
                  _replyToCommunication(communication);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.forward,
                size: bs.sm,
                onPressed: () {
                  _forwardCommunication(communication);
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {
                  _viewCommunicationDetails(communication);
                },
              ),
              Spacer(),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showCommunicationActions(communication);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "email":
        return infoColor;
      case "phone":
        return successColor;
      case "video":
        return primaryColor;
      case "meeting":
        return warningColor;
      case "sms":
        return dangerColor;
      case "whatsapp":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "sent":
        return successColor;
      case "delivered":
        return infoColor;
      case "completed":
        return successColor;
      case "pending_response":
        return warningColor;
      case "scheduled":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getDirectionColor(String direction) {
    switch (direction) {
      case "incoming":
        return successColor;
      case "outgoing":
        return infoColor;
      case "scheduled":
        return warningColor;
      default:
        return disabledBoldColor;
    }
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

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "email":
        return Icons.email;
      case "phone":
        return Icons.phone;
      case "video":
        return Icons.video_call;
      case "meeting":
        return Icons.meeting_room;
      case "sms":
        return Icons.sms;
      case "whatsapp":
        return Icons.chat;
      default:
        return Icons.chat;
    }
  }

  IconData _getDirectionIcon(String direction) {
    switch (direction) {
      case "incoming":
        return Icons.call_received;
      case "outgoing":
        return Icons.call_made;
      case "scheduled":
        return Icons.schedule;
      default:
        return Icons.sync_alt;
    }
  }

  void _showNewCommunicationOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "New Communication",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Send Email",
                size: bs.md,
                onPressed: () {
                  back();
                  // Navigate to email composer
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Make Phone Call",
                size: bs.md,
                onPressed: () {
                  back();
                  // Open phone dialer
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Schedule Video Call",
                size: bs.md,
                onPressed: () {
                  back();
                  // Navigate to video call scheduler
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Schedule Meeting",
                size: bs.md,
                onPressed: () {
                  back();
                  // Navigate to meeting scheduler
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _replyToCommunication(Map<String, dynamic> communication) {
    ss("Reply to ${communication["clientName"]} opened");
  }

  void _forwardCommunication(Map<String, dynamic> communication) {
    ss("Forward communication opened");
  }

  void _viewCommunicationDetails(Map<String, dynamic> communication) {
    ss("Viewing details for ${communication["subject"]}");
  }

  void _showCommunicationActions(Map<String, dynamic> communication) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add to Follow-up",
                size: bs.md,
                onPressed: () {
                  back();
                  _addToFollowUp(communication);
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create Task",
                size: bs.md,
                onPressed: () {
                  back();
                  _createTaskFromCommunication(communication);
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Archive",
                size: bs.md,
                onPressed: () {
                  back();
                  _archiveCommunication(communication);
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Export",
                size: bs.md,
                onPressed: () {
                  back();
                  _exportCommunication(communication);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToFollowUp(Map<String, dynamic> communication) {
    ss("Follow-up created from communication");
  }

  void _createTaskFromCommunication(Map<String, dynamic> communication) {
    ss("Task created from communication");
  }

  void _archiveCommunication(Map<String, dynamic> communication) {
    ss("Communication archived");
  }

  void _exportCommunication(Map<String, dynamic> communication) {
    ss("Communication exported");
  }
}
