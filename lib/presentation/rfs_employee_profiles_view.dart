import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsEmployeeProfilesView extends StatefulWidget {
  const RfsEmployeeProfilesView({super.key});

  @override
  State<RfsEmployeeProfilesView> createState() => _RfsEmployeeProfilesViewState();
}

class _RfsEmployeeProfilesViewState extends State<RfsEmployeeProfilesView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedDepartment = "";

  List<Map<String, dynamic>> employees = [
    {
      "id": "EMP001",
      "name": "John Smith",
      "position": "Head Chef",
      "department": "Kitchen",
      "avatar": "https://picsum.photos/120/120?random=1&keyword=person",
      "phone": "+1-555-0101",
      "email": "john.smith@restaurant.com",
      "address": "123 Main St, City, State 12345",
      "emergency_contact": "Jane Smith - +1-555-0111",
      "hire_date": "2022-01-15",
      "birth_date": "1985-06-20",
      "ssn": "***-**-1234",
      "salary": 55000,
      "benefits": ["Health Insurance", "Dental", "401k", "Paid Time Off"],
      "certifications": ["Food Safety Manager", "Kitchen Management", "HACCP"],
      "skills": ["Leadership", "Menu Development", "Cost Control", "Team Management"],
      "performance_reviews": [
        {"date": "2024-01-15", "score": 95, "notes": "Excellent leadership and kitchen management"},
        {"date": "2023-07-15", "score": 92, "notes": "Strong performance, good team collaboration"},
        {"date": "2023-01-15", "score": 89, "notes": "Solid work, room for improvement in cost control"},
      ],
      "training_records": [
        {"course": "Advanced Culinary Techniques", "date": "2024-02-10", "status": "Completed"},
        {"course": "Food Safety Refresher", "date": "2024-01-05", "status": "Completed"},
        {"course": "Leadership Development", "date": "2023-11-20", "status": "Completed"},
      ],
      "disciplinary_actions": [],
      "status": "Active",
    },
    {
      "id": "EMP002",
      "name": "Sarah Johnson", 
      "position": "Sous Chef",
      "department": "Kitchen",
      "avatar": "https://picsum.photos/120/120?random=2&keyword=person",
      "phone": "+1-555-0102",
      "email": "sarah.johnson@restaurant.com",
      "address": "456 Oak Ave, City, State 12345",
      "emergency_contact": "Mike Johnson - +1-555-0112",
      "hire_date": "2022-03-20",
      "birth_date": "1990-02-14",
      "ssn": "***-**-5678",
      "salary": 45000,
      "benefits": ["Health Insurance", "Dental", "Paid Time Off"],
      "certifications": ["Food Safety", "Culinary Arts Degree"],
      "skills": ["Menu Planning", "Food Preparation", "Quality Control", "Training"],
      "performance_reviews": [
        {"date": "2024-03-20", "score": 88, "notes": "Consistent performance, creative menu contributions"},
        {"date": "2023-09-20", "score": 85, "notes": "Good technical skills, developing leadership"},
        {"date": "2023-03-20", "score": 82, "notes": "Shows promise, needs more experience"},
      ],
      "training_records": [
        {"course": "Pastry Fundamentals", "date": "2024-01-15", "status": "Completed"},
        {"course": "Food Safety Certification", "date": "2023-12-10", "status": "Completed"},
      ],
      "disciplinary_actions": [
        {"date": "2023-08-15", "type": "Verbal Warning", "reason": "Late arrival"},
      ],
      "status": "Active",
    },
    {
      "id": "EMP003",
      "name": "Mike Wilson",
      "position": "Senior Server",
      "department": "Front of House",
      "avatar": "https://picsum.photos/120/120?random=3&keyword=person",
      "phone": "+1-555-0103",
      "email": "mike.wilson@restaurant.com",
      "address": "789 Pine St, City, State 12345",
      "emergency_contact": "Lisa Wilson - +1-555-0113",
      "hire_date": "2023-06-10",
      "birth_date": "1992-11-08",
      "ssn": "***-**-9012",
      "salary": 32000,
      "benefits": ["Health Insurance", "Paid Time Off"],
      "certifications": ["Customer Service Excellence", "POS System", "Wine Service"],
      "skills": ["Customer Relations", "Upselling", "Conflict Resolution", "Team Collaboration"],
      "performance_reviews": [
        {"date": "2024-06-10", "score": 92, "notes": "Exceptional customer service, strong sales"},
        {"date": "2023-12-10", "score": 87, "notes": "Quick learner, positive attitude"},
      ],
      "training_records": [
        {"course": "Wine Service Certification", "date": "2024-03-01", "status": "Completed"},
        {"course": "Customer Service Training", "date": "2023-07-15", "status": "Completed"},
        {"course": "New Employee Orientation", "date": "2023-06-12", "status": "Completed"},
      ],
      "disciplinary_actions": [],
      "status": "Active",
    },
    {
      "id": "EMP004",
      "name": "Emily Davis",
      "position": "Head Bartender",
      "department": "Bar",
      "avatar": "https://picsum.photos/120/120?random=4&keyword=person",
      "phone": "+1-555-0104",
      "email": "emily.davis@restaurant.com",
      "address": "321 Elm Dr, City, State 12345",
      "emergency_contact": "Robert Davis - +1-555-0114",
      "hire_date": "2022-11-05",
      "birth_date": "1988-04-25",
      "ssn": "***-**-3456",
      "salary": 38000,
      "benefits": ["Health Insurance", "Dental", "Paid Time Off"],
      "certifications": ["Responsible Service of Alcohol", "Mixology Advanced", "Bar Management"],
      "skills": ["Cocktail Creation", "Inventory Management", "Customer Engagement", "Staff Training"],
      "performance_reviews": [
        {"date": "2024-05-05", "score": 89, "notes": "Creative cocktails, good bar management"},
        {"date": "2023-11-05", "score": 86, "notes": "Strong technical skills, developing leadership"},
      ],
      "training_records": [
        {"course": "Advanced Mixology", "date": "2024-02-20", "status": "Completed"},
        {"course": "Bar Management", "date": "2023-12-01", "status": "Completed"},
        {"course": "Responsible Service", "date": "2023-01-10", "status": "Completed"},
      ],
      "disciplinary_actions": [],
      "status": "Active",
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

  List<Map<String, dynamic>> get filteredEmployees {
    return employees.where((employee) {
      bool matchesSearch = searchQuery.isEmpty ||
          (employee["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (employee["position"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (employee["id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesDepartment = selectedDepartment.isEmpty || employee["department"] == selectedDepartment;
      
      return matchesSearch && matchesDepartment;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Employee Profiles",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Profiles", icon: Icon(Icons.person)),
        Tab(text: "Directory", icon: Icon(Icons.contacts)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildProfilesTab(),
        _buildDirectoryTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildProfilesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildEmployeeGrid(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search Employees",
          value: searchQuery,
          hint: "Search by name, position, or ID",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        QDropdownField(
          label: "Filter by Department",
          items: departments,
          value: selectedDepartment,
          onChanged: (value, label) {
            selectedDepartment = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildEmployeeGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: filteredEmployees.map((employee) => _buildEmployeeCard(employee)).toList(),
    );
  }

  Widget _buildEmployeeCard(Map<String, dynamic> employee) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage("${employee["avatar"]}"),
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
          Text(
            "${employee["position"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${employee["department"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Profile",
              size: bs.sm,
              onPressed: () => _showEmployeeDetails(employee),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildDirectoryList(),
        ],
      ),
    );
  }

  Widget _buildDirectoryList() {
    return Column(
      children: filteredEmployees.map((employee) => _buildDirectoryCard(employee)).toList(),
    );
  }

  Widget _buildDirectoryCard(Map<String, dynamic> employee) {
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
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage("${employee["avatar"]}"),
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
                Text(
                  "${employee["position"]} • ${employee["department"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${employee["email"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
                Text(
                  "${employee["phone"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.email,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildEmployeeStats(),
          _buildDepartmentBreakdown(),
          _buildPerformanceMetrics(),
        ],
      ),
    );
  }

  Widget _buildEmployeeStats() {
    int totalEmployees = employees.length;
    double avgSalary = employees.fold(0.0, (sum, emp) => sum + (emp["salary"] as int)) / totalEmployees;
    int activeCertifications = employees.fold(0, (sum, emp) => sum + (emp["certifications"] as List).length);
    
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 160,
      children: [
        _buildStatCard("Total Employees", "$totalEmployees", Icons.people, primaryColor),
        _buildStatCard("Avg Salary", "\$${(avgSalary / 1000).toStringAsFixed(1)}K", Icons.attach_money, successColor),
        _buildStatCard("Certifications", "$activeCertifications", Icons.school, infoColor),
        _buildStatCard("Departments", "${departments.length - 1}", Icons.business, warningColor),
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
        children: [
          Icon(icon, color: color, size: 24),
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
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentBreakdown() {
    Map<String, int> departmentCounts = {};
    for (var employee in employees) {
      String dept = employee["department"] as String;
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
            "Department Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...departmentCounts.entries.map((entry) => 
            Container(
              margin: EdgeInsets.only(bottom: spSm),
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
                      value: entry.value / employees.length,
                      backgroundColor: disabledColor.withAlpha(30),
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "${entry.value} (${((entry.value / employees.length) * 100).toStringAsFixed(1)}%)",
                    style: TextStyle(
                      fontSize: 12,
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

  Widget _buildPerformanceMetrics() {
    double avgPerformance = 0;
    int totalReviews = 0;
    
    for (var employee in employees) {
      List reviews = employee["performance_reviews"] as List;
      if (reviews.isNotEmpty) {
        double empAvg = reviews.fold(0.0, (sum, review) => sum + (review["score"] as int)) / reviews.length;
        avgPerformance += empAvg;
        totalReviews += reviews.length;
      }
    }
    
    avgPerformance = avgPerformance / employees.length;

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
            "Performance Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildMetricCard("Avg Performance", "${avgPerformance.toStringAsFixed(1)}%", successColor),
              _buildMetricCard("Total Reviews", "$totalReviews", infoColor),
              _buildMetricCard("High Performers", "${employees.where((e) => (e["performance_reviews"] as List).isNotEmpty && (e["performance_reviews"] as List).last["score"] >= 90).length}", primaryColor),
              _buildMetricCard("Training Records", "${employees.fold(0, (sum, e) => sum + (e["training_records"] as List).length)}", warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
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
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showEmployeeDetails(Map<String, dynamic> employee) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage("${employee["avatar"]}"),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${employee["name"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${employee["position"]} • ${employee["department"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "ID: ${employee["id"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.close,
                  size: bs.sm,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    _buildDetailSection("Contact Information", [
                      "Email: ${employee["email"]}",
                      "Phone: ${employee["phone"]}",
                      "Address: ${employee["address"]}",
                      "Emergency Contact: ${employee["emergency_contact"]}",
                    ]),
                    _buildDetailSection("Employment Details", [
                      "Hire Date: ${employee["hire_date"]}",
                      "Birth Date: ${employee["birth_date"]}",
                      "SSN: ${employee["ssn"]}",
                      "Salary: \$${((employee["salary"] as int)).currency}",
                    ]),
                    _buildDetailSection("Benefits", (employee["benefits"] as List).cast<String>()),
                    _buildDetailSection("Certifications", (employee["certifications"] as List).cast<String>()),
                    _buildDetailSection("Skills", (employee["skills"] as List).cast<String>()),
                    _buildPerformanceSection(employee),
                    _buildTrainingSection(employee),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<String> items) {
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
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...items.map((item) => Padding(
            padding: EdgeInsets.only(bottom: spXs),
            child: Text(
              item,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPerformanceSection(Map<String, dynamic> employee) {
    List reviews = employee["performance_reviews"] as List;
    
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
            "Performance Reviews",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...reviews.map((review) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${review["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${review["score"]}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${review["notes"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTrainingSection(Map<String, dynamic> employee) {
    List training = employee["training_records"] as List;
    
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
            "Training Records",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...training.map((record) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.school, color: successColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${record["course"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${record["date"]} • ${record["status"]}",
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
          )),
        ],
      ),
    );
  }
}
