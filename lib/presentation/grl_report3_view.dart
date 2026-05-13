import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReport3View extends StatefulWidget {
  @override
  State<GrlReport3View> createState() => _GrlReport3ViewState();
}

class _GrlReport3ViewState extends State<GrlReport3View> {
  int selectedTab = 0;
  String selectedDepartment = "all";
  
  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "all"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Sales", "value": "sales"},
    {"label": "HR", "value": "hr"},
  ];

  List<Map<String, dynamic>> employees = [
    {
      "name": "John Smith",
      "position": "Senior Developer",
      "department": "Engineering",
      "email": "john.smith@company.com",
      "phone": "+1 (555) 123-4567",
      "hireDate": "2022-03-15",
      "salary": 95000.0,
      "status": "active",
      "performance": "excellent",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=man",
    },
    {
      "name": "Sarah Johnson",
      "position": "Marketing Manager",
      "department": "Marketing",
      "email": "sarah.johnson@company.com",
      "phone": "+1 (555) 234-5678",
      "hireDate": "2021-08-20",
      "salary": 75000.0,
      "status": "active",
      "performance": "good",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=woman",
    },
    {
      "name": "Mike Brown",
      "position": "Sales Representative",
      "department": "Sales",
      "email": "mike.brown@company.com",
      "phone": "+1 (555) 345-6789",
      "hireDate": "2023-01-10",
      "salary": 55000.0,
      "status": "on_leave",
      "performance": "average",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=man",
    },
    {
      "name": "Emma Davis",
      "position": "HR Specialist",
      "department": "HR",
      "email": "emma.davis@company.com",
      "phone": "+1 (555) 456-7890",
      "hireDate": "2022-11-05",
      "salary": 65000.0,
      "status": "active",
      "performance": "excellent",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=woman",
    },
    {
      "name": "David Wilson",
      "position": "DevOps Engineer",
      "department": "Engineering",
      "email": "david.wilson@company.com",
      "phone": "+1 (555) 567-8901",
      "hireDate": "2021-05-12",
      "salary": 88000.0,
      "status": "active",
      "performance": "good",
      "avatar": "https://picsum.photos/60/60?random=5&keyword=man",
    },
  ];

  List<Map<String, dynamic>> attendanceData = [
    {
      "employee": "John Smith",
      "date": "2024-12-22",
      "checkIn": "09:00",
      "checkOut": "18:00",
      "hoursWorked": 8.0,
      "status": "present",
    },
    {
      "employee": "Sarah Johnson",
      "date": "2024-12-22",
      "checkIn": "08:45",
      "checkOut": "17:30",
      "hoursWorked": 7.75,
      "status": "present",
    },
    {
      "employee": "Mike Brown",
      "date": "2024-12-22",
      "checkIn": "-",
      "checkOut": "-",
      "hoursWorked": 0.0,
      "status": "absent",
    },
    {
      "employee": "Emma Davis",
      "date": "2024-12-22",
      "checkIn": "09:15",
      "checkOut": "18:15",
      "hoursWorked": 8.0,
      "status": "present",
    },
    {
      "employee": "David Wilson",
      "date": "2024-12-22",
      "checkIn": "08:30",
      "checkOut": "17:45",
      "hoursWorked": 8.25,
      "status": "present",
    },
  ];

  List<Map<String, dynamic>> payrollData = [
    {
      "employee": "John Smith",
      "baseSalary": 95000.0,
      "overtime": 2400.0,
      "bonus": 5000.0,
      "deductions": 1200.0,
      "netPay": 101200.0,
      "payPeriod": "December 2024",
    },
    {
      "employee": "Sarah Johnson",
      "baseSalary": 75000.0,
      "overtime": 800.0,
      "bonus": 2500.0,
      "deductions": 900.0,
      "netPay": 77400.0,
      "payPeriod": "December 2024",
    },
    {
      "employee": "Mike Brown",
      "baseSalary": 55000.0,
      "overtime": 400.0,
      "bonus": 1000.0,
      "deductions": 650.0,
      "netPay": 55750.0,
      "payPeriod": "December 2024",
    },
    {
      "employee": "Emma Davis",
      "baseSalary": 65000.0,
      "overtime": 600.0,
      "bonus": 2000.0,
      "deductions": 750.0,
      "netPay": 66850.0,
      "payPeriod": "December 2024",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "HR Report",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Employees", icon: Icon(Icons.people)),
        Tab(text: "Attendance", icon: Icon(Icons.access_time)),
        Tab(text: "Payroll", icon: Icon(Icons.payment)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildEmployeesTab(),
        _buildAttendanceTab(),
        _buildPayrollTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildHRMetrics(),
          _buildDepartmentBreakdown(),
          _buildRecentActivities(),
        ],
      ),
    );
  }

  Widget _buildHRMetrics() {
    List<Map<String, dynamic>> metrics = [
      {
        "title": "Total Employees",
        "value": employees.length.toString(),
        "subtitle": "Active workforce",
        "icon": Icons.people,
        "color": primaryColor,
      },
      {
        "title": "Present Today",
        "value": attendanceData.where((a) => a["status"] == "present").length.toString(),
        "subtitle": "Out of ${attendanceData.length}",
        "icon": Icons.check_circle,
        "color": successColor,
      },
      {
        "title": "On Leave",
        "value": employees.where((e) => e["status"] == "on_leave").length.toString(),
        "subtitle": "Currently away",
        "icon": Icons.event_busy,
        "color": warningColor,
      },
      {
        "title": "Avg. Salary",
        "value": "\$${((employees.fold(0.0, (sum, emp) => sum + (emp["salary"] as double)) / employees.length)).toStringAsFixed(0)}",
        "subtitle": "Company average",
        "icon": Icons.attach_money,
        "color": infoColor,
      },
    ];

    return ResponsiveGridView(
      minItemWidth: 200,
      children: metrics.map((metric) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: (metric["color"] as Color).withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      metric["icon"] as IconData,
                      color: metric["color"] as Color,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${metric["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${metric["value"]}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${metric["subtitle"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDepartmentBreakdown() {
    Map<String, int> departmentCounts = {};
    for (var emp in employees) {
      String dept = emp["department"] as String;
      departmentCounts[dept] = (departmentCounts[dept] ?? 0) + 1;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Department Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: departmentCounts.entries.map((entry) {
              Color deptColor = entry.key == "Engineering" ? primaryColor :
                               entry.key == "Marketing" ? infoColor :
                               entry.key == "Sales" ? successColor : warningColor;

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: deptColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: deptColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        entry.key,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${entry.value} ${entry.value == 1 ? 'employee' : 'employees'}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
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

  Widget _buildRecentActivities() {
    List<Map<String, dynamic>> activities = [
      {
        "type": "New Hire",
        "description": "Mike Brown joined Sales team",
        "date": "2024-12-20",
        "icon": Icons.person_add,
        "color": successColor,
      },
      {
        "type": "Performance Review",
        "description": "John Smith received excellent rating",
        "date": "2024-12-19",
        "icon": Icons.star,
        "color": warningColor,
      },
      {
        "type": "Leave Request",
        "description": "Sarah Johnson requested 3 days off",
        "date": "2024-12-18",
        "icon": Icons.event_busy,
        "color": infoColor,
      },
      {
        "type": "Salary Adjustment",
        "description": "Emma Davis received salary increase",
        "date": "2024-12-17",
        "icon": Icons.trending_up,
        "color": primaryColor,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent HR Activities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: activities.map((activity) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: (activity["color"] as Color).withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        activity["icon"] as IconData,
                        color: activity["color"] as Color,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${activity["type"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${activity["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${activity["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
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

  Widget _buildEmployeesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildDepartmentFilter(),
          _buildEmployeesList(),
        ],
      ),
    );
  }

  Widget _buildDepartmentFilter() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filter by Department",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QCategoryPicker(
            items: departments,
            value: selectedDepartment,
            onChanged: (index, label, value, item) {
              selectedDepartment = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeesList() {
    List<Map<String, dynamic>> filteredEmployees = selectedDepartment == "all" 
        ? employees 
        : employees.where((emp) => (emp["department"] as String).toLowerCase() == selectedDepartment).toList();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Employee Directory (${filteredEmployees.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: filteredEmployees.map((employee) {
              Color statusColor = employee["status"] == "active" ? successColor : warningColor;
              Color performanceColor = employee["performance"] == "excellent" ? successColor :
                                     employee["performance"] == "good" ? infoColor : warningColor;

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: statusColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusLg),
                        image: DecorationImage(
                          image: NetworkImage("${employee["avatar"]}"),
                          fit: BoxFit.cover,
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${employee["position"]} • ${employee["department"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${employee["email"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${((employee["salary"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: performanceColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${employee["performance"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
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

  Widget _buildAttendanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAttendanceSummary(),
          _buildTodayAttendance(),
        ],
      ),
    );
  }

  Widget _buildAttendanceSummary() {
    int presentCount = attendanceData.where((a) => a["status"] == "present").length;
    int absentCount = attendanceData.where((a) => a["status"] == "absent").length;
    double totalHours = attendanceData.fold(0.0, (sum, a) => sum + (a["hoursWorked"] as double));

    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "Present Today",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "$presentCount",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.cancel,
                      color: dangerColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "Absent Today",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "$absentCount",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.access_time,
                      color: infoColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "Total Hours",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${totalHours.toStringAsFixed(1)}h",
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
    );
  }

  Widget _buildTodayAttendance() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Attendance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: attendanceData.map((attendance) {
              Color statusColor = attendance["status"] == "present" ? successColor : dangerColor;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: statusColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${attendance["employee"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Check In: ${attendance["checkIn"]} • Check Out: ${attendance["checkOut"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${(attendance["hoursWorked"] as double).toStringAsFixed(1)}h",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${attendance["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
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

  Widget _buildPayrollTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPayrollSummary(),
          _buildPayrollDetails(),
        ],
      ),
    );
  }

  Widget _buildPayrollSummary() {
    double totalPayroll = payrollData.fold(0.0, (sum, p) => sum + (p["netPay"] as double));
    double totalOvertime = payrollData.fold(0.0, (sum, p) => sum + (p["overtime"] as double));
    double totalBonus = payrollData.fold(0.0, (sum, p) => sum + (p["bonus"] as double));

    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.attach_money,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "Total Payroll",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "\$${totalPayroll.currency}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.schedule,
                      color: warningColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "Total Overtime",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "\$${totalOvertime.currency}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.star,
                      color: successColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "Total Bonus",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "\$${totalBonus.currency}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPayrollDetails() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payroll Details - December 2024",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: payrollData.map((payroll) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: successColor,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${payroll["employee"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "\$${((payroll["netPay"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Base: \$${((payroll["baseSalary"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Overtime: \$${((payroll["overtime"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Bonus: \$${((payroll["bonus"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Deductions: \$${((payroll["deductions"] as double)).currency}",
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
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
