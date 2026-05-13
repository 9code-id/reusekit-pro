import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlList3View extends StatefulWidget {
  @override
  State<GrlList3View> createState() => _GrlList3ViewState();
}

class _GrlList3ViewState extends State<GrlList3View> {
  String searchQuery = "";
  String selectedDepartment = "All";
  
  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All", "value": "All"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Design", "value": "Design"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Sales", "value": "Sales"},
    {"label": "HR", "value": "HR"},
  ];

  List<Map<String, dynamic>> employees = [
    {
      "id": "EMP-001",
      "name": "Alex Johnson",
      "position": "Senior Developer",
      "department": "Engineering",
      "email": "alex.johnson@company.com",
      "phone": "+1 (555) 123-4567",
      "avatar": "https://picsum.photos/100/100?random=11&keyword=face",
      "salary": 95000,
      "joinDate": "2022-03-15",
      "status": "Active",
      "skills": ["Flutter", "React", "Node.js"],
    },
    {
      "id": "EMP-002",
      "name": "Sarah Chen",
      "position": "UX Designer",
      "department": "Design",
      "email": "sarah.chen@company.com",
      "phone": "+1 (555) 234-5678",
      "avatar": "https://picsum.photos/100/100?random=12&keyword=face",
      "salary": 75000,
      "joinDate": "2023-01-20",
      "status": "Active",
      "skills": ["Figma", "Adobe XD", "Sketch"],
    },
    {
      "id": "EMP-003",
      "name": "Michael Davis",
      "position": "Marketing Manager",
      "department": "Marketing",
      "email": "michael.davis@company.com", 
      "phone": "+1 (555) 345-6789",
      "avatar": "https://picsum.photos/100/100?random=13&keyword=face",
      "salary": 85000,
      "joinDate": "2021-11-10",
      "status": "Active",
      "skills": ["SEO", "Content Marketing", "Analytics"],
    },
    {
      "id": "EMP-004",
      "name": "Emma Wilson",
      "position": "Sales Representative",
      "department": "Sales",
      "email": "emma.wilson@company.com",
      "phone": "+1 (555) 456-7890",
      "avatar": "https://picsum.photos/100/100?random=14&keyword=face",
      "salary": 65000,
      "joinDate": "2023-05-12",
      "status": "On Leave",
      "skills": ["CRM", "Negotiation", "Lead Generation"],
    },
    {
      "id": "EMP-005",
      "name": "Robert Martinez",
      "position": "HR Specialist",
      "department": "HR",
      "email": "robert.martinez@company.com",
      "phone": "+1 (555) 567-8901",
      "avatar": "https://picsum.photos/100/100?random=15&keyword=face",
      "salary": 70000,
      "joinDate": "2022-08-05",
      "status": "Active",
      "skills": ["Recruitment", "Training", "Employee Relations"],
    },
  ];

  List<Map<String, dynamic>> get filteredEmployees {
    return employees.where((employee) {
      bool matchesSearch = "${employee["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${employee["position"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${employee["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesDepartment = selectedDepartment == "All" || employee["department"] == selectedDepartment;
      return matchesSearch && matchesDepartment;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "On Leave":
        return warningColor;
      case "Inactive":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Directory"),
        actions: [
          Icon(Icons.person_add),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(10), primaryColor.withAlpha(5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.group,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Total Employees",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${employees.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search employees",
                    value: searchQuery,
                    hint: "Search by name, position, or ID...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
              label: "Department",
              items: departmentOptions,
              value: selectedDepartment,
              onChanged: (value, label) {
                selectedDepartment = value;
                setState(() {});
              },
            ),

            Text(
              "Employees (${filteredEmployees.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredEmployees.length,
              itemBuilder: (context, index) {
                final employee = filteredEmployees[index];
                final statusColor = getStatusColor("${employee["status"]}");
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage("${employee["avatar"]}"),
                              ),
                              Positioned(
                                bottom: 2,
                                right: 2,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${employee["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${employee["id"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${employee["position"]}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: secondaryColor,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${employee["department"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: disabledBoldColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${employee["email"]}",
                                    style: TextStyle(
                                      fontSize: 14,
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
                                  color: disabledBoldColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${employee["phone"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "Join Date",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${employee["joinDate"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: spXs,
                              children: [
                                Text(
                                  "Salary",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((employee["salary"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: double.infinity,
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
                              "Skills:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (employee["skills"] as List).map((skill) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$skill",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: infoColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

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
                            icon: Icons.message,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.call,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
