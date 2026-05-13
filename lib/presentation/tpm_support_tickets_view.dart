import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmSupportTicketsView extends StatefulWidget {
  const TpmSupportTicketsView({super.key});

  @override
  State<TpmSupportTicketsView> createState() => _TpmSupportTicketsViewState();
}

class _TpmSupportTicketsViewState extends State<TpmSupportTicketsView> {
  String selectedStatus = "All";
  String selectedPriority = "All";
  
  List<String> statusOptions = ["All", "Open", "In Progress", "Resolved", "Closed"];
  List<String> priorityOptions = ["All", "Low", "Medium", "High", "Critical"];

  List<Map<String, dynamic>> tickets = [
    {
      "id": "TPM-001",
      "title": "Unable to create new project",
      "description": "Getting error when trying to create a new project from template",
      "status": "Open",
      "priority": "High",
      "category": "Project Management",
      "created_date": "2024-06-18T10:30:00Z",
      "updated_date": "2024-06-18T10:30:00Z",
      "assigned_agent": "Sarah Johnson",
      "customer_name": "John Doe",
      "customer_email": "john.doe@example.com",
      "responses": 0,
    },
    {
      "id": "TPM-002",
      "title": "Team member permissions not working",
      "description": "Team members can't access shared projects despite having correct permissions",
      "status": "In Progress",
      "priority": "Medium",
      "category": "Team Management",
      "created_date": "2024-06-17T14:15:00Z",
      "updated_date": "2024-06-18T09:20:00Z",
      "assigned_agent": "Mike Chen",
      "customer_name": "Alice Smith",
      "customer_email": "alice.smith@example.com",
      "responses": 3,
    },
    {
      "id": "TPM-003",
      "title": "Integration with Slack not syncing",
      "description": "Slack notifications stopped working after last update",
      "status": "Resolved",
      "priority": "Low",
      "category": "Integrations",
      "created_date": "2024-06-16T09:45:00Z",
      "updated_date": "2024-06-17T16:30:00Z",
      "assigned_agent": "Emma Wilson",
      "customer_name": "Bob Brown",
      "customer_email": "bob.brown@example.com",
      "responses": 5,
    },
    {
      "id": "TPM-004",
      "title": "Critical data loss in project reports",
      "description": "All project reports showing empty data since yesterday",
      "status": "Open",
      "priority": "Critical",
      "category": "Reporting",
      "created_date": "2024-06-18T08:00:00Z",
      "updated_date": "2024-06-18T08:00:00Z",
      "assigned_agent": "David Lee",
      "customer_name": "Carol White",
      "customer_email": "carol.white@example.com",
      "responses": 0,
    },
    {
      "id": "TPM-005",
      "title": "Mobile app login issues",
      "description": "Cannot login to mobile app with valid credentials",
      "status": "In Progress",
      "priority": "High",
      "category": "Authentication",
      "created_date": "2024-06-17T11:20:00Z",
      "updated_date": "2024-06-18T07:45:00Z",
      "assigned_agent": "Lisa Garcia",
      "customer_name": "Tom Johnson",
      "customer_email": "tom.johnson@example.com",
      "responses": 2,
    },
    {
      "id": "TPM-006",
      "title": "Feature request: Dark mode",
      "description": "Would like to have dark mode option in the application",
      "status": "Closed",
      "priority": "Low",
      "category": "Feature Request",
      "created_date": "2024-06-15T13:10:00Z",
      "updated_date": "2024-06-16T10:00:00Z",
      "assigned_agent": "Sarah Johnson",
      "customer_name": "Mark Davis",
      "customer_email": "mark.davis@example.com",
      "responses": 4,
    },
  ];

  List<Map<String, dynamic>> get filteredTickets {
    return tickets.where((ticket) {
      bool matchesStatus = selectedStatus == "All" || ticket["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "All" || ticket["priority"] == selectedPriority;
      return matchesStatus && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Open":
        return dangerColor;
      case "In Progress":
        return warningColor;
      case "Resolved":
        return successColor;
      case "Closed":
        return disabledBoldColor;
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

  String _getTimeAgo(String dateString) {
    DateTime date = DateTime.parse(dateString);
    Duration difference = DateTime.now().difference(date);
    
    if (difference.inDays > 0) {
      return "${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inMinutes}m ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Support Tickets"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${tickets.where((t) => t["status"] == "Open").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Open",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${tickets.where((t) => t["status"] == "In Progress").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "In Progress",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${tickets.where((t) => t["status"] == "Resolved").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Resolved",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusOptions.map((status) => {
                      "label": status,
                      "value": status,
                    }).toList(),
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
                    items: priorityOptions.map((priority) => {
                      "label": priority,
                      "value": priority,
                    }).toList(),
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Tickets List Header
            Row(
              children: [
                Text(
                  "Tickets",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredTickets.length} tickets",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            // Tickets List
            Column(
              spacing: spSm,
              children: filteredTickets.map((ticket) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getPriorityColor(ticket["priority"] as String),
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          Text(
                            "#${ticket["id"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(ticket["status"] as String).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "${ticket["status"]}",
                              style: TextStyle(
                                color: _getStatusColor(ticket["status"] as String),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(ticket["priority"] as String).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "${ticket["priority"]}",
                              style: TextStyle(
                                color: _getPriorityColor(ticket["priority"] as String),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            _getTimeAgo(ticket["updated_date"] as String),
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      // Title and Description
                      Text(
                        "${ticket["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${ticket["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),

                      // Customer and Agent Info
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${ticket["customer_name"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Icon(
                            Icons.support_agent,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${ticket["assigned_agent"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          if ((ticket["responses"] as int) > 0)
                            Row(
                              children: [
                                Icon(
                                  Icons.chat_bubble,
                                  size: 16,
                                  color: infoColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${ticket["responses"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),

                      // Category
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: secondaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${ticket["category"]}",
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Actions
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {},
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
}
