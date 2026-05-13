import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaFollowUpView extends StatefulWidget {
  const CmaFollowUpView({super.key});

  @override
  State<CmaFollowUpView> createState() => _CmaFollowUpViewState();
}

class _CmaFollowUpViewState extends State<CmaFollowUpView> {
  String searchQuery = "";
  String selectedStatus = "";
  String selectedPriority = "";
  String selectedType = "";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Pending", "value": "pending"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Overdue", "value": "overdue"},
  ];
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": ""},
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Urgent", "value": "urgent"},
  ];
  
  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": ""},
    {"label": "Sales", "value": "sales"},
    {"label": "Support", "value": "support"},
    {"label": "Meeting", "value": "meeting"},
    {"label": "Proposal", "value": "proposal"},
    {"label": "Contract", "value": "contract"},
  ];

  List<Map<String, dynamic>> followUps = [
    {
      "id": "1",
      "clientName": "Johnson Corp",
      "contactPerson": "Michael Johnson",
      "title": "Quarterly Review Follow-up",
      "description": "Follow up on Q4 performance discussion and next steps",
      "type": "meeting",
      "priority": "high",
      "status": "pending",
      "dueDate": "2024-12-23",
      "originalDate": "2024-12-15",
      "lastContact": "2024-12-15",
      "method": "Email + Phone Call",
      "notes": "Client interested in expanding services for 2025",
      "assignedTo": "John Smith",
      "nextAction": "Send proposal for additional services",
      "urgency": "high",
    },
    {
      "id": "2",
      "clientName": "ABC Industries",
      "contactPerson": "Sarah Wilson",
      "title": "Project Proposal Response",
      "description": "Follow up on submitted project proposal",
      "type": "proposal",
      "priority": "urgent",
      "status": "in_progress",
      "dueDate": "2024-12-22",
      "originalDate": "2024-12-10",
      "lastContact": "2024-12-20",
      "method": "Phone Call",
      "notes": "Client reviewing proposal with board",
      "assignedTo": "Emily Davis",
      "nextAction": "Schedule presentation for board",
      "urgency": "urgent",
    },
    {
      "id": "3",
      "clientName": "TechStart LLC",
      "contactPerson": "Mark Davis",
      "title": "Implementation Support",
      "description": "Check on software implementation progress",
      "type": "support",
      "priority": "medium",
      "status": "completed",
      "dueDate": "2024-12-20",
      "originalDate": "2024-12-05",
      "lastContact": "2024-12-19",
      "method": "Video Call",
      "notes": "Implementation successful, training completed",
      "assignedTo": "David Brown",
      "nextAction": "Schedule monthly check-in",
      "urgency": "low",
    },
    {
      "id": "4",
      "clientName": "Global Solutions",
      "contactPerson": "Lisa Thompson",
      "title": "Contract Renewal Discussion",
      "description": "Follow up on contract renewal terms",
      "type": "contract",
      "priority": "high",
      "status": "overdue",
      "dueDate": "2024-12-18",
      "originalDate": "2024-12-01",
      "lastContact": "2024-12-16",
      "method": "Email",
      "notes": "Client requesting pricing modifications",
      "assignedTo": "Michael Johnson",
      "nextAction": "Prepare revised pricing proposal",
      "urgency": "urgent",
    },
    {
      "id": "5",
      "clientName": "Innovate Inc",
      "contactPerson": "Robert Kim",
      "title": "Demo Feedback Collection",
      "description": "Collect feedback from product demonstration",
      "type": "sales",
      "priority": "medium",
      "status": "pending",
      "dueDate": "2024-12-25",
      "originalDate": "2024-12-18",
      "lastContact": "2024-12-18",
      "method": "Survey + Call",
      "notes": "Demo went well, client needs time to evaluate",
      "assignedTo": "Sarah Wilson",
      "nextAction": "Send follow-up survey and schedule call",
      "urgency": "medium",
    },
    {
      "id": "6",
      "clientName": "Future Tech",
      "contactPerson": "Amanda Brown",
      "title": "Partnership Discussion",
      "description": "Follow up on potential partnership opportunity",
      "type": "sales",
      "priority": "low",
      "status": "in_progress",
      "dueDate": "2024-12-30",
      "originalDate": "2024-12-12",
      "lastContact": "2024-12-21",
      "method": "Meeting",
      "notes": "Initial discussions positive, waiting for proposal",
      "assignedTo": "John Smith",
      "nextAction": "Draft partnership agreement outline",
      "urgency": "low",
    },
  ];

  List<Map<String, dynamic>> get filteredFollowUps {
    return followUps.where((followUp) {
      bool matchesSearch = searchQuery.isEmpty ||
          (followUp["clientName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (followUp["title"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus.isEmpty || followUp["status"] == selectedStatus;
      bool matchesPriority = selectedPriority.isEmpty || followUp["priority"] == selectedPriority;
      bool matchesType = selectedType.isEmpty || followUp["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesPriority && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Follow-ups"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Navigate to add follow-up
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
            child: _buildFollowUpsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    int totalFollowUps = followUps.length;
    int pendingFollowUps = followUps.where((f) => f["status"] == "pending").length;
    int overdueFollowUps = followUps.where((f) => f["status"] == "overdue").length;
    int completedFollowUps = followUps.where((f) => f["status"] == "completed").length;

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
            "Follow-up Overview",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Total", totalFollowUps, Colors.white),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Pending", pendingFollowUps, warningColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Overdue", overdueFollowUps, dangerColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Completed", completedFollowUps, successColor),
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
            label: "Search Follow-ups",
            value: searchQuery,
            hint: "Search by client name or follow-up title",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
            ],
          ),
          QDropdownField(
            label: "Type",
            items: typeOptions,
            value: selectedType,
            onChanged: (value, label) {
              selectedType = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFollowUpsList() {
    if (filteredFollowUps.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spSm,
          children: [
            Icon(
              Icons.follow_the_signs,
              size: 64,
              color: disabledColor,
            ),
            Text(
              "No follow-ups found",
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
      itemCount: filteredFollowUps.length,
      itemBuilder: (context, index) {
        final followUp = filteredFollowUps[index];
        return _buildFollowUpCard(followUp, index);
      },
    );
  }

  Widget _buildFollowUpCard(Map<String, dynamic> followUp, int index) {
    Color priorityColor = _getPriorityColor(followUp["priority"]);
    Color statusColor = _getStatusColor(followUp["status"]);
    Color typeColor = _getTypeColor(followUp["type"]);
    bool isOverdue = followUp["status"] == "overdue";
    
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
            color: isOverdue ? dangerColor : priorityColor,
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
                child: Text(
                  "${followUp["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: isOverdue ? dangerColor : primaryColor,
                  ),
                ),
              ),
              if (isOverdue)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "OVERDUE",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: dangerColor,
                    ),
                  ),
                ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${followUp["status"]}".replaceAll("_", " ").toUpperCase(),
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
            "${followUp["clientName"]} • ${followUp["contactPerson"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${followUp["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
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
                "Due: ${followUp["dueDate"]}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isOverdue ? dangerColor : disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.history,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Last: ${followUp["lastContact"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
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
                "Assigned to: ${followUp["assignedTo"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${followUp["type"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: typeColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.contact_phone,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Method: ${followUp["method"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${followUp["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: priorityColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Next Action:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
                Text(
                  "${followUp["nextAction"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
          if (followUp["notes"] != null && (followUp["notes"] as String).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "Notes: ${followUp["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: warningColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          Row(
            children: [
              if (followUp["status"] == "pending" || followUp["status"] == "overdue")
                QButton(
                  icon: Icons.check,
                  size: bs.sm,
                  onPressed: () {
                    _markAsCompleted(followUp["id"]);
                  },
                ),
              if (followUp["status"] == "pending" || followUp["status"] == "overdue")
                SizedBox(width: spSm),
              if (followUp["status"] == "pending" || followUp["status"] == "overdue")
                QButton(
                  icon: Icons.play_arrow,
                  size: bs.sm,
                  onPressed: () {
                    _startFollowUp(followUp["id"]);
                  },
                ),
              if (followUp["status"] == "pending" || followUp["status"] == "overdue")
                SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  // Navigate to edit follow-up
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {
                  // Navigate to follow-up details
                },
              ),
              Spacer(),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showFollowUpActions(followUp);
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return warningColor;
      case "in_progress":
        return infoColor;
      case "completed":
        return successColor;
      case "overdue":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "sales":
        return primaryColor;
      case "support":
        return successColor;
      case "meeting":
        return infoColor;
      case "proposal":
        return warningColor;
      case "contract":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _markAsCompleted(String followUpId) {
    setState(() {
      int index = followUps.indexWhere((f) => f["id"] == followUpId);
      if (index != -1) {
        followUps[index]["status"] = "completed";
      }
    });
    ss("Follow-up marked as completed");
  }

  void _startFollowUp(String followUpId) {
    setState(() {
      int index = followUps.indexWhere((f) => f["id"] == followUpId);
      if (index != -1) {
        followUps[index]["status"] = "in_progress";
      }
    });
    ss("Follow-up started");
  }

  void _showFollowUpActions(Map<String, dynamic> followUp) {
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
                label: "Schedule Call",
                size: bs.md,
                onPressed: () {
                  back();
                  _scheduleCall(followUp);
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Send Email",
                size: bs.md,
                onPressed: () {
                  back();
                  _sendEmail(followUp);
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
                  _createTask(followUp);
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Reschedule",
                size: bs.md,
                onPressed: () {
                  back();
                  _rescheduleFollowUp(followUp);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scheduleCall(Map<String, dynamic> followUp) {
    ss("Call scheduled with ${followUp["clientName"]}");
  }

  void _sendEmail(Map<String, dynamic> followUp) {
    ss("Email template opened for ${followUp["clientName"]}");
  }

  void _createTask(Map<String, dynamic> followUp) {
    ss("Task created for ${followUp["title"]}");
  }

  void _rescheduleFollowUp(Map<String, dynamic> followUp) {
    ss("Follow-up rescheduled");
  }
}
