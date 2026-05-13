import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaStaffReportsView extends StatefulWidget {
  const RmaStaffReportsView({Key? key}) : super(key: key);

  @override
  State<RmaStaffReportsView> createState() => _RmaStaffReportsViewState();
}

class _RmaStaffReportsViewState extends State<RmaStaffReportsView> {
  String selectedDepartment = "all";
  String selectedPeriod = "monthly";
  bool loading = false;

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "all"},
    {"label": "Customer Service", "value": "customer_service"},
    {"label": "Quality Control", "value": "quality_control"},
    {"label": "Warehouse", "value": "warehouse"},
    {"label": "Management", "value": "management"},
  ];

  List<Map<String, dynamic>> periods = [
    {"label": "This Week", "value": "weekly"},
    {"label": "This Month", "value": "monthly"},
    {"label": "This Quarter", "value": "quarterly"},
    {"label": "This Year", "value": "yearly"},
  ];

  List<Map<String, dynamic>> staffPerformance = [
    {
      "name": "Sarah Johnson",
      "role": "Senior Customer Service Rep",
      "department": "Customer Service",
      "casesHandled": 145,
      "avgResolutionTime": "2.3 hours",
      "customerRating": 4.8,
      "efficiency": 92,
      "avatar": "https://picsum.photos/60/60?random=1&keyword=woman",
    },
    {
      "name": "Michael Chen",
      "role": "Quality Control Specialist",
      "department": "Quality Control",
      "casesHandled": 89,
      "avgResolutionTime": "4.1 hours",
      "customerRating": 4.6,
      "efficiency": 88,
      "avatar": "https://picsum.photos/60/60?random=2&keyword=man",
    },
    {
      "name": "Emma Rodriguez",
      "role": "Warehouse Coordinator",
      "department": "Warehouse",
      "casesHandled": 167,
      "avgResolutionTime": "1.8 hours",
      "customerRating": 4.9,
      "efficiency": 95,
      "avatar": "https://picsum.photos/60/60?random=3&keyword=woman",
    },
    {
      "name": "David Thompson",
      "role": "RMA Manager",
      "department": "Management",
      "casesHandled": 234,
      "avgResolutionTime": "3.2 hours",
      "customerRating": 4.7,
      "efficiency": 89,
      "avatar": "https://picsum.photos/60/60?random=4&keyword=man",
    },
  ];

  List<Map<String, dynamic>> departmentStats = [
    {
      "name": "Customer Service",
      "totalStaff": 12,
      "activeStaff": 11,
      "casesHandled": 1456,
      "avgResponseTime": "1.2 hours",
      "satisfaction": 4.6,
      "efficiency": 87,
    },
    {
      "name": "Quality Control",
      "totalStaff": 8,
      "activeStaff": 7,
      "casesHandled": 892,
      "avgResponseTime": "3.8 hours",
      "satisfaction": 4.5,
      "efficiency": 91,
    },
    {
      "name": "Warehouse",
      "totalStaff": 15,
      "activeStaff": 14,
      "casesHandled": 2134,
      "avgResponseTime": "2.1 hours",
      "satisfaction": 4.8,
      "efficiency": 93,
    },
    {
      "name": "Management",
      "totalStaff": 5,
      "activeStaff": 5,
      "casesHandled": 567,
      "avgResponseTime": "4.2 hours",
      "satisfaction": 4.7,
      "efficiency": 85,
    },
  ];

  List<Map<String, dynamic>> workloadDistribution = [
    {"timeSlot": "9:00 AM", "cases": 45, "staff": 8},
    {"timeSlot": "10:00 AM", "cases": 67, "staff": 12},
    {"timeSlot": "11:00 AM", "cases": 89, "staff": 15},
    {"timeSlot": "12:00 PM", "cases": 72, "staff": 12},
    {"timeSlot": "1:00 PM", "cases": 56, "staff": 9},
    {"timeSlot": "2:00 PM", "cases": 78, "staff": 14},
    {"timeSlot": "3:00 PM", "cases": 91, "staff": 16},
    {"timeSlot": "4:00 PM", "cases": 83, "staff": 15},
    {"timeSlot": "5:00 PM", "cases": 62, "staff": 11},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Performance Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () => _viewStaffDirectory(),
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () => _exportStaffReport(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            SizedBox(height: spLg),
            _buildOverallMetrics(),
            SizedBox(height: spLg),
            _buildDepartmentStats(),
            SizedBox(height: spLg),
            _buildTopPerformers(),
            SizedBox(height: spLg),
            _buildWorkloadAnalysis(),
            SizedBox(height: spLg),
            _buildStaffActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Report Filters",
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
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periods,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverallMetrics() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildMetricCard(
          "Total Staff",
          "40",
          Icons.groups,
          primaryColor,
          "+2 this month",
        ),
        _buildMetricCard(
          "Active Staff",
          "37",
          Icons.work,
          successColor,
          "92.5% availability",
        ),
        _buildMetricCard(
          "Avg Response Time",
          "2.8h",
          Icons.schedule,
          infoColor,
          "-15 min improvement",
        ),
        _buildMetricCard(
          "Team Efficiency",
          "89%",
          Icons.trending_up,
          warningColor,
          "+3% from last month",
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Department Performance",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...departmentStats.map((dept) => _buildDepartmentCard(dept)).toList(),
      ],
    );
  }

  Widget _buildDepartmentCard(Map<String, dynamic> department) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
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
              Expanded(
                child: Text(
                  "${department["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                decoration: BoxDecoration(
                  color: _getEfficiencyColor((department["efficiency"] as int)).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${department["efficiency"]}% Efficiency",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getEfficiencyColor((department["efficiency"] as int)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildDeptMetric(
                  "Staff",
                  "${department["activeStaff"]}/${department["totalStaff"]}",
                  primaryColor,
                ),
              ),
              Expanded(
                child: _buildDeptMetric(
                  "Cases",
                  "${department["casesHandled"]}",
                  successColor,
                ),
              ),
              Expanded(
                child: _buildDeptMetric(
                  "Response",
                  "${department["avgResponseTime"]}",
                  infoColor,
                ),
              ),
              Expanded(
                child: _buildDeptMetric(
                  "Rating",
                  "${department["satisfaction"]}★",
                  warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeptMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getEfficiencyColor(int efficiency) {
    if (efficiency >= 90) return successColor;
    if (efficiency >= 80) return warningColor;
    return dangerColor;
  }

  Widget _buildTopPerformers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Top Performers",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => _viewAllStaff(),
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        ...staffPerformance.map((staff) => _buildStaffCard(staff)).toList(),
      ],
    );
  }

  Widget _buildStaffCard(Map<String, dynamic> staff) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusLg),
            child: Image.network(
              "${staff["avatar"]}",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${staff["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${staff["role"]} • ${staff["department"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    _buildStaffStat("Cases", "${staff["casesHandled"]}"),
                    SizedBox(width: spMd),
                    _buildStaffStat("Avg Time", "${staff["avgResolutionTime"]}"),
                    SizedBox(width: spMd),
                    _buildStaffStat("Rating", "${staff["customerRating"]}★"),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
            decoration: BoxDecoration(
              color: _getEfficiencyColor((staff["efficiency"] as int)).withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${staff["efficiency"]}%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _getEfficiencyColor((staff["efficiency"] as int)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkloadAnalysis() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Workload Distribution by Hour",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: Column(
              children: workloadDistribution.map((data) => _buildWorkloadRow(data)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkloadRow(Map<String, dynamic> data) {
    double casesWidth = ((data["cases"] as int) / 100) * 200;
    double staffRatio = (data["staff"] as int) / 20;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              "${data["timeSlot"]}",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: casesWidth,
                      height: 8,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${data["cases"]} cases",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Container(
                      width: casesWidth * staffRatio,
                      height: 4,
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${data["staff"]} staff",
                      style: TextStyle(
                        fontSize: 10,
                        color: successColor,
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

  Widget _buildStaffActions() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Icon(Icons.schedule, color: primaryColor, size: 32),
              SizedBox(height: spSm),
              Text(
                "Schedule Optimization",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spXs),
              Text(
                "Optimize staff schedules based on workload patterns",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Optimize",
                  size: bs.sm,
                  onPressed: () => _optimizeSchedule(),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Icon(Icons.school, color: successColor, size: 32),
              SizedBox(height: spSm),
              Text(
                "Training Programs",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spXs),
              Text(
                "Assign training based on performance gaps",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "View Training",
                  size: bs.sm,
                  onPressed: () => _viewTraining(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _viewStaffDirectory() {
    si("Opening staff directory");
  }

  void _exportStaffReport() {
    ss("Staff report exported successfully");
  }

  void _viewAllStaff() {
    si("Viewing all staff members");
  }

  void _optimizeSchedule() {
    si("Starting schedule optimization");
  }

  void _viewTraining() {
    si("Opening training programs");
  }
}
