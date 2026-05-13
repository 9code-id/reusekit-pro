import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHelp2View extends StatefulWidget {
  @override
  State<GrlHelp2View> createState() => _GrlHelp2ViewState();
}

class _GrlHelp2ViewState extends State<GrlHelp2View> {
  String selectedStatus = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Tickets", "value": "all"},
    {"label": "Open", "value": "open"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Resolved", "value": "resolved"},
    {"label": "Closed", "value": "closed"},
  ];

  List<Map<String, dynamic>> supportTickets = [
    {
      "id": "TK-001",
      "title": "Unable to process payment",
      "description": "Getting error when trying to make payment using credit card",
      "status": "open",
      "priority": "high",
      "category": "billing",
      "created_at": "2024-01-15T10:30:00Z",
      "updated_at": "2024-01-15T14:30:00Z",
      "agent": "Sarah Johnson",
      "messages": 3
    },
    {
      "id": "TK-002",
      "title": "Account verification issue",
      "description": "Cannot verify email address for account activation",
      "status": "in_progress",
      "priority": "medium",
      "category": "account",
      "created_at": "2024-01-14T09:15:00Z",
      "updated_at": "2024-01-15T11:20:00Z",
      "agent": "Mike Chen",
      "messages": 5
    },
    {
      "id": "TK-003",
      "title": "Feature request: Dark mode",
      "description": "Would like to have dark mode option in the app",
      "status": "resolved",
      "priority": "low",
      "category": "feature",
      "created_at": "2024-01-13T16:45:00Z",
      "updated_at": "2024-01-14T12:00:00Z",
      "agent": "Emma Wilson",
      "messages": 8
    },
    {
      "id": "TK-004",
      "title": "App crashes on startup",
      "description": "Mobile app crashes immediately after opening",
      "status": "closed",
      "priority": "high",
      "category": "technical",
      "created_at": "2024-01-12T08:20:00Z",
      "updated_at": "2024-01-13T15:30:00Z",
      "agent": "David Rodriguez",
      "messages": 12
    },
  ];

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Cards
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildStatCard("Open Tickets", "4", successColor, Icons.schedule),
                _buildStatCard("In Progress", "2", warningColor, Icons.sync),
                _buildStatCard("Resolved", "8", infoColor, Icons.check_circle),
                _buildStatCard("Closed", "15", disabledBoldColor, Icons.archive),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Search and Filter
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search tickets...",
                    value: searchQuery,
                    hint: "Enter ticket ID or title",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Container(
                  width: 120,
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
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Tickets List
            Text(
              "Your Tickets",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...supportTickets.map((ticket) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor(ticket["status"]),
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${ticket["id"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
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
                            color: _getStatusColor(ticket["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${ticket["status"]}".replaceAll("_", " ").toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(ticket["status"]),
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
                            color: _getPriorityColor(ticket["priority"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${ticket["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getPriorityColor(ticket["priority"]),
                            ),
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.more_vert,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Text(
                      "${ticket["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      "${ticket["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 16,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${ticket["agent"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(
                          Icons.message,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${ticket["messages"]} messages",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Updated ${_formatDate(ticket["updated_at"])}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "View",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Create New Ticket
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor.withAlpha(60),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.add_circle,
                    color: primaryColor,
                    size: 48,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Need more help?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Create a new support ticket and our team will get back to you as soon as possible.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QButton(
                    label: "Create New Ticket",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'open':
        return successColor;
      case 'in_progress':
        return warningColor;
      case 'resolved':
        return infoColor;
      case 'closed':
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return primaryColor;
    }
  }

  String _formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      DateTime now = DateTime.now();
      Duration diff = now.difference(date);
      
      if (diff.inDays > 0) {
        return "${diff.inDays}d ago";
      } else if (diff.inHours > 0) {
        return "${diff.inHours}h ago";
      } else {
        return "${diff.inMinutes}m ago";
      }
    } catch (e) {
      return "Recently";
    }
  }
}
