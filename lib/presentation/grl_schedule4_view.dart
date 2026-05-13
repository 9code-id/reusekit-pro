import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSchedule4View extends StatefulWidget {
  @override
  State<GrlSchedule4View> createState() => _GrlSchedule4ViewState();
}

class _GrlSchedule4ViewState extends State<GrlSchedule4View> {
  String selectedView = "week";
  DateTime selectedDate = DateTime.now();
  String selectedFilter = "all";
  
  List<Map<String, dynamic>> scheduleItems = [
    {
      "id": "SCH001",
      "title": "Daily Team Standup",
      "description": "Quick sync with development team",
      "startDate": "2024-01-22",
      "startTime": "09:00",
      "endTime": "09:30",
      "category": "meeting",
      "priority": "medium",
      "location": "Conference Room A",
      "attendees": ["John Doe", "Jane Smith", "Mike Johnson"],
      "status": "confirmed",
      "isRecurring": true,
      "recurringType": "daily",
      "color": Colors.blue,
    },
    {
      "id": "SCH002",
      "title": "Project Presentation",
      "description": "Present Q1 project results to stakeholders",
      "startDate": "2024-01-22",
      "startTime": "14:00",
      "endTime": "15:30",
      "category": "presentation",
      "priority": "high",
      "location": "Main Auditorium",
      "attendees": ["CEO", "CTO", "Project Team"],
      "status": "confirmed",
      "isRecurring": false,
      "recurringType": "",
      "color": Colors.red,
    },
    {
      "id": "SCH003",
      "title": "Client Call - ABC Corp",
      "description": "Quarterly business review with ABC Corp",
      "startDate": "2024-01-22",
      "startTime": "16:00",
      "endTime": "17:00",
      "category": "call",
      "priority": "high",
      "location": "Virtual - Zoom",
      "attendees": ["Account Manager", "Client Team"],
      "status": "confirmed",
      "isRecurring": false,
      "recurringType": "",
      "color": Colors.green,
    },
    {
      "id": "SCH004",
      "title": "Design Review Session",
      "description": "Review new UI designs for mobile app",
      "startDate": "2024-01-23",
      "startTime": "10:00",
      "endTime": "11:30",
      "category": "review",
      "priority": "medium",
      "location": "Design Studio",
      "attendees": ["Design Team", "Product Manager"],
      "status": "pending",
      "isRecurring": false,
      "recurringType": "",
      "color": Colors.purple,
    },
    {
      "id": "SCH005",
      "title": "Marketing Campaign Planning",
      "description": "Plan marketing strategy for new product launch",
      "startDate": "2024-01-23",
      "startTime": "13:00",
      "endTime": "14:30",
      "category": "planning",
      "priority": "medium",
      "location": "Marketing Office",
      "attendees": ["Marketing Team", "Brand Manager"],
      "status": "confirmed",
      "isRecurring": false,
      "recurringType": "",
      "color": Colors.orange,
    },
    {
      "id": "SCH006",
      "title": "Weekly Team Lunch",
      "description": "Team building lunch at local restaurant",
      "startDate": "2024-01-24",
      "startTime": "12:00",
      "endTime": "13:30",
      "category": "social",
      "priority": "low",
      "location": "The Bistro Restaurant",
      "attendees": ["Entire Team"],
      "status": "confirmed",
      "isRecurring": true,
      "recurringType": "weekly",
      "color": Colors.teal,
    },
    {
      "id": "SCH007",
      "title": "Budget Review Meeting",
      "description": "Review Q1 budget allocation and expenses",
      "startDate": "2024-01-24",
      "startTime": "15:00",
      "endTime": "16:00",
      "category": "finance",
      "priority": "high",
      "location": "Finance Department",
      "attendees": ["CFO", "Department Heads"],
      "status": "confirmed",
      "isRecurring": false,
      "recurringType": "",
      "color": Colors.indigo,
    },
    {
      "id": "SCH008",
      "title": "Training Session - New Software",
      "description": "Training on new project management software",
      "startDate": "2024-01-25",
      "startTime": "09:30",
      "endTime": "11:00",
      "category": "training",
      "priority": "medium",
      "location": "Training Room B",
      "attendees": ["All Staff"],
      "status": "confirmed",
      "isRecurring": false,
      "recurringType": "",
      "color": Colors.brown,
    },
  ];

