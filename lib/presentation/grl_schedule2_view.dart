import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSchedule2View extends StatefulWidget {
  @override
  State<GrlSchedule2View> createState() => _GrlSchedule2ViewState();
}

class _GrlSchedule2ViewState extends State<GrlSchedule2View> {
  int selectedTab = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> employees = [
    {
      "id": "EMP001",
      "name": "John Smith",
      "position": "Software Engineer",
      "department": "Engineering",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=person",
      "email": "john.smith@company.com",
      "phone": "+1 234-567-8901",
      "skills": ["Flutter", "React", "Node.js"],
      "availability": "Available",
      "rating": 4.8,
      "experience": "5 years"
    },
    {
      "id": "EMP002",
      "name": "Sarah Johnson",
      "position": "UX Designer", 
      "department": "Design",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=woman",
      "email": "sarah.johnson@company.com",
      "phone": "+1 234-567-8902",
      "skills": ["UI/UX", "Figma", "Adobe Creative"],
      "availability": "Busy",
      "rating": 4.9,
      "experience": "7 years"
    },
    {
      "id": "EMP003",
      "name": "Mike Davis",
      "position": "Project Manager",
      "department": "Management",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=man",
      "email": "mike.davis@company.com",
      "phone": "+1 234-567-8903",
      "skills": ["Agile", "Scrum", "Leadership"],
      "availability": "Available",
      "rating": 4.7,
      "experience": "8 years"
    },
    {
      "id": "EMP004",
      "name": "Emily Chen",
      "position": "Data Analyst",
      "department": "Analytics",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=woman",
      "email": "emily.chen@company.com",
      "phone": "+1 234-567-8904",
      "skills": ["Python", "SQL", "Tableau"],
      "availability": "On Leave",
      "rating": 4.6,
      "experience": "4 years"
    },
    {
      "id": "EMP005",
      "name": "Alex Rodriguez",
      "position": "DevOps Engineer",
      "department": "Engineering",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=person",
      "email": "alex.rodriguez@company.com",
      "phone": "+1 234-567-8905",
      "skills": ["AWS", "Docker", "Kubernetes"],
      "availability": "Available",
      "rating": 4.8,
      "experience": "6 years"
    }
  ];

  List<Map<String, dynamic>> workShifts = [
    {
      "id": "SH001",
      "employeeId": "EMP001",
      "date": "2024-03-20",
      "startTime": "09:00",
      "endTime": "17:00",
      "shiftType": "Regular",
      "status": "Scheduled",
      "location": "Office - Floor 3"
    },
    {
      "id": "SH002", 
      "employeeId": "EMP002",
      "date": "2024-03-20",
      "startTime": "10:00",
      "endTime": "18:00",
      "shiftType": "Flexible",
      "status": "Confirmed",
      "location": "Office - Floor 2"
    },
    {
      "id": "SH003",
      "employeeId": "EMP003",
      "date": "2024-03-20",
      "startTime": "08:00",
      "endTime": "16:00",
      "shiftType": "Early",
      "status": "Confirmed",
      "location": "Office - Floor 4"
    },
    {
      "id": "SH004",
      "employeeId": "EMP001",
      "date": "2024-03-21",
      "startTime": "09:00",
      "endTime": "17:00",
      "shiftType": "Regular",
      "status": "Pending",
      "location": "Remote"
    },
    {
      "id": "SH005",
      "employeeId": "EMP005",
      "date": "2024-03-21",
      "startTime": "12:00",
      "endTime": "20:00",
      "shiftType": "Afternoon",
      "status": "Confirmed",
      "location": "Office - Floor 1"
    }
  ];

