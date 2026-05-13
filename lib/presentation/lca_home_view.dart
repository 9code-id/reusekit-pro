import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaHomeView extends StatefulWidget {
  const LcaHomeView({Key? key}) : super(key: key);

  @override
  State<LcaHomeView> createState() => _LcaHomeViewState();
}

class _LcaHomeViewState extends State<LcaHomeView> {
  String searchQuery = "";
  int selectedQuickAction = -1;
  
  List<Map<String, dynamic>> recentCases = [
    {
      "id": "CASE-2024-001",
      "title": "Johnson vs. Smith Corporation",
      "type": "Civil Litigation",
      "status": "active",
      "priority": "high",
      "lastUpdate": "2024-06-15T10:30:00Z",
      "nextDeadline": "2024-06-20T14:00:00Z",
      "client": "Johnson Family Trust",
      "progress": 75,
    },
    {
      "id": "CASE-2024-002", 
      "title": "Estate Planning - Williams",
      "type": "Estate Law",
      "status": "review",
      "priority": "medium",
      "lastUpdate": "2024-06-14T16:45:00Z",
      "nextDeadline": "2024-06-18T09:00:00Z",
      "client": "Robert Williams",
      "progress": 40,
    },
    {
      "id": "CASE-2024-003",
      "title": "Corporate Merger - TechCorp",
      "type": "Corporate Law",
      "status": "pending",
      "priority": "urgent",
      "lastUpdate": "2024-06-16T11:20:00Z",
      "nextDeadline": "2024-06-17T16:00:00Z",
      "client": "TechCorp Industries",
      "progress": 90,
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "New Case",
      "description": "Create a new case file",
      "icon": Icons.add_circle,
      "color": primaryColor,
    },
    {
      "title": "Schedule Meeting",
      "description": "Book client consultation",
      "icon": Icons.calendar_today,
      "color": successColor,
    },
    {
      "title": "Generate Document",
      "description": "Create legal documents",
      "icon": Icons.description,
      "color": infoColor,
    },
    {
      "title": "Time Tracking",
      "description": "Log billable hours",
      "icon": Icons.timer,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> notifications = [
    {
      "id": "1",
      "title": "Deadline Reminder",
      "message": "Johnson vs. Smith motion due in 2 days",
      "type": "deadline",
      "isRead": false,
      "timestamp": "2024-06-16T09:30:00Z",
    },
    {
      "id": "2",
      "title": "Document Review",
      "message": "Contract review completed for TechCorp case",
      "type": "update",
      "isRead": false,
      "timestamp": "2024-06-16T08:15:00Z",
    },
    {
      "id": "3",
      "title": "Client Message",
      "message": "Robert Williams has sent a new message",
      "type": "message",
      "isRead": true,
      "timestamp": "2024-06-15T14:22:00Z",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Legal Case Assistant"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () => _showNotifications(),
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => _showProfile(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(),
            SizedBox(height: spLg),
            _buildSearchSection(),
            SizedBox(height: spLg),
            _buildQuickActions(),
            SizedBox(height: spLg),
            _buildRecentCases(),
            SizedBox(height: spLg),
            _buildDashboardStats(),
            SizedBox(height: spLg),
            _buildUpcomingDeadlines(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor.withAlpha(20),
            primaryColor.withAlpha(10),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.gavel, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good morning, Attorney Smith",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Johnson, Smith & Associates LLP",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "You have 3 active cases, 2 upcoming deadlines, and 5 unread notifications. Your case management efficiency is up 15% this month.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              _buildQuickStat("Active Cases", "3", Icons.folder_open),
              SizedBox(width: spMd),
              _buildQuickStat("This Week", "2 Deadlines", Icons.schedule),
              SizedBox(width: spMd),
              _buildQuickStat("Efficiency", "+15%", Icons.trending_up),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(200),
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryColor, size: 16),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              label,
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

  Widget _buildSearchSection() {
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
          Text(
            "Search Cases & Documents",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search",
                  value: searchQuery,
                  hint: "Search cases, clients, documents...",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.md,
                onPressed: () => _performSearch(),
              ),
            ],
          ),
          if (searchQuery.isNotEmpty) ...[
            SizedBox(height: spMd),
            _buildSearchSuggestions(),
          ],
        ],
      ),
    );
  }

