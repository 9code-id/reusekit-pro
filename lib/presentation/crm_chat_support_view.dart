import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmChatSupportView extends StatefulWidget {
  const CrmChatSupportView({super.key});

  @override
  State<CrmChatSupportView> createState() => _CrmChatSupportViewState();
}

class _CrmChatSupportViewState extends State<CrmChatSupportView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  
  List<Map<String, dynamic>> chatSessions = [
    {
      "id": "CHT-001",
      "customer": {
        "name": "John Doe",
        "email": "john.doe@email.com",
        "avatar": "https://picsum.photos/100/100?random=1&keyword=man",
        "location": "New York, USA",
      },
      "agent": {
        "name": "Sarah Wilson",
        "avatar": "https://picsum.photos/100/100?random=2&keyword=woman",
        "status": "online",
      },
      "status": "active",
      "priority": "High",
      "startedAt": "2024-12-19 14:30:00",
      "lastMessage": "I'm having trouble with my payment processing",
      "lastMessageTime": "2024-12-19 14:45:00",
      "unreadCount": 3,
      "category": "Payment",
      "satisfaction": null,
      "duration": "00:15:30",
      "messages": 12,
    },
    {
      "id": "CHT-002",
      "customer": {
        "name": "Jane Smith",
        "email": "jane.smith@email.com",
        "avatar": "https://picsum.photos/100/100?random=3&keyword=woman",
        "location": "London, UK",
      },
      "agent": {
        "name": "Mike Johnson",
        "avatar": "https://picsum.photos/100/100?random=4&keyword=man",
        "status": "busy",
      },
      "status": "waiting",
      "priority": "Medium",
      "startedAt": "2024-12-19 14:15:00",
      "lastMessage": "How can I upgrade my subscription plan?",
      "lastMessageTime": "2024-12-19 14:20:00",
      "unreadCount": 1,
      "category": "Billing",
      "satisfaction": null,
      "duration": "00:05:15",
      "messages": 5,
    },
    {
      "id": "CHT-003",
      "customer": {
        "name": "Bob Brown",
        "email": "bob.brown@email.com",
        "avatar": "https://picsum.photos/100/100?random=5&keyword=man",
        "location": "Sydney, Australia",
      },
      "agent": {
        "name": "Emily Davis",
        "avatar": "https://picsum.photos/100/100?random=6&keyword=woman",
        "status": "online",
      },
      "status": "resolved",
      "priority": "Low",
      "startedAt": "2024-12-19 13:30:00",
      "lastMessage": "Thank you for your help! Problem is solved.",
      "lastMessageTime": "2024-12-19 14:10:00",
      "unreadCount": 0,
      "category": "Technical",
      "satisfaction": 5,
      "duration": "00:40:30",
      "messages": 18,
    },
  ];

  List<Map<String, dynamic>> agents = [
    {
      "id": 1,
      "name": "Sarah Wilson",
      "avatar": "https://picsum.photos/100/100?random=7&keyword=woman",
      "status": "online",
      "activeSessions": 3,
      "todayResolved": 12,
      "avgRating": 4.8,
      "department": "Technical Support",
    },
    {
      "id": 2,
      "name": "Mike Johnson",
      "avatar": "https://picsum.photos/100/100?random=8&keyword=man",
      "status": "busy",
      "activeSessions": 5,
      "todayResolved": 8,
      "avgRating": 4.6,
      "department": "Billing Support",
    },
    {
      "id": 3,
      "name": "Emily Davis",
      "avatar": "https://picsum.photos/100/100?random=9&keyword=woman",
      "status": "online",
      "activeSessions": 2,
      "todayResolved": 15,
      "avgRating": 4.9,
      "department": "General Support",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Chat Support",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Active Chats", icon: Icon(Icons.chat)),
        Tab(text: "Agents", icon: Icon(Icons.support_agent)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildActiveChatsTab(),
        _buildAgentsTab(),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildActiveChatsTab() {
    final filteredSessions = chatSessions.where((session) {
      final matchesSearch = (session["customer"]["name"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          (session["lastMessage"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
      final matchesStatus = selectedStatus == "all" ||
          session["status"] == selectedStatus;
      return matchesSearch && matchesStatus;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildChatHeader(),
          _buildChatFilters(),
          _buildChatStats(),
          _buildChatSessionsList(filteredSessions),
        ],
      ),
    );
  }

  Widget _buildChatHeader() {
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
                  "Live Chat Support",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Real-time customer support conversations",
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
                  Icons.chat_bubble,
                  color: Colors.white,
                  size: 24,
                ),
                Text(
                  "${chatSessions.where((s) => s["status"] == "active").length}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Active",
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

  Widget _buildChatFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search chats",
          value: searchQuery,
          hint: "Search by customer name or message",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        QCategoryPicker(
          items: [
            {"label": "All Status", "value": "all"},
            {"label": "Active", "value": "active"},
            {"label": "Waiting", "value": "waiting"},
            {"label": "Resolved", "value": "resolved"},
            {"label": "Closed", "value": "closed"},
          ],
          value: selectedStatus,
          onChanged: (index, label, value, item) {
            selectedStatus = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildChatStats() {
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
            "Chat Overview",
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
                  "Active Chats",
                  "${chatSessions.where((s) => s["status"] == "active").length}",
                  Icons.chat,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Waiting",
                  "${chatSessions.where((s) => s["status"] == "waiting").length}",
                  Icons.pending,
                  warningColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Resolved Today",
                  "${chatSessions.where((s) => s["status"] == "resolved").length}",
                  Icons.check_circle,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Avg Response",
                  "2.5 min",
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

  Widget _buildChatSessionsList(List<Map<String, dynamic>> filteredSessions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Chat Sessions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          spacing: spSm,
          children: filteredSessions.map((session) {
            Color statusColor = _getStatusColor(session["status"]);
            Color priorityColor = _getPriorityColor(session["priority"]);

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
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage("${session["customer"]["avatar"]}"),
                          ),
                          if (session["unreadCount"] > 0)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: Center(
                                  child: Text(
                                    "${session["unreadCount"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${session["customer"]["name"]}",
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
                                    "${session["priority"]}",
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
                              "${session["customer"]["email"]}",
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
                          "${session["status"]}".toUpperCase(),
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
                          "Last Message:",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${session["lastMessage"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage("${session["agent"]["avatar"]}"),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${session["agent"]["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${session["duration"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.chat_bubble, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${session["messages"]} msgs",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  if (session["satisfaction"] != null)
                    Container(
                      padding: EdgeInsets.all(spXs),
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
                            "Rated ${session["satisfaction"]}/5",
                            style: TextStyle(
                              fontSize: 11,
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Join Chat",
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to chat interface
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.person_add,
                        size: bs.sm,
                        onPressed: () {
                          _assignAgent(session);
                        },
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.info,
                        size: bs.sm,
                        onPressed: () {
                          _showSessionDetails(session);
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

  Widget _buildAgentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAgentsOverview(),
          _buildAgentsList(),
        ],
      ),
    );
  }

  Widget _buildAgentsOverview() {
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
            "Agents Overview",
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
                  "Online Agents",
                  "${agents.where((a) => a["status"] == "online").length}",
                  Icons.online_prediction,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Active Sessions",
                  "${agents.fold(0, (sum, a) => sum + (a["activeSessions"] as int))}",
                  Icons.chat,
                  primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAgentsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Support Agents",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          spacing: spSm,
          children: agents.map((agent) {
            Color statusColor = agent["status"] == "online"
                ? successColor
                : agent["status"] == "busy"
                    ? warningColor
                    : disabledBoldColor;

            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage("${agent["avatar"]}"),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${agent["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${agent["department"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, size: 14, color: warningColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${agent["avgRating"]}",
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
                          "${agent["status"]}".toUpperCase(),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Active Sessions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${agent["activeSessions"]}",
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
                                "Resolved Today",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${agent["todayResolved"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Profile",
                          size: bs.sm,
                          onPressed: () {
                            // View agent profile
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.chat,
                        size: bs.sm,
                        onPressed: () {
                          // Start internal chat
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

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsOverview(),
          _buildPerformanceMetrics(),
          _buildSatisfactionMetrics(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsOverview() {
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
            "Chat Support Analytics",
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
                  "Total Chats Today",
                  "47",
                  Icons.chat_bubble,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Avg Response Time",
                  "2.5 min",
                  Icons.timer,
                  infoColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Resolution Rate",
                  "89%",
                  Icons.check_circle,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Customer Satisfaction",
                  "4.7/5",
                  Icons.star,
                  warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
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
            "Performance Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildMetricRow("First Response Time", "1.8 minutes", successColor),
          _buildMetricRow("Average Handle Time", "12.5 minutes", primaryColor),
          _buildMetricRow("Chat Abandonment Rate", "8%", warningColor),
          _buildMetricRow("Agent Utilization", "76%", infoColor),
        ],
      ),
    );
  }

  Widget _buildSatisfactionMetrics() {
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
            "Customer Satisfaction",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildRatingRow("5 Stars", "68%", warningColor),
          _buildRatingRow("4 Stars", "22%", successColor),
          _buildRatingRow("3 Stars", "7%", primaryColor),
          _buildRatingRow("2 Stars", "2%", warningColor),
          _buildRatingRow("1 Star", "1%", dangerColor),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow(String rating, String percentage, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.star, size: 16, color: color),
              SizedBox(width: spXs),
              Text(
                rating,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            percentage,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "waiting":
        return warningColor;
      case "resolved":
        return primaryColor;
      case "closed":
        return disabledBoldColor;
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

  void _assignAgent(Map<String, dynamic> session) {
    si("Agent assignment dialog would be shown here");
  }

  void _showSessionDetails(Map<String, dynamic> session) {
    si("Session details dialog would be shown here");
  }
}
