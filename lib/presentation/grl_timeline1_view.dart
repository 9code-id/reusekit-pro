import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTimeline1View extends StatefulWidget {
  @override
  State<GrlTimeline1View> createState() => _GrlTimeline1ViewState();
}

class _GrlTimeline1ViewState extends State<GrlTimeline1View> {
  String selectedFilter = "All";
  String selectedPeriod = "This Month";

  List<Map<String, dynamic>> timelineEvents = [
    {
      "id": "TL001",
      "title": "Project Kickoff Meeting",
      "description": "Initial meeting with stakeholders to discuss project requirements and timeline",
      "timestamp": "2024-12-20 09:30:00",
      "type": "Meeting",
      "status": "Completed",
      "priority": "High",
      "participants": ["John Doe", "Jane Smith", "Mike Johnson"],
      "location": "Conference Room A",
      "duration": "2 hours",
      "icon": Icons.rocket_launch,
      "color": successColor,
    },
    {
      "id": "TL002",
      "title": "Design Phase Started",
      "description": "UI/UX team begins wireframing and design mockups for the main application interface",
      "timestamp": "2024-12-21 10:00:00",
      "type": "Development",
      "status": "In Progress",
      "priority": "High",
      "participants": ["Sarah Wilson", "Alex Chen"],
      "location": "Design Studio",
      "duration": "Ongoing",
      "icon": Icons.design_services,
      "color": primaryColor,
    },
    {
      "id": "TL003",
      "title": "Code Review Session",
      "description": "Weekly code review to ensure quality standards and best practices are maintained",
      "timestamp": "2024-12-22 14:00:00",
      "type": "Review",
      "status": "Completed",
      "priority": "Medium",
      "participants": ["Tom Brown", "Lisa Davis", "David Wilson"],
      "location": "Dev Room",
      "duration": "1.5 hours",
      "icon": Icons.code,
      "color": infoColor,
    },
    {
      "id": "TL004",
      "title": "Client Presentation",
      "description": "Presenting initial design concepts and project progress to the client for feedback",
      "timestamp": "2024-12-23 11:00:00",
      "type": "Presentation",
      "status": "Scheduled",
      "priority": "High",
      "participants": ["John Doe", "Sarah Wilson", "Client Team"],
      "location": "Virtual Meeting",
      "duration": "1 hour",
      "icon": Icons.present_to_all,
      "color": warningColor,
    },
    {
      "id": "TL005",
      "title": "Sprint Planning",
      "description": "Planning next development sprint with task assignments and timeline estimation",
      "timestamp": "2024-12-24 09:00:00",
      "type": "Planning",
      "status": "Scheduled",
      "priority": "High",
      "participants": ["All Team Members"],
      "location": "Conference Room B",
      "duration": "2 hours",
      "icon": Icons.schedule,
      "color": primaryColor,
    },
    {
      "id": "TL006",
      "title": "Holiday Break",
      "description": "Team holiday break - office closed for Christmas celebration",
      "timestamp": "2024-12-25 00:00:00",
      "type": "Holiday",
      "status": "Scheduled",
      "priority": "Low",
      "participants": ["All Staff"],
      "location": "N/A",
      "duration": "All Day",
      "icon": Icons.celebration,
      "color": successColor,
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Meeting", "value": "Meeting"},
    {"label": "Development", "value": "Development"},
    {"label": "Review", "value": "Review"},
    {"label": "Presentation", "value": "Presentation"},
    {"label": "Planning", "value": "Planning"},
    {"label": "Holiday", "value": "Holiday"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Timeline"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () => _addTimelineEvent(),
          ),
          IconButton(
            icon: Icon(Icons.timeline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildTimelineHeader(),
            _buildFiltersAndControls(),
            _buildTimelineStats(),
            _buildTimelineView(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Project Timeline",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Track project milestones and events",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${_getFilteredEvents().length} events in timeline",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(180),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.timeline,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersAndControls() {
    return Row(
      children: [
        Expanded(
          child: QDropdownField(
            label: "Event Type",
            items: filterOptions,
            value: selectedFilter,
            onChanged: (value, label) {
              selectedFilter = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QDropdownField(
            label: "Time Period",
            items: periodOptions,
            value: selectedPeriod,
            onChanged: (value, label) {
              selectedPeriod = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineStats() {
    List<Map<String, dynamic>> filteredEvents = _getFilteredEvents();
    int completedEvents = filteredEvents.where((event) => event["status"] == "Completed").length;
    int inProgressEvents = filteredEvents.where((event) => event["status"] == "In Progress").length;
    int scheduledEvents = filteredEvents.where((event) => event["status"] == "Scheduled").length;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 24,
                ),
                Text(
                  "$completedEvents",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Completed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
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
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.hourglass_empty,
                  color: warningColor,
                  size: 24,
                ),
                Text(
                  "$inProgressEvents",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "In Progress",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
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
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.schedule,
                  color: infoColor,
                  size: 24,
                ),
                Text(
                  "$scheduledEvents",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Scheduled",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineView() {
    List<Map<String, dynamic>> filteredEvents = _getFilteredEvents();
    
    // Sort events by timestamp (newest first)
    filteredEvents.sort((a, b) => 
      DateTime.parse(b["timestamp"] as String).compareTo(DateTime.parse(a["timestamp"] as String)));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Timeline Events",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        if (filteredEvents.isEmpty)
          Container(
            padding: EdgeInsets.all(spXl),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.timeline,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No events found",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Try adjusting your filters",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                ...filteredEvents.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> event = entry.value;
                  bool isLast = index == filteredEvents.length - 1;
                  
                  return _buildTimelineItem(event, isLast);
                }).toList(),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTimelineItem(Map<String, dynamic> event, bool isLast) {
    DateTime eventDate = DateTime.parse(event["timestamp"] as String);
    String formattedDate = eventDate.dMMMy;
    String formattedTime = "${eventDate.hour.toString().padLeft(2, '0')}:${eventDate.minute.toString().padLeft(2, '0')}";

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline connector
          Container(
            width: 60,
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: (event["color"] as Color).withAlpha(30),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: event["color"] as Color,
                      width: 3,
                    ),
                  ),
                  child: Icon(
                    event["icon"] as IconData,
                    color: event["color"] as Color,
                    size: 20,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 60,
                    color: disabledColor,
                  ),
              ],
            ),
          ),
          // Event content
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: spMd,
                right: spMd,
                bottom: isLast ? spMd : spLg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${event["title"]}",
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
                          color: _getStatusColor(event["status"] as String).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${event["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: _getStatusColor(event["status"] as String),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${event["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "$formattedDate at $formattedTime",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: (event["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${event["type"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: event["color"] as Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (event["location"] != "N/A")
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${event["location"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${event["duration"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  if ((event["participants"] as List).isNotEmpty)
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
                            "${(event["participants"] as List).join(", ")}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getPriorityColor(event["priority"] as String).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${event["priority"]} Priority",
                          style: TextStyle(
                            fontSize: 12,
                            color: _getPriorityColor(event["priority"] as String),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => _editTimelineEvent(event),
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.edit,
                            size: 16,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      GestureDetector(
                        onTap: () => _deleteTimelineEvent(event),
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.delete,
                            size: 16,
                            color: dangerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredEvents() {
    return timelineEvents.where((event) {
      return selectedFilter == "All" || event["type"] == selectedFilter;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Scheduled":
        return infoColor;
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

  void _addTimelineEvent() {
    // Navigate to add timeline event form
    //navigateTo('')
  }

  void _editTimelineEvent(Map<String, dynamic> event) {
    // Navigate to edit timeline event form
    //navigateTo('')
  }

  void _deleteTimelineEvent(Map<String, dynamic> event) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this timeline event?");
    if (isConfirmed) {
      timelineEvents.removeWhere((element) => element["id"] == event["id"]);
      setState(() {});
      ss("Timeline event deleted successfully");
    }
  }
}
