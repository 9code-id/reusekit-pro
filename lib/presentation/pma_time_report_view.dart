import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTimeReportView extends StatefulWidget {
  const PmaTimeReportView({super.key});

  @override
  State<PmaTimeReportView> createState() => _PmaTimeReportViewState();
}

class _PmaTimeReportViewState extends State<PmaTimeReportView> {
  String selectedReportType = "Summary Report";
  String selectedPeriod = "This Month";
  String selectedEmployee = "All Employees";
  String selectedProject = "All Projects";
  
  List<Map<String, dynamic>> reportTypeOptions = [
    {"label": "Summary Report", "value": "Summary Report"},
    {"label": "Detailed Report", "value": "Detailed Report"},
    {"label": "Billable Hours", "value": "Billable Hours"},
    {"label": "Project Report", "value": "Project Report"},
    {"label": "Employee Report", "value": "Employee Report"},
  ];
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "Last Week", "value": "Last Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];
  
  List<Map<String, dynamic>> employeeOptions = [
    {"label": "All Employees", "value": "All Employees"},
    {"label": "Alex Johnson", "value": "Alex Johnson"},
    {"label": "Sarah Chen", "value": "Sarah Chen"},
    {"label": "Mike Rodriguez", "value": "Mike Rodriguez"},
    {"label": "Emily Davis", "value": "Emily Davis"},
    {"label": "James Wilson", "value": "James Wilson"},
  ];
  
  List<Map<String, dynamic>> projectOptions = [
    {"label": "All Projects", "value": "All Projects"},
    {"label": "E-commerce Platform", "value": "E-commerce Platform"},
    {"label": "Mobile App Development", "value": "Mobile App Development"},
    {"label": "Website Redesign", "value": "Website Redesign"},
    {"label": "API Integration", "value": "API Integration"},
  ];
  
  Map<String, dynamic> reportSummary = {
    "totalHours": 324.5,
    "billableHours": 289.0,
    "nonBillableHours": 35.5,
    "billableRate": 89.1,
    "totalRevenue": 24823.50,
    "averageHourlyRate": 85.95,
    "totalEmployees": 5,
    "totalProjects": 4,
    "completedTasks": 47,
    "productivity": 92.3
  };
  
  List<Map<String, dynamic>> employeeReports = [
    {
      "employee": "Alex Johnson",
      "role": "Senior Developer",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=person",
      "totalHours": 85.5,
      "billableHours": 78.0,
      "nonBillableHours": 7.5,
      "revenue": 6630.0,
      "projects": 3,
      "tasks": 12,
      "efficiency": 94.2,
      "hourlyRate": 85.0
    },
    {
      "employee": "Sarah Chen",
      "role": "UX Designer",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=woman",
      "totalHours": 80.0,
      "billableHours": 80.0,
      "nonBillableHours": 0.0,
      "revenue": 6000.0,
      "projects": 2,
      "tasks": 15,
      "efficiency": 98.5,
      "hourlyRate": 75.0
    },
    {
      "employee": "Mike Rodriguez",
      "role": "Project Manager",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=man",
      "totalHours": 78.0,
      "billableHours": 65.0,
      "nonBillableHours": 13.0,
      "revenue": 6175.0,
      "projects": 4,
      "tasks": 8,
      "efficiency": 89.3,
      "hourlyRate": 95.0
    },
    {
      "employee": "Emily Davis",
      "role": "Marketing Specialist",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=girl",
      "totalHours": 72.0,
      "billableHours": 60.0,
      "nonBillableHours": 12.0,
      "revenue": 3900.0,
      "projects": 2,
      "tasks": 9,
      "efficiency": 91.7,
      "hourlyRate": 65.0
    },
    {
      "employee": "James Wilson",
      "role": "Backend Developer",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=person",
      "totalHours": 68.0,
      "billableHours": 62.0,
      "nonBillableHours": 6.0,
      "revenue": 4960.0,
      "projects": 2,
      "tasks": 10,
      "efficiency": 87.1,
      "hourlyRate": 80.0
    }
  ];
  
