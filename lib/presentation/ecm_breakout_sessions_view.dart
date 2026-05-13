import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmBreakoutSessionsView extends StatefulWidget {
  const EcmBreakoutSessionsView({super.key});

  @override
  State<EcmBreakoutSessionsView> createState() => _EcmBreakoutSessionsViewState();
}

class _EcmBreakoutSessionsViewState extends State<EcmBreakoutSessionsView> {
  List<Map<String, dynamic>> breakoutSessions = [
    {
      "id": 1,
      "title": "Future of Remote Work",
      "facilitator": "Dr. Amanda Lee",
      "room": "Breakout Room A",
      "capacity": 25,
      "current_participants": 18,
      "status": "Active",
      "start_time": DateTime.now().subtract(Duration(minutes: 15)),
      "end_time": DateTime.now().add(Duration(minutes: 45)),
      "category": "Workplace Innovation",
      "level": "Intermediate",
      "topics": ["Remote Collaboration", "Digital Nomads", "Work-Life Balance"],
      "materials": ["Discussion Guide", "Case Studies", "Survey"],
      "interaction_type": "Discussion",
      "rating": 4.8,
      "engagement_score": 92
    },
    {
      "id": 2,
      "title": "Sustainable Technology Solutions",
      "facilitator": "Prof. Michael Green",
      "room": "Innovation Lab B",
      "capacity": 30,
      "current_participants": 22,
      "status": "Active",
      "start_time": DateTime.now().subtract(Duration(minutes: 30)),
      "end_time": DateTime.now().add(Duration(minutes: 30)),
      "category": "Environmental Tech",
      "level": "Advanced",
      "topics": ["Green Energy", "Carbon Footprint", "Eco-Innovation"],
      "materials": ["Research Papers", "Calculator Tool", "Action Plan"],
      "interaction_type": "Workshop",
      "rating": 4.6,
      "engagement_score": 87
    },
    {
      "id": 3,
      "title": "AI Ethics in Healthcare",
      "facilitator": "Dr. Sarah Chen",
      "room": "Conference Room C",
      "capacity": 20,
      "current_participants": 0,
      "status": "Scheduled",
      "start_time": DateTime.now().add(Duration(minutes: 30)),
      "end_time": DateTime.now().add(Duration(hours: 1, minutes: 30)),
      "category": "Healthcare AI",
      "level": "Expert",
      "topics": ["Medical AI", "Patient Privacy", "Algorithmic Bias"],
      "materials": ["Ethics Framework", "Case Studies", "Guidelines"],
      "interaction_type": "Panel Discussion",
      "rating": 4.9,
      "engagement_score": 0
    },
    {
      "id": 4,
      "title": "Digital Marketing Strategies",
      "facilitator": "Lisa Rodriguez",
      "room": "Workshop Studio D",
      "capacity": 35,
      "current_participants": 28,
      "status": "Active",
      "start_time": DateTime.now().subtract(Duration(hours: 1)),
      "end_time": DateTime.now().add(Duration(minutes: 15)),
      "category": "Marketing",
      "level": "Beginner",
      "topics": ["Social Media", "Content Strategy", "Analytics"],
      "materials": ["Strategy Template", "Analytics Tools", "Checklist"],
      "interaction_type": "Hands-on Workshop",
      "rating": 4.5,
      "engagement_score": 94
    },
    {
      "id": 5,
      "title": "Blockchain in Finance",
      "facilitator": "James Wilson",
      "room": "Tech Lab E",
      "capacity": 15,
      "current_participants": 12,
      "status": "Break",
      "start_time": DateTime.now().subtract(Duration(minutes: 45)),
      "end_time": DateTime.now().add(Duration(minutes: 30)),
      "category": "FinTech",
      "level": "Advanced",
      "topics": ["DeFi", "Smart Contracts", "Cryptocurrency"],
      "materials": ["Code Samples", "Blockchain Demo", "White Papers"],
      "interaction_type": "Technical Demo",
      "rating": 4.7,
      "engagement_score": 89
    },
    {
      "id": 6,
      "title": "Leadership in Crisis",
      "facilitator": "Robert Johnson",
      "room": "Executive Suite F",
      "capacity": 12,
      "current_participants": 0,
      "status": "Completed",
      "start_time": DateTime.now().subtract(Duration(hours: 3)),
      "end_time": DateTime.now().subtract(Duration(hours: 2)),
      "category": "Leadership",
      "level": "Executive",
      "topics": ["Crisis Management", "Decision Making", "Team Resilience"],
      "materials": ["Leadership Assessment", "Crisis Playbook", "Case Studies"],
      "interaction_type": "Interactive Session",
      "rating": 4.9,
      "engagement_score": 96
    }
  ];

  String selectedStatus = "All";
  String selectedCategory = "All";
  String selectedLevel = "All";
  String searchQuery = "";

  final List<String> statuses = ["All", "Active", "Scheduled", "Break", "Completed", "Cancelled"];
  final List<String> categories = ["All", "Workplace Innovation", "Environmental Tech", "Healthcare AI", "Marketing", "FinTech", "Leadership"];
  final List<String> levels = ["All", "Beginner", "Intermediate", "Advanced", "Expert", "Executive"];

