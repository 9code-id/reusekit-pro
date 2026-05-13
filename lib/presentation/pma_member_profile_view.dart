import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaMemberProfileView extends StatefulWidget {
  const PmaMemberProfileView({super.key});

  @override
  State<PmaMemberProfileView> createState() => _PmaMemberProfileViewState();
}

class _PmaMemberProfileViewState extends State<PmaMemberProfileView> {
  int currentTab = 0;

  Map<String, dynamic> member = {
    "id": 1,
    "name": "Sarah Wilson",
    "email": "sarah.wilson@company.com",
    "avatar": "https://i.pravatar.cc/150?img=1",
    "role": "Team Lead",
    "department": "Engineering",
    "team": "Frontend Development",
    "employeeId": "EMP-001",
    "status": "active",
    "joinDate": "2023-01-15",
    "phone": "+1 (555) 123-4567",
    "location": "New York, NY",
    "address": "123 Main Street, New York, NY 10001",
    "dateOfBirth": "1990-05-15",
    "emergencyContact": "John Wilson - +1 (555) 987-6543",
    "salary": 85000,
    "employmentType": "Full-time",
    "workLocation": "Hybrid",
    "reportingManager": "Mike Johnson",
    "completedTasks": 24,
    "rating": 4.9,
    "performance": 95,
    "yearsOfExperience": 8,
    "previousCompany": "TechCorp Inc.",
    "education": "Master's in Computer Science",
    "certifications": "AWS Certified Solutions Architect",
  };

  List<String> skills = [
    "React", "Flutter", "JavaScript", "TypeScript", "Node.js",
    "Leadership", "Project Management", "Team Building"
  ];

  List<Map<String, dynamic>> projects = [
    {
      "name": "E-Commerce Platform",
      "role": "Lead Developer",
      "status": "In Progress",
      "progress": 75,
      "startDate": "2024-08-01",
      "endDate": "2024-12-30",
      "team": "Frontend Development",
    },
    {
      "name": "Mobile App Redesign",
      "role": "Technical Lead",
      "status": "In Progress",
      "progress": 60,
      "startDate": "2024-09-15",
      "endDate": "2025-01-15",
      "team": "Frontend Development",
    },
    {
      "name": "Admin Dashboard",
      "role": "Lead Developer",
      "status": "Completed",
      "progress": 100,
      "startDate": "2024-06-01",
      "endDate": "2024-11-30",
      "team": "Frontend Development",
    },
  ];

  List<Map<String, dynamic>> activities = [
    {
      "action": "Completed task",
      "target": "Homepage Design Review",
      "date": "2024-12-19",
      "time": "14:30",
      "type": "completion",
    },
    {
      "action": "Updated project",
      "target": "E-Commerce Platform",
      "date": "2024-12-19",
      "time": "11:15",
      "type": "update",
    },
    {
      "action": "Submitted for review",
      "target": "Mobile Navigation Component",
      "date": "2024-12-18",
      "time": "16:45",
      "type": "review",
    },
    {
      "action": "Created branch",
      "target": "feature/user-authentication",
      "date": "2024-12-18",
      "time": "09:20",
      "type": "create",
    },
    {
      "action": "Attended meeting",
      "target": "Sprint Planning",
      "date": "2024-12-17",
      "time": "10:00",
      "type": "meeting",
    },
  ];