  List<Map<String, dynamic>> projectReports = [
    {
      "project": "E-commerce Platform",
      "client": "TechCorp Inc.",
      "totalHours": 125.5,
      "billableHours": 115.0,
      "revenue": 9775.0,
      "employees": 3,
      "progress": 75.0,
      "status": "active",
      "deadline": "2025-12-31"
    },
    {
      "project": "Mobile App Development",
      "client": "StartupX",
      "totalHours": 89.0,
      "billableHours": 89.0,
      "revenue": 6675.0,
      "employees": 2,
      "progress": 60.0,
      "status": "active",
      "deadline": "2025-11-30"
    },
    {
      "project": "Website Redesign",
      "client": "GlobalTech",
      "totalHours": 67.0,
      "billableHours": 55.0,
      "revenue": 4950.0,
      "employees": 2,
      "progress": 45.0,
      "status": "active",
      "deadline": "2025-10-15"
    },
    {
      "project": "API Integration",
      "client": "DevCorp",
      "totalHours": 43.0,
      "billableHours": 43.0,
      "revenue": 3440.0,
      "employees": 1,
      "progress": 90.0,
      "status": "finishing",
      "deadline": "2025-07-31"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () => _exportReport(),
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _shareReport(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildReportFilters(),
            _buildReportSummary(),
            _buildReportCharts(),
            _buildEmployeeBreakdown(),
            _buildProjectBreakdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildReportFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Report Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Report Type",
                  items: reportTypeOptions,
                  value: selectedReportType,
                  onChanged: (value, label) {
                    selectedReportType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Employee",
                  items: employeeOptions,
                  value: selectedEmployee,
                  onChanged: (value, label) {
                    selectedEmployee = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Project",
                  items: projectOptions,
                  value: selectedProject,
                  onChanged: (value, label) {
                    selectedProject = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Generate Report",
                  size: bs.md,
                  onPressed: () => _generateReport(),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Reset",
                color: disabledBoldColor,
                size: bs.md,
                onPressed: () => _resetFilters(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Report Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildSummaryMetric(
                  "Total Hours",
                  "${(reportSummary["totalHours"] as double).toStringAsFixed(0)}h",
                  Icons.schedule,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryMetric(
                  "Billable Hours",
                  "${(reportSummary["billableHours"] as double).toStringAsFixed(0)}h",
                  Icons.attach_money,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryMetric(
                  "Revenue",
                  "\$${((reportSummary["totalRevenue"] as double) / 1000).toStringAsFixed(1)}K",
                  Icons.trending_up,
                  warningColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryMetric(
                  "Efficiency",
                  "${(reportSummary["productivity"] as double).toStringAsFixed(1)}%",
                  Icons.bar_chart,
                  infoColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Billable Rate: ${(reportSummary["billableRate"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Avg. Hourly Rate: \$${(reportSummary["averageHourlyRate"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: spXs,
                  children: [
                    Text(
                      "${reportSummary["totalEmployees"]} Employees",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${reportSummary["totalProjects"]} Projects",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCharts() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Hours Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            child: Column(
              spacing: spSm,
              children: [
                _buildHoursChart("Billable Hours", reportSummary["billableHours"] as double, reportSummary["totalHours"] as double, successColor),
                _buildHoursChart("Non-Billable Hours", reportSummary["nonBillableHours"] as double, reportSummary["totalHours"] as double, warningColor),
                _buildHoursChart("Total Productivity", reportSummary["totalHours"] as double, 400.0, primaryColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHoursChart(String label, double value, double maxValue, Color color) {
    double percentage = (value / maxValue) * 100;
    
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "${value.toStringAsFixed(0)}h (${percentage.toStringAsFixed(1)}%)",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeBreakdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Text(
              "Employee Breakdown",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ...employeeReports.map((employee) => _buildEmployeeReportItem(employee)).toList(),
        ],
      ),
    );
  }

  Widget _buildEmployeeReportItem(Map<String, dynamic> employee) {
    double billableRate = ((employee["billableHours"] as double) / (employee["totalHours"] as double)) * 100;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
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
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${employee["employee"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${(employee["totalHours"] as double).toStringAsFixed(0)}h",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${employee["role"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Billable: ${(employee["billableHours"] as double).toStringAsFixed(0)}h (${billableRate.toStringAsFixed(1)}%)",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "\$${((employee["revenue"] as double) / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${employee["projects"]} projects • ${employee["tasks"]} tasks",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Efficiency: ${(employee["efficiency"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: (employee["efficiency"] as double) >= 90 ? successColor : 
                               (employee["efficiency"] as double) >= 80 ? warningColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectBreakdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Text(
              "Project Breakdown",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ...projectReports.map((project) => _buildProjectReportItem(project)).toList(),
        ],
      ),
    );
  }

  Widget _buildProjectReportItem(Map<String, dynamic> project) {
    Color statusColor = project["status"] == "active" ? successColor : 
                       project["status"] == "finishing" ? warningColor : disabledBoldColor;
    double progress = project["progress"] as double;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${project["project"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Client: ${project["client"]}",
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
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${project["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
                  Text(
                    "${progress.toStringAsFixed(0)}% Complete",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: progress >= 80 ? successColor : progress >= 50 ? warningColor : dangerColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: progress >= 80 ? successColor : progress >= 50 ? warningColor : dangerColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Total: ${(project["totalHours"] as double).toStringAsFixed(0)}h • Billable: ${(project["billableHours"] as double).toStringAsFixed(0)}h",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${project["employees"]} employees • Due: ${project["deadline"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\$${((project["revenue"] as double) / 1000).toStringAsFixed(1)}K",
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
    );
  }

  void _generateReport() {
    ss("Report generated successfully");
  }

  void _resetFilters() {
    selectedReportType = "Summary Report";
    selectedPeriod = "This Month";
    selectedEmployee = "All Employees";
    selectedProject = "All Projects";
    setState(() {});
    si("Filters reset to default");
  }

  void _exportReport() {
    ss("Report exported successfully");
  }

  void _shareReport() {
    si("Report sharing options");
  }
}
