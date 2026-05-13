import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmHelpdeskView extends StatefulWidget {
  const CrmHelpdeskView({super.key});

  @override
  State<CrmHelpdeskView> createState() => _CrmHelpdeskViewState();
}

class _CrmHelpdeskViewState extends State<CrmHelpdeskView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedPriority = "all";
  String selectedStatus = "all";
  String selectedAgent = "all";

  List<Map<String, dynamic>> tickets = [
    {
      "id": "TKT-001",
      "title": "Unable to login to system",
      "description": "User cannot access their account after password reset",
      "priority": "High",
      "status": "Open",
      "category": "Authentication",
      "customer": "John Doe",
      "agent": "Sarah Wilson",
      "createdAt": "2024-12-19 09:15:00",
      "updatedAt": "2024-12-19 10:30:00",
      "slaDeadline": "2024-12-19 17:15:00",
      "tags": ["login", "password", "urgent"],
      "replies": 3,
    },
    {
      "id": "TKT-002",
      "title": "Feature request: Dark mode",
      "description": "Customer requesting dark mode theme option",
      "priority": "Low",
      "status": "In Progress",
      "category": "Feature Request",
      "customer": "Jane Smith",
      "agent": "Mike Johnson",
      "createdAt": "2024-12-18 14:20:00",
      "updatedAt": "2024-12-19 11:45:00",
      "slaDeadline": "2024-12-22 14:20:00",
      "tags": ["feature", "ui", "enhancement"],
      "replies": 5,
    },
    {
      "id": "TKT-003",
      "title": "Payment gateway error",
      "description": "Transaction failed during checkout process",
      "priority": "Critical",
      "status": "Escalated",
      "category": "Payment",
      "customer": "Bob Brown",
      "agent": "Emily Davis",
      "createdAt": "2024-12-19 08:00:00",
      "updatedAt": "2024-12-19 08:15:00",
      "slaDeadline": "2024-12-19 10:00:00",
      "tags": ["payment", "critical", "checkout"],
      "replies": 1,
    },
  ];

  List<Map<String, dynamic>> agents = [
    {
      "id": 1,
      "name": "Sarah Wilson",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "status": "online",
      "activeTickets": 8,
      "resolvedToday": 5,
      "avgResponseTime": "12 minutes",
    },
    {
      "id": 2,
      "name": "Mike Johnson",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "status": "busy",
      "activeTickets": 12,
      "resolvedToday": 3,
      "avgResponseTime": "18 minutes",
    },
    {
      "id": 3,
      "name": "Emily Davis",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      "status": "online",
      "activeTickets": 6,
      "resolvedToday": 7,
      "avgResponseTime": "9 minutes",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Help Desk",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Tickets", icon: Icon(Icons.confirmation_number)),
        Tab(text: "Agents", icon: Icon(Icons.support_agent)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildTicketsTab(),
        _buildAgentsTab(),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildTicketsTab() {
    final filteredTickets = tickets.where((ticket) {
      final matchesSearch = (ticket["title"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          (ticket["description"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
      final matchesPriority = selectedPriority == "all" ||
          ticket["priority"] == selectedPriority;
      final matchesStatus =
          selectedStatus == "all" || ticket["status"] == selectedStatus;
      final matchesAgent =
          selectedAgent == "all" || ticket["agent"] == selectedAgent;

      return matchesSearch && matchesPriority && matchesStatus && matchesAgent;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTicketFilters(),
          _buildTicketStats(),
          _buildTicketsList(filteredTickets),
        ],
      ),
    );
  }

  Widget _buildTicketFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search tickets",
          value: searchQuery,
          hint: "Search by title, description, or ticket ID",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Priority",
                items: [
                  {"label": "All Priorities", "value": "all"},
                  {"label": "Critical", "value": "Critical"},
                  {"label": "High", "value": "High"},
                  {"label": "Medium", "value": "Medium"},
                  {"label": "Low", "value": "Low"},
                ],
                value: selectedPriority,
                onChanged: (value, label) {
                  selectedPriority = value;
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
                  {"label": "Open", "value": "Open"},
                  {"label": "In Progress", "value": "In Progress"},
                  {"label": "Escalated", "value": "Escalated"},
                  {"label": "Resolved", "value": "Resolved"},
                  {"label": "Closed", "value": "Closed"},
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
      ],
    );
  }

  Widget _buildTicketStats() {
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
            "Ticket Overview",
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
                  "Total Tickets",
                  "${tickets.length}",
                  Icons.confirmation_number,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Open Tickets",
                  "${tickets.where((t) => t["status"] == "Open").length}",
                  Icons.fiber_new,
                  warningColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "In Progress",
                  "${tickets.where((t) => t["status"] == "In Progress").length}",
                  Icons.pending,
                  infoColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Escalated",
                  "${tickets.where((t) => t["status"] == "Escalated").length}",
                  Icons.trending_up,
                  dangerColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTicketsList(List<Map<String, dynamic>> filteredTickets) {
    return Column(
      spacing: spSm,
      children: filteredTickets.map((ticket) {
        Color priorityColor = _getPriorityColor(ticket["priority"]);
        Color statusColor = _getStatusColor(ticket["status"]);

        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: Border(
              left: BorderSide(
                width: 4,
                color: priorityColor,
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
                          "${ticket["id"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${ticket["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${ticket["priority"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: priorityColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "${ticket["description"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.person, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${ticket["customer"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Icon(Icons.support_agent, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${ticket["agent"]}",
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
                            "Status",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${ticket["status"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
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
                            "Category",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${ticket["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
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
                            "Replies",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${ticket["replies"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
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
                children: (ticket["tags"] as List).map((tag) {
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
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        // Navigate to ticket details
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.chat,
                    size: bs.sm,
                    onPressed: () {
                      // Open chat
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAgentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAgentsStats(),
          _buildAgentsList(),
        ],
      ),
    );
  }

  Widget _buildAgentsStats() {
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
            "Agent Performance",
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
                  "Total Active Tickets",
                  "${agents.fold(0, (sum, a) => sum + (a["activeTickets"] as int))}",
                  Icons.assignment,
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
                  SizedBox(width: spSm),
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
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
                  ),
                  QButton(
                    icon: Icons.chat,
                    size: bs.sm,
                    onPressed: () {
                      // Start chat with agent
                    },
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
                            "Active Tickets",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${agent["activeTickets"]}",
                            style: TextStyle(
                              fontSize: 14,
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
                            "${agent["resolvedToday"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
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
                            "Avg Response",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${agent["avgResponseTime"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
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
          _buildSLACompliance(),
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
            "Help Desk Analytics",
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
                  "Resolution Rate",
                  "87%",
                  Icons.check_circle,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Avg Response Time",
                  "13 min",
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
                  "Customer Satisfaction",
                  "4.6/5",
                  Icons.star,
                  warningColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "First Contact Resolution",
                  "72%",
                  Icons.flash_on,
                  primaryColor,
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
          _buildMetricRow("Tickets Created Today", "28", successColor),
          _buildMetricRow("Tickets Resolved Today", "24", primaryColor),
          _buildMetricRow("Tickets Escalated Today", "3", dangerColor),
          _buildMetricRow("Average Handle Time", "25 minutes", infoColor),
        ],
      ),
    );
  }

  Widget _buildSLACompliance() {
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
            "SLA Compliance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildSLARow("Critical Tickets", "95%", successColor),
          _buildSLARow("High Priority", "88%", successColor),
          _buildSLARow("Medium Priority", "92%", successColor),
          _buildSLARow("Low Priority", "96%", successColor),
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

  Widget _buildSLARow(String priority, String compliance, Color color) {
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
            priority,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.check_circle, size: 16, color: color),
              SizedBox(width: spXs),
              Text(
                compliance,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "Open":
        return infoColor;
      case "In Progress":
        return warningColor;
      case "Escalated":
        return dangerColor;
      case "Resolved":
        return successColor;
      case "Closed":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }
}
