import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTimeline3View extends StatefulWidget {
  const GrlTimeline3View({Key? key}) : super(key: key);

  @override
  State<GrlTimeline3View> createState() => _GrlTimeline3ViewState();
}

class _GrlTimeline3ViewState extends State<GrlTimeline3View> {
  String selectedFilter = "all";
  List<Map<String, dynamic>> timelineItems = [
    {
      "id": 1,
      "type": "meeting",
      "title": "Team Standup Meeting",
      "description": "Daily sync with development team to discuss progress and blockers",
      "time": "09:00 AM",
      "date": "2024-01-15",
      "status": "completed",
      "participants": ["John Doe", "Jane Smith", "Mike Johnson"],
      "duration": "30 minutes",
      "category": "work"
    },
    {
      "id": 2,
      "type": "task",
      "title": "Code Review - User Authentication",
      "description": "Review pull request for new authentication system implementation",
      "time": "10:30 AM",
      "date": "2024-01-15",
      "status": "in_progress",
      "assignee": "Sarah Wilson",
      "priority": "high",
      "category": "development"
    },
    {
      "id": 3,
      "type": "appointment",
      "title": "Client Presentation",
      "description": "Present quarterly results and upcoming project roadmap",
      "time": "02:00 PM",
      "date": "2024-01-15",
      "status": "upcoming",
      "client": "TechCorp Solutions",
      "location": "Conference Room A",
      "category": "business"
    },
    {
      "id": 4,
      "type": "event",
      "title": "Product Launch",
      "description": "Official launch event for our new mobile application",
      "time": "06:00 PM",
      "date": "2024-01-15",
      "status": "upcoming",
      "attendees": 150,
      "venue": "Grand Ballroom",
      "category": "marketing"
    },
    {
      "id": 5,
      "type": "milestone",
      "title": "Project Alpha Completion",
      "description": "Successfully delivered all features for Project Alpha ahead of schedule",
      "time": "11:45 AM",
      "date": "2024-01-14",
      "status": "completed",
      "team": "Development Team",
      "impact": "high",
      "category": "achievement"
    }
  ];

  List<Map<String, dynamic>> get filteredItems {
    if (selectedFilter == "all") return timelineItems;
    return timelineItems.where((item) => item["category"] == selectedFilter).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return warningColor;
      case "upcoming":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "meeting":
        return Icons.groups;
      case "task":
        return Icons.task_alt;
      case "appointment":
        return Icons.calendar_today;
      case "event":
        return Icons.event;
      case "milestone":
        return Icons.flag;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Timeline"),
        actions: [
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Categories
            QCategoryPicker(
              label: "Filter by Category",
              items: const [
                {"label": "All", "value": "all"},
                {"label": "Work", "value": "work"},
                {"label": "Development", "value": "development"},
                {"label": "Business", "value": "business"},
                {"label": "Marketing", "value": "marketing"},
                {"label": "Achievement", "value": "achievement"},
              ],
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),

            // Timeline Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.timeline,
                    color: primaryColor,
                    size: 28,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today's Activity",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${filteredItems.length} activities scheduled",
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
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "Live",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Timeline Items
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                final isLast = index == filteredItems.length - 1;
                
                return Container(
                  margin: EdgeInsets.only(bottom: isLast ? 0 : spMd),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timeline Line
                      Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _getStatusColor("${item["status"]}"),
                              borderRadius: BorderRadius.circular(radiusLg),
                              boxShadow: [shadowSm],
                            ),
                            child: Icon(
                              _getTypeIcon("${item["type"]}"),
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          if (!isLast)
                            Container(
                              width: 2,
                              height: 60,
                              color: disabledOutlineBorderColor,
                              margin: EdgeInsets.symmetric(vertical: spXs),
                            ),
                        ],
                      ),
                      
                      SizedBox(width: spMd),
                      
                      // Timeline Content
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                            border: Border.all(
                              color: _getStatusColor("${item["status"]}").withAlpha(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${item["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor("${item["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${item["status"]}".replaceAll("_", " ").toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor("${item["status"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spSm),
                              
                              // Description
                              Text(
                                "${item["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              
                              SizedBox(height: spSm),
                              
                              // Time and Details
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${item["time"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  if (item["type"] == "meeting" && item["duration"] != null)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${item["duration"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: infoColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              
                              // Additional Info
                              if (item["participants"] != null) ...[
                                SizedBox(height: spSm),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.people,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "${(item["participants"] as List).length} participants",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              
                              if (item["location"] != null) ...[
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "${item["location"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTimelineDialog();
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showFilterDialog() {
    // Filter dialog implementation
  }

  void _showAddTimelineDialog() {
    // Add timeline item dialog implementation
  }
}
