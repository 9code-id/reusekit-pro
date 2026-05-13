import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaSafetyMeetingsView extends StatefulWidget {
  const ComaSafetyMeetingsView({Key? key}) : super(key: key);

  @override
  State<ComaSafetyMeetingsView> createState() => _ComaSafetyMeetingsViewState();
}

class _ComaSafetyMeetingsViewState extends State<ComaSafetyMeetingsView> {
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
    {"label": "Cancelled", "value": "cancelled"},
    {"label": "Postponed", "value": "postponed"},
  ];

  List<Map<String, dynamic>> typeFilters = [
    {"label": "All Types", "value": "all"},
    {"label": "Toolbox Talk", "value": "toolbox_talk"},
    {"label": "Safety Briefing", "value": "safety_briefing"},
    {"label": "Emergency Drill", "value": "emergency_drill"},
    {"label": "Incident Review", "value": "incident_review"},
    {"label": "Training Session", "value": "training_session"},
    {"label": "Safety Committee", "value": "safety_committee"},
  ];

  List<Map<String, dynamic>> priorityFilters = [
    {"label": "All Priority", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> safetyMeetings = [
    {
      "id": "MTG-001",
      "meeting_code": "TB-2024-001",
      "title": "Daily Toolbox Talk - Fall Protection",
      "type": "toolbox_talk",
      "description": "Daily safety meeting focusing on fall protection requirements and best practices",
      "priority": "high",
      "status": "completed",
      "facilitator": "Michael Rodriguez",
      "facilitator_id": "EMP-001",
      "facilitator_certification": "Safety Officer Level II",
      "scheduled_date": "2024-06-20",
      "start_time": "07:00",
      "end_time": "07:30",
      "duration_minutes": 30,
      "location": "Site Trailer Conference Room",
      "project_id": "PROJ-001",
      "project_name": "Metro Downtown Complex",
      "attendees_required": 15,
      "attendees_present": 13,
      "attendees_absent": 2,
      "attendance_rate": 87,
      "agenda_items": [
        {
          "item": "Review yesterday's incidents",
          "duration": 5,
          "presenter": "Michael Rodriguez"
        },
        {
          "item": "Fall protection equipment inspection",
          "duration": 10,
          "presenter": "Safety Team"
        },
        {
          "item": "New safety procedures update",
          "duration": 10,
          "presenter": "Michael Rodriguez"
        },
        {
          "item": "Q&A session",
          "duration": 5,
          "presenter": "All"
        }
      ],
      "topics_covered": [
        "Fall protection equipment usage",
        "Guardrail inspection procedures",
        "Personal fall arrest systems",
        "Ladder safety guidelines",
        "Weather-related safety considerations"
      ],
      "safety_concerns_raised": [
        {
          "concern": "Wet surfaces causing slip hazards",
          "raised_by": "John Smith",
          "response": "Increase caution signage and provide slip-resistant mats",
          "action_taken": true
        },
        {
          "concern": "Inadequate lighting in stairwells",
          "raised_by": "Sarah Johnson",
          "response": "Schedule additional lighting installation",
          "action_taken": false
        }
      ],
      "action_items": [
        {
          "action": "Install additional safety signage",
          "assigned_to": "Safety Team",
          "due_date": "2024-06-21",
          "status": "completed"
        },
        {
          "action": "Schedule lighting assessment",
          "assigned_to": "Electrical Team",
          "due_date": "2024-06-22",
          "status": "pending"
        }
      ],
      "meeting_materials": [
        "Fall protection checklist",
        "Equipment inspection forms",
        "Safety procedure updates"
      ],
      "effectiveness_rating": 4.5,
      "participant_feedback": [
        {
          "participant": "John Smith",
          "rating": 5,
          "comment": "Very informative session on fall protection"
        },
        {
          "participant": "Sarah Johnson",
          "rating": 4,
          "comment": "Good discussion on safety procedures"
        }
      ],
      "follow_up_meeting": "2024-06-21",
      "meeting_notes": "Excellent participation and engagement from team members",
      "attachments": ["toolbox_talk_checklist.pdf", "safety_photos.zip"]
    },
    {
      "id": "MTG-002",
      "meeting_code": "ED-2024-002",
      "title": "Emergency Evacuation Drill",
      "type": "emergency_drill",
      "description": "Monthly emergency evacuation drill to test response procedures and timing",
      "priority": "critical",
      "status": "scheduled",
      "facilitator": "Sarah Thompson",
      "facilitator_id": "EMP-002",
      "facilitator_certification": "Emergency Response Coordinator",
      "scheduled_date": "2024-06-25",
      "start_time": "10:00",
      "end_time": "11:00",
      "duration_minutes": 60,
      "location": "Entire Construction Site",
      "project_id": "PROJ-001",
      "project_name": "Metro Downtown Complex",
      "attendees_required": 45,
      "attendees_present": null,
      "attendees_absent": null,
      "attendance_rate": null,
      "agenda_items": [
        {
          "item": "Pre-drill safety briefing",
          "duration": 15,
          "presenter": "Sarah Thompson"
        },
        {
          "item": "Evacuation drill execution",
          "duration": 30,
          "presenter": "Emergency Team"
        },
        {
          "item": "Post-drill assessment",
          "duration": 15,
          "presenter": "Sarah Thompson"
        }
      ],
      "topics_covered": [
        "Emergency alarm procedures",
        "Evacuation routes and assembly points",
        "Emergency equipment locations",
        "Communication protocols",
        "Head count procedures"
      ],
      "safety_concerns_raised": [],
      "action_items": [
        {
          "action": "Test emergency alarm systems",
          "assigned_to": "Facilities Team",
          "due_date": "2024-06-24",
          "status": "pending"
        },
        {
          "action": "Update evacuation route signage",
          "assigned_to": "Safety Team",
          "due_date": "2024-06-24",
          "status": "pending"
        }
      ],
      "meeting_materials": [
        "Emergency response procedures",
        "Evacuation route maps",
        "Emergency contact list"
      ],
      "effectiveness_rating": null,
      "participant_feedback": [],
      "follow_up_meeting": "2024-06-26",
      "meeting_notes": null,
      "attachments": ["emergency_procedures.pdf", "evacuation_map.pdf"]
    },
    {
      "id": "MTG-003",
      "meeting_code": "SC-2024-003",
      "title": "Monthly Safety Committee Meeting",
      "type": "safety_committee",
      "description": "Monthly safety committee meeting to review incidents, policies, and safety performance",
      "priority": "medium",
      "status": "in_progress",
      "facilitator": "James Wilson",
      "facilitator_id": "EMP-003",
      "facilitator_certification": "Safety Committee Chairman",
      "scheduled_date": "2024-06-21",
      "start_time": "14:00",
      "end_time": "16:00",
      "duration_minutes": 120,
      "location": "Main Office Conference Room",
      "project_id": "PROJ-ALL",
      "project_name": "All Projects",
      "attendees_required": 8,
      "attendees_present": 6,
      "attendees_absent": 2,
      "attendance_rate": 75,
      "agenda_items": [
        {
          "item": "Review of monthly safety statistics",
          "duration": 30,
          "presenter": "Safety Manager"
        },
        {
          "item": "Incident investigation reports",
          "duration": 45,
          "presenter": "Investigation Team"
        },
        {
          "item": "Policy updates and revisions",
          "duration": 30,
          "presenter": "HR Representative"
        },
        {
          "item": "Budget allocation for safety improvements",
          "duration": 15,
          "presenter": "Finance Manager"
        }
      ],
      "topics_covered": [
        "Monthly incident analysis",
        "Safety training effectiveness",
        "Budget allocation for safety programs",
        "Regulatory compliance updates",
        "Best practices sharing"
      ],
      "safety_concerns_raised": [
        {
          "concern": "Increasing near-miss incidents in Zone A",
          "raised_by": "Safety Manager",
          "response": "Implement additional safety measures and increased supervision",
          "action_taken": false
        }
      ],
      "action_items": [
        {
          "action": "Develop enhanced safety protocols for Zone A",
          "assigned_to": "Safety Team",
          "due_date": "2024-06-28",
          "status": "in_progress"
        },
        {
          "action": "Schedule additional safety training sessions",
          "assigned_to": "Training Coordinator",
          "due_date": "2024-07-05",
          "status": "pending"
        }
      ],
      "meeting_materials": [
        "Monthly safety report",
        "Incident statistics",
        "Budget proposals",
        "Policy draft documents"
      ],
      "effectiveness_rating": 4.0,
      "participant_feedback": [],
      "follow_up_meeting": "2024-07-21",
      "meeting_notes": "Committee discussed increased safety measures and budget allocations",
      "attachments": ["safety_statistics.pdf", "incident_reports.pdf"]
    },
    {
      "id": "MTG-004",
      "meeting_code": "IR-2024-004",
      "title": "Incident Review Meeting - Near Miss Analysis",
      "type": "incident_review",
      "description": "Review of recent near-miss incident and development of preventive measures",
      "priority": "high",
      "status": "postponed",
      "facilitator": "Maria Garcia",
      "facilitator_id": "EMP-004",
      "facilitator_certification": "Incident Investigation Specialist",
      "scheduled_date": "2024-06-19",
      "start_time": "09:00",
      "end_time": "11:00",
      "duration_minutes": 120,
      "location": "Site Office Meeting Room",
      "project_id": "PROJ-002",
      "project_name": "Healthcare Facility Expansion",
      "attendees_required": 10,
      "attendees_present": null,
      "attendees_absent": null,
      "attendance_rate": null,
      "agenda_items": [
        {
          "item": "Incident details review",
          "duration": 30,
          "presenter": "Investigation Team"
        },
        {
          "item": "Root cause analysis",
          "duration": 45,
          "presenter": "Safety Engineer"
        },
        {
          "item": "Corrective action development",
          "duration": 30,
          "presenter": "Safety Committee"
        },
        {
          "item": "Prevention strategy implementation",
          "duration": 15,
          "presenter": "Project Manager"
        }
      ],
      "topics_covered": [
        "Incident timeline and facts",
        "Contributing factors analysis",
        "Equipment and procedure evaluation",
        "Training gap identification",
        "Systemic improvement opportunities"
      ],
      "safety_concerns_raised": [],
      "action_items": [
        {
          "action": "Complete incident investigation report",
          "assigned_to": "Investigation Team",
          "due_date": "2024-06-22",
          "status": "pending"
        },
        {
          "action": "Develop revised safety procedures",
          "assigned_to": "Safety Team",
          "due_date": "2024-06-25",
          "status": "pending"
        }
      ],
      "meeting_materials": [
        "Incident report forms",
        "Photo evidence",
        "Witness statements",
        "Equipment inspection records"
      ],
      "effectiveness_rating": null,
      "participant_feedback": [],
      "follow_up_meeting": "2024-06-26",
      "meeting_notes": "Meeting postponed due to incomplete investigation",
      "attachments": ["incident_photos.zip", "preliminary_report.pdf"]
    },
    {
      "id": "MTG-005",
      "meeting_code": "TS-2024-005",
      "title": "Confined Space Entry Training Session",
      "type": "training_session",
      "description": "Specialized training session on confined space entry procedures and safety protocols",
      "priority": "high",
      "status": "cancelled",
      "facilitator": "David Chen",
      "facilitator_id": "EMP-005",
      "facilitator_certification": "Confined Space Instructor",
      "scheduled_date": "2024-06-18",
      "start_time": "08:00",
      "end_time": "17:00",
      "duration_minutes": 480,
      "location": "Training Facility - Room C",
      "project_id": "PROJ-003",
      "project_name": "Residential Tower A",
      "attendees_required": 12,
      "attendees_present": null,
      "attendees_absent": null,
      "attendance_rate": null,
      "agenda_items": [
        {
          "item": "Confined space regulations overview",
          "duration": 60,
          "presenter": "David Chen"
        },
        {
          "item": "Atmospheric testing procedures",
          "duration": 120,
          "presenter": "Safety Technician"
        },
        {
          "item": "Entry procedures and permits",
          "duration": 180,
          "presenter": "David Chen"
        },
        {
          "item": "Emergency rescue procedures",
          "duration": 120,
          "presenter": "Emergency Response Team"
        }
      ],
      "topics_covered": [
        "Confined space identification",
        "Atmospheric monitoring",
        "Entry permit systems",
        "Personal protective equipment",
        "Emergency response procedures"
      ],
      "safety_concerns_raised": [],
      "action_items": [
        {
          "action": "Reschedule training session",
          "assigned_to": "Training Coordinator",
          "due_date": "2024-06-22",
          "status": "pending"
        },
        {
          "action": "Notify all registered participants",
          "assigned_to": "Administrative Assistant",
          "due_date": "2024-06-18",
          "status": "completed"
        }
      ],
      "meeting_materials": [
        "Confined space training manual",
        "Atmospheric testing equipment",
        "Emergency rescue equipment",
        "Permit forms and procedures"
      ],
      "effectiveness_rating": null,
      "participant_feedback": [],
      "follow_up_meeting": null,
      "meeting_notes": "Session cancelled due to equipment malfunction",
      "attachments": ["training_manual.pdf", "equipment_checklist.pdf"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Safety Meetings"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _scheduleMeeting(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.calendar_today,
            size: bs.sm,
            onPressed: () => _viewMeetingCalendar(),
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
                  _buildMeetingOverview(),
                  _buildFilters(),
                  _buildMeetingMetrics(),
                  _buildUpcomingMeetings(),
                  _buildMeetingsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildMeetingOverview() {
    int totalMeetings = safetyMeetings.length;
    int completedMeetings = safetyMeetings.where((m) => m["status"] == "completed").length;
    int scheduledMeetings = safetyMeetings.where((m) => m["status"] == "scheduled").length;
    int cancelledMeetings = safetyMeetings.where((m) => m["status"] == "cancelled").length;

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
                child: Icon(Icons.groups, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Safety Meetings Overview",
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
              _buildOverviewCard("Total", "$totalMeetings", Icons.event, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Completed", "$completedMeetings", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Scheduled", "$scheduledMeetings", Icons.schedule, infoColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Cancelled", "$cancelledMeetings", Icons.cancel, dangerColor),
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
                  label: "Search meetings...",
                  value: searchQuery,
                  hint: "Search by title, facilitator, or type",
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

  Widget _buildMeetingMetrics() {
    List<Map<String, dynamic>> completedMeetings = safetyMeetings
        .where((m) => m["status"] == "completed" && m["attendance_rate"] != null)
        .toList();
    
    double avgAttendance = completedMeetings.isEmpty ? 0 : 
        completedMeetings.fold(0.0, (sum, m) => sum + (m["attendance_rate"] as int)) / completedMeetings.length;
    
    double avgEffectiveness = completedMeetings
        .where((m) => m["effectiveness_rating"] != null)
        .fold(0.0, (sum, m) => sum + (m["effectiveness_rating"] as double)) / 
        completedMeetings.where((m) => m["effectiveness_rating"] != null).length;
    
    int totalActionItems = safetyMeetings.fold(0, (sum, m) => sum + (m["action_items"] as List).length);

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
            "Meeting Performance Metrics",
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
                      Icon(Icons.people, color: successColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "${avgAttendance.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Avg Attendance",
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
                      Icon(Icons.star, color: infoColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "${avgEffectiveness.toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Effectiveness",
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
                      Icon(Icons.assignment, color: warningColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "$totalActionItems",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Action Items",
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

  Widget _buildUpcomingMeetings() {
    List<Map<String, dynamic>> upcomingMeetings = safetyMeetings
        .where((m) => m["status"] == "scheduled" || m["status"] == "in_progress")
        .toList();

    if (upcomingMeetings.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Upcoming Meetings",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          height: 140,
          child: QHorizontalScroll(
            children: upcomingMeetings.map((meeting) => Container(
              width: 280,
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    color: _getStatusColor(meeting["status"]),
                    width: 4,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${meeting["title"]}",
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
                      Icon(Icons.person, color: disabledBoldColor, size: 12),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${meeting["facilitator"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: disabledBoldColor, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "${meeting["scheduled_date"]} ${meeting["start_time"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: disabledBoldColor, size: 12),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${meeting["location"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                          overflow: TextOverflow.ellipsis,
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
                          color: _getStatusColor(meeting["status"]).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${meeting["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 8,
                            color: _getStatusColor(meeting["status"]),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${meeting["duration_minutes"]} min",
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

  Widget _buildMeetingsList() {
    List<Map<String, dynamic>> filteredMeetings = _getFilteredMeetings();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Safety Meetings (${filteredMeetings.length})",
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
        ...filteredMeetings.map((meeting) => _buildMeetingCard(meeting)),
      ],
    );
  }

  Widget _buildMeetingCard(Map<String, dynamic> meeting) {
    Color statusColor = _getStatusColor(meeting["status"]);
    Color priorityColor = _getPriorityColor(meeting["priority"]);

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
                      "${meeting["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Code: ${meeting["meeting_code"]}",
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
                  color: priorityColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${meeting["priority"]}".toUpperCase(),
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
              Icon(Icons.person, color: primaryColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Facilitator: ${meeting["facilitator"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${meeting["status"]}".toUpperCase(),
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
                      "Date: ${meeting["scheduled_date"]}",
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
                      "${meeting["start_time"]} - ${meeting["end_time"]}",
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
                    Expanded(
                      child: Text(
                        "${meeting["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Icon(Icons.group, color: primaryColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "${meeting["attendees_required"]} required",
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
          if (meeting["attendance_rate"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.people, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Attendance: ${meeting["attendance_rate"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "Present: ${meeting["attendees_present"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                    ),
                  ),
                  Spacer(),
                  if (meeting["effectiveness_rating"] != null)
                    Row(
                      children: [
                        Icon(Icons.star, color: successColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Rating: ${meeting["effectiveness_rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          if ((meeting["topics_covered"] as List).isNotEmpty)
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
                    children: (meeting["topics_covered"] as List).take(3).map((topic) => Container(
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
          if ((meeting["action_items"] as List).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Action Items: ${(meeting["action_items"] as List).length}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                  ...(meeting["action_items"] as List).take(2).map((action) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${action["action"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: warningColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getActionStatusColor(action["status"]).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${action["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 8,
                              color: _getActionStatusColor(action["status"]),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          Row(
            children: [
              Icon(Icons.business, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Project: ${meeting["project_name"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "Duration: ${meeting["duration_minutes"]} min",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Type: ${meeting["type"]}".replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewMeetingDetails(meeting["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editMeeting(meeting["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showMeetingOptions(meeting),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredMeetings() {
    List<Map<String, dynamic>> filtered = safetyMeetings;

    if (selectedStatus != "all") {
      filtered = filtered.where((meeting) => meeting["status"] == selectedStatus).toList();
    }

    if (selectedType != "all") {
      filtered = filtered.where((meeting) => meeting["type"] == selectedType).toList();
    }

    if (selectedPriority != "all") {
      filtered = filtered.where((meeting) => meeting["priority"] == selectedPriority).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((meeting) =>
          meeting["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          meeting["facilitator"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          meeting["type"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
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
      case 'cancelled':
      case 'postponed':
        return dangerColor;
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

  Color _getActionStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in_progress':
        return infoColor;
      case 'pending':
        return warningColor;
      case 'overdue':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _scheduleMeeting() {
    ss("Schedule new safety meeting");
  }

  void _viewMeetingCalendar() {
    ss("View meeting calendar");
  }

  void _showSortOptions() {
    ss("Meeting sort options");
  }

  void _viewMeetingDetails(String meetingId) {
    ss("Viewing meeting details $meetingId");
  }

  void _editMeeting(String meetingId) {
    ss("Editing meeting $meetingId");
  }

  void _showMeetingOptions(Map<String, dynamic> meeting) {
    ss("Meeting options for ${meeting["title"]}");
  }
}
