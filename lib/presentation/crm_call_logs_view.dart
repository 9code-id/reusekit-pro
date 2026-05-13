import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmCallLogsView extends StatefulWidget {
  const CrmCallLogsView({super.key});

  @override
  State<CrmCallLogsView> createState() => _CrmCallLogsViewState();
}

class _CrmCallLogsViewState extends State<CrmCallLogsView> {
  String searchQuery = "";
  String selectedType = "all";
  String selectedStatus = "all";
  String selectedAgent = "all";
  String selectedDateRange = "7_days";
  bool loading = false;

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Inbound", "value": "inbound"},
    {"label": "Outbound", "value": "outbound"},
    {"label": "Internal", "value": "internal"},
    {"label": "Conference", "value": "conference"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Completed", "value": "completed"},
    {"label": "Missed", "value": "missed"},
    {"label": "Busy", "value": "busy"},
    {"label": "No Answer", "value": "no_answer"},
    {"label": "Failed", "value": "failed"},
  ];

  List<Map<String, dynamic>> agentOptions = [
    {"label": "All Agents", "value": "all"},
    {"label": "John Smith", "value": "agent_001"},
    {"label": "Sarah Wilson", "value": "agent_002"},
    {"label": "Mike Johnson", "value": "agent_003"},
    {"label": "Emily Davis", "value": "agent_004"},
    {"label": "David Brown", "value": "agent_005"},
  ];

