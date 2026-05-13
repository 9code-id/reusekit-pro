import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmChatHistoryView extends StatefulWidget {
  const CrmChatHistoryView({super.key});

  @override
  State<CrmChatHistoryView> createState() => _CrmChatHistoryViewState();
}

class _CrmChatHistoryViewState extends State<CrmChatHistoryView> {
  String searchQuery = "";
  String selectedAgent = "all";
  String selectedStatus = "all";
  String selectedDateRange = "7_days";
  
  List<Map<String, dynamic>> chatHistory = [
    {
      "id": "CHT-001",
      "customer": {
        "name": "John Doe",
        "email": "john.doe@email.com",
        "avatar": "https://picsum.photos/100/100?random=1&keyword=man",
      },
      "agent": {
        "name": "Sarah Wilson",
        "avatar": "https://picsum.photos/100/100?random=2&keyword=woman",
      },
      "status": "resolved",
      "priority": "High",
      "category": "Payment",
      "startedAt": "2024-12-19 14:30:00",
      "endedAt": "2024-12-19 15:15:00",
      "duration": "00:45:30",
      "messageCount": 18,
      "satisfaction": 5,
      "tags": ["payment", "credit card", "resolved"],
      "summary": "Customer had issues with payment processing. Agent helped reset payment method and resolved the issue.",
      "firstResponseTime": "00:01:30",
      "resolutionTime": "00:45:30",
    },
    {
      "id": "CHT-002",
      "customer": {
        "name": "Jane Smith",
        "email": "jane.smith@email.com",
        "avatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      },
      "agent": {
        "name": "Mike Johnson",
        "avatar": "https://picsum.photos/100/100?random=4&keyword=man",
      },
      "status": "resolved",
      "priority": "Medium",
      "category": "Billing",
      "startedAt": "2024-12-19 10:15:00",
      "endedAt": "2024-12-19 10:45:00",
      "duration": "00:30:15",
      "messageCount": 12,
      "satisfaction": 4,
      "tags": ["billing", "subscription", "upgrade"],
      "summary": "Customer wanted to upgrade subscription plan. Agent explained options and processed the upgrade.",
      "firstResponseTime": "00:02:15",
      "resolutionTime": "00:30:15",
    },
    {
      "id": "CHT-003",
      "customer": {
        "name": "Bob Brown",
        "email": "bob.brown@email.com",
        "avatar": "https://picsum.photos/100/100?random=5&keyword=man",
      },
      "agent": {
        "name": "Emily Davis",
        "avatar": "https://picsum.photos/100/100?random=6&keyword=woman",
      },
      "status": "closed",
      "priority": "Low",
      "category": "Technical",
      "startedAt": "2024-12-18 16:20:00",
      "endedAt": "2024-12-18 17:10:00",
      "duration": "00:50:30",
      "messageCount": 24,
      "satisfaction": 5,
      "tags": ["technical", "api", "integration"],
      "summary": "Developer had questions about API integration. Agent provided documentation and code examples.",
      "firstResponseTime": "00:03:45",
      "resolutionTime": "00:50:30",
    },
    {
      "id": "CHT-004",
      "customer": {
        "name": "Alice Johnson",
        "email": "alice.johnson@email.com",
        "avatar": "https://picsum.photos/100/100?random=7&keyword=woman",
      },
      "agent": {
        "name": "Sarah Wilson",
        "avatar": "https://picsum.photos/100/100?random=2&keyword=woman",
      },
      "status": "escalated",
      "priority": "High",
      "category": "Account",
      "startedAt": "2024-12-18 13:30:00",
      "endedAt": "2024-12-18 14:45:00",
      "duration": "01:15:20",
      "messageCount": 32,
      "satisfaction": 3,
      "tags": ["account", "security", "escalated"],
      "summary": "Customer reported account security concerns. Issue was escalated to security team for investigation.",
      "firstResponseTime": "00:01:15",
      "resolutionTime": "01:15:20",
    },
    {
      "id": "CHT-005",
      "customer": {
        "name": "David Wilson",
        "email": "david.wilson@email.com",
        "avatar": "https://picsum.photos/100/100?random=8&keyword=man",
      },
      "agent": {
        "name": "Mike Johnson",
        "avatar": "https://picsum.photos/100/100?random=4&keyword=man",
      },
      "status": "resolved",
      "priority": "Medium",
      "category": "General",
      "startedAt": "2024-12-17 11:00:00",
      "endedAt": "2024-12-17 11:25:00",
      "duration": "00:25:45",
      "messageCount": 9,
      "satisfaction": 4,
      "tags": ["general", "information", "features"],
      "summary": "Customer asked about platform features and pricing. Agent provided comprehensive information.",
      "firstResponseTime": "00:02:30",
      "resolutionTime": "00:25:45",
    },
  ];

  List<Map<String, dynamic>> agents = [
    {"name": "Sarah Wilson", "id": "sarah_wilson"},
    {"name": "Mike Johnson", "id": "mike_johnson"},
    {"name": "Emily Davis", "id": "emily_davis"},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredHistory = _getFilteredHistory();

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat History"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _exportChatHistory();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildHistoryHeader(),
            _buildFilters(),
            _buildHistoryStats(filteredHistory),
            _buildHistoryList(filteredHistory),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chat History",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Review past customer conversations and analytics",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 24,
                ),
                Text(
                  "${chatHistory.length}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Chats",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
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
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Search chats",
            value: searchQuery,
            hint: "Search by customer name, agent, or summary",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Agent",
                  items: [
                    {"label": "All Agents", "value": "all"},
                    ...agents.map((agent) => {
                          "label": agent["name"],
                          "value": agent["id"],
                        }),
                  ],
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
                  label: "Status",
                  items: [
                    {"label": "All Status", "value": "all"},
                    {"label": "Resolved", "value": "resolved"},
                    {"label": "Closed", "value": "closed"},
                    {"label": "Escalated", "value": "escalated"},
                  ],
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Date Range",
            items: [
              {"label": "Last 7 days", "value": "7_days"},
              {"label": "Last 30 days", "value": "30_days"},
              {"label": "Last 90 days", "value": "90_days"},
              {"label": "This year", "value": "year"},
            ],
            value: selectedDateRange,
            onChanged: (value, label) {
              selectedDateRange = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryStats(List<Map<String, dynamic>> filteredHistory) {
    final avgSatisfaction = filteredHistory.isNotEmpty
        ? (filteredHistory
                .where((chat) => chat["satisfaction"] != null)
                .fold(0.0, (sum, chat) => sum + (chat["satisfaction"] as int)) /
            filteredHistory
                .where((chat) => chat["satisfaction"] != null)
                .length)
        : 0.0;

    final avgResolutionTime = filteredHistory.isNotEmpty
        ? _calculateAverageTime(filteredHistory.map((chat) => chat["resolutionTime"] as String).toList())
        : "0 min";

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Total Chats",
                  "${filteredHistory.length}",
                  Icons.chat,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Avg Satisfaction",
                  "${avgSatisfaction.toStringAsFixed(1)}/5",
                  Icons.star,
                  warningColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Resolved",
                  "${filteredHistory.where((c) => c["status"] == "resolved").length}",
                  Icons.check_circle,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Avg Resolution",
                  avgResolutionTime,
                  Icons.timer,
                  infoColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(List<Map<String, dynamic>> filteredHistory) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Chat Sessions (${filteredHistory.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          spacing: spSm,
          children: filteredHistory.map((chat) {
            Color statusColor = _getStatusColor(chat["status"]);
            Color priorityColor = _getPriorityColor(chat["priority"]);

            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
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
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage("${chat["customer"]["avatar"]}"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${chat["customer"]["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: priorityColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${chat["priority"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: priorityColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${chat["id"]} • ${chat["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${chat["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Summary:",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${chat["summary"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage("${chat["agent"]["avatar"]}"),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${chat["agent"]["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${chat["duration"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.chat_bubble, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${chat["messageCount"]} msgs",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "First Response",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${chat["firstResponseTime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
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
                                "Resolution Time",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${chat["resolutionTime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (chat["satisfaction"] != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star, size: 14, color: warningColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${chat["satisfaction"]}/5",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    children: (chat["tags"] as List).map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: secondaryColor.withAlpha(20),
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
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Transcript",
                          size: bs.sm,
                          onPressed: () {
                            _viewTranscript(chat);
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () {
                          _downloadTranscript(chat);
                        },
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.analytics,
                        size: bs.sm,
                        onPressed: () {
                          _viewAnalytics(chat);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredHistory() {
    return chatHistory.where((chat) {
      final matchesSearch = searchQuery.isEmpty ||
          (chat["customer"]["name"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          (chat["agent"]["name"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          (chat["summary"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase());

      final matchesAgent = selectedAgent == "all" ||
          (chat["agent"]["name"] as String)
              .toLowerCase()
              .replaceAll(" ", "_") == selectedAgent;

      final matchesStatus = selectedStatus == "all" ||
          chat["status"] == selectedStatus;

      return matchesSearch && matchesAgent && matchesStatus;
    }).toList();
  }

  String _calculateAverageTime(List<String> times) {
    if (times.isEmpty) return "0 min";
    
    int totalMinutes = 0;
    for (String time in times) {
      final parts = time.split(":");
      totalMinutes += (int.parse(parts[0]) * 60) + int.parse(parts[1]);
    }
    
    int avgMinutes = (totalMinutes / times.length).round();
    return "${avgMinutes} min";
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "resolved":
        return successColor;
      case "closed":
        return primaryColor;
      case "escalated":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _exportChatHistory() {
    si("Chat history export feature would be implemented here");
  }

  void _viewTranscript(Map<String, dynamic> chat) {
    si("Chat transcript viewer would be opened for ${chat["id"]}");
  }

  void _downloadTranscript(Map<String, dynamic> chat) {
    si("Downloading transcript for ${chat["id"]}");
  }

  void _viewAnalytics(Map<String, dynamic> chat) {
    si("Analytics view would be opened for ${chat["id"]}");
  }
}
