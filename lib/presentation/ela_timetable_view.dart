import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaTimetableView extends StatefulWidget {
  const ElaTimetableView({super.key});

  @override
  State<ElaTimetableView> createState() => _ElaTimetableViewState();
}

class _ElaTimetableViewState extends State<ElaTimetableView> {
  String selectedSemester = "Fall 2024";
  int selectedDayIndex = DateTime.now().weekday - 1;
  
  final List<Map<String, dynamic>> semesterOptions = [
    {"label": "Fall 2024", "value": "Fall 2024"},
    {"label": "Spring 2024", "value": "Spring 2024"},
    {"label": "Summer 2024", "value": "Summer 2024"},
  ];

  final List<String> weekDays = [
    "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
  ];

  final List<String> timeSlots = [
    "08:00", "09:00", "10:00", "11:00", "12:00", 
    "13:00", "14:00", "15:00", "16:00", "17:00", "18:00"
  ];

  final Map<String, List<Map<String, dynamic>>> timetableData = {
    "Monday": [
      {
        "subject": "Mathematics II",
        "code": "MATH102",
        "instructor": "Dr. Sarah Johnson",
        "room": "A-201",
        "time": "08:00 - 09:30",
        "type": "Lecture",
        "color": primaryColor,
      },
      {
        "subject": "Physics",
        "code": "PHYS101",
        "instructor": "Prof. Michael Chen",
        "room": "B-105",
        "time": "10:00 - 11:30",
        "type": "Lecture",
        "color": infoColor,
      },
      {
        "subject": "Chemistry Lab",
        "code": "CHEM101L",
        "instructor": "Dr. Emily Davis",
        "room": "Chem Lab A",
        "time": "14:00 - 16:00",
        "type": "Lab",
        "color": successColor,
      },
    ],
    "Tuesday": [
      {
        "subject": "Computer Science",
        "code": "CS201",
        "instructor": "Prof. Alex Kumar",
        "room": "C-301",
        "time": "09:00 - 10:30",
        "type": "Lecture",
        "color": warningColor,
      },
      {
        "subject": "English Literature",
        "code": "ENG301",
        "instructor": "Dr. Rebecca Miller",
        "room": "D-205",
        "time": "11:00 - 12:30",
        "type": "Seminar",
        "color": dangerColor,
      },
      {
        "subject": "Physics Lab",
        "code": "PHYS101L",
        "instructor": "Prof. Michael Chen",
        "room": "Physics Lab B",
        "time": "15:00 - 17:00",
        "type": "Lab",
        "color": infoColor,
      },
    ],
    "Wednesday": [
      {
        "subject": "Mathematics II",
        "code": "MATH102",
        "instructor": "Dr. Sarah Johnson",
        "room": "A-201",
        "time": "08:00 - 09:30",
        "type": "Lecture",
        "color": primaryColor,
      },
      {
        "subject": "Statistics",
        "code": "STAT201",
        "instructor": "Dr. James Wilson",
        "room": "A-105",
        "time": "13:00 - 14:30",
        "type": "Lecture",
        "color": successColor,
      },
    ],
    "Thursday": [
      {
        "subject": "Computer Science",
        "code": "CS201",
        "instructor": "Prof. Alex Kumar",
        "room": "C-301",
        "time": "09:00 - 10:30",
        "type": "Lecture",
        "color": warningColor,
      },
      {
        "subject": "English Literature",
        "code": "ENG301",
        "instructor": "Dr. Rebecca Miller",
        "room": "D-205",
        "time": "11:00 - 12:30",
        "type": "Seminar",
        "color": dangerColor,
      },
      {
        "subject": "CS Lab",
        "code": "CS201L",
        "instructor": "Prof. Alex Kumar",
        "room": "Computer Lab 1",
        "time": "16:00 - 18:00",
        "type": "Lab",
        "color": warningColor,
      },
    ],
    "Friday": [
      {
        "subject": "Mathematics II",
        "code": "MATH102",
        "instructor": "Dr. Sarah Johnson",
        "room": "A-201",
        "time": "08:00 - 09:30",
        "type": "Lecture",
        "color": primaryColor,
      },
      {
        "subject": "Physics",
        "code": "PHYS101",
        "instructor": "Prof. Michael Chen",
        "room": "B-105",
        "time": "10:00 - 11:30",
        "type": "Lecture",
        "color": infoColor,
      },
    ],
    "Saturday": [],
    "Sunday": [],
  };

  List<Map<String, dynamic>> get todaySchedule {
    String today = weekDays[selectedDayIndex];
    return timetableData[today] ?? [];
  }

  Color getTypeColor(String type) {
    switch (type) {
      case "Lecture": return primaryColor;
      case "Lab": return successColor;
      case "Seminar": return dangerColor;
      case "Tutorial": return warningColor;
      default: return disabledBoldColor;
    }
  }

