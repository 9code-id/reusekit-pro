import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsStaffManagementView extends StatefulWidget {
  const RfsStaffManagementView({super.key});

  @override
  State<RfsStaffManagementView> createState() => _RfsStaffManagementViewState();
}

class _RfsStaffManagementViewState extends State<RfsStaffManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedDepartment = "";
  String selectedStatus = "";

  List<Map<String, dynamic>> staffMembers = [
    {
      "id": "EMP001",
      "name": "John Smith",
      "position": "Head Chef",
      "department": "Kitchen",
      "status": "Active",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
      "phone": "+1-555-0101",
      "email": "john.smith@restaurant.com",
      "hire_date": "2022-01-15",
      "salary": 55000,
      "performance_score": 95,
      "shifts_this_week": 5,
      "overtime_hours": 8,
      "certifications": ["Food Safety", "Kitchen Management"],
    },
    {
      "id": "EMP002", 
      "name": "Sarah Johnson",
      "position": "Sous Chef",
      "department": "Kitchen",
      "status": "Active",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=person",
      "phone": "+1-555-0102",
      "email": "sarah.johnson@restaurant.com",
      "hire_date": "2022-03-20",
      "salary": 45000,
      "performance_score": 88,
      "shifts_this_week": 5,
      "overtime_hours": 4,
      "certifications": ["Food Safety", "Culinary Arts"],
    },
    {
      "id": "EMP003",
      "name": "Mike Wilson",
      "position": "Server",
      "department": "Front of House",
      "status": "Active",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=person",
      "phone": "+1-555-0103",
      "email": "mike.wilson@restaurant.com",
      "hire_date": "2023-06-10",
      "salary": 32000,
      "performance_score": 92,
      "shifts_this_week": 6,
      "overtime_hours": 2,
      "certifications": ["Customer Service", "POS System"],
    },
    {
      "id": "EMP004",
      "name": "Emily Davis",
      "position": "Bartender",
      "department": "Bar",
      "status": "Active",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=person",
      "phone": "+1-555-0104",
      "email": "emily.davis@restaurant.com",
      "hire_date": "2022-11-05",
      "salary": 38000,
      "performance_score": 89,
      "shifts_this_week": 5,
      "overtime_hours": 6,
      "certifications": ["Responsible Service", "Mixology"],
    },
    {
      "id": "EMP005",
      "name": "David Brown",
      "position": "Cleaner",
      "department": "Housekeeping",
      "status": "On Leave",
      "avatar": "https://picsum.photos/60/60?random=5&keyword=person",
      "phone": "+1-555-0105",
      "email": "david.brown@restaurant.com",
      "hire_date": "2023-02-28",
      "salary": 28000,
      "performance_score": 85,
      "shifts_this_week": 0,
      "overtime_hours": 0,
      "certifications": ["Safety Training"],
    },
    {
      "id": "EMP006",
      "name": "Lisa Garcia",
      "position": "Manager",
      "department": "Management",
      "status": "Active",
      "avatar": "https://picsum.photos/60/60?random=6&keyword=person",
      "phone": "+1-555-0106",
      "email": "lisa.garcia@restaurant.com",
      "hire_date": "2021-08-12",
      "salary": 65000,
      "performance_score": 96,
      "shifts_this_week": 5,
      "overtime_hours": 12,
      "certifications": ["Management", "HR Compliance", "Food Safety"],
    },
  ];

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": ""},
    {"label": "Kitchen", "value": "Kitchen"},
    {"label": "Front of House", "value": "Front of House"},
    {"label": "Bar", "value": "Bar"},
    {"label": "Management", "value": "Management"},
    {"label": "Housekeeping", "value": "Housekeeping"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "Active"},
    {"label": "On Leave", "value": "On Leave"},
    {"label": "Terminated", "value": "Terminated"},
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "activity": "New employee onboarded",
      "details": "Mike Wilson joined as Server",
      "timestamp": "2 hours ago",
      "type": "hire",
    },
    {
      "activity": "Performance review completed",
      "details": "Sarah Johnson - Quarterly review",
      "timestamp": "1 day ago",
      "type": "review",
    },
    {
      "activity": "Training completed",
      "details": "Emily Davis completed Mixology certification",
      "timestamp": "3 days ago",
      "type": "training",
    },
    {
      "activity": "Schedule updated",
      "details": "Weekend shifts reassigned",
      "timestamp": "1 week ago",
      "type": "schedule",
    },
  ];

  List<Map<String, dynamic>> get filteredStaff {
    return staffMembers.where((staff) {
      bool matchesSearch = searchQuery.isEmpty ||
          (staff["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (staff["position"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (staff["id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesDepartment = selectedDepartment.isEmpty || staff["department"] == selectedDepartment;
      bool matchesStatus = selectedStatus.isEmpty || staff["status"] == selectedStatus;
      
      return matchesSearch && matchesDepartment && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Staff Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Staff List", icon: Icon(Icons.people)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Activities", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildStaffListTab(),
        _buildAnalyticsTab(),
        _buildActivitiesTab(),
      ],
    );
  }

  Widget _buildStaffListTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildStaffStats(),
          _buildStaffList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search Staff",
          value: searchQuery,
          hint: "Search by name, position, or ID",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Department",
                items: departments,
                value: selectedDepartment,
                onChanged: (value, label) {
                  selectedDepartment = value;
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
      ],
    );
  }

  Widget _buildStaffStats() {
    int totalStaff = staffMembers.length;
    int activeStaff = staffMembers.where((s) => s["status"] == "Active").length;
    int onLeave = staffMembers.where((s) => s["status"] == "On Leave").length;
    double avgPerformance = staffMembers.fold(0.0, (sum, staff) => sum + (staff["performance_score"] as int)) / totalStaff;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 160,
      children: [
        _buildStatCard("Total Staff", "$totalStaff", Icons.people, primaryColor),
        _buildStatCard("Active", "$activeStaff", Icons.check_circle, successColor),
        _buildStatCard("On Leave", "$onLeave", Icons.pause_circle, warningColor),
        _buildStatCard("Avg Performance", "${avgPerformance.toStringAsFixed(1)}%", Icons.star, infoColor),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Staff Members (${filteredStaff.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "Add Staff",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        ...filteredStaff.map((staff) => _buildStaffCard(staff)),
      ],
    );
  }

  Widget _buildStaffCard(Map<String, dynamic> staff) {
    Color statusColor = staff["status"] == "Active" 
        ? successColor 
        : staff["status"] == "On Leave"
        ? warningColor
        : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("${staff["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${staff["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${staff["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${staff["position"]} • ${staff["department"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "ID: ${staff["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildStaffMetric("Performance", "${staff["performance_score"]}%", Icons.star),
              _buildStaffMetric("Shifts/Week", "${staff["shifts_this_week"]}", Icons.schedule),
              _buildStaffMetric("Overtime", "${staff["overtime_hours"]}h", Icons.access_time),
              _buildStaffMetric("Salary", "\$${((staff["salary"] as int) / 1000).toStringAsFixed(0)}K", Icons.attach_money),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Profile",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStaffMetric(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: primaryColor, size: 16),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildDepartmentAnalytics(),
          _buildPerformanceAnalytics(),
          _buildAttendanceAnalytics(),
        ],
      ),
    );
  }

  Widget _buildDepartmentAnalytics() {
    Map<String, int> departmentCounts = {};
    for (var staff in staffMembers) {
      String dept = staff["department"] as String;
      departmentCounts[dept] = (departmentCounts[dept] ?? 0) + 1;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Staff by Department",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...departmentCounts.entries.map((entry) => 
            Container(
              margin: EdgeInsets.only(bottom: spXs),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: LinearProgressIndicator(
                      value: entry.value / staffMembers.length,
                      backgroundColor: disabledColor.withAlpha(30),
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "${entry.value}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceAnalytics() {
    List<Map<String, dynamic>> performanceRanges = [
      {"range": "90-100%", "count": staffMembers.where((s) => (s["performance_score"] as int) >= 90).length, "color": successColor},
      {"range": "80-89%", "count": staffMembers.where((s) => (s["performance_score"] as int) >= 80 && (s["performance_score"] as int) < 90).length, "color": infoColor},
      {"range": "70-79%", "count": staffMembers.where((s) => (s["performance_score"] as int) >= 70 && (s["performance_score"] as int) < 80).length, "color": warningColor},
      {"range": "Below 70%", "count": staffMembers.where((s) => (s["performance_score"] as int) < 70).length, "color": dangerColor},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Performance Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 140,
            children: performanceRanges.map((range) => 
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (range["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "${range["count"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: range["color"] as Color,
                      ),
                    ),
                    Text(
                      "${range["range"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceAnalytics() {
    double totalOvertimeHours = staffMembers.fold(0.0, (sum, staff) => sum + (staff["overtime_hours"] as int));
    double avgShiftsPerWeek = staffMembers.fold(0.0, (sum, staff) => sum + (staff["shifts_this_week"] as int)) / staffMembers.length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildAnalyticsCard("Total Overtime", "${totalOvertimeHours.toStringAsFixed(0)} hours", Icons.access_time, warningColor),
        _buildAnalyticsCard("Avg Shifts/Week", avgShiftsPerWeek.toStringAsFixed(1), Icons.schedule, infoColor),
        _buildAnalyticsCard("Active Staff", "${staffMembers.where((s) => s["status"] == "Active").length}", Icons.check_circle, successColor),
        _buildAnalyticsCard("Total Payroll", "\$${(staffMembers.fold(0, (sum, staff) => sum + (staff["salary"] as int)) / 1000).toStringAsFixed(0)}K", Icons.attach_money, primaryColor),
      ],
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Recent Activities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...recentActivities.map((activity) => _buildActivityCard(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    IconData icon;
    Color iconColor;
    
    switch (activity["type"]) {
      case "hire":
        icon = Icons.person_add;
        iconColor = successColor;
        break;
      case "review":
        icon = Icons.rate_review;
        iconColor = infoColor;
        break;
      case "training":
        icon = Icons.school;
        iconColor = warningColor;
        break;
      case "schedule":
        icon = Icons.schedule;
        iconColor = primaryColor;
        break;
      default:
        icon = Icons.info;
        iconColor = disabledBoldColor;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: iconColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["activity"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${activity["details"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${activity["timestamp"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }
}
