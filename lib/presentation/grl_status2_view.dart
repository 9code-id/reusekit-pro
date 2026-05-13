import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStatus2View extends StatefulWidget {
  @override
  State<GrlStatus2View> createState() => _GrlStatus2ViewState();
}

class _GrlStatus2ViewState extends State<GrlStatus2View> {
  String selectedDepartment = "all";
  String selectedStatus = "all";

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "all"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Sales", "value": "sales"},
    {"label": "HR", "value": "hr"},
    {"label": "Finance", "value": "finance"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "On Leave", "value": "on_leave"},
    {"label": "Remote", "value": "remote"},
    {"label": "Inactive", "value": "inactive"},
  ];

  List<Map<String, dynamic>> employees = [
    {
      "id": "EMP001",
      "name": "John Doe",
      "position": "Senior Software Engineer",
      "department": "engineering",
      "email": "john.doe@company.com",
      "phone": "+1 234 567 8900",
      "status": "active",
      "location": "Office",
      "joinDate": "2022-03-15",
      "avatar": "J",
      "manager": "Sarah Wilson",
      "workingHours": "9:00 AM - 6:00 PM",
      "projects": ["Mobile App", "API Development"],
      "skills": ["React Native", "Node.js", "Python"],
      "performance": 92
    },
    {
      "id": "EMP002",
      "name": "Sarah Smith",
      "position": "Marketing Manager",
      "department": "marketing",
      "email": "sarah.smith@company.com",
      "phone": "+1 234 567 8901",
      "status": "remote",
      "location": "Home Office",
      "joinDate": "2021-07-20",
      "avatar": "S",
      "manager": "Mike Johnson",
      "workingHours": "10:00 AM - 7:00 PM",
      "projects": ["Brand Campaign", "Social Media"],
      "skills": ["Digital Marketing", "Content Strategy", "Analytics"],
      "performance": 88
    },
    {
      "id": "EMP003",
      "name": "Mike Wilson",
      "position": "Sales Representative",
      "department": "sales",
      "email": "mike.wilson@company.com",
      "phone": "+1 234 567 8902",
      "status": "active",
      "location": "Office",
      "joinDate": "2023-01-10",
      "avatar": "M",
      "manager": "Emma Davis",
      "workingHours": "8:00 AM - 5:00 PM",
      "projects": ["Q1 Sales", "Client Acquisition"],
      "skills": ["Sales Strategy", "CRM", "Negotiation"],
      "performance": 95
    },
    {
      "id": "EMP004",
      "name": "Emma Davis",
      "position": "HR Specialist",
      "department": "hr",
      "email": "emma.davis@company.com",
      "phone": "+1 234 567 8903",
      "status": "on_leave",
      "location": "N/A",
      "joinDate": "2020-11-05",
      "avatar": "E",
      "manager": "David Brown",
      "workingHours": "N/A",
      "projects": ["Recruitment", "Employee Training"],
      "skills": ["Recruitment", "Training", "Policy Development"],
      "performance": 85
    },
    {
      "id": "EMP005",
      "name": "David Brown",
      "position": "Finance Analyst",
      "department": "finance",
      "email": "david.brown@company.com",
      "phone": "+1 234 567 8904",
      "status": "inactive",
      "location": "N/A",
      "joinDate": "2019-09-12",
      "avatar": "D",
      "manager": "Alex Wilson",
      "workingHours": "N/A",
      "projects": [],
      "skills": ["Financial Analysis", "Excel", "Reporting"],
      "performance": 78
    },
  ];

  List<Map<String, dynamic>> get filteredEmployees {
    return employees.where((employee) {
      final deptMatch = selectedDepartment == "all" || employee["department"] == selectedDepartment;
      final statusMatch = selectedStatus == "all" || employee["status"] == selectedStatus;
      return deptMatch && statusMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Row(
              spacing: spSm,
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

            // Employee Statistics
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "Employee Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Total",
                          "${employees.length}",
                          Icons.people,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Active",
                          "${_getStatusCount('active')}",
                          Icons.check_circle,
                          successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Remote",
                          "${_getStatusCount('remote')}",
                          Icons.home,
                          infoColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "On Leave",
                          "${_getStatusCount('on_leave')}",
                          Icons.schedule,
                          warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Department Distribution
            Container(
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
                  Text(
                    "Department Distribution",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  Column(
                    spacing: spSm,
                    children: _buildDepartmentStats(),
                  ),
                ],
              ),
            ),

            // Employee List
            Column(
              spacing: spSm,
              children: List.generate(
                filteredEmployees.length,
                (index) => _buildEmployeeCard(filteredEmployees[index]),
              ),
            ),

            if (filteredEmployees.isEmpty)
              Container(
                padding: EdgeInsets.all(sp2xl),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.person_search,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    Text(
                      "No employees found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
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
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeCard(Map<String, dynamic> employee) {
    final statusColor = _getStatusColor(employee["status"]);
    final isActive = employee["status"] == "active" || employee["status"] == "remote";
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(color: statusColor.withAlpha(60)),
      ),
      child: Column(
        spacing: spMd,
        children: [
          // Employee Header
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: statusColor,
                child: Text(
                  "${employee["avatar"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${employee["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${employee["position"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "${employee["id"]} • ${employee["department"]}".toUpperCase(),
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${employee["status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          // Contact Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${employee["email"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${employee["phone"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Icon(
                      employee["status"] == "remote" ? Icons.home : Icons.business,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${employee["location"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Employee Details
          Row(
            children: [
              Expanded(
                child: _buildDetailCard(
                  "Manager",
                  "${employee["manager"]}",
                  Icons.person,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildDetailCard(
                  "Join Date",
                  "${DateTime.parse(employee["joinDate"]).day}/${DateTime.parse(employee["joinDate"]).month}/${DateTime.parse(employee["joinDate"]).year}",
                  Icons.calendar_today,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildDetailCard(
                  "Performance",
                  "${employee["performance"]}%",
                  Icons.trending_up,
                ),
              ),
            ],
          ),

          if (isActive)
            Column(
              spacing: spSm,
              children: [
                // Working Hours
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: statusColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Working Hours: ${employee["workingHours"]}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Current Projects
                if ((employee["projects"] as List).isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Current Projects",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (employee["projects"] as List).map((project) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${project}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                // Skills
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Skills",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (employee["skills"] as List).map((skill) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${skill}",
                              style: TextStyle(
                                fontSize: 11,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Profile",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Message",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              if (isActive)
                Expanded(
                  child: QButton(
                    label: "Assign Task",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            size: 16,
            color: primaryColor,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDepartmentStats() {
    final deptCounts = <String, int>{};
    
    for (var employee in employees) {
      final dept = employee["department"] as String;
      deptCounts[dept] = (deptCounts[dept] ?? 0) + 1;
    }
    
    return deptCounts.entries.map((entry) {
      final percentage = (entry.value / employees.length * 100);
      return Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.key.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Text(
                  "${entry.value} (${percentage.toStringAsFixed(1)}%)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              minHeight: 6,
            ),
          ],
        ),
      );
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "remote":
        return infoColor;
      case "on_leave":
        return warningColor;
      case "inactive":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  int _getStatusCount(String status) {
    return employees.where((employee) => employee["status"] == status).length;
  }
}
