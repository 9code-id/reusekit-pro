import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaStaffManagementView extends StatefulWidget {
  const FmaStaffManagementView({super.key});

  @override
  State<FmaStaffManagementView> createState() => _FmaStaffManagementViewState();
}

class _FmaStaffManagementViewState extends State<FmaStaffManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedDepartment = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All", "value": "All"},
    {"label": "Kitchen", "value": "Kitchen"},
    {"label": "Service", "value": "Service"},
    {"label": "Management", "value": "Management"},
    {"label": "Cleaning", "value": "Cleaning"},
    {"label": "Delivery", "value": "Delivery"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "On Leave", "value": "On Leave"},
    {"label": "Part-time", "value": "Part-time"},
    {"label": "Inactive", "value": "Inactive"},
  ];

  List<Map<String, dynamic>> staffMembers = [
    {
      "id": "1",
      "name": "John Smith",
      "position": "Head Chef",
      "department": "Kitchen",
      "email": "john.smith@restaurant.com",
      "phone": "+1 555-0101",
      "hireDate": "2022-03-15",
      "hourlyRate": 25.00,
      "status": "Active",
      "shift": "Morning",
      "skills": ["Cooking", "Leadership", "Menu Planning"],
      "certifications": ["Food Safety", "ServSafe"],
      "emergencyContact": "+1 555-0102",
      "address": "123 Main St, City",
      "notes": "Excellent leadership skills",
      "image": "https://picsum.photos/80/80?random=1&keyword=chef",
      "performance": 95
    },
    {
      "id": "2",
      "name": "Sarah Johnson",
      "position": "Waitress",
      "department": "Service",
      "email": "sarah.j@restaurant.com",
      "phone": "+1 555-0103",
      "hireDate": "2023-06-20",
      "hourlyRate": 15.00,
      "status": "Active",
      "shift": "Evening",
      "skills": ["Customer Service", "POS System", "Multitasking"],
      "certifications": ["Food Handling"],
      "emergencyContact": "+1 555-0104",
      "address": "456 Oak Ave, City",
      "notes": "Great with customers",
      "image": "https://picsum.photos/80/80?random=2&keyword=waitress",
      "performance": 88
    },
    {
      "id": "3",
      "name": "Mike Chen",
      "position": "Sous Chef",
      "department": "Kitchen",
      "email": "mike.chen@restaurant.com",
      "phone": "+1 555-0105",
      "hireDate": "2023-01-10",
      "hourlyRate": 20.00,
      "status": "On Leave",
      "shift": "Evening",
      "skills": ["Cooking", "Inventory", "Training"],
      "certifications": ["Food Safety", "Allergy Awareness"],
      "emergencyContact": "+1 555-0106",
      "address": "789 Pine St, City",
      "notes": "On medical leave until July",
      "image": "https://picsum.photos/80/80?random=3&keyword=chef",
      "performance": 92
    },
    {
      "id": "4",
      "name": "Emily Davis",
      "position": "Manager",
      "department": "Management",
      "email": "emily.davis@restaurant.com",
      "phone": "+1 555-0107",
      "hireDate": "2021-11-05",
      "hourlyRate": 30.00,
      "status": "Active",
      "shift": "All Day",
      "skills": ["Leadership", "Scheduling", "Finance", "HR"],
      "certifications": ["Management", "Food Safety", "First Aid"],
      "emergencyContact": "+1 555-0108",
      "address": "321 Elm St, City",
      "notes": "Handles scheduling and staff issues",
      "image": "https://picsum.photos/80/80?random=4&keyword=manager",
      "performance": 97
    },
    {
      "id": "5",
      "name": "David Wilson",
      "position": "Dishwasher",
      "department": "Cleaning",
      "email": "david.w@restaurant.com",
      "phone": "+1 555-0109",
      "hireDate": "2024-02-14",
      "hourlyRate": 12.00,
      "status": "Part-time",
      "shift": "Evening",
      "skills": ["Cleaning", "Organization"],
      "certifications": ["Sanitation"],
      "emergencyContact": "+1 555-0110",
      "address": "654 Maple Dr, City",
      "notes": "Works weekends only",
      "image": "https://picsum.photos/80/80?random=5&keyword=worker",
      "performance": 85
    },
    {
      "id": "6",
      "name": "Lisa Brown",
      "position": "Delivery Driver",
      "department": "Delivery",
      "email": "lisa.brown@restaurant.com",
      "phone": "+1 555-0111",
      "hireDate": "2023-09-12",
      "hourlyRate": 14.00,
      "status": "Active",
      "shift": "Evening",
      "skills": ["Driving", "Navigation", "Customer Service"],
      "certifications": ["Valid Driver's License", "Food Transport"],
      "emergencyContact": "+1 555-0112",
      "address": "987 Cedar Ln, City",
      "notes": "Reliable driver with clean record",
      "image": "https://picsum.photos/80/80?random=6&keyword=driver",
      "performance": 90
    },
  ];

  List<Map<String, dynamic>> schedules = [
    {
      "staffId": "1",
      "staffName": "John Smith",
      "date": "2024-06-19",
      "shift": "Morning",
      "startTime": "06:00",
      "endTime": "14:00",
      "hours": 8,
      "status": "Scheduled"
    },
    {
      "staffId": "2",
      "staffName": "Sarah Johnson",
      "date": "2024-06-19",
      "shift": "Evening",
      "startTime": "16:00",
      "endTime": "22:00",
      "hours": 6,
      "status": "Scheduled"
    },
    {
      "staffId": "4",
      "staffName": "Emily Davis",
      "date": "2024-06-19",
      "shift": "All Day",
      "startTime": "10:00",
      "endTime": "20:00",
      "hours": 10,
      "status": "Scheduled"
    },
    {
      "staffId": "6",
      "staffName": "Lisa Brown",
      "date": "2024-06-19",
      "shift": "Evening",
      "startTime": "17:00",
      "endTime": "21:00",
      "hours": 4,
      "status": "Scheduled"
    },
  ];

  List<Map<String, dynamic>> get filteredStaffMembers {
    return staffMembers.where((staff) {
      bool matchesSearch = staff["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          staff["position"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          staff["email"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesDepartment = selectedDepartment == "All" || staff["department"] == selectedDepartment;
      bool matchesStatus = selectedStatus == "All" || staff["status"] == selectedStatus;
      return matchesSearch && matchesDepartment && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active": return successColor;
      case "On Leave": return warningColor;
      case "Part-time": return infoColor;
      case "Inactive": return disabledBoldColor;
      default: return primaryColor;
    }
  }

  Color _getPerformanceColor(int performance) {
    if (performance >= 95) return successColor;
    if (performance >= 85) return infoColor;
    if (performance >= 75) return warningColor;
    return dangerColor;
  }

  Widget _buildOverviewTab() {
    int totalStaff = staffMembers.length;
    int activeStaff = staffMembers.where((staff) => staff["status"] == "Active").length;
    int onLeaveStaff = staffMembers.where((staff) => staff["status"] == "On Leave").length;
    double avgPerformance = staffMembers.map((staff) => staff["performance"] as int)
        .reduce((a, b) => a + b) / staffMembers.length;
    
    Map<String, int> departmentStats = {};
    for (var staff in staffMembers) {
      String department = staff["department"];
      departmentStats[department] = (departmentStats[department] ?? 0) + 1;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Stats Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.people, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$totalStaff",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Staff",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$activeStaff",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Active Staff",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.schedule, color: warningColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$onLeaveStaff",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "On Leave",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.star, color: infoColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "${avgPerformance.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Avg Performance",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Department Breakdown
          Text(
            "Staff by Department",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: departmentStats.entries.map((entry) {
                double percentage = entry.value / totalStaff;
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            entry.key,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${entry.value} (${(percentage * 100).toStringAsFixed(1)}%)",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(102),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: percentage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),

          // Today's Schedule
          Text(
            "Today's Schedule",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Column(
            spacing: spSm,
            children: schedules.map((schedule) {
              return Container(
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
                        color: primaryColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(Icons.schedule, color: primaryColor, size: 20),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${schedule["staffName"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${schedule["shift"]} • ${schedule["startTime"]} - ${schedule["endTime"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${schedule["hours"]} hours",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${schedule["status"]}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
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

  Widget _buildStaffTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Column(
            spacing: spSm,
            children: [
              QTextField(
                label: "Search staff...",
                value: searchQuery,
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
                      items: departmentOptions,
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
          ),

          // Add New Staff Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Staff",
              icon: Icons.person_add,
              size: bs.md,
              onPressed: () {
                ss("Add new staff member");
              },
            ),
          ),

          // Staff List
          Column(
            spacing: spSm,
            children: filteredStaffMembers.map((staff) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${staff["image"]}",
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
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
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(staff["status"]).withAlpha(51),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${staff["status"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(staff["status"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${staff["position"]} • ${staff["department"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${staff["email"]} • ${staff["phone"]}",
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
                    
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "\$${((staff["hourlyRate"] as double)).currency}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "per hour",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: successColor,
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
                              color: _getPerformanceColor(staff["performance"]).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${staff["performance"]}%",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _getPerformanceColor(staff["performance"]),
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Performance",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: _getPerformanceColor(staff["performance"]),
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
                              color: primaryColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${staff["shift"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Shift",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Skills:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  (staff["skills"] as List<String>).join(", "),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Certifications:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  (staff["certifications"] as List<String>).join(", "),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hire Date: ${staff["hireDate"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledColor,
                              ),
                            ),
                            Text(
                              "Emergency: ${staff["emergencyContact"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        if (staff["notes"] != null && staff["notes"] != "") ...[
                          Container(
                            constraints: BoxConstraints(maxWidth: 150),
                            child: Text(
                              "${staff["notes"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledColor,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Edit Profile",
                            size: bs.sm,
                            onPressed: () {
                              ss("Editing ${staff["name"]} profile");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "View Schedule",
                            size: bs.sm,
                            onPressed: () {
                              ss("Viewing ${staff["name"]} schedule");
                            },
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Staff Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Staff List", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildStaffTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
