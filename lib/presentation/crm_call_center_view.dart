import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmCallCenterView extends StatefulWidget {
  const CrmCallCenterView({super.key});

  @override
  State<CrmCallCenterView> createState() => _CrmCallCenterViewState();
}

class _CrmCallCenterViewState extends State<CrmCallCenterView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedAgent = "all";
  bool loading = false;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Available", "value": "available"},
    {"label": "On Call", "value": "on_call"},
    {"label": "Break", "value": "break"},
    {"label": "Offline", "value": "offline"},
    {"label": "Training", "value": "training"},
  ];

  List<Map<String, dynamic>> agentOptions = [
    {"label": "All Agents", "value": "all"},
    {"label": "John Smith", "value": "agent_001"},
    {"label": "Sarah Wilson", "value": "agent_002"},
    {"label": "Mike Johnson", "value": "agent_003"},
    {"label": "Emily Davis", "value": "agent_004"},
    {"label": "David Brown", "value": "agent_005"},
  ];

  List<Map<String, dynamic>> agents = [
    {
      "id": "agent_001",
      "name": "John Smith",
      "email": "john.smith@company.com",
      "phone": "+1-555-0101",
      "status": "on_call",
      "currentCall": "Call with Premium Customer",
      "callStartTime": "2024-06-19T14:30:00Z",
      "totalCalls": 47,
      "successfulCalls": 42,
      "avgCallDuration": "8m 32s",
      "rating": 4.8,
      "department": "Sales",
      "shift": "9 AM - 6 PM",
      "extensions": ["2001", "2002"],
      "skills": ["Sales", "Customer Support", "Spanish"],
      "avatar": "https://picsum.photos/150/150?random=1&keyword=man",
    },
    {
      "id": "agent_002",
      "name": "Sarah Wilson",
      "email": "sarah.wilson@company.com",
      "phone": "+1-555-0102",
      "status": "available",
      "currentCall": null,
      "callStartTime": null,
      "totalCalls": 63,
      "successfulCalls": 59,
      "avgCallDuration": "12m 45s",
      "rating": 4.9,
      "department": "Customer Support",
      "shift": "8 AM - 5 PM",
      "extensions": ["2003"],
      "skills": ["Customer Support", "Technical Support", "French"],
      "avatar": "https://picsum.photos/150/150?random=2&keyword=woman",
    },
    {
      "id": "agent_003",
      "name": "Mike Johnson",
      "email": "mike.johnson@company.com",
      "phone": "+1-555-0103",
      "status": "break",
      "currentCall": null,
      "callStartTime": null,
      "totalCalls": 38,
      "successfulCalls": 35,
      "avgCallDuration": "15m 20s",
      "rating": 4.6,
      "department": "Technical Support",
      "shift": "10 AM - 7 PM",
      "extensions": ["2004", "2005"],
      "skills": ["Technical Support", "Troubleshooting", "Product Knowledge"],
      "avatar": "https://picsum.photos/150/150?random=3&keyword=man",
    },
    {
      "id": "agent_004",
      "name": "Emily Davis",
      "email": "emily.davis@company.com",
      "phone": "+1-555-0104",
      "status": "available",
      "currentCall": null,
      "callStartTime": null,
      "totalCalls": 72,
      "successfulCalls": 68,
      "avgCallDuration": "9m 15s",
      "rating": 4.7,
      "department": "Sales",
      "shift": "9 AM - 6 PM",
      "extensions": ["2006"],
      "skills": ["Sales", "Lead Generation", "Customer Support"],
      "avatar": "https://picsum.photos/150/150?random=4&keyword=woman",
    },
    {
      "id": "agent_005",
      "name": "David Brown",
      "email": "david.brown@company.com",
      "phone": "+1-555-0105",
      "status": "offline",
      "currentCall": null,
      "callStartTime": null,
      "totalCalls": 29,
      "successfulCalls": 26,
      "avgCallDuration": "11m 08s",
      "rating": 4.5,
      "department": "Customer Support",
      "shift": "2 PM - 11 PM",
      "extensions": ["2007", "2008"],
      "skills": ["Customer Support", "Billing", "Account Management"],
      "avatar": "https://picsum.photos/150/150?random=5&keyword=man",
    },
  ];

  List<Map<String, dynamic>> queueCalls = [
    {
      "id": "queue_001",
      "customerName": "Jennifer Adams",
      "customerPhone": "+1-555-1001",
      "waitTime": "2m 15s",
      "priority": "high",
      "department": "Sales",
      "reason": "Product Inquiry",
      "type": "inbound",
      "queuePosition": 1,
    },
    {
      "id": "queue_002",
      "customerName": "Robert Lee",
      "customerPhone": "+1-555-1002",
      "waitTime": "4m 32s",
      "priority": "medium",
      "department": "Customer Support",
      "reason": "Billing Question",
      "type": "inbound",
      "queuePosition": 2,
    },
    {
      "id": "queue_003",
      "customerName": "Lisa Martinez",
      "customerPhone": "+1-555-1003",
      "waitTime": "1m 45s",
      "priority": "urgent",
      "department": "Technical Support",
      "reason": "Service Outage",
      "type": "inbound",
      "queuePosition": 3,
    },
  ];

  List<Map<String, dynamic>> activeCalls = [
    {
      "id": "call_001",
      "agent": "John Smith",
      "customer": "Premium Customer",
      "customerPhone": "+1-555-2001",
      "duration": "8m 32s",
      "type": "inbound",
      "department": "Sales",
      "priority": "high",
      "startTime": "2024-06-19T14:30:00Z",
    },
    {
      "id": "call_002",
      "agent": "System",
      "customer": "Michael Thompson",
      "customerPhone": "+1-555-2002",
      "duration": "3m 15s",
      "type": "outbound",
      "department": "Customer Support",
      "priority": "medium",
      "startTime": "2024-06-19T14:45:00Z",
    },
  ];

  List<Map<String, dynamic>> get filteredAgents {
    return agents.where((agent) {
      bool matchesSearch = agent["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          agent["email"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          agent["department"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || agent["status"] == selectedStatus;
      bool matchesAgent = selectedAgent == "all" || agent["id"] == selectedAgent;
      
      return matchesSearch && matchesStatus && matchesAgent;
    }).toList();
  }

  Map<String, dynamic> get callCenterStats {
    int totalAgents = agents.length;
    int availableAgents = agents.where((a) => a["status"] == "available").length;
    int onCallAgents = agents.where((a) => a["status"] == "on_call").length;
    int queuedCalls = queueCalls.length;
    int activeCallsCount = activeCalls.length;
    double avgWaitTime = queueCalls.isEmpty ? 0.0 : 
        queueCalls.map((c) => _parseWaitTime(c["waitTime"].toString())).reduce((a, b) => a + b) / queueCalls.length;
    
    return {
      "totalAgents": totalAgents,
      "availableAgents": availableAgents,
      "onCallAgents": onCallAgents,
      "queuedCalls": queuedCalls,
      "activeCalls": activeCallsCount,
      "avgWaitTime": avgWaitTime,
    };
  }

  double _parseWaitTime(String waitTime) {
    // Parse "2m 15s" format to seconds
    RegExp regex = RegExp(r'(\d+)m\s+(\d+)s');
    Match? match = regex.firstMatch(waitTime);
    if (match != null) {
      int minutes = int.parse(match.group(1)!);
      int seconds = int.parse(match.group(2)!);
      return (minutes * 60 + seconds).toDouble();
    }
    return 0.0;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "available":
        return successColor;
      case "on_call":
        return primaryColor;
      case "break":
        return warningColor;
      case "offline":
        return disabledColor;
      case "training":
        return infoColor;
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
      case "available":
        return "Available";
      case "on_call":
        return "On Call";
      case "break":
        return "Break";
      case "offline":
        return "Offline";
      case "training":
        return "Training";
      default:
        return "Unknown";
    }
  }

  void _assignCallToAgent(Map<String, dynamic> call, Map<String, dynamic> agent) async {
    bool isConfirmed = await confirm("Assign call from ${call["customerName"]} to ${agent["name"]}?");
    if (isConfirmed) {
      setState(() {
        queueCalls.removeWhere((c) => c["id"] == call["id"]);
        agent["status"] = "on_call";
        agent["currentCall"] = "Call with ${call["customerName"]}";
        agent["callStartTime"] = DateTime.now().toIso8601String();
      });
      ss("Call assigned to ${agent["name"]} successfully");
    }
  }

  void _endCall(Map<String, dynamic> call) async {
    bool isConfirmed = await confirm("End call with ${call["customer"]}?");
    if (isConfirmed) {
      setState(() {
        activeCalls.removeWhere((c) => c["id"] == call["id"]);
        // Update agent status
        var agent = agents.firstWhere((a) => a["name"] == call["agent"], orElse: () => {});
        if (agent.isNotEmpty) {
          agent["status"] = "available";
          agent["currentCall"] = null;
          agent["callStartTime"] = null;
        }
      });
      ss("Call ended successfully");
    }
  }

  void _viewAgentDetails(Map<String, dynamic> agent) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Agent Details",
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
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage("${agent["avatar"]}"),
                  ),
                ),
                SizedBox(height: spSm),
                _buildDetailRow("Name", "${agent["name"]}"),
                _buildDetailRow("Email", "${agent["email"]}"),
                _buildDetailRow("Phone", "${agent["phone"]}"),
                _buildDetailRow("Department", "${agent["department"]}"),
                _buildDetailRow("Status", _getStatusLabel("${agent["status"]}")),
                _buildDetailRow("Shift", "${agent["shift"]}"),
                _buildDetailRow("Total Calls", "${agent["totalCalls"]}"),
                _buildDetailRow("Success Rate", "${((agent["successfulCalls"] as int) / (agent["totalCalls"] as int) * 100).toStringAsFixed(1)}%"),
                _buildDetailRow("Avg Duration", "${agent["avgCallDuration"]}"),
                _buildDetailRow("Rating", "${agent["rating"]}/5.0"),
                SizedBox(height: spSm),
                Text(
                  "Skills:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  children: (agent["skills"] as List).map((skill) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$skill",
                      style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          actions: [
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

  @override
  Widget build(BuildContext context) {
    final stats = callCenterStats;
    
    return QTabBar(
      title: "Call Center",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Agents", icon: Icon(Icons.people)),
        Tab(text: "Queue", icon: Icon(Icons.queue)),
        Tab(text: "Active Calls", icon: Icon(Icons.call)),
      ],
      tabChildren: [
        _buildDashboardTab(stats),
        _buildAgentsTab(),
        _buildQueueTab(),
        _buildActiveCallsTab(),
      ],
    );
  }

  Widget _buildDashboardTab(Map<String, dynamic> stats) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Call Center Overview",
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
                "Total Agents",
                "${stats["totalAgents"]}",
                Icons.people,
                primaryColor,
              ),
              _buildStatCard(
                "Available",
                "${stats["availableAgents"]}",
                Icons.check_circle,
                successColor,
              ),
              _buildStatCard(
                "On Call",
                "${stats["onCallAgents"]}",
                Icons.call,
                infoColor,
              ),
              _buildStatCard(
                "Queue",
                "${stats["queuedCalls"]}",
                Icons.queue,
                warningColor,
              ),
            ],
          ),
          SizedBox(height: spLg),
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                _buildActivityItem("John Smith answered call from Premium Customer", "2 minutes ago", Icons.call_received, successColor),
                _buildActivityItem("New call added to Sales queue", "5 minutes ago", Icons.add_call, warningColor),
                _buildActivityItem("Sarah Wilson completed call with Tech Support", "8 minutes ago", Icons.call_end, infoColor),
                _buildActivityItem("Mike Johnson went on break", "12 minutes ago", Icons.free_breakfast, disabledBoldColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search agents...",
                  value: searchQuery,
                  hint: "Search by name, email, or department",
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
          QDropdownField(
            label: "Filter by Status",
            items: statusOptions,
            value: selectedStatus,
            onChanged: (value, label) {
              selectedStatus = value;
              setState(() {});
            },
          ),
          SizedBox(height: spLg),
          Text(
            "Agents (${filteredAgents.length})",
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
            itemCount: filteredAgents.length,
            itemBuilder: (context, index) {
              final agent = filteredAgents[index];
              return _buildAgentCard(agent);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQueueTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Call Queue (${queueCalls.length})",
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
            itemCount: queueCalls.length,
            itemBuilder: (context, index) {
              final call = queueCalls[index];
              return _buildQueueCard(call);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCallsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Active Calls (${activeCalls.length})",
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
            itemCount: activeCalls.length,
            itemBuilder: (context, index) {
              final call = activeCalls[index];
              return _buildActiveCallCard(call);
            },
          ),
        ],
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
                  "Live",
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

  Widget _buildActivityItem(String activity, String time, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgentCard(Map<String, dynamic> agent) {
    Color statusColor = _getStatusColor("${agent["status"]}");
    
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
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage("${agent["avatar"]}"),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${agent["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${agent["department"]} • ${agent["email"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        _getStatusLabel("${agent["status"]}"),
                        style: TextStyle(
                          fontSize: 10,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Rating: ${agent["rating"]}/5",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          QButton(
            label: "View",
            size: bs.sm,
            onPressed: () => _viewAgentDetails(agent),
          ),
        ],
      ),
    );
  }

  Widget _buildQueueCard(Map<String, dynamic> call) {
    Color priorityColor = _getPriorityColor("${call["priority"]}");
    
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
            color: priorityColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${call["customerName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
                        "${call["priority"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: priorityColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${call["customerPhone"]} • ${call["department"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Reason: ${call["reason"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Wait Time: ${call["waitTime"]} • Position: #${call["queuePosition"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: disabledBoldColor),
            onSelected: (value) {
              if (value.startsWith('assign_')) {
                String agentId = value.substring(7);
                var agent = agents.firstWhere((a) => a["id"] == agentId);
                _assignCallToAgent(call, agent);
              }
            },
            itemBuilder: (BuildContext context) => [
              ...agents.where((a) => a["status"] == "available").map(
                (agent) => PopupMenuItem(
                  value: 'assign_${agent["id"]}',
                  child: Text('Assign to ${agent["name"]}'),
                ),
              ).toList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCallCard(Map<String, dynamic> call) {
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
            color: successColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${call["customer"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Agent: ${call["agent"]} • ${call["department"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${call["customerPhone"]} • ${call["type"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Duration: ${call["duration"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "End Call",
            size: bs.sm,
            onPressed: () => _endCall(call),
          ),
        ],
      ),
    );
  }
}
