import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaSalaryManagementView extends StatefulWidget {
  const RhaSalaryManagementView({super.key});

  @override
  State<RhaSalaryManagementView> createState() => _RhaSalaryManagementViewState();
}

class _RhaSalaryManagementViewState extends State<RhaSalaryManagementView> {
  int currentTab = 0;
  String selectedDepartment = "all";
  String selectedPayGrade = "all";
  String selectedStatus = "all";
  String searchQuery = "";
  bool showPendingOnly = false;

  List<Map<String, dynamic>> salaryData = [
    {
      "id": "SAL001",
      "employee": "Sarah Johnson",
      "employeeId": "EMP001",
      "department": "Engineering",
      "position": "Senior Developer",
      "payGrade": "G7",
      "currentSalary": 95000.0,
      "proposedSalary": 103000.0,
      "salaryIncrease": 8000.0,
      "increasePercentage": 8.42,
      "effectiveDate": "2024-01-01",
      "lastIncrease": "2023-06-15",
      "nextReview": "2024-06-15",
      "status": "approved",
      "approvedBy": "John Smith",
      "approvedDate": "2024-12-10",
      "reason": "Merit increase - exceptional performance",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=woman",
      "yearsInRole": 2.5,
      "performanceRating": 4.8,
    },
    {
      "id": "SAL002",
      "employee": "Michael Chen",
      "employeeId": "EMP002",
      "department": "Marketing",
      "position": "Marketing Manager",
      "payGrade": "G6",
      "currentSalary": 78000.0,
      "proposedSalary": 83000.0,
      "salaryIncrease": 5000.0,
      "increasePercentage": 6.41,
      "effectiveDate": "2024-03-01",
      "lastIncrease": "2023-03-01",
      "nextReview": "2024-09-01",
      "status": "pending",
      "reason": "Market adjustment and performance increase",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=man",
      "yearsInRole": 1.8,
      "performanceRating": 4.2,
    },
    {
      "id": "SAL003",
      "employee": "Emily Rodriguez",
      "employeeId": "EMP003",
      "department": "Design",
      "position": "UI/UX Designer",
      "payGrade": "G5",
      "currentSalary": 72000.0,
      "proposedSalary": 76000.0,
      "salaryIncrease": 4000.0,
      "increasePercentage": 5.56,
      "effectiveDate": "2024-02-15",
      "lastIncrease": "2023-08-15",
      "nextReview": "2024-08-15",
      "status": "rejected",
      "rejectedBy": "Jane Wilson",
      "rejectedDate": "2024-12-08",
      "rejectionReason": "Budget constraints - defer to next quarter",
      "reason": "Annual merit increase",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=woman",
      "yearsInRole": 1.2,
      "performanceRating": 4.0,
    }
  ];

  List<Map<String, dynamic>> payGrades = [
    {
      "grade": "G5",
      "title": "Individual Contributor",
      "minSalary": 65000,
      "midSalary": 75000,
      "maxSalary": 85000,
      "employeeCount": 12,
      "avgSalary": 72400,
    },
    {
      "grade": "G6",
      "title": "Senior Individual Contributor",
      "minSalary": 75000,
      "midSalary": 85000,
      "maxSalary": 95000,
      "employeeCount": 8,
      "avgSalary": 81200,
    },
    {
      "grade": "G7",
      "title": "Lead/Principal",
      "minSalary": 90000,
      "midSalary": 105000,
      "maxSalary": 120000,
      "employeeCount": 5,
      "avgSalary": 98600,
    },
    {
      "grade": "G8",
      "title": "Management",
      "minSalary": 110000,
      "midSalary": 130000,
      "maxSalary": 150000,
      "employeeCount": 3,
      "avgSalary": 125000,
    }
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "all"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Design", "value": "design"},
    {"label": "Sales", "value": "sales"},
  ];

