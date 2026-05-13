import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaExamScheduleView extends StatefulWidget {
  const ElaExamScheduleView({super.key});

  @override
  State<ElaExamScheduleView> createState() => _ElaExamScheduleViewState();
}

class _ElaExamScheduleViewState extends State<ElaExamScheduleView> {
  String selectedSemester = "Fall 2024";
  String selectedFilter = "All";
  String selectedStatus = "All";
  
  final List<Map<String, dynamic>> semesterOptions = [
    {"label": "Fall 2024", "value": "Fall 2024"},
    {"label": "Spring 2024", "value": "Spring 2024"},
    {"label": "Summer 2024", "value": "Summer 2024"},
  ];

  final List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Midterm", "value": "Midterm"},
    {"label": "Final", "value": "Final"},
    {"label": "Quiz", "value": "Quiz"},
  ];

  final List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Upcoming", "value": "Upcoming"},
    {"label": "Completed", "value": "Completed"},
    {"label": "In Progress", "value": "In Progress"},
  ];

  final List<Map<String, dynamic>> examData = [
    {
      "subject": "Mathematics II",
      "code": "MATH102",
      "instructor": "Dr. Sarah Johnson",
      "type": "Midterm",
      "date": "2024-06-20",
      "time": "09:00 - 11:00",
      "duration": "2 hours",
      "location": "Exam Hall A",
      "status": "Upcoming",
      "topics": ["Calculus", "Linear Algebra", "Differential Equations"],
      "totalMarks": 100,
      "passingMarks": 40,
      "color": primaryColor,
      "difficulty": "Hard",
      "instructions": "Bring calculator and ID card. No mobile phones allowed.",
    },
    {
      "subject": "Physics",
      "code": "PHYS101",
      "instructor": "Prof. Michael Chen",
      "type": "Final",
      "date": "2024-06-25",
      "time": "14:00 - 17:00",
      "duration": "3 hours",
      "location": "Exam Hall B",
      "status": "Upcoming",
      "topics": ["Mechanics", "Thermodynamics", "Electromagnetism", "Optics"],
      "totalMarks": 150,
      "passingMarks": 60,
      "color": infoColor,
      "difficulty": "Hard",
      "instructions": "All formulas will be provided. Bring scientific calculator.",
    },
    {
      "subject": "Chemistry",
      "code": "CHEM101",
      "instructor": "Dr. Emily Davis",
      "type": "Quiz",
      "date": "2024-06-18",
      "time": "10:00 - 10:30",
      "duration": "30 minutes",
      "location": "Room C-105",
      "status": "Upcoming",
      "topics": ["Organic Chemistry Basics", "Molecular Structure"],
      "totalMarks": 25,
      "passingMarks": 10,
      "color": successColor,
      "difficulty": "Medium",
      "instructions": "Short answer questions only. No calculators needed.",
    },
    {
      "subject": "Computer Science",
      "code": "CS201",
      "instructor": "Prof. Alex Kumar",
      "type": "Midterm",
      "date": "2024-06-15",
      "time": "11:00 - 13:00",
      "duration": "2 hours",
      "location": "Computer Lab 1",
      "status": "Completed",
      "topics": ["Data Structures", "Algorithms", "Programming"],
      "totalMarks": 100,
      "passingMarks": 40,
      "color": warningColor,
      "difficulty": "Medium",
      "instructions": "Practical exam on computers. Code compilation required.",
      "result": 85,
      "grade": "A",
    },
    {
      "subject": "Statistics",
      "code": "STAT201",
      "instructor": "Dr. James Wilson",
      "type": "Final",
      "date": "2024-06-22",
      "time": "09:00 - 12:00",
      "duration": "3 hours",
      "location": "Exam Hall C",
      "status": "Upcoming",
      "topics": ["Probability", "Hypothesis Testing", "Regression Analysis"],
      "totalMarks": 150,
      "passingMarks": 60,
      "color": dangerColor,
      "difficulty": "Hard",
      "instructions": "Statistical tables will be provided. Calculator allowed.",
    },
    {
      "subject": "English Literature",
      "code": "ENG301",
      "instructor": "Dr. Rebecca Miller",
      "type": "Quiz",
      "date": "2024-06-12",
      "time": "15:00 - 15:45",
      "duration": "45 minutes",
      "location": "Room D-205",
      "status": "Completed",
      "topics": ["Modern Poetry", "Literary Analysis"],
      "totalMarks": 30,
      "passingMarks": 12,
      "color": Colors.purple,
      "difficulty": "Easy",
      "instructions": "Essay-type questions. Handwritten answers only.",
      "result": 28,
      "grade": "A+",
    },
  ];

  List<Map<String, dynamic>> get filteredExams {
    List<Map<String, dynamic>> filtered = examData;
    
    if (selectedFilter != "All") {
      filtered = filtered.where((exam) => exam["type"] == selectedFilter).toList();
    }
    
    if (selectedStatus != "All") {
      filtered = filtered.where((exam) => exam["status"] == selectedStatus).toList();
    }
    
    // Sort by date
    filtered.sort((a, b) => DateTime.parse(a["date"]).compareTo(DateTime.parse(b["date"])));
    
    return filtered;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Upcoming": return warningColor;
      case "Completed": return successColor;
      case "In Progress": return infoColor;
      default: return disabledBoldColor;
    }
  }

  Color getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy": return successColor;
      case "Medium": return warningColor;
      case "Hard": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  IconData getTypeIcon(String type) {
    switch (type) {
      case "Midterm": return Icons.quiz;
      case "Final": return Icons.assignment_turned_in;
      case "Quiz": return Icons.help;
      default: return Icons.school;
    }
  }

  int getDaysUntilExam(String dateStr) {
    DateTime examDate = DateTime.parse(dateStr);
    DateTime now = DateTime.now();
    return examDate.difference(now).inDays;
  }

  String getGradeColor(String grade) {
    switch (grade) {
      case "A+":
      case "A": return "text-green-600";
      case "B+":
      case "B": return "text-blue-600";
      case "C+":
      case "C": return "text-yellow-600";
      default: return "text-red-600";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // View in calendar
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Exam reminders
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
                  Icon(Icons.school, color: primaryColor, size: 20),
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
            
            // Exam Statistics
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
                    "Exam Overview",
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
                      _buildStatCard("Total Exams", "${examData.length}", Icons.quiz, primaryColor),
                      _buildStatCard("Upcoming", "${examData.where((e) => e["status"] == "Upcoming").length}", Icons.schedule, warningColor),
                      _buildStatCard("Completed", "${examData.where((e) => e["status"] == "Completed").length}", Icons.check_circle, successColor),
                      _buildStatCard("Average", "${examData.where((e) => e.containsKey("result")).isEmpty ? "N/A" : (examData.where((e) => e.containsKey("result")).map((e) => e["result"] as int).reduce((a, b) => a + b) / examData.where((e) => e.containsKey("result")).length).toInt()}%", Icons.trending_up, infoColor),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Filters
            Text(
              "Filter Exams",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Type",
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
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Exam List
            Text(
              "Exam Schedule (${filteredExams.length} exams)",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            if (filteredExams.isEmpty)
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
                      Icons.event_busy,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No exams found",
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
              )
            else
              ...filteredExams.map((exam) {
                int daysUntil = getDaysUntilExam(exam["date"]);
                bool isUpcoming = exam["status"] == "Upcoming";
                bool isCompleted = exam["status"] == "Completed";
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: exam["color"],
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Main Content
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Row
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: (exam["color"] as Color).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    getTypeIcon(exam["type"]),
                                    color: exam["color"],
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${exam["subject"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${exam["code"]} • ${exam["type"]}",
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
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: getStatusColor(exam["status"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXxs),
                                      ),
                                      child: Text(
                                        "${exam["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: getStatusColor(exam["status"]),
                                        ),
                                      ),
                                    ),
                                    if (isUpcoming && daysUntil >= 0) ...[
                                      SizedBox(height: spXxs),
                                      Text(
                                        daysUntil == 0 ? "Today!" : daysUntil == 1 ? "Tomorrow" : "in $daysUntil days",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: daysUntil <= 3 ? dangerColor : warningColor,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Date and Time
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (exam["color"] as Color).withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(color: (exam["color"] as Color).withAlpha(30)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_today, color: exam["color"], size: 16),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${DateTime.parse(exam["date"]).dMMMy}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: exam["color"],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spXxs),
                                        Row(
                                          children: [
                                            Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${exam["time"]} (${exam["duration"]})",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${exam["location"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXxs),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: getDifficultyColor(exam["difficulty"]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXxs),
                                        ),
                                        child: Text(
                                          "${exam["difficulty"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: getDifficultyColor(exam["difficulty"]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Instructor and Marks
                            Row(
                              children: [
                                Icon(Icons.person, color: disabledBoldColor, size: 16),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${exam["instructor"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Total: ${exam["totalMarks"]} marks",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Result (if completed)
                            if (isCompleted && exam.containsKey("result")) ...[
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(color: successColor.withAlpha(30)),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.grade, color: successColor, size: 20),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Result: ${exam["result"]}/${exam["totalMarks"]} (${((exam["result"] as int) / (exam["totalMarks"] as int) * 100).toInt()}%)",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: successColor,
                                            ),
                                          ),
                                          Text(
                                            "Grade: ${exam["grade"]}",
                                            style: TextStyle(
                                              fontSize: 12,
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
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${exam["grade"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: spSm),
                            ],
                            
                            // Topics
                            Text(
                              "Topics:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (exam["topics"] as List<String>).map((topic) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: disabledColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXxs),
                                  ),
                                  child: Text(
                                    topic,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Instructions
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(color: warningColor.withAlpha(30)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.info, color: warningColor, size: 16),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${exam["instructions"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Action Buttons
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(10),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(radiusSm),
                            bottomRight: Radius.circular(radiusSm),
                          ),
                        ),
                        child: Row(
                          children: [
                            if (isUpcoming) ...[
                              GestureDetector(
                                onTap: () {
                                  // Set reminder
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.notifications, color: warningColor, size: 16),
                                    SizedBox(width: spXxs),
                                    Text(
                                      "Remind",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spMd),
                              GestureDetector(
                                onTap: () {
                                  // Study materials
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.book, color: infoColor, size: 16),
                                    SizedBox(width: spXxs),
                                    Text(
                                      "Study",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: infoColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            if (isCompleted) ...[
                              GestureDetector(
                                onTap: () {
                                  // View detailed results
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.analytics, color: successColor, size: 16),
                                    SizedBox(width: spXxs),
                                    Text(
                                      "Details",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                // View exam details
                              },
                              child: Icon(Icons.more_vert, color: disabledBoldColor, size: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            
            SizedBox(height: spXl),
            
            // Quick Actions
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Study Plan",
                          icon: Icons.schedule,
                          color: infoColor,
                          size: bs.sm,
                          onPressed: () {
                            // Create study plan
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Calendar View",
                          icon: Icons.calendar_today,
                          color: primaryColor,
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to calendar
                          },
                        ),
                      ),
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

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
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
            value,
            style: TextStyle(
              fontSize: 16,
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