  IconData getTypeIcon(String type) {
    switch (type) {
      case "Lecture": return Icons.school;
      case "Lab": return Icons.science;
      case "Seminar": return Icons.groups;
      case "Tutorial": return Icons.person;
      default: return Icons.event;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timetable"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Edit timetable
            },
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              // Print timetable
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Semester Selector
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_month, color: primaryColor, size: 20),
                  SizedBox(width: spXs),
                  Text(
                    "Academic Period:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "",
                      items: semesterOptions,
                      value: selectedSemester,
                      onChanged: (value, label) {
                        selectedSemester = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Weekly Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Weekly Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 100,
                    children: weekDays.asMap().entries.map((entry) {
                      int index = entry.key;
                      String day = entry.value;
                      int classCount = (timetableData[day] ?? []).length;
                      bool isSelected = index == selectedDayIndex;
                      bool isToday = index == DateTime.now().weekday - 1;
                      
                      return GestureDetector(
                        onTap: () {
                          selectedDayIndex = index;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected 
                              ? primaryColor.withAlpha(20)
                              : (isToday ? successColor.withAlpha(10) : Colors.transparent),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(
                              color: isSelected 
                                ? primaryColor
                                : (isToday ? successColor : disabledColor),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                day.substring(0, 3),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected 
                                    ? primaryColor
                                    : (isToday ? successColor : disabledBoldColor),
                                ),
                              ),
                              SizedBox(height: spXxs),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: classCount > 0 
                                    ? (isSelected ? primaryColor : successColor)
                                    : disabledColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    "$classCount",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Selected Day Schedule
            Text(
              "${weekDays[selectedDayIndex]} Schedule",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            if (todaySchedule.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledColor),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.free_breakfast,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No classes scheduled",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Enjoy your free day!",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...todaySchedule.map((classItem) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: classItem["color"],
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (classItem["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                getTypeIcon(classItem["type"]),
                                color: classItem["color"],
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${classItem["subject"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${classItem["code"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: getTypeColor(classItem["type"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXxs),
                              ),
                              child: Text(
                                "${classItem["type"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: getTypeColor(classItem["type"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Time and Location
                        Row(
                          children: [
                            Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${classItem["time"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${classItem["room"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Instructor
                        Row(
                          children: [
                            Icon(Icons.person, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${classItem["instructor"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                // View class details
                              },
                              child: Icon(
                                Icons.info,
                                color: infoColor,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            
            SizedBox(height: spLg),
            
            // Full Week Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Full Week View",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Expand full timetable
                        },
                        child: Text(
                          "View Details",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  // Timetable Grid
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: 600,
                      child: Column(
                        children: [
                          // Header Row
                          Container(
                            height: 40,
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Time",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                ...weekDays.take(5).map((day) {
                                  return Container(
                                    width: 108,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(10),
                                    ),
                                    child: Text(
                                      day.substring(0, 3),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                          
                          // Time Rows
                          ...timeSlots.take(8).map((time) {
                            return Container(
                              height: 60,
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: disabledColor, width: 0.5),
                                    ),
                                    child: Text(
                                      time,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                  ...weekDays.take(5).map((day) {
                                    // Find class for this time slot
                                    List<Map<String, dynamic>> dayClasses = timetableData[day] ?? [];
                                    Map<String, dynamic>? classForTime;
                                    
                                    for (var classItem in dayClasses) {
                                      String startTime = (classItem["time"] as String).split(" - ")[0];
                                      if (startTime == time) {
                                        classForTime = classItem;
                                        break;
                                      }
                                    }
                                    
                                    return Container(
                                      width: 108,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: disabledColor, width: 0.5),
                                        color: classForTime != null 
                                          ? (classForTime["color"] as Color).withAlpha(20)
                                          : Colors.transparent,
                                      ),
                                      child: classForTime != null 
                                        ? Padding(
                                            padding: EdgeInsets.all(2),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${classForTime["code"]}",
                                                  style: TextStyle(
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.bold,
                                                    color: classForTime["color"],
                                                  ),
                                                ),
                                                Text(
                                                  "${classForTime["room"]}",
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    color: disabledBoldColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    );
                                  }).toList(),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Quick Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Weekly Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 120,
                    children: [
                      _buildStatCard("Total Classes", "${timetableData.values.fold(0, (sum, classes) => sum + classes.length)}", Icons.school, primaryColor),
                      _buildStatCard("Lectures", "${timetableData.values.fold(0, (sum, classes) => sum + classes.where((c) => c["type"] == "Lecture").length)}", Icons.school, successColor),
                      _buildStatCard("Labs", "${timetableData.values.fold(0, (sum, classes) => sum + classes.where((c) => c["type"] == "Lab").length)}", Icons.science, infoColor),
                      _buildStatCard("Seminars", "${timetableData.values.fold(0, (sum, classes) => sum + classes.where((c) => c["type"] == "Seminar").length)}", Icons.groups, dangerColor),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String count, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            count,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXxs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
