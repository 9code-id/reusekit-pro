import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmPanelDiscussionsView extends StatefulWidget {
  const EcmPanelDiscussionsView({super.key});

  @override
  State<EcmPanelDiscussionsView> createState() => _EcmPanelDiscussionsViewState();
}

class _EcmPanelDiscussionsViewState extends State<EcmPanelDiscussionsView> {
  List<Map<String, dynamic>> panelDiscussions = [
    {
      "id": 1,
      "title": "The Future of Artificial Intelligence",
      "moderator": "Dr. Janet Smith",
      "panelists": [
        {"name": "Dr. Michael Chen", "title": "AI Research Director", "company": "TechCorp"},
        {"name": "Prof. Sarah Johnson", "title": "Ethics Professor", "company": "Stanford University"},
        {"name": "James Wilson", "title": "CEO", "company": "AI Innovations"},
        {"name": "Dr. Maria Garcia", "title": "ML Engineer", "company": "Google"}
      ],
      "room": "Main Auditorium",
      "capacity": 500,
      "registered": 478,
      "status": "Active",
      "start_time": DateTime.now().subtract(Duration(minutes: 20)),
      "end_time": DateTime.now().add(Duration(minutes: 40)),
      "category": "Technology",
      "format": "Q&A Session",
      "topics": ["Machine Learning", "AI Ethics", "Future Trends", "Industry Impact"],
      "audience_level": "General",
      "live_viewers": 1247,
      "questions_submitted": 89,
      "engagement_score": 94.5,
      "rating": 4.8
    },
    {
      "id": 2,
      "title": "Sustainable Business Practices",
      "moderator": "Emma Rodriguez",
      "panelists": [
        {"name": "Robert Green", "title": "Sustainability Director", "company": "EcoTech"},
        {"name": "Lisa Chang", "title": "ESG Analyst", "company": "Green Finance"},
        {"name": "Dr. David Miller", "title": "Environmental Scientist", "company": "Climate Solutions"},
        {"name": "Anna Thompson", "title": "Policy Advisor", "company": "UN Environment"}
      ],
      "room": "Conference Hall B",
      "capacity": 300,
      "registered": 245,
      "status": "Scheduled",
      "start_time": DateTime.now().add(Duration(minutes: 45)),
      "end_time": DateTime.now().add(Duration(hours: 1, minutes: 45)),
      "category": "Sustainability",
      "format": "Panel Discussion",
      "topics": ["Carbon Footprint", "ESG Reporting", "Green Innovation", "Policy Framework"],
      "audience_level": "Professional",
      "live_viewers": 0,
      "questions_submitted": 23,
      "engagement_score": 0,
      "rating": 4.6
    },
    {
      "id": 3,
      "title": "Digital Health Revolution",
      "moderator": "Dr. Karen Lee",
      "panelists": [
        {"name": "Dr. Andrew Kim", "title": "Chief Medical Officer", "company": "HealthTech"},
        {"name": "Jennifer White", "title": "Digital Health Lead", "company": "MedCorp"},
        {"name": "Dr. Thomas Brown", "title": "Telemedicine Specialist", "company": "VirtualCare"},
        {"name": "Susan Davis", "title": "Health Data Analyst", "company": "HealthAnalytics"}
      ],
      "room": "Medical Center C",
      "capacity": 200,
      "registered": 189,
      "status": "Break",
      "start_time": DateTime.now().subtract(Duration(hours: 1)),
      "end_time": DateTime.now().add(Duration(minutes: 15)),
      "category": "Healthcare",
      "format": "Interactive Panel",
      "topics": ["Telemedicine", "Health Data", "Patient Privacy", "Digital Therapeutics"],
      "audience_level": "Expert",
      "live_viewers": 567,
      "questions_submitted": 45,
      "engagement_score": 87.2,
      "rating": 4.7
    },
    {
      "id": 4,
      "title": "Fintech Innovation Trends",
      "moderator": "Mark Johnson",
      "panelists": [
        {"name": "Alex Chen", "title": "Fintech Founder", "company": "PaymentPro"},
        {"name": "Rachel Adams", "title": "Banking Innovation Head", "company": "DigitalBank"},
        {"name": "Carlos Martinez", "title": "Blockchain Expert", "company": "CryptoSolutions"},
        {"name": "Nancy Wilson", "title": "Regulatory Affairs", "company": "FinRegulator"}
      ],
      "room": "Finance Hub D",
      "capacity": 250,
      "registered": 198,
      "status": "Completed",
      "start_time": DateTime.now().subtract(Duration(hours: 3)),
      "end_time": DateTime.now().subtract(Duration(hours: 2)),
      "category": "Finance",
      "format": "Expert Panel",
      "topics": ["Digital Payments", "Blockchain", "RegTech", "Financial Inclusion"],
      "audience_level": "Professional",
      "live_viewers": 0,
      "questions_submitted": 67,
      "engagement_score": 91.8,
      "rating": 4.9
    },
    {
      "id": 5,
      "title": "Future of Remote Work",
      "moderator": "Amanda Foster",
      "panelists": [
        {"name": "Steve Taylor", "title": "HR Director", "company": "RemoteFirst"},
        {"name": "Linda Garcia", "title": "Workplace Consultant", "company": "FutureWork"},
        {"name": "Kevin Lee", "title": "Productivity Expert", "company": "WorkSmart"},
        {"name": "Michelle Brown", "title": "Team Lead", "company": "DistributedTeam"}
      ],
      "room": "Innovation Space E",
      "capacity": 150,
      "registered": 142,
      "status": "Scheduled",
      "start_time": DateTime.now().add(Duration(hours: 2)),
      "end_time": DateTime.now().add(Duration(hours: 3)),
      "category": "Workplace",
      "format": "Interactive Discussion",
      "topics": ["Remote Collaboration", "Work-Life Balance", "Team Management", "Digital Tools"],
      "audience_level": "General",
      "live_viewers": 0,
      "questions_submitted": 12,
      "engagement_score": 0,
      "rating": 4.4
    }
  ];

