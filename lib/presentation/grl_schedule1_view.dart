import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSchedule1View extends StatefulWidget {
  @override
  State<GrlSchedule1View> createState() => _GrlSchedule1ViewState();
}

class _GrlSchedule1ViewState extends State<GrlSchedule1View> {
  int selectedWeekDay = DateTime.now().weekday - 1;
  DateTime selectedDate = DateTime.now();
  String selectedView = "Day";
  
  List<Map<String, dynamic>> scheduleItems = [
    {
      "id": "1",
      "title": "Team Meeting",
      "description": "Weekly team sync and project updates",
      "startTime": "09:00",
      "endTime": "10:00",
      "date": DateTime.now().toString().split(' ')[0],
      "type": "Meeting",
      "priority": "High",
      "location": "Conference Room A",
      "attendees": ["John", "Sarah", "Mike"],
      "color": primaryColor,
      "status": "Confirmed"
    },
    {
      "id": "2",
      "title": "Client Presentation",
      "description": "Product demo for potential client",
      "startTime": "14:00",
      "endTime": "15:30",
      "date": DateTime.now().toString().split(' ')[0],
      "type": "Presentation",
      "priority": "High",
      "location": "Meeting Room B",
      "attendees": ["Client Team"],
      "color": dangerColor,
      "status": "Confirmed"
    },
    {
      "id": "3",
      "title": "Code Review",
      "description": "Review pull requests and code quality",
      "startTime": "16:00",
      "endTime": "17:00",
      "date": DateTime.now().toString().split(' ')[0],
      "type": "Development",
      "priority": "Medium",
      "location": "Dev Room",
      "attendees": ["Dev Team"],
      "color": infoColor,
      "status": "Pending"
    },
    {
      "id": "4",
      "title": "Marketing Strategy",
      "description": "Plan Q2 marketing campaigns",
      "startTime": "10:00",
      "endTime": "11:30",
      "date": DateTime.now().add(Duration(days: 1)).toString().split(' ')[0],
      "type": "Planning",
      "priority": "Medium",
      "location": "Marketing Office",
      "attendees": ["Marketing Team"],
      "color": warningColor,
      "status": "Confirmed"
    },
    {
      "id": "5",
      "title": "Training Session",
      "description": "New employee orientation",
      "startTime": "13:00",
      "endTime": "16:00",
      "date": DateTime.now().add(Duration(days: 2)).toString().split(' ')[0],
      "type": "Training",
      "priority": "Low",
      "location": "Training Center",
      "attendees": ["HR Team", "New Hires"],
      "color": successColor,
      "status": "Confirmed"
    }
  ];

  List<String> weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  List<String> viewOptions = ["Day", "Week", "Month"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_view_day),
            onPressed: () => _changeView("Day"),
          ),
          IconButton(
            icon: Icon(Icons.view_week),
            onPressed: () => _changeView("Week"),
          ),
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () => _changeView("Month"),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          _buildDateSelector(),
          Expanded(
            child: selectedView == "Day" 
                ? _buildDayView()
                : selectedView == "Week"
                    ? _buildWeekView()
                    : _buildMonthView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewEvent,
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Row(
        children: [
          Text(
            selectedDate.dMMMy,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: viewOptions.map((view) {
                bool isSelected = selectedView == view;
                return GestureDetector(
                  onTap: () => _changeView(view),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      view,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(vertical: spSm),
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 14, // Show 14 days
        itemBuilder: (context, index) {
          DateTime date = DateTime.now().add(Duration(days: index - 7));
          bool isSelected = date.day == selectedDate.day && 
                           date.month == selectedDate.month;
          bool isToday = date.day == DateTime.now().day && 
                        date.month == DateTime.now().month;
          
          return GestureDetector(
            onTap: () {
              selectedDate = date;
              setState(() {});
            },
            child: Container(
              width: 60,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected 
                    ? primaryColor 
                    : isToday
                        ? primaryColor.withAlpha(20)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weekDays[date.weekday - 1],
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected 
                          ? Colors.white 
                          : isToday 
                              ? primaryColor
                              : disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${date.day}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected 
                          ? Colors.white 
                          : isToday 
                              ? primaryColor
                              : primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDayView() {
    List<Map<String, dynamic>> dayEvents = scheduleItems
        .where((item) => item["date"] == selectedDate.toString().split(' ')[0])
        .toList();
    
    dayEvents.sort((a, b) => a["startTime"].compareTo(b["startTime"]));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Today's Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${dayEvents.length} events",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          if (dayEvents.isEmpty) ...[
            Center(
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Icon(
                    Icons.event_busy,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No events scheduled",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Tap + to add a new event",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ...dayEvents.map((event) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                child: _buildEventCard(event),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildWeekView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "This Week",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...List.generate(7, (index) {
            DateTime date = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1 - index));
            List<Map<String, dynamic>> dayEvents = scheduleItems
                .where((item) => item["date"] == date.toString().split(' ')[0])
                .toList();
            
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spSm),
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
                        "${weekDays[index]} ${date.day}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${dayEvents.length} events",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (dayEvents.isNotEmpty) ...[
                    SizedBox(height: spSm),
                    ...dayEvents.take(3).map((event) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (event["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border(
                            left: BorderSide(
                              color: event["color"],
                              width: 3,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "${event["startTime"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: event["color"],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${event["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    if (dayEvents.length > 3)
                      Text(
                        "+${dayEvents.length - 3} more",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                  ] else ...[
                    SizedBox(height: spSm),
                    Text(
                      "No events",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMonthView() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Text(
            "Calendar View",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          Expanded(
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 64,
                      color: primaryColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Month View",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Calendar widget coming soon",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    Color eventColor = event["color"];
    IconData typeIcon = _getTypeIcon(event["type"]);
    Color priorityColor = _getPriorityColor(event["priority"]);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: eventColor,
            width: 4,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: eventColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    typeIcon,
                    size: 16,
                    color: eventColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${event["title"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: priorityColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${event["priority"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            Text(
              "${event["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "${event["startTime"]} - ${event["endTime"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spMd),
                Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${event["location"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            if ((event["attendees"] as List).isNotEmpty) ...[
              Row(
                children: [
                  Icon(Icons.people, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${(event["attendees"] as List).join(", ")}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
            ],
            
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: event["status"] == "Confirmed" ? successColor : warningColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${event["status"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.edit,
                  size: bs.sm,
                  color: disabledBoldColor,
                  onPressed: () {
                    _editEvent(event);
                  },
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.delete,
                  size: bs.sm,
                  color: dangerColor,
                  onPressed: () {
                    _deleteEvent(event);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Meeting":
        return Icons.meeting_room;
      case "Presentation":
        return Icons.present_to_all;
      case "Development":
        return Icons.code;
      case "Planning":
        return Icons.event_note;
      case "Training":
        return Icons.school;
      default:
        return Icons.event;
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
        return disabledColor;
    }
  }

  void _changeView(String view) {
    selectedView = view;
    setState(() {});
  }

  void _addNewEvent() {
    si("Add new event feature coming soon");
  }

  void _editEvent(Map<String, dynamic> event) {
    si("Edit event: ${event["title"]}");
  }

  void _deleteEvent(Map<String, dynamic> event) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this event?");
    if (isConfirmed) {
      scheduleItems.removeWhere((item) => item["id"] == event["id"]);
      setState(() {});
      ss("Event deleted successfully");
    }
  }
}
