import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmWebinarIntegrationView extends StatefulWidget {
  const EcmWebinarIntegrationView({super.key});

  @override
  State<EcmWebinarIntegrationView> createState() => _EcmWebinarIntegrationViewState();
}

class _EcmWebinarIntegrationViewState extends State<EcmWebinarIntegrationView> {
  List<Map<String, dynamic>> webinars = [
    {
      "id": 1,
      "title": "Digital Transformation Strategies",
      "host": "Dr. Amanda Rodriguez",
      "platform": "Zoom",
      "meeting_id": "123-456-789",
      "status": "Live",
      "start_time": DateTime.now().subtract(Duration(minutes: 30)),
      "end_time": DateTime.now().add(Duration(minutes: 30)),
      "attendees": 247,
      "capacity": 500,
      "registration_url": "https://zoom.us/webinar/register/123456789",
      "passcode": "DT2024",
      "category": "Business Strategy",
      "level": "Intermediate",
      "description": "Learn how to implement effective digital transformation strategies in your organization.",
      "agenda": ["Introduction", "Current Challenges", "Best Practices", "Case Studies", "Q&A"],
      "materials": ["Presentation Slides", "Resource Links", "Templates"],
      "recording_available": true,
      "chat_enabled": true,
      "polls_count": 3,
      "q_and_a_enabled": true,
      "breakout_rooms": false,
      "waiting_room": true,
      "registration_required": true,
      "fee": 49.99,
      "language": "English",
      "timezone": "UTC-8",
      "external_id": "zoom_123456789"
    },
    {
      "id": 2,
      "title": "AI in Healthcare: Practical Applications",
      "host": "Prof. Michael Chen",
      "platform": "Microsoft Teams",
      "meeting_id": "19:meeting_abc123def456@thread.v2",
      "status": "Scheduled",
      "start_time": DateTime.now().add(Duration(hours: 2)),
      "end_time": DateTime.now().add(Duration(hours: 3, minutes: 30)),
      "attendees": 0,
      "capacity": 300,
      "registration_url": "https://teams.microsoft.com/registration/abc123",
      "passcode": "AI2024",
      "category": "Healthcare Technology",
      "level": "Advanced",
      "description": "Explore real-world applications of artificial intelligence in healthcare settings.",
      "agenda": ["AI Overview", "Medical Imaging", "Diagnostics", "Treatment Planning", "Ethics"],
      "materials": ["Case Studies", "Research Papers", "Code Examples"],
      "recording_available": true,
      "chat_enabled": true,
      "polls_count": 2,
      "q_and_a_enabled": true,
      "breakout_rooms": true,
      "waiting_room": false,
      "registration_required": true,
      "fee": 75.00,
      "language": "English",
      "timezone": "UTC-5",
      "external_id": "teams_abc123def456"
    },
    {
      "id": 3,
      "title": "Sustainable Business Practices Workshop",
      "host": "Sarah Johnson",
      "platform": "Google Meet",
      "meeting_id": "abc-defg-hij",
      "status": "Break",
      "start_time": DateTime.now().subtract(Duration(hours: 1)),
      "end_time": DateTime.now().add(Duration(minutes: 45)),
      "attendees": 156,
      "capacity": 200,
      "registration_url": "https://meet.google.com/register/abc-defg-hij",
      "passcode": "GREEN2024",
      "category": "Sustainability",
      "level": "Beginner",
      "description": "Learn how to implement sustainable practices in your business operations.",
      "agenda": ["Sustainability Basics", "Implementation Strategies", "Measurement", "ROI Analysis"],
      "materials": ["Sustainability Checklist", "ROI Calculator", "Best Practices Guide"],
      "recording_available": true,
      "chat_enabled": true,
      "polls_count": 4,
      "q_and_a_enabled": true,
      "breakout_rooms": true,
      "waiting_room": true,
      "registration_required": false,
      "fee": 0.00,
      "language": "English",
      "timezone": "UTC+0",
      "external_id": "meet_abc_defg_hij"
    },
    {
      "id": 4,
      "title": "Cybersecurity Fundamentals",
      "host": "Robert Kim",
      "platform": "GoToWebinar",
      "meeting_id": "GTW123456",
      "status": "Completed",
      "start_time": DateTime.now().subtract(Duration(hours: 4)),
      "end_time": DateTime.now().subtract(Duration(hours: 2)),
      "attendees": 0,
      "capacity": 1000,
      "registration_url": "https://attendee.gotowebinar.com/register/123456",
      "passcode": "CYBER2024",
      "category": "Cybersecurity",
      "level": "Beginner",
      "description": "Essential cybersecurity knowledge for modern businesses and individuals.",
      "agenda": ["Threat Landscape", "Protection Strategies", "Incident Response", "Compliance"],
      "materials": ["Security Checklist", "Incident Response Plan", "Tool Recommendations"],
      "recording_available": true,
      "chat_enabled": true,
      "polls_count": 5,
      "q_and_a_enabled": true,
      "breakout_rooms": false,
      "waiting_room": true,
      "registration_required": true,
      "fee": 29.99,
      "language": "English",
      "timezone": "UTC-7",
      "external_id": "gtw_123456"
    },
    {
      "id": 5,
      "title": "Financial Planning for Startups",
      "host": "Lisa Park",
      "platform": "WebEx",
      "meeting_id": "2583456789",
      "status": "Scheduled",
      "start_time": DateTime.now().add(Duration(days: 1)),
      "end_time": DateTime.now().add(Duration(days: 1, hours: 2)),
      "attendees": 0,
      "capacity": 150,
      "registration_url": "https://webex.com/join/2583456789",
      "passcode": "FINANCE24",
      "category": "Finance",
      "level": "Intermediate",
      "description": "Essential financial planning strategies for startup success and growth.",
      "agenda": ["Financial Basics", "Budgeting", "Fundraising", "Growth Planning", "Exit Strategies"],
      "materials": ["Financial Templates", "Budgeting Spreadsheet", "Investor Pitch Deck"],
      "recording_available": true,
      "chat_enabled": true,
      "polls_count": 3,
      "q_and_a_enabled": true,
      "breakout_rooms": true,
      "waiting_room": true,
      "registration_required": true,
      "fee": 99.99,
      "language": "English",
      "timezone": "UTC-3",
      "external_id": "webex_2583456789"
    }
  ];

