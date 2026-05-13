import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaEmployeeDirectoryView extends StatefulWidget {
  const RhaEmployeeDirectoryView({super.key});

  @override
  State<RhaEmployeeDirectoryView> createState() => _RhaEmployeeDirectoryViewState();
}

class _RhaEmployeeDirectoryViewState extends State<RhaEmployeeDirectoryView> {
  String searchQuery = "";
  String selectedDepartment = "all";
  String selectedPosition = "all";
  String viewMode = "grid";

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "all"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Design", "value": "design"},
    {"label": "Product", "value": "product"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Sales", "value": "sales"},
    {"label": "HR", "value": "hr"},
    {"label": "Finance", "value": "finance"},
  ];

  List<Map<String, dynamic>> positions = [
    {"label": "All Positions", "value": "all"},
    {"label": "Manager", "value": "manager"},
    {"label": "Senior", "value": "senior"},
    {"label": "Mid-level", "value": "mid"},
    {"label": "Junior", "value": "junior"},
    {"label": "Intern", "value": "intern"},
  ];

  List<Map<String, dynamic>> employees = [
    {
      "id": "1",
      "name": "John Doe",
      "position": "Senior Software Engineer",
      "department": "engineering",
      "level": "senior",
      "email": "john.doe@company.com",
      "phone": "+1 (555) 123-4567",
      "avatar": "https://picsum.photos/120/120?random=1&keyword=man",
      "location": "San Francisco, CA",
      "skills": ["Flutter", "React", "Node.js"],
      "status": "available",
      "joinDate": "2022-03-15",
      "manager": "Jane Smith"
    },
    {
      "id": "2",
      "name": "Jane Smith",
      "position": "Engineering Manager",
      "department": "engineering",
      "level": "manager",
      "email": "jane.smith@company.com",
      "phone": "+1 (555) 234-5678",
      "avatar": "https://picsum.photos/120/120?random=2&keyword=woman",
      "location": "San Francisco, CA",
      "skills": ["Leadership", "Architecture", "Strategy"],
      "status": "busy",
      "joinDate": "2021-01-10",
      "manager": "CTO"
    },
    {
      "id": "3",
      "name": "Mike Johnson",
      "position": "Product Manager",
      "department": "product",
      "level": "senior",
      "email": "mike.johnson@company.com",
      "phone": "+1 (555) 345-6789",
      "avatar": "https://picsum.photos/120/120?random=3&keyword=man",
      "location": "New York, NY",
      "skills": ["Product Strategy", "Analytics", "UX"],
      "status": "available",
      "joinDate": "2022-06-20",
      "manager": "VP Product"
    },
    {
      "id": "4",
      "name": "Sarah Wilson",
      "position": "UX Designer",
      "department": "design",
      "level": "mid",
      "email": "sarah.wilson@company.com",
      "phone": "+1 (555) 456-7890",
      "avatar": "https://picsum.photos/120/120?random=4&keyword=woman",
      "location": "Austin, TX",
      "skills": ["Figma", "User Research", "Prototyping"],
      "status": "away",
      "joinDate": "2023-02-14",
      "manager": "Design Lead"
    },
    {
      "id": "5",
      "name": "David Chen",
      "position": "Marketing Specialist",
      "department": "marketing",
      "level": "junior",
      "email": "david.chen@company.com",
      "phone": "+1 (555) 567-8901",
      "avatar": "https://picsum.photos/120/120?random=5&keyword=man",
      "location": "Seattle, WA",
      "skills": ["Digital Marketing", "SEO", "Content"],
      "status": "available",
      "joinDate": "2023-08-01",
      "manager": "Marketing Manager"
    },
    {
      "id": "6",
      "name": "Emily Davis",
      "position": "Sales Representative",
      "department": "sales",
      "level": "mid",
      "email": "emily.davis@company.com",
      "phone": "+1 (555) 678-9012",
      "avatar": "https://picsum.photos/120/120?random=6&keyword=woman",
      "location": "Chicago, IL",
      "skills": ["CRM", "Negotiation", "Client Relations"],
      "status": "available",
      "joinDate": "2022-11-30",
      "manager": "Sales Manager"
    },
  ];

  List<Map<String, dynamic>> get filteredEmployees {
    return employees.where((employee) {
      bool matchesSearch = searchQuery.isEmpty ||
          (employee["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (employee["position"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (employee["email"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesDepartment = selectedDepartment == "all" || employee["department"] == selectedDepartment;
      bool matchesPosition = selectedPosition == "all" || employee["level"] == selectedPosition;

      return matchesSearch && matchesDepartment && matchesPosition;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "available":
        return successColor;
      case "busy":
        return dangerColor;
      case "away":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Directory"),
        actions: [
          QButton(
            icon: viewMode == "grid" ? Icons.list : Icons.grid_view,
            size: bs.sm,
            onPressed: () {
              viewMode = viewMode == "grid" ? "list" : "grid";
              setState(() {});
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () {
              //navigateTo('FilterEmployeesView')
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search and Filters
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search employees...",
                    value: searchQuery,
                    hint: "Name, position, or email",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Filter Row
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
                    label: "Level",
                    items: positions,
                    value: selectedPosition,
                    onChanged: (value, label) {
                      selectedPosition = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Results Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredEmployees.length} employees found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Text(
                    "Total: ${employees.length}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),

            // Employee List/Grid
            if (viewMode == "grid")
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredEmployees.map((employee) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage("${employee["avatar"]}"),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: _getStatusColor(employee["status"]),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${employee["name"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${employee["position"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${employee["department"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            QButton(
                              icon: Icons.email,
                              size: bs.sm,
                              onPressed: () {
                                ss("Email sent to ${employee["name"]}");
                              },
                            ),
                            QButton(
                              icon: Icons.phone,
                              size: bs.sm,
                              onPressed: () {
                                ss("Calling ${employee["name"]}");
                              },
                            ),
                            QButton(
                              icon: Icons.chat,
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('ChatView')
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
            else
              Column(
                children: filteredEmployees.map((employee) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage("${employee["avatar"]}"),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: _getStatusColor(employee["status"]),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: spMd),
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
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.email, size: 14, color: disabledColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${employee["email"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                "${employee["department"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                QButton(
                                  icon: Icons.phone,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Calling ${employee["name"]}");
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {
                                    //navigateTo('EmployeeDetailsView')
                                  },
                                ),
                              ],
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('AddEmployeeView')
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
