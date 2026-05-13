import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmProjectCalendarView extends StatefulWidget {
  const TpmProjectCalendarView({super.key});

  @override
  State<TpmProjectCalendarView> createState() => _TpmProjectCalendarViewState();
}

class _TpmProjectCalendarViewState extends State<TpmProjectCalendarView> {
  DateTime selectedDate = DateTime.now();
  DateTime currentMonth = DateTime.now();
  String selectedView = "month";
  
  List<Map<String, dynamic>> calendarEvents = [
    {
      "id": 1,
      "title": "Project Kickoff Meeting",
      "description": "Initial project planning and team alignment",
      "startTime": DateTime(2025, 6, 20, 9, 0),
      "endTime": DateTime(2025, 6, 20, 10, 30),
      "type": "meeting",
      "color": "#3B82F6",
      "attendees": ["John Doe", "Jane Smith", "Mike Johnson"],
      "location": "Conference Room A",
    },
    {
      "id": 2,
      "title": "Design Review",
      "description": "Review and approve UI/UX designs",
      "startTime": DateTime(2025, 6, 22, 14, 0),
      "endTime": DateTime(2025, 6, 22, 16, 0),
      "type": "review",
      "color": "#10B981",
      "attendees": ["Jane Smith", "Tom Brown"],
      "location": "Design Studio",
    },
    {
      "id": 3,
      "title": "Development Sprint",
      "description": "2-week development sprint",
      "startTime": DateTime(2025, 6, 25, 0, 0),
      "endTime": DateTime(2025, 7, 8, 23, 59),
      "type": "milestone",
      "color": "#F59E0B",
      "attendees": ["Mike Johnson", "Sarah Wilson"],
      "location": "Development Team",
    },
    {
      "id": 4,
      "title": "Client Presentation",
      "description": "Progress presentation to stakeholders",
      "startTime": DateTime(2025, 6, 28, 15, 0),
      "endTime": DateTime(2025, 6, 28, 16, 30),
      "type": "presentation",
      "color": "#8B5CF6",
      "attendees": ["John Doe", "Jane Smith", "Tom Brown"],
      "location": "Boardroom",
    },
    {
      "id": 5,
      "title": "Code Review Session",
      "description": "Weekly code review and feedback",
      "startTime": DateTime(2025, 6, 19, 10, 0),
      "endTime": DateTime(2025, 6, 19, 11, 30),
      "type": "review",
      "color": "#EF4444",
      "attendees": ["Mike Johnson", "Sarah Wilson", "Tom Brown"],
      "location": "Virtual Meeting",
    },
  ];