  List<String> viewOptions = ["day", "week", "month"];
  List<String> filterOptions = ["all", "meeting", "call", "presentation", "review", "planning", "social", "finance", "training"];

  List<Map<String, dynamic>> get filteredScheduleItems {
    List<Map<String, dynamic>> filtered = scheduleItems.where((item) {
      bool matchesFilter = selectedFilter == "all" || item["category"] == selectedFilter;
      
      DateTime itemDate = DateTime.parse(item["startDate"]);
      bool matchesDateRange = false;
      
      switch (selectedView) {
        case "day":
          matchesDateRange = isSameDay(itemDate, selectedDate);
          break;
        case "week":
          DateTime weekStart = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
          DateTime weekEnd = weekStart.add(Duration(days: 6));
          matchesDateRange = itemDate.isAfter(weekStart.subtract(Duration(days: 1))) && 
                           itemDate.isBefore(weekEnd.add(Duration(days: 1)));
          break;
        case "month":
          matchesDateRange = itemDate.month == selectedDate.month && itemDate.year == selectedDate.year;
          break;
      }
      
      return matchesFilter && matchesDateRange;
    }).toList();
    
    filtered.sort((a, b) {
      int dateCompare = DateTime.parse(a["startDate"]).compareTo(DateTime.parse(b["startDate"]));
      if (dateCompare != 0) return dateCompare;
      return a["startTime"].compareTo(b["startTime"]);
    });
    
    return filtered;
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  String _getPriorityLabel(String priority) {
    switch (priority) {
      case "high":
        return "High Priority";
      case "medium":
        return "Medium Priority";
      case "low":
        return "Low Priority";
      default:
        return "Normal";
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "meeting":
        return Icons.groups;
      case "call":
        return Icons.phone;
      case "presentation":
        return Icons.present_to_all;
      case "review":
        return Icons.rate_review;
      case "planning":
        return Icons.event_note;
      case "social":
        return Icons.celebration;
      case "finance":
        return Icons.account_balance;
      case "training":
        return Icons.school;
      default:
        return Icons.event;
    }
  }

  void _navigateDate(int direction) {
    setState(() {
      switch (selectedView) {
        case "day":
          selectedDate = selectedDate.add(Duration(days: direction));
          break;
        case "week":
          selectedDate = selectedDate.add(Duration(days: direction * 7));
          break;
        case "month":
          selectedDate = DateTime(selectedDate.year, selectedDate.month + direction, selectedDate.day);
          break;
      }
    });
  }

  String _getDateRangeText() {
    switch (selectedView) {
      case "day":
        return selectedDate.dMMMy;
      case "week":
        DateTime weekStart = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
        DateTime weekEnd = weekStart.add(Duration(days: 6));
        return "${weekStart.dMMMy} - ${weekEnd.dMMMy}";
      case "month":
        return "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}";
      default:
        return "";
    }
  }

  void _showScheduleDetails(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item["title"]),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow("Description", item["description"]),
              _buildDetailRow("Date", DateTime.parse(item["startDate"]).dMMMy),
              _buildDetailRow("Time", "${item["startTime"]} - ${item["endTime"]}"),
              _buildDetailRow("Location", item["location"]),
              _buildDetailRow("Priority", _getPriorityLabel(item["priority"])),
              _buildDetailRow("Status", item["status"]),
              if (item["isRecurring"])
                _buildDetailRow("Recurring", item["recurringType"]),
              _buildDetailRow("Attendees", (item["attendees"] as List).join(", ")),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Edit",
            size: bs.sm,
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to edit
            },
          ),
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: disabledBoldColor,
              ),
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
        title: Text("Schedule Manager"),
        actions: [
          IconButton(
            icon: Icon(Icons.today),
            onPressed: () {
              setState(() {
                selectedDate = DateTime.now();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create schedule
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Header Controls
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // View Selector
                  QCategoryPicker(
                    items: [
                      {"label": "Day", "value": "day"},
                      {"label": "Week", "value": "week"},
                      {"label": "Month", "value": "month"},
                    ],
                    value: selectedView,
                    onChanged: (index, label, value, item) {
                      selectedView = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Date Navigation
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _navigateDate(-1),
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(Icons.chevron_left, color: primaryColor),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _getDateRangeText(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _navigateDate(1),
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(Icons.chevron_right, color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Filter
                  QDropdownField(
                    label: "Filter by Category",
                    items: filterOptions.map((option) => {
                      "label": option == "all" ? "All Categories" : option.substring(0, 1).toUpperCase() + option.substring(1),
                      "value": option,
                    }).toList(),
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Summary Stats
            Container(
              padding: EdgeInsets.all(spSm),
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
                      children: [
                        Icon(Icons.event, color: Colors.white, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${filteredScheduleItems.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Total Events",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withAlpha(50),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Icon(Icons.priority_high, color: Colors.white, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${filteredScheduleItems.where((item) => item["priority"] == "high").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "High Priority",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withAlpha(50),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Icon(Icons.repeat, color: Colors.white, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${filteredScheduleItems.where((item) => item["isRecurring"]).length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Recurring",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Schedule Items
            if (filteredScheduleItems.isNotEmpty) ...[
              // Group by date for better organization
              ...filteredScheduleItems.fold<Map<String, List<Map<String, dynamic>>>>({}, (groups, item) {
                String date = item["startDate"];
                groups[date] = (groups[date] ?? [])..add(item);
                return groups;
              }).entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Header
                    Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, color: primaryColor, size: 20),
                          SizedBox(width: spSm),
                          Text(
                            DateTime.parse(entry.key).dMMMy,
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${entry.value.length} event${entry.value.length > 1 ? 's' : ''}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Events for this date
                    ...entry.value.map((item) {
                      Color priorityColor = _getPriorityColor(item["priority"]);
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: item["color"],
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            // Item Header
                            Container(
                              padding: EdgeInsets.all(spSm),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: (item["color"] as Color).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      _getCategoryIcon(item["category"]),
                                      color: item["color"],
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                item["title"],
                                                style: TextStyle(
                                                  fontSize: fsH6,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                            if (item["isRecurring"])
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: infoColor.withAlpha(20),
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.repeat, color: infoColor, size: 12),
                                                    SizedBox(width: 2),
                                                    Text(
                                                      item["recurringType"],
                                                      style: TextStyle(
                                                        color: infoColor,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          item["description"],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: priorityColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          _getPriorityLabel(item["priority"]),
                                          style: TextStyle(
                                            color: priorityColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${item["startTime"]} - ${item["endTime"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            // Item Details
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      item["location"],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.people, size: 16, color: disabledBoldColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(item["attendees"] as List).length} attendee${(item["attendees"] as List).length > 1 ? 's' : ''}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Action Buttons
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(20),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(radiusLg),
                                  bottomRight: Radius.circular(radiusLg),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "View Details",
                                      size: bs.sm,
                                      onPressed: () => _showScheduleDetails(item),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: QButton(
                                      label: "Edit",
                                      size: bs.sm,
                                      onPressed: () {
                                        // Navigate to edit
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  PopupMenuButton(
                                    icon: Icon(Icons.more_vert, color: disabledBoldColor, size: 20),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Row(
                                          children: [
                                            Icon(Icons.copy, size: 16),
                                            SizedBox(width: spSm),
                                            Text("Duplicate"),
                                          ],
                                        ),
                                        onTap: () {
                                          // Duplicate event
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: Row(
                                          children: [
                                            Icon(Icons.share, size: 16),
                                            SizedBox(width: spSm),
                                            Text("Share"),
                                          ],
                                        ),
                                        onTap: () {
                                          // Share event
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete, size: 16, color: dangerColor),
                                            SizedBox(width: spSm),
                                            Text("Delete", style: TextStyle(color: dangerColor)),
                                          ],
                                        ),
                                        onTap: () {
                                          // Delete event
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    
                    SizedBox(height: spMd),
                  ],
                );
              }),
            ] else ...[
              // Empty State
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No events scheduled",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "No events found for the selected period and filter",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Create New Event",
                      size: bs.md,
                      onPressed: () {
                        // Navigate to create event
                      },
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
