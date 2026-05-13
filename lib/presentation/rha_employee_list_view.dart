import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaEmployeeListView extends StatefulWidget {
  const RhaEmployeeListView({super.key});

  @override
  State<RhaEmployeeListView> createState() => _RhaEmployeeListViewState();
}

class _RhaEmployeeListViewState extends State<RhaEmployeeListView> {
  String searchQuery = "";
  String selectedDepartment = "All";
  String selectedStatus = "All";
  String sortBy = "name";

  List<Map<String, dynamic>> employees = [
    {
      "id": "EMP001",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@company.com",
      "department": "Engineering",
      "position": "Senior Developer",
      "status": "Active",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=person",
      "joinDate": "2023-01-15",
      "assessments": 12,
      "completionRate": 95.5,
      "lastActivity": "2 hours ago",
      "skills": ["Flutter", "React", "Node.js"],
      "experience": "5 years"
    },
    {
      "id": "EMP002", 
      "name": "Michael Chen",
      "email": "michael.chen@company.com",
      "department": "Marketing",
      "position": "Marketing Manager",
      "status": "Active",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=person",
      "joinDate": "2022-11-08",
      "assessments": 8,
      "completionRate": 87.3,
      "lastActivity": "1 day ago",
      "skills": ["Digital Marketing", "Analytics", "SEO"],
      "experience": "7 years"
    },
    {
      "id": "EMP003",
      "name": "Emily Rodriguez",
      "email": "emily.rodriguez@company.com", 
      "department": "HR",
      "position": "HR Specialist",
      "status": "Inactive",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=person",
      "joinDate": "2023-06-20",
      "assessments": 6,
      "completionRate": 78.9,
      "lastActivity": "1 week ago",
      "skills": ["Recruitment", "Training", "Employee Relations"],
      "experience": "3 years"
    },
    {
      "id": "EMP004",
      "name": "David Kim",
      "email": "david.kim@company.com",
      "department": "Sales",
      "position": "Sales Representative", 
      "status": "Active",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=person",
      "joinDate": "2022-09-12",
      "assessments": 15,
      "completionRate": 92.1,
      "lastActivity": "3 hours ago",
      "skills": ["Sales Strategy", "Customer Relations", "Negotiation"],
      "experience": "4 years"
    },
    {
      "id": "EMP005",
      "name": "Lisa Thompson",
      "email": "lisa.thompson@company.com",
      "department": "Finance",
      "position": "Financial Analyst",
      "status": "Active",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=person",
      "joinDate": "2023-03-05",
      "assessments": 10,
      "completionRate": 89.7,
      "lastActivity": "5 hours ago",
      "skills": ["Financial Analysis", "Excel", "Reporting"],
      "experience": "6 years"
    },
    {
      "id": "EMP006",
      "name": "James Wilson", 
      "email": "james.wilson@company.com",
      "department": "Engineering",
      "position": "DevOps Engineer",
      "status": "Active",
      "avatar": "https://picsum.photos/100/100?random=6&keyword=person",
      "joinDate": "2022-12-18",
      "assessments": 9,
      "completionRate": 94.2,
      "lastActivity": "1 hour ago",
      "skills": ["AWS", "Docker", "Kubernetes"],
      "experience": "8 years"
    }
  ];

  List<Map<String, dynamic>> departments = [
    {"label": "All", "value": "All"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "HR", "value": "HR"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Finance", "value": "Finance"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"}
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name", "value": "name"},
    {"label": "Department", "value": "department"},
    {"label": "Join Date", "value": "joinDate"},
    {"label": "Completion Rate", "value": "completionRate"}
  ];

  List<Map<String, dynamic>> get filteredEmployees {
    var filtered = employees.where((employee) {
      bool matchesSearch = employee["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          employee["email"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          employee["department"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesDepartment = selectedDepartment == "All" || employee["department"] == selectedDepartment;
      bool matchesStatus = selectedStatus == "All" || employee["status"] == selectedStatus;
      
      return matchesSearch && matchesDepartment && matchesStatus;
    }).toList();

    filtered.sort((a, b) {
      switch (sortBy) {
        case "name":
          return a["name"].compareTo(b["name"]);
        case "department":
          return a["department"].compareTo(b["department"]);
        case "joinDate":
          return DateTime.parse(a["joinDate"]).compareTo(DateTime.parse(b["joinDate"]));
        case "completionRate":
          return ((b["completionRate"] as double).compareTo(a["completionRate"] as double));
        default:
          return 0;
      }
    });

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildEmployeeCard(Map<String, dynamic> employee) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusMd),
          onTap: () {
            // Navigate to employee detail
          },
          child: Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage("${employee["avatar"]}"),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${employee["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(employee["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${employee["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(employee["status"]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${employee["position"]} • ${employee["department"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: secondaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${employee["email"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Assessments",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${employee["assessments"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Completion Rate",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(employee["completionRate"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Last Activity",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${employee["lastActivity"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spXs,
                        runSpacing: 4,
                        children: (employee["skills"] as List).take(3).map((skill) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(
                                color: primaryColor.withAlpha(30),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "$skill",
                              style: TextStyle(
                                fontSize: 11,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Column(
                  children: [
                    QButton(
                      icon: Icons.visibility,
                      size: bs.sm,
                      onPressed: () {
                        // View employee details
                      },
                    ),
                    SizedBox(height: spXs),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        // Edit employee
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterRow() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "Search employees...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
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
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Sort By",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Add Employee",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  // Add new employee
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    int totalEmployees = employees.length;
    int activeEmployees = employees.where((e) => e["status"] == "Active").length;
    double avgCompletionRate = employees.map((e) => e["completionRate"] as double).reduce((a, b) => a + b) / employees.length;
    int totalAssessments = employees.map((e) => e["assessments"] as int).reduce((a, b) => a + b);

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
          Text(
            "Employee Overview",
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
                child: Column(
                  children: [
                    Text(
                      "$totalEmployees",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Employees",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "$activeEmployees",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Active",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${avgCompletionRate.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Avg Completion",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "$totalAssessments",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Total Assessments",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
        actions: [
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              // Export employee list
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildStatsCard(),
            SizedBox(height: spMd),
            _buildFilterRow(),
            SizedBox(height: spMd),
            ...filteredEmployees.map((employee) => _buildEmployeeCard(employee)).toList(),
            if (filteredEmployees.isEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No employees found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