  List<Map<String, dynamic>> performanceData = [
    {"month": "Jan", "score": 92},
    {"month": "Feb", "score": 88},
    {"month": "Mar", "score": 95},
    {"month": "Apr", "score": 90},
    {"month": "May", "score": 97},
    {"month": "Jun", "score": 94},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "${member["name"]}",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Profile", icon: Icon(Icons.person)),
        Tab(text: "Projects", icon: Icon(Icons.folder)),
        Tab(text: "Performance", icon: Icon(Icons.analytics)),
        Tab(text: "Activity", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildProfileTab(),
        _buildProjectsTab(),
        _buildPerformanceTab(),
        _buildActivityTab(),
      ],
      actions: [
        QButton(
          icon: Icons.edit,
          size: bs.sm,
          onPressed: () {
            // Navigate to edit profile
          },
        ),
        QButton(
          icon: Icons.more_vert,
          size: bs.sm,
          onPressed: () {},
        ),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage("${member["avatar"]}"),
                ),
                SizedBox(height: spMd),
                Text(
                  "${member["name"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${member["role"]} • ${member["department"]}",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "ACTIVE",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Send Message",
                        icon: Icons.message,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Call",
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QButton(
                  label: "Video Conference",
                  icon: Icons.video_call,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Tasks Completed", "${member["completedTasks"]}", Icons.task_alt, successColor),
              _buildStatCard("Rating", "${member["rating"]}", Icons.star, warningColor),
              _buildStatCard("Performance", "${member["performance"]}%", Icons.trending_up, infoColor),
              _buildStatCard("Experience", "${member["yearsOfExperience"]} years", Icons.work, primaryColor),
            ],
          ),

          SizedBox(height: spMd),

          // Personal Information
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Personal Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildInfoRow(Icons.email, "Email", "${member["email"]}"),
                _buildInfoRow(Icons.phone, "Phone", "${member["phone"]}"),
                _buildInfoRow(Icons.location_on, "Location", "${member["location"]}"),
                _buildInfoRow(Icons.home, "Address", "${member["address"]}"),
                _buildInfoRow(Icons.cake, "Date of Birth", "${DateTime.parse("${member["dateOfBirth"]}").dMMMy}"),
                _buildInfoRow(Icons.emergency, "Emergency Contact", "${member["emergencyContact"]}"),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Employment Information
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Employment Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildInfoRow(Icons.badge, "Employee ID", "${member["employeeId"]}"),
                _buildInfoRow(Icons.business, "Department", "${member["department"]}"),
                _buildInfoRow(Icons.groups, "Team", "${member["team"]}"),
                _buildInfoRow(Icons.work, "Employment Type", "${member["employmentType"]}"),
                _buildInfoRow(Icons.location_city, "Work Location", "${member["workLocation"]}"),
                _buildInfoRow(Icons.person, "Reporting Manager", "${member["reportingManager"]}"),
                _buildInfoRow(Icons.calendar_today, "Join Date", "${DateTime.parse("${member["joinDate"]}").dMMMy}"),
                _buildInfoRow(Icons.account_balance_wallet, "Salary", "\$${((member["salary"] as int) / 1000).toInt()}K annually"),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Skills & Qualifications
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Skills & Qualifications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                // Skills
                Text(
                  "Skills:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: skills.map((skill) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: primaryColor.withAlpha(30)),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: spMd),

                // Education & Certifications
                _buildInfoRow(Icons.school, "Education", "${member["education"]}"),
                _buildInfoRow(Icons.verified, "Certifications", "${member["certifications"]}"),
                _buildInfoRow(Icons.business_center, "Previous Company", "${member["previousCompany"]}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Current Projects (${projects.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          Column(
            children: projects.map((project) {
              Color statusColor = _getProjectStatusColor("${project["status"]}");
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: statusColor,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${project["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Role: ${project["role"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${project["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    if ((project["progress"] as int) < 100) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Progress: ${project["progress"]}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                          Text(
                            "Due: ${DateTime.parse("${project["endDate"]}").dMMMy}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      LinearProgressIndicator(
                        value: (project["progress"] as int) / 100,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation(statusColor),
                      ),
                      SizedBox(height: spSm),
                    ],
                    
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Started: ${DateTime.parse("${project["startDate"]}").dMMMy}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.groups,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${project["team"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Performance Overview
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Performance Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                // Current Performance Score
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _getPerformanceColor(member["performance"] as int),
                            width: 8,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${member["performance"]}%",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: _getPerformanceColor(member["performance"] as int),
                                ),
                              ),
                              Text(
                                "Overall",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        _getPerformanceLabel(member["performance"] as int),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _getPerformanceColor(member["performance"] as int),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Performance Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildPerformanceMetric("Quality Score", "92%", Icons.star, warningColor),
              _buildPerformanceMetric("On-Time Delivery", "98%", Icons.timer, successColor),
              _buildPerformanceMetric("Team Collaboration", "96%", Icons.people, infoColor),
              _buildPerformanceMetric("Innovation", "89%", Icons.lightbulb, primaryColor),
            ],
          ),

          SizedBox(height: spMd),

          // Performance History
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "6-Month Performance Trend",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                // Simple performance chart representation
                Column(
                  children: performanceData.map((data) {
                    double progress = (data["score"] as int) / 100;
                    Color barColor = _getPerformanceColor(data["score"] as int);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Text(
                              "${data["month"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation(barColor),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${data["score"]}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: barColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          Column(
            children: activities.map((activity) {
              Color typeColor = _getActivityTypeColor("${activity["type"]}");
              IconData typeIcon = _getActivityTypeIcon("${activity["type"]}");
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: typeColor.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        typeIcon,
                        size: 20,
                        color: typeColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                              children: [
                                TextSpan(
                                  text: "${activity["action"]} ",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: "${activity["target"]}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 12,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${DateTime.parse("${activity["date"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.access_time,
                                size: 12,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${activity["time"]}",
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
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: color,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: disabledBoldColor,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getProjectStatusColor(String status) {
    switch (status) {
      case "In Progress":
        return infoColor;
      case "Completed":
        return successColor;
      case "On Hold":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPerformanceColor(int performance) {
    if (performance >= 90) return successColor;
    if (performance >= 80) return infoColor;
    if (performance >= 70) return warningColor;
    return dangerColor;
  }

  String _getPerformanceLabel(int performance) {
    if (performance >= 90) return "Excellent";
    if (performance >= 80) return "Good";
    if (performance >= 70) return "Average";
    return "Needs Improvement";
  }

  Color _getActivityTypeColor(String type) {
    switch (type) {
      case "completion":
        return successColor;
      case "update":
        return infoColor;
      case "create":
        return primaryColor;
      case "review":
        return warningColor;
      case "meeting":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getActivityTypeIcon(String type) {
    switch (type) {
      case "completion":
        return Icons.check_circle;
      case "update":
        return Icons.update;
      case "create":
        return Icons.add_circle;
      case "review":
        return Icons.rate_review;
      case "meeting":
        return Icons.meeting_room;
      default:
        return Icons.info;
    }
  }
}
