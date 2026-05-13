import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSchedule5View extends StatefulWidget {
  @override
  State<GrlSchedule5View> createState() => _GrlSchedule5ViewState();
}

class _GrlSchedule5ViewState extends State<GrlSchedule5View> {
  String selectedDate = DateTime.now().toString();
  String selectedPriority = "All";
  String selectedCategory = "All";

  List<Map<String, dynamic>> scheduleItems = [
    {
      "id": "SCH001",
      "title": "Team Meeting",
      "description": "Weekly team sync and project updates",
      "startTime": "09:00",
      "endTime": "10:30",
      "category": "Meeting",
      "priority": "High",
      "location": "Conference Room A",
      "attendees": 8,
      "color": primaryColor,
      "completed": false,
      "reminder": true,
    },
    {
      "id": "SCH002",
      "title": "Client Presentation",
      "description": "Q4 project results presentation",
      "startTime": "14:00",
      "endTime": "15:30",
      "category": "Presentation",
      "priority": "High",
      "location": "Zoom Meeting",
      "attendees": 12,
      "color": dangerColor,
      "completed": false,
      "reminder": true,
    },
    {
      "id": "SCH003",
      "title": "Code Review",
      "description": "Review pull requests and discuss improvements",
      "startTime": "11:00",
      "endTime": "12:00",
      "category": "Development",
      "priority": "Medium",
      "location": "Dev Room",
      "attendees": 4,
      "color": warningColor,
      "completed": true,
      "reminder": false,
    },
    {
      "id": "SCH004",
      "title": "Lunch Break",
      "description": "Team lunch at local restaurant",
      "startTime": "12:30",
      "endTime": "13:30",
      "category": "Break",
      "priority": "Low",
      "location": "Restaurant",
      "attendees": 6,
      "color": successColor,
      "completed": false,
      "reminder": true,
    },
    {
      "id": "SCH005",
      "title": "Sprint Planning",
      "description": "Plan next sprint tasks and assignments",
      "startTime": "16:00",
      "endTime": "17:00",
      "category": "Planning",
      "priority": "High",
      "location": "Conference Room B",
      "attendees": 8,
      "color": infoColor,
      "completed": false,
      "reminder": true,
    }
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Meeting", "value": "Meeting"},
    {"label": "Presentation", "value": "Presentation"},
    {"label": "Development", "value": "Development"},
    {"label": "Planning", "value": "Planning"},
    {"label": "Break", "value": "Break"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddEventModal(),
          ),
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildDateHeader(),
            _buildFilters(),
            _buildStatsOverview(),
            _buildScheduleList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateHeader() {
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
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's Schedule",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${DateTime.now().dMMMy}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(200),
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
                  Icons.today,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Select Date",
                  value: DateTime.parse(selectedDate),
                  onChanged: (value) {
                    selectedDate = value.toString();
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          child: QDropdownField(
            label: "Priority",
            items: priorityOptions,
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
            label: "Category",
            items: categoryOptions,
            value: selectedCategory,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatsOverview() {
    int totalEvents = scheduleItems.length;
    int completedEvents = scheduleItems.where((item) => item["completed"] as bool).length;
    int pendingEvents = totalEvents - completedEvents;
    int upcomingEvents = scheduleItems.where((item) => !(item["completed"] as bool)).length;

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
                  Icons.event,
                  color: primaryColor,
                  size: 24,
                ),
                Text(
                  "$totalEvents",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Events",
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
                  Icons.schedule,
                  color: warningColor,
                  size: 24,
                ),
                Text(
                  "$upcomingEvents",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Upcoming",
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

  Widget _buildScheduleList() {
    List<Map<String, dynamic>> filteredItems = scheduleItems.where((item) {
      bool priorityMatch = selectedPriority == "All" || item["priority"] == selectedPriority;
      bool categoryMatch = selectedCategory == "All" || item["category"] == selectedCategory;
      return priorityMatch && categoryMatch;
    }).toList();

    // Sort by start time
    filteredItems.sort((a, b) => a["startTime"].compareTo(b["startTime"]));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Schedule Items",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              "${filteredItems.length} events",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        ...filteredItems.map((item) => _buildScheduleCard(item)).toList(),
      ],
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> item) {
    bool isCompleted = item["completed"] as bool;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: item["color"] as Color,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: isCompleted ? disabledBoldColor : primaryColor,
                              decoration: isCompleted ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${item["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        item["completed"] = !isCompleted;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: isCompleted ? successColor : disabledColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isCompleted ? Icons.check : Icons.circle_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
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
                      "${item["startTime"]} - ${item["endTime"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(item["priority"] as String).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${item["priority"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: _getPriorityColor(item["priority"] as String),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
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
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.people,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${item["attendees"]} people",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                if (item["reminder"] as bool)
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_active,
                        size: 16,
                        color: warningColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Reminder set",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: (item["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${item["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: item["color"] as Color,
                            fontWeight: FontWeight.w500,
                          ),
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
              color: disabledColor.withAlpha(50),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Edit Event",
                    size: bs.sm,
                    onPressed: () => _showEditEventModal(item),
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.delete,
                  size: bs.sm,
                  onPressed: () => _deleteEvent(item),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  void _showAddEventModal() {
    // Navigate to add event form
    //navigateTo('')
  }

  void _showEditEventModal(Map<String, dynamic> item) {
    // Navigate to edit event form
    //navigateTo('')
  }

  void _deleteEvent(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this event?");
    if (isConfirmed) {
      scheduleItems.removeWhere((element) => element["id"] == item["id"]);
      setState(() {});
      ss("Event deleted successfully");
    }
  }
}