  List<Map<String, dynamic>> viewOptions = [
    {"label": "Month", "value": "month"},
    {"label": "Week", "value": "week"},
    {"label": "Day", "value": "day"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Calendar"),
        actions: [
          IconButton(
            icon: Icon(Icons.today),
            onPressed: () {
              setState(() {
                selectedDate = DateTime.now();
                currentMonth = DateTime.now();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddEventDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "View",
                        items: viewOptions,
                        value: selectedView,
                        onChanged: (value, label) {
                          selectedView = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    QButton(
                      icon: Icons.chevron_left,
                      size: bs.sm,
                      onPressed: () => _navigateMonth(-1),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.chevron_right,
                      size: bs.sm,
                      onPressed: () => _navigateMonth(1),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Text(
                      "${currentMonth.dMMMy}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    _buildEventLegend(),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: selectedView == "month" 
                ? _buildMonthView()
                : selectedView == "week"
                    ? _buildWeekView()
                    : _buildDayView(),
          ),
        ],
      ),
    );
  }

  Widget _buildEventLegend() {
    return Row(
      children: [
        _buildLegendItem("Meeting", Color(0xFF3B82F6)),
        SizedBox(width: spSm),
        _buildLegendItem("Review", Color(0xFF10B981)),
        SizedBox(width: spSm),
        _buildLegendItem("Milestone", Color(0xFFF59E0B)),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildMonthView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          _buildCalendarHeader(),
          SizedBox(height: spSm),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    List<String> weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    
    return Row(
      children: weekdays.map((day) => Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spSm),
          child: Text(
            day,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildCalendarGrid() {
    DateTime firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    DateTime lastDayOfMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0);
    
    int firstWeekday = firstDayOfMonth.weekday % 7;
    int daysInMonth = lastDayOfMonth.day;
    
    List<Widget> calendarDays = [];
    
    // Add empty cells for days before the first day of the month
    for (int i = 0; i < firstWeekday; i++) {
      calendarDays.add(Expanded(child: Container()));
    }
    
    // Add days of the month
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime date = DateTime(currentMonth.year, currentMonth.month, day);
      calendarDays.add(Expanded(child: _buildCalendarDay(date)));
    }
    
    // Group days into weeks
    List<Widget> weeks = [];
    for (int i = 0; i < calendarDays.length; i += 7) {
      int end = (i + 7 < calendarDays.length) ? i + 7 : calendarDays.length;
      weeks.add(Row(children: calendarDays.sublist(i, end)));
    }
    
    return Column(children: weeks);
  }

  Widget _buildCalendarDay(DateTime date) {
    bool isToday = date.day == DateTime.now().day && 
                   date.month == DateTime.now().month && 
                   date.year == DateTime.now().year;
    bool isSelected = date.day == selectedDate.day && 
                      date.month == selectedDate.month && 
                      date.year == selectedDate.year;
    
    List<Map<String, dynamic>> dayEvents = _getEventsForDate(date);
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDate = date;
        });
        if (dayEvents.isNotEmpty) {
          _showDayEventsDialog(date, dayEvents);
        }
      },
      child: Container(
        height: 80,
        margin: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: isSelected 
              ? primaryColor.withAlpha(20)
              : isToday 
                  ? primaryColor.withAlpha(10)
                  : Colors.white,
          border: Border.all(
            color: isSelected 
                ? primaryColor
                : disabledOutlineBorderColor,
          ),
          borderRadius: BorderRadius.circular(radiusXs),
        ),
        child: Column(
          children: [
            Container(
              height: 24,
              child: Center(
                child: Text(
                  "${date.day}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    color: isToday || isSelected ? primaryColor : primaryColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: dayEvents.take(3).map((event) => Container(
                    width: double.infinity,
                    height: 14,
                    margin: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    decoration: BoxDecoration(
                      color: Color(int.parse(event["color"].replaceFirst('#', '0xFF'))),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Center(
                      child: Text(
                        "${event["title"]}",
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ),
            if (dayEvents.length > 3)
              Text(
                "+${dayEvents.length - 3} more",
                style: TextStyle(
                  fontSize: 8,
                  color: disabledBoldColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          _buildWeekHeader(),
          SizedBox(height: spMd),
          _buildWeekGrid(),
        ],
      ),
    );
  }

  Widget _buildWeekHeader() {
    DateTime startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday % 7));
    
    return Row(
      children: List.generate(7, (index) {
        DateTime date = startOfWeek.add(Duration(days: index));
        bool isToday = date.day == DateTime.now().day && 
                       date.month == DateTime.now().month && 
                       date.year == DateTime.now().year;
        
        return Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: spSm),
            decoration: BoxDecoration(
              color: isToday ? primaryColor.withAlpha(20) : Colors.transparent,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              children: [
                Text(
                  ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][index],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isToday ? primaryColor : disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${date.day}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isToday ? primaryColor : primaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildWeekGrid() {
    DateTime startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday % 7));
    
    return Container(
      height: 400,
      child: Row(
        children: List.generate(7, (index) {
          DateTime date = startOfWeek.add(Duration(days: index));
          List<Map<String, dynamic>> dayEvents = _getEventsForDate(date);
          
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Column(
                children: dayEvents.map((event) => _buildWeekEventCard(event)).toList(),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildWeekEventCard(Map<String, dynamic> event) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: Color(int.parse(event["color"].replaceFirst('#', '0xFF'))),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${event["title"]}",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "${(event["startTime"] as DateTime).kkmm}",
            style: TextStyle(
              fontSize: 8,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayView() {
    List<Map<String, dynamic>> dayEvents = _getEventsForDate(selectedDate);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "${selectedDate.dMMMy}",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (dayEvents.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Text(
                "No events scheduled for this day",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                ),
              ),
            )
          else
            ...dayEvents.map((event) => _buildDayEventCard(event)).toList(),
        ],
      ),
    );
  }

  Widget _buildDayEventCard(Map<String, dynamic> event) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: Color(int.parse(event["color"].replaceFirst('#', '0xFF'))),
          ),
        ),
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
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: Color(int.parse(event["color"].replaceFirst('#', '0xFF'))).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${event["type"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(int.parse(event["color"].replaceFirst('#', '0xFF'))),
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
            ),
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${(event["startTime"] as DateTime).kkmm} - ${(event["endTime"] as DateTime).kkmm}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${event["location"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if ((event["attendees"] as List).isNotEmpty) ...[
            Row(
              children: [
                Icon(Icons.people, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "Attendees:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            QHorizontalScroll(
              children: (event["attendees"] as List).map((attendee) => Container(
                margin: EdgeInsets.only(right: spXs),
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$attendee",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getEventsForDate(DateTime date) {
    return calendarEvents.where((event) {
      DateTime eventStart = event["startTime"];
      DateTime eventEnd = event["endTime"];
      
      return (date.year == eventStart.year && 
              date.month == eventStart.month && 
              date.day == eventStart.day) ||
             (date.isAfter(eventStart.subtract(Duration(days: 1))) && 
              date.isBefore(eventEnd.add(Duration(days: 1))));
    }).toList();
  }

  void _navigateMonth(int direction) {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + direction, 1);
    });
  }

  void _showAddEventDialog() {
    // Implementation for add event dialog
  }

  void _showDayEventsDialog(DateTime date, List<Map<String, dynamic>> events) {
    // Implementation for day events dialog
  }
}