  List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "Today", "value": "today"},
    {"label": "Yesterday", "value": "yesterday"},
    {"label": "Last 7 Days", "value": "7_days"},
    {"label": "Last 30 Days", "value": "30_days"},
    {"label": "This Month", "value": "this_month"},
    {"label": "Last Month", "value": "last_month"},
  ];

  List<Map<String, dynamic>> callLogs = [
    {
      "id": "log_001",
      "customerName": "Jennifer Adams",
      "customerPhone": "+1-555-1001",
      "agentName": "John Smith",
      "agentId": "agent_001",
      "type": "inbound",
      "status": "completed",
      "duration": "12m 45s",
      "startTime": "2024-06-19T14:30:00Z",
      "endTime": "2024-06-19T14:42:45Z",
      "department": "Sales",
      "purpose": "Product Inquiry",
      "notes": "Customer interested in premium package. Follow-up scheduled for next week.",
      "recording": "rec_001.wav",
      "satisfaction": 4.5,
      "tags": ["sales", "premium", "follow-up"],
      "priority": "high",
    },
    {
      "id": "log_002",
      "customerName": "Robert Lee",
      "customerPhone": "+1-555-1002",
      "agentName": "Sarah Wilson",
      "agentId": "agent_002",
      "type": "outbound",
      "status": "completed",
      "duration": "8m 20s",
      "startTime": "2024-06-19T13:15:00Z",
      "endTime": "2024-06-19T13:23:20Z",
      "department": "Customer Support",
      "purpose": "Follow-up Call",
      "notes": "Issue resolved. Customer satisfied with the solution provided.",
      "recording": "rec_002.wav",
      "satisfaction": 5.0,
      "tags": ["support", "resolved", "satisfied"],
      "priority": "medium",
    },
    {
      "id": "log_003",
      "customerName": "Lisa Martinez",
      "customerPhone": "+1-555-1003",
      "agentName": "Mike Johnson",
      "agentId": "agent_003",
      "type": "inbound",
      "status": "missed",
      "duration": "0m 0s",
      "startTime": "2024-06-19T12:45:00Z",
      "endTime": null,
      "department": "Technical Support",
      "purpose": "Service Issue",
      "notes": "Customer called regarding service outage. No agent available at the time.",
      "recording": null,
      "satisfaction": null,
      "tags": ["missed", "urgent", "service-outage"],
      "priority": "urgent",
    },
    {
      "id": "log_004",
      "customerName": "Michael Thompson",
      "customerPhone": "+1-555-1004",
      "agentName": "Emily Davis",
      "agentId": "agent_004",
      "type": "outbound",
      "status": "no_answer",
      "duration": "0m 0s",
      "startTime": "2024-06-19T11:30:00Z",
      "endTime": null,
      "department": "Sales",
      "purpose": "Lead Follow-up",
      "notes": "Attempted to reach potential lead. Will try again tomorrow.",
      "recording": null,
      "satisfaction": null,
      "tags": ["lead", "no-answer", "retry"],
      "priority": "medium",
    },
    {
      "id": "log_005",
      "customerName": "David Wilson",
      "customerPhone": "+1-555-1005",
      "agentName": "John Smith",
      "agentId": "agent_001",
      "type": "inbound",
      "status": "completed",
      "duration": "15m 30s",
      "startTime": "2024-06-19T10:15:00Z",
      "endTime": "2024-06-19T10:30:30Z",
      "department": "Customer Support",
      "purpose": "Billing Inquiry",
      "notes": "Billing dispute resolved. Refund processed for overcharge.",
      "recording": "rec_005.wav",
      "satisfaction": 4.8,
      "tags": ["billing", "dispute", "refund"],
      "priority": "high",
    },
    {
      "id": "log_006",
      "customerName": "Amanda Clark",
      "customerPhone": "+1-555-1006",
      "agentName": "Sarah Wilson",
      "agentId": "agent_002",
      "type": "internal",
      "status": "completed",
      "duration": "5m 12s",
      "startTime": "2024-06-19T09:45:00Z",
      "endTime": "2024-06-19T09:50:12Z",
      "department": "Internal",
      "purpose": "Team Coordination",
      "notes": "Discussed customer escalation process with team lead.",
      "recording": "rec_006.wav",
      "satisfaction": null,
      "tags": ["internal", "coordination", "process"],
      "priority": "low",
    },
  ];

  List<Map<String, dynamic>> get filteredCallLogs {
    return callLogs.where((log) {
      bool matchesSearch = log["customerName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["customerPhone"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["agentName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          log["purpose"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedType == "all" || log["type"] == selectedType;
      bool matchesStatus = selectedStatus == "all" || log["status"] == selectedStatus;
      bool matchesAgent = selectedAgent == "all" || log["agentId"] == selectedAgent;
      
      return matchesSearch && matchesType && matchesStatus && matchesAgent;
    }).toList();
  }

  Map<String, dynamic> get callLogStats {
    int totalCalls = callLogs.length;
    int completedCalls = callLogs.where((l) => l["status"] == "completed").length;
    int missedCalls = callLogs.where((l) => l["status"] == "missed").length;
    int inboundCalls = callLogs.where((l) => l["type"] == "inbound").length;
    int outboundCalls = callLogs.where((l) => l["type"] == "outbound").length;
    
    double completionRate = totalCalls > 0 ? (completedCalls / totalCalls) * 100 : 0;
    double avgSatisfaction = callLogs.where((l) => l["satisfaction"] != null)
        .fold(0.0, (sum, l) => sum + (l["satisfaction"] as double)) / 
        callLogs.where((l) => l["satisfaction"] != null).length;
    
    return {
      "totalCalls": totalCalls,
      "completedCalls": completedCalls,
      "missedCalls": missedCalls,
      "inboundCalls": inboundCalls,
      "outboundCalls": outboundCalls,
      "completionRate": completionRate,
      "avgSatisfaction": avgSatisfaction.isNaN ? 0.0 : avgSatisfaction,
    };
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "missed":
        return dangerColor;
      case "busy":
        return warningColor;
      case "no_answer":
        return infoColor;
      case "failed":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "inbound":
        return primaryColor;
      case "outbound":
        return successColor;
      case "internal":
        return infoColor;
      case "conference":
        return warningColor;
      default:
        return disabledColor;
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
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "missed":
        return "Missed";
      case "busy":
        return "Busy";
      case "no_answer":
        return "No Answer";
      case "failed":
        return "Failed";
      default:
        return "Unknown";
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case "inbound":
        return "Inbound";
      case "outbound":
        return "Outbound";
      case "internal":
        return "Internal";
      case "conference":
        return "Conference";
      default:
        return "Unknown";
    }
  }

  void _viewCallDetails(Map<String, dynamic> log) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Call Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetailRow("Customer", "${log["customerName"]}"),
                _buildDetailRow("Phone", "${log["customerPhone"]}"),
                _buildDetailRow("Agent", "${log["agentName"]}"),
                _buildDetailRow("Type", _getTypeLabel("${log["type"]}")),
                _buildDetailRow("Status", _getStatusLabel("${log["status"]}")),
                _buildDetailRow("Department", "${log["department"]}"),
                _buildDetailRow("Purpose", "${log["purpose"]}"),
                _buildDetailRow("Duration", "${log["duration"]}"),
                _buildDetailRow("Start Time", "${log["startTime"]}"),
                if (log["endTime"] != null)
                  _buildDetailRow("End Time", "${log["endTime"]}"),
                if (log["satisfaction"] != null)
                  _buildDetailRow("Satisfaction", "${log["satisfaction"]}/5.0"),
                SizedBox(height: spSm),
                Text(
                  "Notes:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${log["notes"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ),
                if (log["tags"] != null) ...[
                  SizedBox(height: spSm),
                  Text(
                    "Tags:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Wrap(
                    spacing: spXs,
                    children: (log["tags"] as List).map((tag) => Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$tag",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            if (log["recording"] != null)
              QButton(
                label: "Play Recording",
                size: bs.sm,
                onPressed: () {
                  Navigator.of(context).pop();
                  ss("Playing call recording: ${log["recording"]}");
                },
              ),
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteCallLog(Map<String, dynamic> log) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this call log?");
    if (isConfirmed) {
      setState(() {
        callLogs.removeWhere((l) => l["id"] == log["id"]);
      });
      ss("Call log deleted successfully");
    }
  }

  void _exportCallLogs() {
    loading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Call logs exported successfully");
    });
  }

  @override
  Widget build(BuildContext context) {
    final stats = callLogStats;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Call Logs"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportCallLogs,
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
                  Text(
                    "Call Analytics Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildStatCard(
                        "Total Calls",
                        "${stats["totalCalls"]}",
                        Icons.call,
                        primaryColor,
                      ),
                      _buildStatCard(
                        "Completed",
                        "${stats["completedCalls"]}",
                        Icons.check_circle,
                        successColor,
                      ),
                      _buildStatCard(
                        "Completion Rate",
                        "${(stats["completionRate"] as double).toStringAsFixed(1)}%",
                        Icons.trending_up,
                        infoColor,
                      ),
                      _buildStatCard(
                        "Avg Satisfaction",
                        "${(stats["avgSatisfaction"] as double).toStringAsFixed(1)}/5",
                        Icons.star,
                        warningColor,
                      ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search call logs...",
                          value: searchQuery,
                          hint: "Search by customer, agent, or purpose",
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
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Type",
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
                          label: "Filter by Status",
                          items: statusOptions,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Agent",
                          items: agentOptions,
                          value: selectedAgent,
                          onChanged: (value, label) {
                            selectedAgent = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Date Range",
                          items: dateRangeOptions,
                          value: selectedDateRange,
                          onChanged: (value, label) {
                            selectedDateRange = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  Text(
                    "Call Logs (${filteredCallLogs.length})",
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
                    itemCount: filteredCallLogs.length,
                    itemBuilder: (context, index) {
                      final log = filteredCallLogs[index];
                      return _buildCallLogCard(log);
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Logs",
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallLogCard(Map<String, dynamic> log) {
    Color statusColor = _getStatusColor("${log["status"]}");
    Color typeColor = _getTypeColor("${log["type"]}");
    Color priorityColor = _getPriorityColor("${log["priority"]}");
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${log["customerName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${log["customerPhone"]} • Agent: ${log["agentName"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: disabledBoldColor),
                onSelected: (value) {
                  switch (value) {
                    case 'view':
                      _viewCallDetails(log);
                      break;
                    case 'play':
                      if (log["recording"] != null) {
                        ss("Playing call recording: ${log["recording"]}");
                      } else {
                        se("No recording available for this call");
                      }
                      break;
                    case 'delete':
                      _deleteCallLog(log);
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(value: 'view', child: Text('View Details')),
                  if (log["recording"] != null)
                    PopupMenuItem(value: 'play', child: Text('Play Recording')),
                  PopupMenuItem(value: 'delete', child: Text('Delete Log')),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  _getTypeLabel("${log["type"]}"),
                  style: TextStyle(
                    fontSize: 10,
                    color: typeColor,
                    fontWeight: FontWeight.w600,
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
                  _getStatusLabel("${log["status"]}"),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
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
                  "${log["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: priorityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (log["recording"] != null) ...[
                SizedBox(width: spXs),
                Icon(
                  Icons.play_circle_filled,
                  color: successColor,
                  size: 16,
                ),
              ],
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Purpose: ${log["purpose"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Department: ${log["department"]} • Duration: ${log["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (log["satisfaction"] != null) ...[
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: warningColor,
                            size: 14,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "${log["satisfaction"]}/5.0",
                            style: TextStyle(
                              fontSize: 12,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${log["startTime"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () => _viewCallDetails(log),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
