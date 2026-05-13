import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaHarvestCalendarView extends StatefulWidget {
  const AmaHarvestCalendarView({super.key});

  @override
  State<AmaHarvestCalendarView> createState() => _AmaHarvestCalendarViewState();
}

class _AmaHarvestCalendarViewState extends State<AmaHarvestCalendarView> {
  DateTime selectedDate = DateTime.now();
  String viewMode = "Month";
  
  List<Map<String, dynamic>> harvestEvents = [
    {
      "id": 1,
      "title": "Wheat Harvest - East Field C",
      "crop": "Wheat",
      "field": "East Field C",
      "area": 42.1,
      "startDate": "2024-07-15",
      "endDate": "2024-07-18",
      "priority": "Critical",
      "status": "Ready",
      "estimatedYield": 78.5,
      "workers": 12,
      "equipment": ["New Holland CR9090", "Grain Cart"],
      "weather": "Partly Cloudy",
      "notes": "Monitor weather closely - rain risk"
    },
    {
      "id": 2,
      "title": "Corn Harvest - North Field A",
      "crop": "Corn",
      "field": "North Field A",
      "area": 25.5,
      "startDate": "2024-07-20",
      "endDate": "2024-07-25",
      "priority": "High",
      "status": "Scheduled",
      "estimatedYield": 185.5,
      "workers": 8,
      "equipment": ["John Deere 9600", "Grain Cart"],
      "weather": "Sunny",
      "notes": "Equipment maintenance on 7/19"
    },
    {
      "id": 3,
      "title": "Soybean Harvest - South Field B",
      "crop": "Soybean",
      "field": "South Field B",
      "area": 18.3,
      "startDate": "2024-09-15",
      "endDate": "2024-09-20",
      "priority": "Medium",
      "status": "Planning",
      "estimatedYield": 58.2,
      "workers": 6,
      "equipment": ["Case IH 8230", "Grain Cart"],
      "weather": "Forecasting",
      "notes": "Wait for moisture levels to drop"
    },
    {
      "id": 4,
      "title": "Tomato Harvest - Greenhouse 1",
      "crop": "Tomato",
      "field": "Greenhouse 1",
      "area": 5.2,
      "startDate": "2024-06-25",
      "endDate": "2024-08-15",
      "priority": "High",
      "status": "Active",
      "estimatedYield": 28.5,
      "workers": 15,
      "equipment": ["Harvest Crates", "Sorting Tables"],
      "weather": "Controlled",
      "notes": "Continuous harvest every 3 days"
    },
    {
      "id": 5,
      "title": "Apple Harvest - Orchard A",
      "crop": "Apple",
      "field": "Orchard A",
      "area": 12.8,
      "startDate": "2024-09-10",
      "endDate": "2024-10-05",
      "priority": "High",
      "status": "Planning",
      "estimatedYield": 45.2,
      "workers": 20,
      "equipment": ["Harvest Bins", "Ladders", "Trucks"],
      "weather": "Monitoring",
      "notes": "Check fruit maturity weekly"
    }
  ];

  List<String> viewModes = ["Month", "Week", "Day"];

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Ready":
        return warningColor;
      case "Scheduled":
        return primaryColor;
      case "Planning":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  List<Map<String, dynamic>> _getEventsForDate(DateTime date) {
    return harvestEvents.where((event) {
      final startDate = DateTime.parse(event["startDate"]);
      final endDate = DateTime.parse(event["endDate"]);
      return date.isAfter(startDate.subtract(Duration(days: 1))) && 
             date.isBefore(endDate.add(Duration(days: 1)));
    }).toList();
  }

  List<Map<String, dynamic>> _getEventsForWeek(DateTime weekStart) {
    final weekEnd = weekStart.add(Duration(days: 6));
    return harvestEvents.where((event) {
      final startDate = DateTime.parse(event["startDate"]);
      final endDate = DateTime.parse(event["endDate"]);
      return (startDate.isBefore(weekEnd.add(Duration(days: 1))) && 
              endDate.isAfter(weekStart.subtract(Duration(days: 1))));
    }).toList();
  }