  List<Map<String, dynamic>> get filteredSessions {
    return breakoutSessions.where((session) {
      final matchesStatus = selectedStatus == "All" || session["status"] == selectedStatus;
      final matchesCategory = selectedCategory == "All" || session["category"] == selectedCategory;
      final matchesLevel = selectedLevel == "All" || session["level"] == selectedLevel;
      final matchesSearch = searchQuery.isEmpty || 
          "${session["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${session["facilitator"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesCategory && matchesLevel && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Scheduled":
        return infoColor;
      case "Break":
        return warningColor;
      case "Completed":
        return primaryColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return infoColor;
      case "Advanced":
        return warningColor;
      case "Expert":
        return dangerColor;
      case "Executive":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getInteractionIcon(String type) {
    switch (type) {
      case "Discussion":
        return Icons.forum;
      case "Workshop":
        return Icons.build;
      case "Panel Discussion":
        return Icons.group;
      case "Hands-on Workshop":
        return Icons.construction;
      case "Technical Demo":
        return Icons.computer;
      case "Interactive Session":
        return Icons.psychology;
      default:
        return Icons.chat;
    }
  }

  void _joinSession(Map<String, dynamic> session) async {
    if (session["status"] != "Active") {
      se("This session is not currently active");
      return;
    }
    
    if ((session["current_participants"] as int) >= (session["capacity"] as int)) {
      se("This session is at full capacity");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    // Navigate to session room
    // navigateTo(EcmBreakoutRoomView(session: session));
    ss("Joined ${session["title"]}");
  }

  void _manageSession(Map<String, dynamic> session) {
    // Navigate to session management
    // navigateTo(EcmSessionManagementView(session: session));
  }

  void _viewSessionDetails(Map<String, dynamic> session) {
    // Navigate to session details
    // navigateTo(EcmSessionDetailsView(session: session));
  }

  void _createNewSession() {
    // Navigate to create session
    // navigateTo(EcmCreateBreakoutSessionView());
  }

  Widget _buildStatsCard() {
    final totalSessions = breakoutSessions.length;
    final activeSessions = breakoutSessions.where((s) => s["status"] == "Active").length;
    final totalParticipants = breakoutSessions.fold(0, (sum, s) => sum + (s["current_participants"] as int));
    final avgEngagement = breakoutSessions.fold(0.0, (sum, s) => sum + (s["engagement_score"] as int)) / totalSessions;

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Breakout Sessions Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatItem("Total Sessions", totalSessions.toString(), Icons.groups, primaryColor),
              ),
              Expanded(
                child: _buildStatItem("Active Now", activeSessions.toString(), Icons.play_circle, successColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatItem("Participants", totalParticipants.toString(), Icons.people, infoColor),
              ),
              Expanded(
                child: _buildStatItem("Avg Engagement", "${avgEngagement.toStringAsFixed(0)}%", Icons.trending_up, warningColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: spXs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSessionCard(Map<String, dynamic> session) {
    final participationRate = ((session["current_participants"] as int) / (session["capacity"] as int)) * 100;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        _getInteractionIcon("${session["interaction_type"]}"),
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${session["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Facilitated by ${session["facilitator"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor("${session["status"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${session["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor("${session["status"]}"),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.room, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${session["room"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${(session["start_time"] as DateTime).kkmm} - ${(session["end_time"] as DateTime).kkmm}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getLevelColor("${session["level"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${session["level"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _getLevelColor("${session["level"]}"),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${session["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${session["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Topics:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (session["topics"] as List).map<Widget>((topic) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "$topic",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spSm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Participation (${session["current_participants"]}/${session["capacity"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: participationRate / 100,
                      backgroundColor: Colors.grey.withAlpha(50),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        participationRate > 80 ? dangerColor :
                        participationRate > 60 ? warningColor : successColor,
                      ),
                    ),
                  ],
                ),
                if (session["engagement_score"] > 0) ...[
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "Engagement: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${session["engagement_score"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${session["interaction_type"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radiusMd),
                bottomRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                if (session["status"] == "Active" || session["status"] == "Scheduled") ...[
                  QButton(
                    label: "Join",
                    icon: Icons.login,
                    size: bs.sm,
                    onPressed: () => _joinSession(session),
                  ),
                  SizedBox(width: spSm),
                ],
                QButton(
                  label: "Details",
                  icon: Icons.info,
                  size: bs.sm,
                  onPressed: () => _viewSessionDetails(session),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => _manageSession(session),
                  child: Icon(
                    Icons.settings,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Breakout Sessions"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createNewSession,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCard(),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search sessions...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
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
                    label: "Status",
                    items: statuses.map((status) => {
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
                    label: "Level",
                    items: levels.map((level) => {
                      "label": level,
                      "value": level,
                    }).toList(),
                    value: selectedLevel,
                    onChanged: (value, label) {
                      selectedLevel = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Category",
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
            if (filteredSessions.isEmpty)
              Center(
                child: Column(
                  children: [
                    SizedBox(height: spXl),
                    Icon(
                      Icons.groups,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No breakout sessions found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or create a new session",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredSessions.map((session) {
                  return _buildSessionCard(session);
                }).toList(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewSession,
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
