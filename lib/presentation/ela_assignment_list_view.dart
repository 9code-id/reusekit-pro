import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaAssignmentListView extends StatefulWidget {
  const ElaAssignmentListView({super.key});

  @override
  State<ElaAssignmentListView> createState() => _ElaAssignmentListViewState();
}

class _ElaAssignmentListViewState extends State<ElaAssignmentListView> {
  String selectedFilter = "All";
  String searchQuery = "";
  
  List<Map<String, dynamic>> assignments = [
    {
      "id": 1,
      "title": "Poetry Analysis: Robert Frost",
      "description": "Analyze themes and literary devices in 'The Road Not Taken'",
      "subject": "Literature",
      "type": "Essay",
      "due_date": "2024-12-20",
      "assigned_date": "2024-12-10",
      "status": "Pending",
      "points": 100,
      "difficulty": "Medium",
      "estimated_time": "2 hours",
      "submission_type": "Document",
      "instructions": "Write a 500-word analysis focusing on metaphors and symbolism.",
      "teacher": "Ms. Johnson",
      "class": "English Literature 101"
    },
    {
      "id": 2,
      "title": "Grammar Workshop: Sentence Structure",
      "description": "Complete exercises on complex and compound sentences",
      "subject": "Grammar",
      "type": "Practice",
      "due_date": "2024-12-18",
      "assigned_date": "2024-12-12",
      "status": "In Progress",
      "points": 50,
      "difficulty": "Easy",
      "estimated_time": "1 hour",
      "submission_type": "Online",
      "instructions": "Complete all 20 exercises in the grammar workbook.",
      "teacher": "Mr. Smith",
      "class": "English Grammar"
    },
    {
      "id": 3,
      "title": "Creative Writing: Short Story",
      "description": "Write an original short story with dialogue and character development",
      "subject": "Creative Writing",
      "type": "Creative",
      "due_date": "2024-12-25",
      "assigned_date": "2024-12-08",
      "status": "Submitted",
      "points": 150,
      "difficulty": "Hard",
      "estimated_time": "4 hours",
      "submission_type": "Document",
      "instructions": "Minimum 800 words, include dialogue and descriptive language.",
      "teacher": "Ms. Williams",
      "class": "Creative Writing Workshop"
    },
    {
      "id": 4,
      "title": "Reading Comprehension: Shakespeare",
      "description": "Answer questions about Romeo and Juliet Act II",
      "subject": "Literature",
      "type": "Quiz",
      "due_date": "2024-12-16",
      "assigned_date": "2024-12-14",
      "status": "Overdue",
      "points": 75,
      "difficulty": "Medium",
      "estimated_time": "45 minutes",
      "submission_type": "Online",
      "instructions": "Read Act II and answer all comprehension questions.",
      "teacher": "Ms. Johnson",
      "class": "English Literature 101"
    }
  ];

  List<Map<String, dynamic>> get filteredAssignments {
    List<Map<String, dynamic>> filtered = assignments;
    
    // Filter by status
    if (selectedFilter != "All") {
      filtered = filtered.where((assignment) => 
        assignment["status"] == selectedFilter).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((assignment) =>
        assignment["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        assignment["subject"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        assignment["teacher"].toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "In Progress":
        return infoColor;
      case "Submitted":
        return successColor;
      case "Overdue":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return successColor;
      case "Medium":
        return warningColor;
      case "Hard":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _viewAssignment(Map<String, dynamic> assignment) {
    // navigateTo(ElaAssignmentDetailView(assignment: assignment))
  }

  void _startAssignment(Map<String, dynamic> assignment) {
    // navigateTo(ElaAssignmentSubmissionView(assignment: assignment))
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ELA Assignments"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search assignments...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Filter tabs
            QCategoryPicker(
              items: [
                {"label": "All", "value": "All"},
                {"label": "Pending", "value": "Pending"},
                {"label": "In Progress", "value": "In Progress"},
                {"label": "Submitted", "value": "Submitted"},
                {"label": "Overdue", "value": "Overdue"},
              ],
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Assignment stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${assignments.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total",
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${assignments.where((a) => a["status"] == "Pending").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${assignments.where((a) => a["status"] == "Overdue").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Overdue",
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
            
            SizedBox(height: spLg),
            
            // Assignments list
            Text(
              "Assignments (${filteredAssignments.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...filteredAssignments.map((assignment) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(assignment["status"]),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${assignment["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(assignment["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${assignment["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(assignment["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      "${assignment["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.subject,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${assignment["subject"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(
                          Icons.schedule,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${assignment["estimated_time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(assignment["difficulty"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${assignment["difficulty"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: _getDifficultyColor(assignment["difficulty"]),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Due: ${DateTime.parse(assignment["due_date"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${assignment["points"]} points",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () => _viewAssignment(assignment),
                          ),
                        ),
                        SizedBox(width: spSm),
                        if (assignment["status"] != "Submitted")
                          Expanded(
                            child: QButton(
                              label: assignment["status"] == "In Progress" ? "Continue" : "Start",
                              size: bs.sm,
                              onPressed: () => _startAssignment(assignment),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            
            if (filteredAssignments.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.assignment,
                      color: disabledColor,
                      size: 60,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No assignments found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filters or search terms",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