  Widget _buildSearchSuggestions() {
    List<String> suggestions = [
      "Johnson vs. Smith Corporation",
      "Estate Planning - Williams",
      "Corporate Merger - TechCorp",
      "Contract Review Templates",
      "Motion to Dismiss Forms",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Searches",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spSm),
        Wrap(
          spacing: spXs,
          runSpacing: spXs,
          children: suggestions.map((suggestion) => GestureDetector(
            onTap: () {
              searchQuery = suggestion;
              setState(() {});
              _performSearch();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Text(
                suggestion,
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                ),
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
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
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: quickActions.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> action = entry.value;
              
              return GestureDetector(
                onTap: () => _executeQuickAction(index),
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: selectedQuickAction == index 
                        ? (action["color"] as Color).withAlpha(20)
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: selectedQuickAction == index 
                          ? (action["color"] as Color).withAlpha(100)
                          : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (action["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          action["icon"] as IconData,
                          color: action["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${action["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${action["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentCases() {
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
              Text(
                "Recent Cases",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _viewAllCases(),
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...recentCases.map((caseData) => _buildCaseCard(caseData)),
        ],
      ),
    );
  }

  Widget _buildCaseCard(Map<String, dynamic> caseData) {
    Color statusColor = _getStatusColor("${caseData["status"]}");
    Color priorityColor = _getPriorityColor("${caseData["priority"]}");
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border(
          left: BorderSide(
            width: 4,
            color: priorityColor,
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
                      "${caseData["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${caseData["id"]} • ${caseData["type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${caseData["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.person, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${caseData["client"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Progress: ${caseData["progress"]}%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          LinearProgressIndicator(
            value: (caseData["progress"] as int) / 100,
            backgroundColor: disabledColor.withAlpha(50),
            valueColor: AlwaysStoppedAnimation<Color>(priorityColor),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.schedule, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Next: ${DateTime.parse(caseData["nextDeadline"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _viewCase("${caseData["id"]}"),
                child: Icon(Icons.arrow_forward, size: 16, color: primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardStats() {
    List<Map<String, dynamic>> stats = [
      {
        "title": "Total Cases",
        "value": "28",
        "change": "+3",
        "icon": Icons.folder,
        "color": primaryColor,
      },
      {
        "title": "Billable Hours",
        "value": "127.5",
        "change": "+8.2",
        "icon": Icons.timer,
        "color": successColor,
      },
      {
        "title": "Revenue",
        "value": "\$45,200",
        "change": "+12%",
        "icon": Icons.attach_money,
        "color": infoColor,
      },
      {
        "title": "Win Rate",
        "value": "87%",
        "change": "+5%",
        "icon": Icons.trending_up,
        "color": warningColor,
      },
    ];

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: stats.map((stat) {
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
                      color: (stat["color"] as Color).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      stat["icon"] as IconData,
                      color: stat["color"] as Color,
                      size: 20,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${stat["change"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "${stat["value"]}",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${stat["title"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUpcomingDeadlines() {
    List<Map<String, dynamic>> deadlines = [
      {
        "case": "Johnson vs. Smith Corporation",
        "task": "Motion to Dismiss Filing",
        "date": "2024-06-20T14:00:00Z",
        "priority": "high",
      },
      {
        "case": "Estate Planning - Williams", 
        "task": "Will Review Meeting",
        "date": "2024-06-18T09:00:00Z",
        "priority": "medium",
      },
      {
        "case": "Corporate Merger - TechCorp",
        "task": "Due Diligence Report",
        "date": "2024-06-17T16:00:00Z",
        "priority": "urgent",
      },
    ];

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
          Text(
            "Upcoming Deadlines",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...deadlines.map((deadline) {
            Color priorityColor = _getPriorityColor("${deadline["priority"]}");
            DateTime deadlineDate = DateTime.parse("${deadline["date"]}");
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: priorityColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: priorityColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(Icons.schedule, color: priorityColor, size: 16),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${deadline["task"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${deadline["case"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    deadlineDate.dMMMy,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: priorityColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return successColor;
      case "pending":
        return warningColor;
      case "review":
        return infoColor;
      case "closed":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "urgent":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return primaryColor;
    }
  }

  void _performSearch() {
    if (searchQuery.isNotEmpty) {
      si("Searching for: $searchQuery");
      // Navigate to search results
      //navigateTo('');
    }
  }

  void _executeQuickAction(int index) {
    setState(() {
      selectedQuickAction = index;
    });
    
    List<String> actions = ["new_case", "schedule_meeting", "generate_document", "time_tracking"];
    si("Executing: ${actions[index]}");
    
    // Reset selection after a delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        selectedQuickAction = -1;
      });
    });
    
    // Navigate to appropriate screen
    //navigateTo('');
  }

  void _viewAllCases() {
    si("Opening case management");
    // Navigate to case list
    //navigateTo('');
  }

  void _viewCase(String caseId) {
    si("Opening case: $caseId");
    // Navigate to case detail
    //navigateTo('');
  }

  void _showNotifications() {
    si("Opening notifications");
    // Show notifications panel or navigate
    //navigateTo('');
  }

  void _showProfile() {
    si("Opening profile");
    // Navigate to profile
    //navigateTo('');
  }
}