  List<String> departments = ["All", "Engineering", "Design", "Management", "Analytics"];
  List<String> statusTabs = ["All Staff", "Available", "Busy", "On Leave"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Scheduling"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          _buildStatusTabs(),
          _buildStatsRow(),
          Expanded(
            child: _buildStaffList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewShift,
        backgroundColor: primaryColor,
        child: Icon(Icons.add_task, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search staff members...",
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
                onPressed: () {
                  // Perform search
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          QCategoryPicker(
            items: departments.map((dept) => {
              "label": dept,
              "value": dept,
            }).toList(),
            value: "All",
            onChanged: (index, label, value, item) {
              // Filter by department
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTabs() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      color: Colors.white,
      child: Row(
        children: statusTabs.asMap().entries.map((entry) {
          int index = entry.key;
          String status = entry.value;
          bool isSelected = selectedTab == index;
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedTab = index;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? primaryColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? primaryColor : disabledBoldColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatsRow() {
    int totalStaff = employees.length;
    int availableStaff = employees.where((emp) => emp["availability"] == "Available").length;
    int busyStaff = employees.where((emp) => emp["availability"] == "Busy").length;
    int onLeaveStaff = employees.where((emp) => emp["availability"] == "On Leave").length;

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          _buildStatItem("Total", totalStaff.toString(), primaryColor),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
            margin: EdgeInsets.symmetric(horizontal: spSm),
          ),
          _buildStatItem("Available", availableStaff.toString(), successColor),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
            margin: EdgeInsets.symmetric(horizontal: spSm),
          ),
          _buildStatItem("Busy", busyStaff.toString(), warningColor),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
            margin: EdgeInsets.symmetric(horizontal: spSm),
          ),
          _buildStatItem("On Leave", onLeaveStaff.toString(), dangerColor),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffList() {
    List<Map<String, dynamic>> filteredEmployees = _getFilteredEmployees();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: filteredEmployees.map((employee) {
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            child: _buildStaffCard(employee),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStaffCard(Map<String, dynamic> employee) {
    Color availabilityColor = _getAvailabilityColor(employee["availability"]);
    List<Map<String, dynamic>> employeeShifts = workShifts
        .where((shift) => shift["employeeId"] == employee["id"])
        .toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          // Employee info header
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage("${employee["avatar"]}"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: availabilityColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${employee["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${employee["position"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${employee["department"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Row(
                            children: [
                              Icon(Icons.star, size: 14, color: warningColor),
                              SizedBox(width: 2),
                              Text(
                                "${employee["rating"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: availabilityColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${employee["availability"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Contact info and skills
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.email, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${employee["email"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${employee["phone"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "Skills:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Wrap(
                        spacing: spXs,
                        children: (employee["skills"] as List).map((skill) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$skill",
                              style: TextStyle(
                                fontSize: 10,
                                color: successColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Upcoming shifts
          if (employeeShifts.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upcoming Shifts",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...employeeShifts.take(2).map((shift) {
                    Color shiftColor = _getShiftStatusColor(shift["status"]);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: shiftColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Text(
                            DateTime.parse(shift["date"]).dMMMy,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: shiftColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${shift["startTime"]} - ${shift["endTime"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: shiftColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${shift["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],

          // Action buttons
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radiusLg),
                bottomRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Schedule",
                    size: bs.sm,
                    color: disabledBoldColor,
                    onPressed: () {
                      _viewEmployeeSchedule(employee);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Assign Shift",
                    size: bs.sm,
                    onPressed: () {
                      _assignShift(employee);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.message,
                  size: bs.sm,
                  color: infoColor,
                  onPressed: () {
                    _contactEmployee(employee);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredEmployees() {
    List<Map<String, dynamic>> filtered = employees;

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((employee) {
        return employee["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               employee["position"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               employee["department"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by status tab
    if (selectedTab > 0) {
      String statusFilter = statusTabs[selectedTab];
      if (statusFilter != "All Staff") {
        filtered = filtered.where((employee) => employee["availability"] == statusFilter).toList();
      }
    }

    return filtered;
  }

  Color _getAvailabilityColor(String availability) {
    switch (availability) {
      case "Available":
        return successColor;
      case "Busy":
        return warningColor;
      case "On Leave":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getShiftStatusColor(String status) {
    switch (status) {
      case "Confirmed":
        return successColor;
      case "Scheduled":
        return primaryColor;
      case "Pending":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  void _addNewShift() {
    si("Add new shift feature coming soon");
  }

  void _viewEmployeeSchedule(Map<String, dynamic> employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${employee["name"]}'s Schedule"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Upcoming shifts for this employee will be displayed here."),
              SizedBox(height: spSm),
              ...workShifts
                  .where((shift) => shift["employeeId"] == employee["id"])
                  .map((shift) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date: ${DateTime.parse(shift["date"]).dMMMy}"),
                      Text("Time: ${shift["startTime"]} - ${shift["endTime"]}"),
                      Text("Type: ${shift["shiftType"]}"),
                      Text("Status: ${shift["status"]}"),
                      Text("Location: ${shift["location"]}"),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _assignShift(Map<String, dynamic> employee) {
    si("Assign shift to ${employee["name"]}");
  }

  void _contactEmployee(Map<String, dynamic> employee) {
    si("Contact ${employee["name"]} at ${employee["email"]}");
  }
}
