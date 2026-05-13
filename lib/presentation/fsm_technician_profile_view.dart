import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmTechnicianProfileView extends StatefulWidget {
  const FsmTechnicianProfileView({super.key});

  @override
  State<FsmTechnicianProfileView> createState() => _FsmTechnicianProfileViewState();
}

class _FsmTechnicianProfileViewState extends State<FsmTechnicianProfileView> {
  bool loading = false;
  int currentTab = 0;

  Map<String, dynamic> technician = {
    "id": "TECH-001",
    "name": "John Smith",
    "email": "john.smith@company.com",
    "phone": "+1-555-0101",
    "emergencyContact": "+1-555-9101",
    "department": "IT Support",
    "status": "Active",
    "availability": "Available",
    "employeeId": "EMP-001",
    "location": "New York, NY",
    "address": "123 Tech Street, New York, NY 10001",
    "profileImage": "https://picsum.photos/200/200?random=1",
    "hireDate": "2020-01-15",
    "experienceYears": 8,
    "hourlyRate": 75.0,
    "overtimeRate": 112.50,
    "supervisor": "Mike Johnson",
    "workingHours": "9:00 AM - 5:00 PM",
    "nextAvailableSlot": "Today 2:00 PM",
    "responseTime": "< 30 min",
    "specializationArea": "Network Infrastructure",
    "performanceScore": 95,
    "averageRating": 4.8,
    "totalJobs": 142,
    "currentJobs": 3,
    "completedJobs": 139,
    "lastActiveDate": "2024-06-19",
    "joinDate": "2020-01-15",
    "skills": [
      {"name": "Network Administration", "level": "Expert", "years": 8},
      {"name": "Windows Server", "level": "Advanced", "years": 6},
      {"name": "Cisco Equipment", "level": "Expert", "years": 7},
      {"name": "Troubleshooting", "level": "Expert", "years": 8},
      {"name": "System Security", "level": "Intermediate", "years": 4},
      {"name": "Cloud Services", "level": "Advanced", "years": 3}
    ],
    "certifications": [
      {"name": "CompTIA Network+", "issuer": "CompTIA", "issueDate": "2020-03-15", "expiryDate": "2024-03-15", "status": "Valid"},
      {"name": "Microsoft MCSA", "issuer": "Microsoft", "issueDate": "2021-06-10", "expiryDate": "2025-06-10", "status": "Valid"},
      {"name": "Cisco CCNA", "issuer": "Cisco", "issueDate": "2022-01-20", "expiryDate": "2025-01-20", "status": "Valid"},
      {"name": "CompTIA Security+", "issuer": "CompTIA", "issueDate": "2023-09-15", "expiryDate": "2026-09-15", "status": "Valid"}
    ],
    "recentJobs": [
      {
        "id": "JOB-234",
        "customer": "TechCorp Industries",
        "description": "Network Infrastructure Upgrade",
        "status": "Completed",
        "date": "2024-06-18",
        "duration": "6 hours",
        "rating": 5.0,
        "feedback": "Excellent work on the network upgrade. Very professional and knowledgeable."
      },
      {
        "id": "JOB-233",
        "customer": "Global Systems Inc",
        "description": "Server Configuration",
        "status": "Completed",
        "date": "2024-06-15",
        "duration": "4 hours",
        "rating": 4.8,
        "feedback": "Great technical skills and clear communication throughout the process."
      },
      {
        "id": "JOB-232",
        "customer": "Healthcare Solutions",
        "description": "Network Security Assessment",
        "status": "In Progress",
        "date": "2024-06-19",
        "duration": "8 hours",
        "rating": null,
        "feedback": null
      }
    ],
    "performanceHistory": [
      {"month": "Jan 2024", "jobsCompleted": 12, "rating": 4.9, "revenue": 8400.0},
      {"month": "Feb 2024", "jobsCompleted": 11, "rating": 4.8, "revenue": 7700.0},
      {"month": "Mar 2024", "jobsCompleted": 13, "rating": 4.7, "revenue": 9100.0},
      {"month": "Apr 2024", "jobsCompleted": 14, "rating": 4.8, "revenue": 9800.0},
      {"month": "May 2024", "jobsCompleted": 15, "rating": 4.9, "revenue": 10500.0},
      {"month": "Jun 2024", "jobsCompleted": 8, "rating": 4.8, "revenue": 5600.0}
    ],
    "schedule": [
      {"day": "Monday", "startTime": "9:00 AM", "endTime": "5:00 PM", "status": "Available"},
      {"day": "Tuesday", "startTime": "9:00 AM", "endTime": "5:00 PM", "status": "Scheduled"},
      {"day": "Wednesday", "startTime": "9:00 AM", "endTime": "5:00 PM", "status": "Available"},
      {"day": "Thursday", "startTime": "9:00 AM", "endTime": "5:00 PM", "status": "Scheduled"},
      {"day": "Friday", "startTime": "9:00 AM", "endTime": "5:00 PM", "status": "Available"}
    ],
    "notes": [
      {"date": "2024-06-15", "author": "Mike Johnson", "note": "Excellent performance on the healthcare project. Demonstrates strong leadership skills."},
      {"date": "2024-05-20", "author": "Lisa Chen", "note": "Completed advanced networking certification. Ready for complex infrastructure projects."},
      {"date": "2024-04-10", "author": "Mike Johnson", "note": "Received positive feedback from three consecutive clients. Maintaining high service standards."}
    ]
  };

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Available":
        return successColor;
      case "Scheduled":
        return infoColor;
      case "Busy":
        return warningColor;
      case "On Leave":
        return warningColor;
      case "Unavailable":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSkillLevelColor(String level) {
    switch (level) {
      case "Expert":
        return successColor;
      case "Advanced":
        return infoColor;
      case "Intermediate":
        return warningColor;
      case "Beginner":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _editProfile() {
    ss("Edit profile functionality");
  }

  void _assignJob() {
    ss("Assign job functionality");
  }

  void _updateAvailability() {
    ss("Update availability functionality");
  }

  void _viewJobDetails(Map<String, dynamic> job) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Job Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text("Job ID: ${job["id"]}", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Customer: ${job["customer"]}"),
            Text("Description: ${job["description"]}"),
            Text("Status: ${job["status"]}"),
            Text("Date: ${job["date"]}"),
            Text("Duration: ${job["duration"]}"),
            if (job["rating"] != null) Text("Rating: ${job["rating"]}/5.0"),
            if (job["feedback"] != null) ...[
              SizedBox(height: spSm),
              Text("Customer Feedback:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("${job["feedback"]}"),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        // Profile Header
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(technician["profileImage"]),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${technician["name"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${technician["department"]} • ${technician["employeeId"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${technician["specializationArea"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(technician["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${technician["status"]}",
                                style: TextStyle(
                                  color: _getStatusColor(technician["status"]),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(technician["availability"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${technician["availability"]}",
                                style: TextStyle(
                                  color: _getStatusColor(technician["availability"]),
                                  fontSize: 12,
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
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Edit Profile",
                      size: bs.sm,
                      onPressed: _editProfile,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Assign Job",
                      size: bs.sm,
                      onPressed: _assignJob,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Update Availability",
                      size: bs.sm,
                      onPressed: _updateAvailability,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Performance Metrics
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildMetricCard("Performance Score", "${technician["performanceScore"]}%", primaryColor, Icons.trending_up),
            _buildMetricCard("Average Rating", "${technician["averageRating"]}/5.0", successColor, Icons.star),
            _buildMetricCard("Total Jobs", "${technician["totalJobs"]}", infoColor, Icons.assignment),
            _buildMetricCard("Experience", "${technician["experienceYears"]} years", warningColor, Icons.work),
          ],
        ),

        // Contact Information
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                        Text("${technician["email"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Phone", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                        Text("${technician["phone"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Emergency Contact", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                        Text("${technician["emergencyContact"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Supervisor", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                        Text("${technician["supervisor"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Address", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                  Text("${technician["address"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ),

        // Recent Jobs
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Recent Jobs",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...(technician["recentJobs"] as List).map((job) => GestureDetector(
                onTap: () => _viewJobDetails(job),
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${job["description"]}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: job["status"] == "Completed" ? successColor.withAlpha(20) : infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${job["status"]}",
                              style: TextStyle(
                                color: job["status"] == "Completed" ? successColor : infoColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${job["customer"]} • ${job["date"]}",
                        style: TextStyle(color: disabledBoldColor, fontSize: 12),
                      ),
                      if (job["rating"] != null)
                        Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 12),
                            SizedBox(width: 4),
                            Text(
                              "${job["rating"]}/5.0",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Skills & Expertise",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        ...(technician["skills"] as List).map((skill) => Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${skill["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getSkillLevelColor(skill["level"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${skill["level"]}",
                      style: TextStyle(
                        color: _getSkillLevelColor(skill["level"]),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "Experience: ${skill["years"]} years",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildCertificationsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Certifications",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        ...(technician["certifications"] as List).map((cert) => Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${cert["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${cert["status"]}",
                      style: TextStyle(
                        color: successColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "Issued by: ${cert["issuer"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Issue Date", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                        Text("${cert["issueDate"]}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Expiry Date", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
                        Text("${cert["expiryDate"]}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildScheduleTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Current Schedule",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Working Hours: ${technician["workingHours"]}",
                style: TextStyle(color: disabledBoldColor),
              ),
              Text(
                "Next Available: ${technician["nextAvailableSlot"]}",
                style: TextStyle(color: disabledBoldColor),
              ),
              Text(
                "Response Time: ${technician["responseTime"]}",
                style: TextStyle(color: disabledBoldColor),
              ),
            ],
          ),
        ),

        Text(
          "Weekly Schedule",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        ...(technician["schedule"] as List).map((schedule) => Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "${schedule["day"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "${schedule["startTime"]} - ${schedule["endTime"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(schedule["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${schedule["status"]}",
                  style: TextStyle(
                    color: _getStatusColor(schedule["status"]),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Technician Profile"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return QTabBar(
      title: technician["name"],
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.person)),
        Tab(text: "Skills", icon: Icon(Icons.build)),
        Tab(text: "Certifications", icon: Icon(Icons.verified)),
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildOverviewTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildSkillsTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildCertificationsTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildScheduleTab(),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, Color color, IconData icon) {
    return Container(
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