  String selectedStatus = "All";
  String selectedCategory = "All";
  String selectedFormat = "All";
  String searchQuery = "";

  final List<String> statuses = ["All", "Active", "Scheduled", "Break", "Completed", "Cancelled"];
  final List<String> categories = ["All", "Technology", "Sustainability", "Healthcare", "Finance", "Workplace"];
  final List<String> formats = ["All", "Q&A Session", "Panel Discussion", "Interactive Panel", "Expert Panel", "Interactive Discussion"];

  List<Map<String, dynamic>> get filteredDiscussions {
    return panelDiscussions.where((discussion) {
      final matchesStatus = selectedStatus == "All" || discussion["status"] == selectedStatus;
      final matchesCategory = selectedCategory == "All" || discussion["category"] == selectedCategory;
      final matchesFormat = selectedFormat == "All" || discussion["format"] == selectedFormat;
      final matchesSearch = searchQuery.isEmpty || 
          "${discussion["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${discussion["moderator"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesCategory && matchesFormat && matchesSearch;
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

  Color _getAudienceLevelColor(String level) {
    switch (level) {
      case "General":
        return successColor;
      case "Professional":
        return infoColor;
      case "Expert":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _joinDiscussion(Map<String, dynamic> discussion) async {
    if (discussion["status"] != "Active" && discussion["status"] != "Break") {
      se("This panel discussion is not currently active");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    // Navigate to panel room
    // navigateTo(EcmPanelRoomView(discussion: discussion));
    ss("Joined ${discussion["title"]}");
  }

  void _manageDiscussion(Map<String, dynamic> discussion) {
    // Navigate to discussion management
    // navigateTo(EcmPanelManagementView(discussion: discussion));
  }

  void _viewDiscussionDetails(Map<String, dynamic> discussion) {
    // Navigate to discussion details
    // navigateTo(EcmPanelDetailsView(discussion: discussion));
  }

  void _submitQuestion(Map<String, dynamic> discussion) {
    // Navigate to question submission
    // navigateTo(EcmSubmitQuestionView(discussion: discussion));
  }

  void _createNewPanel() {
    // Navigate to create panel
    // navigateTo(EcmCreatePanelView());
  }

  Widget _buildStatsCard() {
    final totalPanels = panelDiscussions.length;
    final activePanels = panelDiscussions.where((p) => p["status"] == "Active").length;
    final totalViewers = panelDiscussions.fold(0, (sum, p) => sum + (p["live_viewers"] as int));
    final totalQuestions = panelDiscussions.fold(0, (sum, p) => sum + (p["questions_submitted"] as int));

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
            "Panel Discussions Overview",
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
                child: _buildStatItem("Total Panels", totalPanels.toString(), Icons.group, primaryColor),
              ),
              Expanded(
                child: _buildStatItem("Live Now", activePanels.toString(), Icons.live_tv, successColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatItem("Live Viewers", "${(totalViewers / 1000).toStringAsFixed(1)}K", Icons.visibility, infoColor),
              ),
              Expanded(
                child: _buildStatItem("Questions", totalQuestions.toString(), Icons.help, warningColor),
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

  Widget _buildPanelCard(Map<String, dynamic> discussion) {
    final registrationRate = ((discussion["registered"] as int) / (discussion["capacity"] as int)) * 100;
    
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
                        Icons.group,
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
                            "${discussion["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Moderated by ${discussion["moderator"]}",
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
                        color: _getStatusColor("${discussion["status"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${discussion["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor("${discussion["status"]}"),
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
                      "${discussion["room"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${(discussion["start_time"] as DateTime).kkmm} - ${(discussion["end_time"] as DateTime).kkmm}",
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
                        color: _getAudienceLevelColor("${discussion["audience_level"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${discussion["audience_level"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _getAudienceLevelColor("${discussion["audience_level"]}"),
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
                        "${discussion["format"]}",
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
                          "${discussion["rating"]}",
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
                  "Panelists:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Column(
                  children: (discussion["panelists"] as List).take(3).map<Widget>((panelist) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.person,
                              color: primaryColor,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${panelist["name"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${panelist["title"]} at ${panelist["company"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                if ((discussion["panelists"] as List).length > 3) ...[
                  SizedBox(height: spXs),
                  Text(
                    "+${(discussion["panelists"] as List).length - 3} more panelists",
                    style: TextStyle(
                      fontSize: 11,
                      color: infoColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
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
                  children: (discussion["topics"] as List).map<Widget>((topic) {
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
                      "Registration (${discussion["registered"]}/${discussion["capacity"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: registrationRate / 100,
                      backgroundColor: Colors.grey.withAlpha(50),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        registrationRate > 80 ? successColor :
                        registrationRate > 60 ? warningColor : infoColor,
                      ),
                    ),
                  ],
                ),
                if ((discussion["live_viewers"] as int) > 0) ...[
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.live_tv, color: dangerColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Live: ${discussion["live_viewers"]} viewers",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Engagement: ${discussion["engagement_score"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.help, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${discussion["questions_submitted"]} questions submitted",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                      ),
                    ),
                  ],
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
                if (discussion["status"] == "Active" || discussion["status"] == "Break") ...[
                  QButton(
                    label: "Join",
                    icon: Icons.play_arrow,
                    size: bs.sm,
                    onPressed: () => _joinDiscussion(discussion),
                  ),
                  SizedBox(width: spSm),
                ],
                QButton(
                  label: "Ask Question",
                  icon: Icons.help,
                  size: bs.sm,
                  onPressed: () => _submitQuestion(discussion),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Details",
                  icon: Icons.info,
                  size: bs.sm,
                  onPressed: () => _viewDiscussionDetails(discussion),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => _manageDiscussion(discussion),
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
        title: Text("Panel Discussions"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createNewPanel,
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
                    label: "Search panels...",
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
                ),
              ],
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Format",
              items: formats.map((format) => {
                "label": format,
                "value": format,
              }).toList(),
              value: selectedFormat,
              onChanged: (value, label) {
                selectedFormat = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
            if (filteredDiscussions.isEmpty)
              Center(
                child: Column(
                  children: [
                    SizedBox(height: spXl),
                    Icon(
                      Icons.group,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No panel discussions found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or create a new panel",
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
                children: filteredDiscussions.map((discussion) {
                  return _buildPanelCard(discussion);
                }).toList(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewPanel,
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
