import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaInterviewRoundsView extends StatefulWidget {
  const RhaInterviewRoundsView({super.key});

  @override
  State<RhaInterviewRoundsView> createState() => _RhaInterviewRoundsViewState();
}

class _RhaInterviewRoundsViewState extends State<RhaInterviewRoundsView> {
  String selectedStatus = "all";
  String searchQuery = "";
  int currentTab = 0;

  List<Map<String, dynamic>> interviewRounds = [
    {
      "id": "R001",
      "candidateName": "Sarah Wilson",
      "candidateImage": "https://picsum.photos/80/80?random=1&keyword=woman",
      "position": "Senior Software Engineer",
      "round": "Technical Round 1",
      "roundNumber": 1,
      "status": "scheduled",
      "date": "2024-06-20",
      "time": "10:00 AM",
      "interviewer": "John Smith",
      "interviewerTitle": "Tech Lead",
      "duration": 60,
      "type": "video",
      "location": "Zoom Meeting",
      "score": null,
      "feedback": "",
      "notes": "Focus on JavaScript, React, and system design"
    },
    {
      "id": "R002", 
      "candidateName": "Michael Chen",
      "candidateImage": "https://picsum.photos/80/80?random=2&keyword=man",
      "position": "Product Manager",
      "round": "Panel Interview",
      "roundNumber": 3,
      "status": "completed",
      "date": "2024-06-19",
      "time": "2:00 PM",
      "interviewer": "Lisa Garcia",
      "interviewerTitle": "VP Product",
      "duration": 90,
      "type": "in-person",
      "location": "Conference Room A",
      "score": 85,
      "feedback": "Strong strategic thinking and communication skills",
      "notes": "Excellent product vision and stakeholder management experience"
    },
    {
      "id": "R003",
      "candidateName": "Emily Johnson",
      "candidateImage": "https://picsum.photos/80/80?random=3&keyword=woman",
      "position": "UX Designer",
      "round": "Design Challenge",
      "roundNumber": 2,
      "status": "in-progress",
      "date": "2024-06-20",
      "time": "1:30 PM",
      "interviewer": "David Park",
      "interviewerTitle": "Design Director",
      "duration": 120,
      "type": "hybrid",
      "location": "Design Studio + Screen Share",
      "score": null,
      "feedback": "",
      "notes": "Portfolio review and live design exercise"
    },
    {
      "id": "R004",
      "candidateName": "Alex Rodriguez",
      "candidateImage": "https://picsum.photos/80/80?random=4&keyword=person",
      "position": "Data Scientist",
      "round": "HR Screening",
      "roundNumber": 1,
      "status": "scheduled",
      "date": "2024-06-21",
      "time": "9:00 AM",
      "interviewer": "Rachel Kim",
      "interviewerTitle": "HR Manager",
      "duration": 30,
      "type": "phone",
      "location": "Phone Call",
      "score": null,
      "feedback": "",
      "notes": "Initial screening and culture fit assessment"
    },
    {
      "id": "R005",
      "candidateName": "James Thompson",
      "candidateImage": "https://picsum.photos/80/80?random=5&keyword=man",
      "position": "DevOps Engineer",
      "round": "Technical Round 2",
      "roundNumber": 2,
      "status": "cancelled",
      "date": "2024-06-18",
      "time": "3:00 PM",
      "interviewer": "Tom Wilson",
      "interviewerTitle": "DevOps Lead",
      "duration": 45,
      "type": "video",
      "location": "Teams Meeting",
      "score": null,
      "feedback": "",
      "notes": "Candidate unavailable - rescheduling needed"
    }
  ];

  List<Map<String, dynamic>> get filteredRounds {
    return interviewRounds.where((round) {
      bool matchesStatus = selectedStatus == "all" || round["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty ||
          (round["candidateName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (round["position"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesStatus && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "scheduled":
        return infoColor;
      case "in-progress":
        return warningColor;
      case "completed":
        return successColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "scheduled":
        return "Scheduled";
      case "in-progress":
        return "In Progress";
      case "completed":
        return "Completed";
      case "cancelled":
        return "Cancelled";
      default:
        return "Unknown";
    }
  }

  Widget _buildRoundCard(Map<String, dynamic> round) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  image: DecorationImage(
                    image: NetworkImage("${round["candidateImage"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${round["candidateName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${round["position"]}",
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
                  color: _getStatusColor(round["status"]).withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _getStatusLabel(round["status"]),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(round["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.event,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Round ${round["roundNumber"]}: ${round["round"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${round["date"]} at ${round["time"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.timer,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${round["duration"]} min",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${round["interviewer"]} - ${round["interviewerTitle"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      round["type"] == "video" ? Icons.videocam :
                      round["type"] == "phone" ? Icons.phone :
                      round["type"] == "in-person" ? Icons.location_on :
                      Icons.merge_type,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${round["location"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (round["score"] != null) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: 18,
                  color: warningColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Score: ${round["score"]}/100",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ],
          if (round["feedback"].isNotEmpty) ...[
            SizedBox(height: spSm),
            Text(
              "Feedback:",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "${round["feedback"]}",
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
              ),
            ),
          ],
          SizedBox(height: spSm),
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
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
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
  }

  Widget _buildStatsCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      title,
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interview Rounds"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.calendar_month),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
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
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatsCard("Total Rounds", "24", primaryColor, Icons.event),
                _buildStatsCard("Scheduled", "8", infoColor, Icons.schedule),
                _buildStatsCard("Completed", "12", successColor, Icons.check_circle),
                _buildStatsCard("In Progress", "3", warningColor, Icons.play_circle),
              ],
            ),
            SizedBox(height: spLg),
            
            // Search and Filter
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search candidates or positions",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            // Status Filter
            QCategoryPicker(
              items: [
                {"label": "All Rounds", "value": "all"},
                {"label": "Scheduled", "value": "scheduled"},
                {"label": "In Progress", "value": "in-progress"},
                {"label": "Completed", "value": "completed"},
                {"label": "Cancelled", "value": "cancelled"},
              ],
              value: selectedStatus,
              onChanged: (index, label, value, item) {
                selectedStatus = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),
            
            // Interview Rounds List
            Text(
              "Interview Rounds (${filteredRounds.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ...filteredRounds.map((round) => _buildRoundCard(round)).toList(),
            
            if (filteredRounds.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No interview rounds found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
