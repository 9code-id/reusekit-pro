import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaSafetyTrainingView extends StatefulWidget {
  const ComaSafetyTrainingView({Key? key}) : super(key: key);

  @override
  State<ComaSafetyTrainingView> createState() => _ComaSafetyTrainingViewState();
}

class _ComaSafetyTrainingViewState extends State<ComaSafetyTrainingView> {
  String selectedStatus = "all";
  String selectedType = "all";
  String selectedPriority = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Overdue", "value": "overdue"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> typeFilters = [
    {"label": "All Types", "value": "all"},
    {"label": "OSHA 10", "value": "osha_10"},
    {"label": "OSHA 30", "value": "osha_30"},
    {"label": "Fall Protection", "value": "fall_protection"},
    {"label": "Electrical Safety", "value": "electrical_safety"},
    {"label": "Confined Space", "value": "confined_space"},
    {"label": "Hazmat", "value": "hazmat"},
  ];

  List<Map<String, dynamic>> priorityFilters = [
    {"label": "All Priority", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> trainingPrograms = [
    {
      "id": "TRAIN-001",
      "title": "OSHA 10-Hour Construction Safety",
      "type": "osha_10",
      "description": "Comprehensive safety training for construction workers covering hazard recognition and safety standards",
      "instructor": "John Martinez",
      "instructor_id": "INST-001",
      "instructor_image": "https://picsum.photos/100/100?random=1&keyword=instructor",
      "duration": 10,
      "duration_unit": "hours",
      "max_participants": 25,
      "enrolled_count": 18,
      "location": "Training Room A",
      "scheduled_date": "2024-06-25",
      "start_time": "08:00",
      "end_time": "17:00",
      "status": "scheduled",
      "priority": "high",
      "cost_per_person": 150.00,
      "total_cost": 2700.00,
      "prerequisites": ["Basic Safety Orientation"],
      "certification_type": "OSHA 10-Hour Card",
      "certification_validity": 3,
      "materials_required": [
        "Safety manual",
        "Personal protective equipment",
        "Training workbook"
      ],
      "topics_covered": [
        "Introduction to OSHA",
        "Fall Protection",
        "Electrical Safety",
        "Personal Protective Equipment",
        "Hazard Communication",
        "Scaffolding Safety",
        "Crane and Rigging Safety"
      ],
      "participants": [
        {
          "employee_id": "EMP-001",
          "name": "Michael Rodriguez",
          "position": "Electrician",
          "enrollment_date": "2024-06-15",
          "completion_status": "enrolled",
          "progress": 0
        },
        {
          "employee_id": "EMP-002",
          "name": "Sarah Thompson",
          "position": "Plumber",
          "enrollment_date": "2024-06-16",
          "completion_status": "enrolled",
          "progress": 0
        }
      ],
      "requirements": {
        "minimum_score": 80,
        "attendance_required": 100,
        "practical_assessment": true,
        "written_exam": true
      }
    },
    {
      "id": "TRAIN-002",
      "title": "Fall Protection Certification",
      "type": "fall_protection",
      "description": "Specialized training on fall protection systems, equipment inspection, and rescue procedures",
      "instructor": "Lisa Chen",
      "instructor_id": "INST-002",
      "instructor_image": "https://picsum.photos/100/100?random=2&keyword=instructor",
      "duration": 8,
      "duration_unit": "hours",
      "max_participants": 15,
      "enrolled_count": 12,
      "location": "Outdoor Training Facility",
      "scheduled_date": "2024-06-28",
      "start_time": "07:30",
      "end_time": "16:30",
      "status": "in_progress",
      "priority": "critical",
      "cost_per_person": 200.00,
      "total_cost": 2400.00,
      "prerequisites": ["OSHA 10-Hour", "Basic Safety Orientation"],
      "certification_type": "Fall Protection Competent Person",
      "certification_validity": 2,
      "materials_required": [
        "Full body harness",
        "Safety lanyard",
        "Hard hat",
        "Safety glasses"
      ],
      "topics_covered": [
        "Fall Protection Systems",
        "Equipment Inspection",
        "Anchor Point Selection",
        "Rescue Procedures",
        "OSHA Fall Protection Standards"
      ],
      "participants": [
        {
          "employee_id": "EMP-003",
          "name": "James Wilson",
          "position": "Foreman",
          "enrollment_date": "2024-06-20",
          "completion_status": "in_progress",
          "progress": 65
        },
        {
          "employee_id": "EMP-004",
          "name": "Maria Garcia",
          "position": "Carpenter",
          "enrollment_date": "2024-06-21",
          "completion_status": "in_progress",
          "progress": 58
        }
      ],
      "requirements": {
        "minimum_score": 85,
        "attendance_required": 100,
        "practical_assessment": true,
        "written_exam": true
      }
    },
    {
      "id": "TRAIN-003",
      "title": "Electrical Safety for Construction",
      "type": "electrical_safety",
      "description": "Comprehensive electrical safety training covering lockout/tagout, electrical hazards, and safe work practices",
      "instructor": "Robert Kim",
      "instructor_id": "INST-003",
      "instructor_image": "https://picsum.photos/100/100?random=3&keyword=instructor",
      "duration": 6,
      "duration_unit": "hours",
      "max_participants": 20,
      "enrolled_count": 20,
      "location": "Training Room B",
      "scheduled_date": "2024-06-22",
      "start_time": "08:00",
      "end_time": "15:00",
      "status": "completed",
      "priority": "high",
      "cost_per_person": 175.00,
      "total_cost": 3500.00,
      "prerequisites": ["Basic Safety Orientation"],
      "certification_type": "Electrical Safety Certified",
      "certification_validity": 3,
      "materials_required": [
        "Electrical safety manual",
        "Voltage detector",
        "Insulated gloves",
        "Arc flash calculator"
      ],
      "topics_covered": [
        "Electrical Hazards",
        "Lockout/Tagout Procedures",
        "Arc Flash Protection",
        "Ground Fault Protection",
        "Electrical PPE Requirements"
      ],
      "participants": [
        {
          "employee_id": "EMP-005",
          "name": "David Chen",
          "position": "Electrician",
          "enrollment_date": "2024-06-10",
          "completion_status": "completed",
          "progress": 100
        },
        {
          "employee_id": "EMP-006",
          "name": "Amanda Foster",
          "position": "Supervisor",
          "enrollment_date": "2024-06-12",
          "completion_status": "completed",
          "progress": 100
        }
      ],
      "requirements": {
        "minimum_score": 80,
        "attendance_required": 100,
        "practical_assessment": true,
        "written_exam": true
      }
    },
    {
      "id": "TRAIN-004",
      "title": "Confined Space Entry Training",
      "type": "confined_space",
      "description": "Training on confined space entry procedures, atmospheric testing, and emergency rescue",
      "instructor": "Patricia Adams",
      "instructor_id": "INST-004",
      "instructor_image": "https://picsum.photos/100/100?random=4&keyword=instructor",
      "duration": 12,
      "duration_unit": "hours",
      "max_participants": 12,
      "enrolled_count": 8,
      "location": "Specialized Training Facility",
      "scheduled_date": "2024-07-05",
      "start_time": "07:00",
      "end_time": "19:00",
      "status": "scheduled",
      "priority": "critical",
      "cost_per_person": 300.00,
      "total_cost": 2400.00,
      "prerequisites": ["OSHA 10-Hour", "Respiratory Protection"],
      "certification_type": "Confined Space Entrant/Attendant",
      "certification_validity": 1,
      "materials_required": [
        "Gas detector",
        "Rescue equipment",
        "Communication devices",
        "Emergency response kit"
      ],
      "topics_covered": [
        "Confined Space Identification",
        "Atmospheric Testing",
        "Entry Procedures",
        "Emergency Rescue",
        "Communication Systems"
      ],
      "participants": [
        {
          "employee_id": "EMP-007",
          "name": "Kevin Johnson",
          "position": "Maintenance Tech",
          "enrollment_date": "2024-06-25",
          "completion_status": "enrolled",
          "progress": 0
        }
      ],
      "requirements": {
        "minimum_score": 90,
        "attendance_required": 100,
        "practical_assessment": true,
        "written_exam": true
      }
    },
    {
      "id": "TRAIN-005",
      "title": "Hazmat Safety Refresher",
      "type": "hazmat",
      "description": "Annual refresher training for hazardous materials handling and emergency response",
      "instructor": "Steven Lee",
      "instructor_id": "INST-005",
      "instructor_image": "https://picsum.photos/100/100?random=5&keyword=instructor",
      "duration": 4,
      "duration_unit": "hours",
      "max_participants": 30,
      "enrolled_count": 5,
      "location": "Conference Room C",
      "scheduled_date": "2024-06-18",
      "start_time": "13:00",
      "end_time": "17:00",
      "status": "overdue",
      "priority": "medium",
      "cost_per_person": 100.00,
      "total_cost": 500.00,
      "prerequisites": ["Initial Hazmat Training"],
      "certification_type": "Hazmat Handler Refresher",
      "certification_validity": 1,
      "materials_required": [
        "Updated safety data sheets",
        "Emergency response guide",
        "Personal protective equipment"
      ],
      "topics_covered": [
        "Material Classification",
        "Storage Requirements",
        "Spill Response",
        "Personal Protection",
        "Emergency Procedures"
      ],
      "participants": [
        {
          "employee_id": "EMP-008",
          "name": "Rebecca Martinez",
          "position": "Safety Coordinator",
          "enrollment_date": "2024-06-01",
          "completion_status": "enrolled",
          "progress": 25
        }
      ],
      "requirements": {
        "minimum_score": 75,
        "attendance_required": 100,
        "practical_assessment": false,
        "written_exam": true
      }
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Safety Training"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _createTraining(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.calendar_today,
            size: bs.sm,
            onPressed: () => _viewTrainingCalendar(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildTrainingOverview(),
                  _buildFilters(),
                  _buildTrainingMetrics(),
                  _buildUpcomingTrainings(),
                  _buildTrainingsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildTrainingOverview() {
    int totalTrainings = trainingPrograms.length;
    int scheduledTrainings = trainingPrograms.where((t) => t["status"] == "scheduled").length;
    int completedTrainings = trainingPrograms.where((t) => t["status"] == "completed").length;
    int overdueTrainings = trainingPrograms.where((t) => t["status"] == "overdue").length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.school, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Safety Training Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildOverviewCard("Total Programs", "$totalTrainings", Icons.list_alt, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Scheduled", "$scheduledTrainings", Icons.schedule, infoColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Completed", "$completedTrainings", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Overdue", "$overdueTrainings", Icons.warning, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: disabledBoldColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Search trainings...",
                  value: searchQuery,
                  hint: "Search by title, instructor, or type",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusFilters,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeFilters,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: priorityFilters,
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
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

  Widget _buildTrainingMetrics() {
    double totalCost = trainingPrograms.fold(0.0, (sum, t) => sum + (t["total_cost"] as double));
    int totalParticipants = trainingPrograms.fold(0, (sum, t) => sum + (t["enrolled_count"] as int));
    double avgDuration = trainingPrograms.fold(0.0, (sum, t) => sum + (t["duration"] as int)) / trainingPrograms.length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Training Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.attach_money, color: successColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalCost.currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Cost",
                        style: TextStyle(
                          fontSize: 10,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.people, color: infoColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "$totalParticipants",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Participants",
                        style: TextStyle(
                          fontSize: 10,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.access_time, color: warningColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "${avgDuration.toStringAsFixed(1)}h",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Avg Duration",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingTrainings() {
    List<Map<String, dynamic>> upcomingTrainings = trainingPrograms
        .where((t) => t["status"] == "scheduled" || t["status"] == "in_progress")
        .toList();

    if (upcomingTrainings.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Upcoming Trainings",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          height: 120,
          child: QHorizontalScroll(
            children: upcomingTrainings.map((training) => Container(
              width: 250,
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    color: _getStatusColor(training["status"]),
                    width: 4,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${training["title"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: disabledBoldColor, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "${training["scheduled_date"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: disabledBoldColor, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "${training["start_time"]} - ${training["end_time"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor(training["status"]).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${training["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 8,
                            color: _getStatusColor(training["status"]),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${training["enrolled_count"]}/${training["max_participants"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTrainingsList() {
    List<Map<String, dynamic>> filteredTrainings = _getFilteredTrainings();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Training Programs (${filteredTrainings.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.sort,
              size: bs.sm,
              onPressed: () => _showSortOptions(),
            ),
          ],
        ),
        ...filteredTrainings.map((training) => _buildTrainingCard(training)),
      ],
    );
  }

  Widget _buildTrainingCard(Map<String, dynamic> training) {
    Color statusColor = _getStatusColor(training["status"]);
    Color priorityColor = _getPriorityColor(training["priority"]);

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: statusColor,
            width: 4,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${training["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${training["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${training["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: priorityColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${training["instructor_image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Instructor: ${training["instructor"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Duration: ${training["duration"]} ${training["duration_unit"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${training["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: primaryColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "Date: ${training["scheduled_date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.access_time, color: primaryColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "${training["start_time"]} - ${training["end_time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: primaryColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "${training["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.people, color: primaryColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "${training["enrolled_count"]}/${training["max_participants"]} enrolled",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.attach_money, color: successColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Cost: \$${(training["cost_per_person"] as double).currency}/person",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "Total: \$${(training["total_cost"] as double).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if ((training["topics_covered"] as List).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Topics Covered:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (training["topics_covered"] as List).take(3).map((topic) => Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$topic",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Certification: ${training["certification_type"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewTrainingDetails(training["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editTraining(training["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showTrainingOptions(training),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredTrainings() {
    List<Map<String, dynamic>> filtered = trainingPrograms;

    if (selectedStatus != "all") {
      filtered = filtered.where((training) => training["status"] == selectedStatus).toList();
    }

    if (selectedType != "all") {
      filtered = filtered.where((training) => training["type"] == selectedType).toList();
    }

    if (selectedPriority != "all") {
      filtered = filtered.where((training) => training["priority"] == selectedPriority).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((training) =>
          training["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          training["instructor"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          training["type"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in_progress':
        return infoColor;
      case 'scheduled':
        return warningColor;
      case 'overdue':
        return dangerColor;
      case 'cancelled':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _createTraining() {
    ss("Create new training program");
  }

  void _viewTrainingCalendar() {
    ss("View training calendar");
  }

  void _showSortOptions() {
    ss("Training sort options");
  }

  void _viewTrainingDetails(String trainingId) {
    ss("Viewing training details $trainingId");
  }

  void _editTraining(String trainingId) {
    ss("Editing training $trainingId");
  }

  void _showTrainingOptions(Map<String, dynamic> training) {
    ss("Training options for ${training["title"]}");
  }
}