  String selectedStatus = "All";
  String selectedPlatform = "All";
  String selectedCategory = "All";
  String searchQuery = "";

  final List<String> statuses = ["All", "Live", "Scheduled", "Break", "Completed", "Cancelled"];
  final List<String> platforms = ["All", "Zoom", "Microsoft Teams", "Google Meet", "GoToWebinar", "WebEx"];
  final List<String> categories = ["All", "Business Strategy", "Healthcare Technology", "Sustainability", "Cybersecurity", "Finance"];

  List<Map<String, dynamic>> get filteredWebinars {
    return webinars.where((webinar) {
      final matchesStatus = selectedStatus == "All" || webinar["status"] == selectedStatus;
      final matchesPlatform = selectedPlatform == "All" || webinar["platform"] == selectedPlatform;
      final matchesCategory = selectedCategory == "All" || webinar["category"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty || 
          "${webinar["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${webinar["host"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesPlatform && matchesCategory && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Live":
        return dangerColor;
      case "Scheduled":
        return infoColor;
      case "Break":
        return warningColor;
      case "Completed":
        return successColor;
      case "Cancelled":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPlatformColor(String platform) {
    switch (platform) {
      case "Zoom":
        return Color(0xFF2D8CFF);
      case "Microsoft Teams":
        return Color(0xFF6264A7);
      case "Google Meet":
        return Color(0xFF00AC47);
      case "GoToWebinar":
        return Color(0xFFFF6900);
      case "WebEx":
        return Color(0xFF00BCF2);
      default:
        return primaryColor;
    }
  }

  IconData _getPlatformIcon(String platform) {
    switch (platform) {
      case "Zoom":
        return Icons.video_call;
      case "Microsoft Teams":
        return Icons.groups;
      case "Google Meet":
        return Icons.videocam;
      case "GoToWebinar":
        return Icons.cast;
      case "WebEx":
        return Icons.web;
      default:
        return Icons.computer;
    }
  }

  void _joinWebinar(Map<String, dynamic> webinar) async {
    if (webinar["status"] != "Live" && webinar["status"] != "Break") {
      se("This webinar is not currently live");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    // Navigate to webinar viewer or open external URL
    // navigateTo(EcmWebinarViewerView(webinar: webinar));
    ss("Joining webinar: ${webinar["title"]}");
  }

  void _manageWebinar(Map<String, dynamic> webinar) {
    // Navigate to webinar management
    // navigateTo(EcmWebinarManagementView(webinar: webinar));
  }

  void _viewWebinarDetails(Map<String, dynamic> webinar) {
    // Navigate to webinar details
    // navigateTo(EcmWebinarDetailsView(webinar: webinar));
  }

  void _integrateNewWebinar() {
    // Navigate to integrate new webinar
    // navigateTo(EcmIntegrateWebinarView());
  }

  void _syncWebinar(Map<String, dynamic> webinar) async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Webinar synchronized with ${webinar["platform"]}");
  }

  Widget _buildStatsCard() {
    final totalWebinars = webinars.length;
    final liveWebinars = webinars.where((w) => w["status"] == "Live").length;
    final totalAttendees = webinars.fold(0, (sum, w) => sum + (w["attendees"] as int));
    final totalRevenue = webinars.fold(0.0, (sum, w) => sum + ((w["fee"] as double) * (w["attendees"] as int)));

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
            "Webinar Integration Overview",
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
                child: _buildStatItem("Total Webinars", totalWebinars.toString(), Icons.computer, primaryColor),
              ),
              Expanded(
                child: _buildStatItem("Live Now", liveWebinars.toString(), Icons.live_tv, dangerColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatItem("Total Attendees", totalAttendees.toString(), Icons.people, infoColor),
              ),
              Expanded(
                child: _buildStatItem("Revenue", "\$${(totalRevenue / 1000).toStringAsFixed(1)}K", Icons.attach_money, successColor),
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

  Widget _buildWebinarCard(Map<String, dynamic> webinar) {
    final attendanceRate = ((webinar["attendees"] as int) / (webinar["capacity"] as int)) * 100;
    
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
                        color: _getPlatformColor("${webinar["platform"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        _getPlatformIcon("${webinar["platform"]}"),
                        color: _getPlatformColor("${webinar["platform"]}"),
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${webinar["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Hosted by ${webinar["host"]}",
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
                        color: _getStatusColor("${webinar["status"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${webinar["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor("${webinar["status"]}"),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${webinar["description"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getPlatformColor("${webinar["platform"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${webinar["platform"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getPlatformColor("${webinar["platform"]}"),
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
                        "${webinar["level"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    if ((webinar["fee"] as double) > 0) ...[
                      Text(
                        "\$${webinar["fee"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ] else ...[
                      Text(
                        "FREE",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${(webinar["start_time"] as DateTime).dMMMy} ${(webinar["start_time"] as DateTime).kkmm}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.language, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${webinar["language"]}",
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
                    Icon(Icons.meeting_room, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "ID: ${webinar["meeting_id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.lock, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Code: ${webinar["passcode"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Attendance (${webinar["attendees"]}/${webinar["capacity"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: attendanceRate / 100,
                      backgroundColor: Colors.grey.withAlpha(50),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        attendanceRate > 80 ? dangerColor :
                        attendanceRate > 60 ? warningColor : successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Features:",
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
                  children: [
                    if (webinar["recording_available"]) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Recording",
                          style: TextStyle(
                            fontSize: 10,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    if (webinar["chat_enabled"]) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Chat",
                          style: TextStyle(
                            fontSize: 10,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    if (webinar["q_and_a_enabled"]) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Q&A",
                          style: TextStyle(
                            fontSize: 10,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    if (webinar["breakout_rooms"]) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Breakouts",
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    if ((webinar["polls_count"] as int) > 0) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${webinar["polls_count"]} Polls",
                          style: TextStyle(
                            fontSize: 10,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Agenda: ${(webinar["agenda"] as List).join(" • ")}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
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
                if (webinar["status"] == "Live" || webinar["status"] == "Break") ...[
                  QButton(
                    label: "Join",
                    icon: Icons.login,
                    size: bs.sm,
                    onPressed: () => _joinWebinar(webinar),
                  ),
                  SizedBox(width: spSm),
                ],
                QButton(
                  label: "Details",
                  icon: Icons.info,
                  size: bs.sm,
                  onPressed: () => _viewWebinarDetails(webinar),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Sync",
                  icon: Icons.sync,
                  size: bs.sm,
                  onPressed: () => _syncWebinar(webinar),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => _manageWebinar(webinar),
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
        title: Text("Webinar Integration"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _integrateNewWebinar,
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
                    label: "Search webinars...",
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
                    label: "Platform",
                    items: platforms.map((platform) => {
                      "label": platform,
                      "value": platform,
                    }).toList(),
                    value: selectedPlatform,
                    onChanged: (value, label) {
                      selectedPlatform = value;
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
            if (filteredWebinars.isEmpty)
              Center(
                child: Column(
                  children: [
                    SizedBox(height: spXl),
                    Icon(
                      Icons.computer,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No webinars found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or integrate a new webinar",
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
                children: filteredWebinars.map((webinar) {
                  return _buildWebinarCard(webinar);
                }).toList(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _integrateNewWebinar,
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
