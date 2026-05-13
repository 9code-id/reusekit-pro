import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaAssignmentDetailView extends StatefulWidget {
  const ElaAssignmentDetailView({super.key});

  @override
  State<ElaAssignmentDetailView> createState() => _ElaAssignmentDetailViewState();
}

class _ElaAssignmentDetailViewState extends State<ElaAssignmentDetailView> {
  Map<String, dynamic> assignment = {
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
    "instructions": "Write a 500-word analysis focusing on metaphors and symbolism used in Robert Frost's 'The Road Not Taken'. Your essay should include an introduction, body paragraphs analyzing specific literary devices, and a conclusion that ties the themes together.",
    "teacher": "Ms. Johnson",
    "class": "English Literature 101",
    "materials": [
      {
        "type": "text",
        "title": "The Road Not Taken - Full Text",
        "url": "https://example.com/poem.pdf",
        "description": "Complete poem text with annotations"
      },
      {
        "type": "video",
        "title": "Understanding Poetry Analysis",
        "url": "https://example.com/video.mp4",
        "description": "15-minute instructional video"
      },
      {
        "type": "document", 
        "title": "Essay Writing Guidelines",
        "url": "https://example.com/guidelines.pdf",
        "description": "Format and structure requirements"
      }
    ],
    "rubric": [
      {
        "criteria": "Thesis Statement",
        "description": "Clear, focused thesis that addresses the prompt",
        "points": 20,
        "levels": [
          {"level": "Excellent", "description": "Strong, clear thesis", "points": 18-20},
          {"level": "Good", "description": "Clear thesis with minor issues", "points": 15-17},
          {"level": "Satisfactory", "description": "Basic thesis present", "points": 12-14},
          {"level": "Needs Improvement", "description": "Weak or unclear thesis", "points": 0-11}
        ]
      },
      {
        "criteria": "Literary Analysis",
        "description": "Analysis of metaphors, symbolism, and themes",
        "points": 40,
        "levels": [
          {"level": "Excellent", "description": "Deep, insightful analysis", "points": 36-40},
          {"level": "Good", "description": "Good analysis with examples", "points": 30-35},
          {"level": "Satisfactory", "description": "Basic analysis", "points": 24-29},
          {"level": "Needs Improvement", "description": "Limited or incorrect analysis", "points": 0-23}
        ]
      },
      {
        "criteria": "Writing Quality",
        "description": "Grammar, structure, and clarity",
        "points": 25,
        "levels": [
          {"level": "Excellent", "description": "Clear, error-free writing", "points": 23-25},
          {"level": "Good", "description": "Minor errors, good structure", "points": 20-22},
          {"level": "Satisfactory", "description": "Some errors, adequate structure", "points": 17-19},
          {"level": "Needs Improvement", "description": "Many errors, poor structure", "points": 0-16}
        ]
      },
      {
        "criteria": "Citations & Format",
        "description": "Proper MLA format and citations",
        "points": 15,
        "levels": [
          {"level": "Excellent", "description": "Perfect format and citations", "points": 14-15},
          {"level": "Good", "description": "Minor format issues", "points": 12-13},
          {"level": "Satisfactory", "description": "Basic format followed", "points": 10-11},
          {"level": "Needs Improvement", "description": "Poor or missing format", "points": 0-9}
        ]
      }
    ],
    "submission_history": [
      {
        "date": "2024-12-12",
        "action": "Assignment created",
        "description": "Assignment posted by Ms. Johnson"
      },
      {
        "date": "2024-12-13",
        "action": "Materials accessed",
        "description": "Student viewed poem and guidelines"
      }
    ]
  };

  void _startAssignment() {
    // navigateTo(ElaAssignmentSubmissionView(assignment: assignment))
  }

  void _downloadMaterial(Map<String, dynamic> material) {
    ss("Downloading ${material["title"]}...");
  }

  void _askQuestion() {
    // navigateTo(AssignmentQuestionsView(assignment: assignment))
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

  IconData _getMaterialIcon(String type) {
    switch (type) {
      case "video":
        return Icons.play_circle;
      case "document":
        return Icons.description;
      case "text":
        return Icons.article;
      default:
        return Icons.attach_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assignment Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => _askQuestion(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Assignment header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                      Expanded(
                        child: Text(
                          "${assignment["title"]}",
                          style: TextStyle(
                            fontSize: fsH4,
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
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "${assignment["description"]}",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${assignment["teacher"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Icon(
                        Icons.class_,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${assignment["class"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Assignment details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Assignment Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          "Type",
                          "${assignment["type"]}",
                          Icons.assignment,
                        ),
                      ),
                      Expanded(
                        child: _buildDetailItem(
                          "Points",
                          "${assignment["points"]}",
                          Icons.star,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          "Due Date",
                          DateTime.parse(assignment["due_date"]).dMMMy,
                          Icons.calendar_today,
                        ),
                      ),
                      Expanded(
                        child: _buildDetailItem(
                          "Est. Time",
                          "${assignment["estimated_time"]}",
                          Icons.schedule,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          "Difficulty",
                          "${assignment["difficulty"]}",
                          Icons.trending_up,
                        ),
                      ),
                      Expanded(
                        child: _buildDetailItem(
                          "Submission",
                          "${assignment["submission_type"]}",
                          Icons.upload,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Instructions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Instructions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${assignment["instructions"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Materials
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Materials & Resources",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...(assignment["materials"] as List<Map<String, dynamic>>).map((material) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _getMaterialIcon(material["type"]),
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${material["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${material["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _downloadMaterial(material),
                            child: Icon(
                              Icons.download,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Rubric
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Grading Rubric",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...(assignment["rubric"] as List<Map<String, dynamic>>).map((criteria) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${criteria["criteria"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${criteria["points"]} pts",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${criteria["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Action button
            Container(
              width: double.infinity,
              child: QButton(
                label: assignment["status"] == "Submitted" ? "View Submission" : "Start Assignment",
                size: bs.md,
                onPressed: () => _startAssignment(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: disabledBoldColor,
              size: 16,
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
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
