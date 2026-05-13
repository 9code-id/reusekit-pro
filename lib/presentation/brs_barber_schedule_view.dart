import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsBarberScheduleView extends StatefulWidget {
  const BrsBarberScheduleView({super.key});

  @override
  State<BrsBarberScheduleView> createState() => _BrsBarberScheduleViewState();
}

class _BrsBarberScheduleViewState extends State<BrsBarberScheduleView> {
  DateTime selectedDate = DateTime.now();
  int selectedWeek = 0;

  List<Map<String, dynamic>> weekDays = [
    {"day": "Mon", "date": "15", "isToday": false},
    {"day": "Tue", "date": "16", "isToday": false},
    {"day": "Wed", "date": "17", "isToday": true},
    {"day": "Thu", "date": "18", "isToday": false},
    {"day": "Fri", "date": "19", "isToday": false},
    {"day": "Sat", "date": "20", "isToday": false},
    {"day": "Sun", "date": "21", "isToday": false},
  ];

  List<Map<String, dynamic>> timeSlots = [
    {
      "time": "09:00",
      "status": "available",
      "service": "",
      "client": "",
      "duration": 30,
    },
    {
      "time": "09:30",
      "status": "booked",
      "service": "Classic Haircut",
      "client": "John Smith",
      "duration": 45,
    },
    {
      "time": "10:15",
      "status": "booked",
      "service": "Beard Trim",
      "client": "Mike Johnson",
      "duration": 30,
    },
    {
      "time": "10:45",
      "status": "available",
      "service": "",
      "client": "",
      "duration": 30,
    },
    {
      "time": "11:15",
      "status": "break",
      "service": "Coffee Break",
      "client": "",
      "duration": 15,
    },
    {
      "time": "11:30",
      "status": "booked",
      "service": "Hair Styling",
      "client": "David Brown",
      "duration": 60,
    },
    {
      "time": "12:30",
      "status": "lunch",
      "service": "Lunch Break",
      "client": "",
      "duration": 30,
    },
    {
      "time": "13:00",
      "status": "available",
      "service": "",
      "client": "",
      "duration": 30,
    },
    {
      "time": "13:30",
      "status": "booked",
      "service": "Premium Package",
      "client": "Alex Wilson",
      "duration": 90,
    },
    {
      "time": "15:00",
      "status": "available",
      "service": "",
      "client": "",
      "duration": 30,
    },
    {
      "time": "15:30",
      "status": "booked",
      "service": "Quick Trim",
      "client": "Tom Davis",
      "duration": 30,
    },
    {
      "time": "16:00",
      "status": "available",
      "service": "",
      "client": "",
      "duration": 30,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barber Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Month & Week Navigation
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: () {},
                    ),
                    Text(
                      "January 2024",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_right),
                      onPressed: () {},
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Week Days
                Row(
                  children: List.generate(weekDays.length, (index) {
                    final day = weekDays[index];
                    final isSelected = selectedWeek == index;
                    final isToday = day["isToday"] as bool;
                    
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedWeek = index;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: spXs),
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : (isToday ? primaryColor.withAlpha(50) : Colors.transparent),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: isToday && !isSelected ? Border.all(color: primaryColor, width: 1) : null,
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${day["day"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected ? Colors.white : (isToday ? primaryColor : disabledBoldColor),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${day["date"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected ? Colors.white : (isToday ? primaryColor : primaryColor),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          
          // Schedule Summary
          Container(
            margin: EdgeInsets.all(spMd),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryItem("Total Slots", "12", successColor),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                Expanded(
                  child: _buildSummaryItem("Booked", "6", primaryColor),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                Expanded(
                  child: _buildSummaryItem("Available", "6", infoColor),
                ),
              ],
            ),
          ),
          
          // Time Slots
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: timeSlots.length,
              itemBuilder: (context, index) {
                final slot = timeSlots[index];
                return _buildTimeSlot(slot);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: spXs),
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

  Widget _buildTimeSlot(Map<String, dynamic> slot) {
    Color getStatusColor() {
      switch (slot["status"]) {
        case "booked":
          return primaryColor;
        case "available":
          return successColor;
        case "break":
          return warningColor;
        case "lunch":
          return infoColor;
        default:
          return disabledColor;
      }
    }

    IconData getStatusIcon() {
      switch (slot["status"]) {
        case "booked":
          return Icons.person;
        case "available":
          return Icons.schedule;
        case "break":
          return Icons.coffee;
        case "lunch":
          return Icons.restaurant;
        default:
          return Icons.help_outline;
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: getStatusColor(),
          ),
        ),
      ),
      child: Row(
        children: [
          // Time
          Container(
            width: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${slot["time"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${slot["duration"]}min",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(width: spSm),
          
          // Status Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: getStatusColor().withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              getStatusIcon(),
              color: getStatusColor(),
              size: 20,
            ),
          ),
          
          SizedBox(width: spSm),
          
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  slot["service"].isEmpty ? "Available Slot" : "${slot["service"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: slot["service"].isEmpty ? disabledBoldColor : primaryColor,
                  ),
                ),
                if (slot["client"].isNotEmpty) ...[
                  SizedBox(height: spXs),
                  Text(
                    "${slot["client"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Action Button
          if (slot["status"] == "booked")
            QButton(
              icon: Icons.more_vert,
              size: bs.sm,
              onPressed: () {},
            )
          else if (slot["status"] == "available")
            QButton(
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {},
            ),
        ],
      ),
    );
  }
}