  DateTime _getWeekStart(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Harvest Calendar"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add harvest event
            },
          ),
          IconButton(
            icon: Icon(Icons.today),
            onPressed: () {
              setState(() {
                selectedDate = DateTime.now();
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // View Mode Selector
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_view_month, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Calendar View",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QCategoryPicker(
                    items: viewModes.map((mode) => {
                      "label": mode,
                      "value": mode,
                    }).toList(),
                    value: viewMode,
                    onChanged: (index, label, value, item) {
                      viewMode = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Calendar Navigation
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () {
                      setState(() {
                        if (viewMode == "Month") {
                          selectedDate = DateTime(selectedDate.year, selectedDate.month - 1, 1);
                        } else if (viewMode == "Week") {
                          selectedDate = selectedDate.subtract(Duration(days: 7));
                        } else {
                          selectedDate = selectedDate.subtract(Duration(days: 1));
                        }
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      viewMode == "Month"
                          ? "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}"
                          : viewMode == "Week"
                              ? "Week of ${_getWeekStart(selectedDate).dMMMy}"
                              : selectedDate.dMMMy,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: () {
                      setState(() {
                        if (viewMode == "Month") {
                          selectedDate = DateTime(selectedDate.year, selectedDate.month + 1, 1);
                        } else if (viewMode == "Week") {
                          selectedDate = selectedDate.add(Duration(days: 7));
                        } else {
                          selectedDate = selectedDate.add(Duration(days: 1));
                        }
                      });
                    },
                  ),
                ],
              ),
            ),

            // Summary Statistics
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${harvestEvents.length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Events",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${harvestEvents.where((e) => e["status"] == "Active").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${harvestEvents.where((e) => e["priority"] == "Critical").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Critical",
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
            ),

            // Calendar Content based on view mode
            if (viewMode == "Month") _buildMonthView(),
            if (viewMode == "Week") _buildWeekView(),
            if (viewMode == "Day") _buildDayView(),

            // Upcoming Events
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Upcoming Events",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...List.generate(
                    harvestEvents.where((event) {
                      final eventDate = DateTime.parse(event["startDate"]);
                      return eventDate.isAfter(DateTime.now().subtract(Duration(days: 1)));
                    }).take(3).length,
                    (index) {
                      final event = harvestEvents.where((event) {
                        final eventDate = DateTime.parse(event["startDate"]);
                        return eventDate.isAfter(DateTime.now().subtract(Duration(days: 1)));
                      }).toList()[index];
                      
                      return Container(
                        padding: EdgeInsets.all(spXs),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${event["status"]}").withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(
                            color: _getStatusColor("${event["status"]}").withAlpha(30),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _getPriorityColor("${event["priority"]}"),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 2,
                                children: [
                                  Text(
                                    "${event["title"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${DateTime.parse(event["startDate"]).dMMMy} - ${DateTime.parse(event["endDate"]).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor("${event["status"]}"),
                                          borderRadius: BorderRadius.circular(radiusXxs),
                                        ),
                                        child: Text(
                                          "${event["status"]}",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: _getPriorityColor("${event["priority"]}"),
                                          borderRadius: BorderRadius.circular(radiusXxs),
                                        ),
                                        child: Text(
                                          "${event["priority"]}",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }

  Widget _buildMonthView() {
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final lastDayOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0);
    final firstDayOfCalendar = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday - 1));
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          // Days of week header
          Row(
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((day) {
              return Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: spXs),
                  child: Text(
                    day,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          
          // Calendar grid
          ...List.generate(6, (weekIndex) {
            return Row(
              children: List.generate(7, (dayIndex) {
                final currentDate = firstDayOfCalendar.add(Duration(days: weekIndex * 7 + dayIndex));
                final eventsForDay = _getEventsForDate(currentDate);
                final isCurrentMonth = currentDate.month == selectedDate.month;
                final isToday = currentDate.day == DateTime.now().day &&
                               currentDate.month == DateTime.now().month &&
                               currentDate.year == DateTime.now().year;
                
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = currentDate;
                        viewMode = "Day";
                      });
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: isToday ? primaryColor.withAlpha(20) : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: isToday ? Border.all(color: primaryColor) : null,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${currentDate.day}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                              color: isCurrentMonth 
                                  ? (isToday ? primaryColor : primaryColor)
                                  : disabledColor,
                            ),
                          ),
                          if (eventsForDay.isNotEmpty)
                            Expanded(
                              child: Column(
                                children: eventsForDay.take(2).map((event) {
                                  return Container(
                                    width: double.infinity,
                                    height: 12,
                                    margin: EdgeInsets.symmetric(vertical: 1),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor("${event["priority"]}"),
                                      borderRadius: BorderRadius.circular(radiusXxs),
                                    ),
                                    child: Text(
                                      "${event["crop"]}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          if (eventsForDay.length > 2)
                            Text(
                              "+${eventsForDay.length - 2}",
                              style: TextStyle(
                                fontSize: 8,
                                color: disabledBoldColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildWeekView() {
    final weekStart = _getWeekStart(selectedDate);
    final weekEvents = _getEventsForWeek(weekStart);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          // Week days header
          Row(
            children: List.generate(7, (dayIndex) {
              final currentDate = weekStart.add(Duration(days: dayIndex));
              final isToday = currentDate.day == DateTime.now().day &&
                             currentDate.month == DateTime.now().month &&
                             currentDate.year == DateTime.now().year;
              
              return Expanded(
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: isToday ? primaryColor.withAlpha(20) : Colors.transparent,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    children: [
                      Text(
                        ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][dayIndex],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${currentDate.day}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                          color: isToday ? primaryColor : primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          
          // Week events
          ...weekEvents.map((event) {
            return Container(
              padding: EdgeInsets.all(spXs),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: _getStatusColor("${event["status"]}").withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getPriorityColor("${event["priority"]}"),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        Text(
                          "${event["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${DateTime.parse(event["startDate"]).dMMMy} - ${DateTime.parse(event["endDate"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 2,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${event["status"]}"),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${event["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "${(event["area"] as num).toStringAsFixed(1)} acres",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDayView() {
    final dayEvents = _getEventsForDate(selectedDate);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Events for ${selectedDate.dMMMy}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          if (dayEvents.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.event_available,
                    size: 48,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No harvest events scheduled",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          
          ...dayEvents.map((event) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: _getStatusColor("${event["status"]}").withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getPriorityColor("${event["priority"]}"),
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
                          color: _getStatusColor("${event["status"]}"),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${event["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 2,
                            children: [
                              Text(
                                "Area: ${(event["area"] as num).toStringAsFixed(1)} acres",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Workers: ${event["workers"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Yield: ${(event["estimatedYield"] as num).toStringAsFixed(1)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 2,
                            children: [
                              Text(
                                "Weather: ${event["weather"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Equipment: ${(event["equipment"] as List).length} items",
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
                  ),
                  
                  if (event["notes"].toString().isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: warningColor.withAlpha(30)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.note, size: 16, color: warningColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${event["notes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      // Navigate to event details
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