  List<Map<String, dynamic>> payGradeOptions = [
    {"label": "All Pay Grades", "value": "all"},
    {"label": "G5 - Individual Contributor", "value": "G5"},
    {"label": "G6 - Senior IC", "value": "G6"},
    {"label": "G7 - Lead/Principal", "value": "G7"},
    {"label": "G8 - Management", "value": "G8"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "Rejected", "value": "rejected"},
    {"label": "Processed", "value": "processed"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Salary Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Salaries", icon: Icon(Icons.attach_money)),
        Tab(text: "Pay Grades", icon: Icon(Icons.grade)),
        Tab(text: "Reviews", icon: Icon(Icons.rate_review)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildSalariesTab(),
        _buildPayGradesTab(),
        _buildReviewsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Salary Budget", "\$2.8M", Icons.account_balance, primaryColor),
              _buildStatCard("Average Salary", "\$87.5K", Icons.trending_up, successColor),
              _buildStatCard("Pending Reviews", "12", Icons.pending_actions, warningColor),
              _buildStatCard("Merit Budget Used", "68%", Icons.pie_chart, infoColor),
            ],
          ),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Salary Review Cycle",
                        icon: Icons.rate_review,
                        size: bs.sm,
                        onPressed: () => _startSalaryReviewCycle(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Bulk Salary Update",
                        icon: Icons.update,
                        size: bs.sm,
                        onPressed: () => _bulkSalaryUpdate(),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Market Analysis",
                        icon: Icons.analytics,
                        size: bs.sm,
                        onPressed: () => _marketAnalysis(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Export Report",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () => _exportSalaryReport(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Department Salary Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Department Salary Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(4, (index) {
                  final departments = [
                    {"name": "Engineering", "avgSalary": 98500, "employees": 12, "budget": 1182000, "color": primaryColor},
                    {"name": "Marketing", "avgSalary": 76200, "employees": 8, "budget": 609600, "color": successColor},
                    {"name": "Design", "avgSalary": 71800, "employees": 6, "budget": 430800, "color": warningColor},
                    {"name": "Sales", "avgSalary": 82400, "employees": 9, "budget": 741600, "color": infoColor},
                  ];
                  final dept = departments[index];
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: (dept["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.business,
                            color: dept["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${dept["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${dept["employees"]} employees • Budget: \$${((dept["budget"] as num) / 1000).toInt()}K",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${((dept["avgSalary"] as num) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: dept["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // Recent Salary Changes
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Recent Salary Changes",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...salaryData.where((salary) => salary["status"] == "approved").take(3).map((salary) => 
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage("${salary["avatar"]}"),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${salary["employee"]} - ${salary["position"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Increased by \$${((salary["salaryIncrease"] as num).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "+${(salary["increasePercentage"] as num).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalariesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Container(
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
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search employees...",
                        value: searchQuery,
                        hint: "Name or position",
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
                Row(
                  spacing: spSm,
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
                    Expanded(
                      child: QDropdownField(
                        label: "Pay Grade",
                        items: payGradeOptions,
                        value: selectedPayGrade,
                        onChanged: (value, label) {
                          selectedPayGrade = value;
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
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Show pending reviews only",
                            "value": true,
                            "checked": showPendingOnly,
                          }
                        ],
                        value: [
                          if (showPendingOnly)
                            {
                              "label": "Show pending reviews only",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          showPendingOnly = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                    QButton(
                      label: "Add Salary Review",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () => _addSalaryReview(),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Salary Records
          ...salaryData.map((salary) => _buildSalaryCard(salary)),
        ],
      ),
    );
  }

  Widget _buildPayGradesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Pay Grade Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Text(
                      "Pay Grade Structure",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Edit Structure",
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () => _editPayGradeStructure(),
                    ),
                  ],
                ),
                Text(
                  "Define salary ranges and progression paths for different roles",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Pay Grade Cards
          ...payGrades.map((grade) => _buildPayGradeCard(grade)),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Review Schedule
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Review Schedule",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Q1 Reviews (Jan-Mar)",
                        size: bs.sm,
                        onPressed: () => _viewQuarterlyReviews("Q1"),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Q2 Reviews (Apr-Jun)",
                        size: bs.sm,
                        onPressed: () => _viewQuarterlyReviews("Q2"),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Q3 Reviews (Jul-Sep)",
                        size: bs.sm,
                        onPressed: () => _viewQuarterlyReviews("Q3"),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Q4 Reviews (Oct-Dec)",
                        size: bs.sm,
                        onPressed: () => _viewQuarterlyReviews("Q4"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Upcoming Reviews
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Upcoming Reviews",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(5, (index) {
                  final upcomingReviews = [
                    {"employee": "David Wilson", "department": "Engineering", "dueDate": "2025-01-15", "type": "Annual Review"},
                    {"employee": "Lisa Brown", "department": "Marketing", "dueDate": "2025-01-20", "type": "Merit Review"},
                    {"employee": "James Davis", "department": "Sales", "dueDate": "2025-02-01", "type": "Promotion Review"},
                    {"employee": "Anna Garcia", "department": "Design", "dueDate": "2025-02-10", "type": "Annual Review"},
                    {"employee": "Robert Taylor", "department": "Engineering", "dueDate": "2025-02-15", "type": "Merit Review"},
                  ];
                  final review = upcomingReviews[index];
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.schedule,
                            color: warningColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${review["employee"]} - ${review["department"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${review["type"]} • Due: ${review["dueDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          label: "Schedule",
                          size: bs.sm,
                          onPressed: () => _scheduleReview(review),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
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
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalaryCard(Map<String, dynamic> salary) {
    Color statusColor = salary["status"] == "approved" 
        ? successColor 
        : salary["status"] == "pending" 
            ? warningColor 
            : dangerColor;

    return Container(
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
        spacing: spSm,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${salary["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${salary["employee"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${salary["department"]} • ${salary["position"]} • ${salary["payGrade"]}",
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
                  "${salary["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          
          // Salary Change Details
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text("Current Salary:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${((salary["currentSalary"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                if (salary["proposedSalary"] != null) ...[
                  Row(
                    children: [
                      Text("Proposed Salary:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                      Spacer(),
                      Text("\$${((salary["proposedSalary"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: primaryColor)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Increase:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text(
                        "+\$${((salary["salaryIncrease"] as num).toDouble()).currency} (+${(salary["increasePercentage"] as num).toStringAsFixed(1)}%)",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: successColor),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Additional Info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Performance",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        ...List.generate(5, (index) => Icon(
                          index < (salary["performanceRating"] as num).floor() ? Icons.star : Icons.star_border,
                          color: warningColor,
                          size: 16,
                        )),
                        SizedBox(width: spXs),
                        Text(
                          "${salary["performanceRating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Years in Role",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${salary["yearsInRole"]} years",
                      style: TextStyle(
                        fontSize: 12,
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
                      "Next Review",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${salary["nextReview"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Reason
          if (salary["reason"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: primaryColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${salary["reason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Rejection Reason
          if (salary["status"] == "rejected" && salary["rejectionReason"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Rejected: ${salary["rejectionReason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewSalaryDetails(salary),
                ),
              ),
              if (salary["status"] == "pending") ...[
                QButton(
                  icon: Icons.check,
                  size: bs.sm,
                  onPressed: () => _approveSalary(salary),
                ),
                QButton(
                  icon: Icons.close,
                  size: bs.sm,
                  onPressed: () => _rejectSalary(salary),
                ),
              ],
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editSalary(salary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPayGradeCard(Map<String, dynamic> grade) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Center(
                  child: Text(
                    "${grade["grade"]}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${grade["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${grade["employeeCount"]} employees",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\$${((grade["avgSalary"] as num) / 1000).toInt()}K",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          // Salary Range
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text("Minimum:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${((grade["minSalary"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  children: [
                    Text("Midpoint:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${((grade["midSalary"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: primaryColor)),
                  ],
                ),
                Row(
                  children: [
                    Text("Maximum:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${((grade["maxSalary"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  children: [
                    Text("Current Average:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    Spacer(),
                    Text("\$${((grade["avgSalary"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: successColor)),
                  ],
                ),
              ],
            ),
          ),

          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Employees",
                  size: bs.sm,
                  onPressed: () => _viewGradeEmployees(grade),
                ),
              ),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editPayGrade(grade),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _startSalaryReviewCycle() {
    // Navigate to salary review cycle setup
  }

  void _bulkSalaryUpdate() {
    // Navigate to bulk salary update tool
  }

  void _marketAnalysis() {
    // Navigate to market analysis tool
  }

  void _exportSalaryReport() {
    // Navigate to export salary report
  }

  void _addSalaryReview() {
    // Navigate to add salary review form
  }

  void _editPayGradeStructure() {
    // Navigate to edit pay grade structure
  }

  void _viewQuarterlyReviews(String quarter) {
    // Navigate to quarterly reviews for specific quarter
  }

  void _scheduleReview(Map<String, dynamic> review) {
    // Navigate to schedule review functionality
  }

  void _viewSalaryDetails(Map<String, dynamic> salary) {
    // Navigate to detailed salary view
  }

  void _approveSalary(Map<String, dynamic> salary) {
    salary["status"] = "approved";
    salary["approvedDate"] = DateTime.now().toIso8601String();
    salary["approvedBy"] = "Current User";
    setState(() {});
    ss("Salary increase approved successfully");
  }

  void _rejectSalary(Map<String, dynamic> salary) {
    // Navigate to rejection reason dialog
  }

  void _editSalary(Map<String, dynamic> salary) {
    // Navigate to edit salary form
  }

  void _viewGradeEmployees(Map<String, dynamic> grade) {
    // Navigate to view employees in pay grade
  }

  void _editPayGrade(Map<String, dynamic> grade) {
    // Navigate to edit pay grade form
  }
}
