import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaLaborManagementView extends StatefulWidget {
  const AmaLaborManagementView({super.key});

  @override
  State<AmaLaborManagementView> createState() => _AmaLaborManagementViewState();
}

class _AmaLaborManagementViewState extends State<AmaLaborManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedDepartment = "All";
  String selectedStatus = "All";
  bool showFilters = false;

  List<Map<String, dynamic>> workers = [
    {
      "id": "EMP001",
      "name": "John Martinez",
      "position": "Farm Supervisor",
      "department": "Field Operations",
      "status": "Active",
      "hireDate": "2022-03-15",
      "phoneNumber": "+1 555-0123",
      "email": "john.martinez@farm.com",
      "hourlyRate": 25.50,
      "hoursWorked": 168,
      "overtime": 12,
      "skills": ["Tractor Operation", "Crop Management", "Team Leadership"],
      "certifications": ["Agricultural Supervisor License", "Pesticide Application"],
      "address": "123 Farm Road, Rural County",
      "emergencyContact": "Maria Martinez - +1 555-0124",
      "photo": "https://picsum.photos/150/150?random=1&keyword=man",
      "performance": 4.8,
      "attendance": 95,
      "lastReview": "2025-03-20",
      "nextReview": "2025-09-20",
      "benefits": ["Health Insurance", "Retirement Plan", "Paid Time Off"],
      "notes": "Excellent supervisor with strong leadership skills",
      "icon": Icons.person,
      "color": Colors.blue
    },
    {
      "id": "EMP002",
      "name": "Sarah Johnson",
      "position": "Equipment Operator",
      "department": "Machinery",
      "status": "Active",
      "hireDate": "2023-01-10",
      "phoneNumber": "+1 555-0456",
      "email": "sarah.johnson@farm.com",
      "hourlyRate": 22.00,
      "hoursWorked": 160,
      "overtime": 8,
      "skills": ["Heavy Equipment", "Maintenance", "Safety Procedures"],
      "certifications": ["CDL License", "Equipment Safety Certified"],
      "address": "456 Country Lane, Farmville",
      "emergencyContact": "Tom Johnson - +1 555-0457",
      "photo": "https://picsum.photos/150/150?random=2&keyword=woman",
      "performance": 4.6,
      "attendance": 98,
      "lastReview": "2025-02-15",
      "nextReview": "2025-08-15",
      "benefits": ["Health Insurance", "Equipment Training", "Safety Bonus"],
      "notes": "Reliable operator with excellent safety record",
      "icon": Icons.engineering,
      "color": Colors.orange
    },
    {
      "id": "EMP003",
      "name": "Miguel Rodriguez",
      "position": "Field Worker",
      "department": "Field Operations",
      "status": "Active",
      "hireDate": "2024-05-20",
      "phoneNumber": "+1 555-0789",
      "email": "miguel.rodriguez@farm.com",
      "hourlyRate": 18.50,
      "hoursWorked": 155,
      "overtime": 15,
      "skills": ["Planting", "Harvesting", "Irrigation", "Crop Care"],
      "certifications": ["Organic Farming Certificate"],
      "address": "789 Rural Route, Green Valley",
      "emergencyContact": "Ana Rodriguez - +1 555-0790",
      "photo": "https://picsum.photos/150/150?random=3&keyword=man",
      "performance": 4.4,
      "attendance": 92,
      "lastReview": "2025-05-20",
      "nextReview": "2025-11-20",
      "benefits": ["Health Insurance", "Seasonal Bonus"],
      "notes": "Hardworking and dedicated field worker",
      "icon": Icons.agriculture,
      "color": Colors.green
    },
    {
      "id": "EMP004",
      "name": "Lisa Chen",
      "position": "Quality Control Specialist",
      "department": "Quality Assurance",
      "status": "Active",
      "hireDate": "2021-11-08",
      "phoneNumber": "+1 555-0321",
      "email": "lisa.chen@farm.com",
      "hourlyRate": 28.00,
      "hoursWorked": 150,
      "overtime": 5,
      "skills": ["Quality Testing", "Food Safety", "Documentation", "Analysis"],
      "certifications": ["Food Safety Certified", "Quality Management ISO"],
      "address": "321 Quality Street, Safe Harbor",
      "emergencyContact": "David Chen - +1 555-0322",
      "photo": "https://picsum.photos/150/150?random=4&keyword=woman",
      "performance": 4.9,
      "attendance": 96,
      "lastReview": "2025-01-10",
      "nextReview": "2025-07-10",
      "benefits": ["Health Insurance", "Professional Development", "Performance Bonus"],
      "notes": "Exceptional attention to detail and quality standards",
      "icon": Icons.verified,
      "color": Colors.purple
    },
    {
      "id": "EMP005",
      "name": "Robert Thompson",
      "position": "Maintenance Technician",
      "department": "Maintenance",
      "status": "On Leave",
      "hireDate": "2020-07-12",
      "phoneNumber": "+1 555-0654",
      "email": "robert.thompson@farm.com",
      "hourlyRate": 24.75,
      "hoursWorked": 0,
      "overtime": 0,
      "skills": ["Mechanical Repair", "Electrical Systems", "Welding", "Diagnostics"],
      "certifications": ["Certified Mechanic", "Electrical Safety"],
      "address": "654 Workshop Avenue, Repair Town",
      "emergencyContact": "Nancy Thompson - +1 555-0655",
      "photo": "https://picsum.photos/150/150?random=5&keyword=man",
      "performance": 4.7,
      "attendance": 88,
      "lastReview": "2024-12-05",
      "nextReview": "2025-06-05",
      "benefits": ["Health Insurance", "Tool Allowance", "Overtime Pay"],
      "notes": "Currently on medical leave, excellent technical skills",
      "icon": Icons.build,
      "color": Colors.grey,
      "leaveType": "Medical Leave",
      "leaveStart": "2025-06-01",
      "expectedReturn": "2025-07-15"
    },
    {
      "id": "EMP006",
      "name": "Amanda White",
      "position": "Harvest Coordinator",
      "department": "Field Operations",
      "status": "Seasonal",
      "hireDate": "2024-08-01",
      "phoneNumber": "+1 555-0987",
      "email": "amanda.white@farm.com",
      "hourlyRate": 21.00,
      "hoursWorked": 145,
      "overtime": 20,
      "skills": ["Harvest Planning", "Team Coordination", "Logistics", "Quality Control"],
      "certifications": ["Project Management", "Agricultural Coordination"],
      "address": "987 Harvest Road, Seasonal Valley",
      "emergencyContact": "Mark White - +1 555-0988",
      "photo": "https://picsum.photos/150/150?random=6&keyword=woman",
      "performance": 4.5,
      "attendance": 94,
      "lastReview": "2025-04-01",
      "nextReview": "2025-10-01",
      "benefits": ["Seasonal Health Plan", "Performance Bonus"],
      "notes": "Excellent coordination skills during harvest season",
      "icon": Icons.schedule,
      "color": Colors.teal,
      "seasonStart": "2025-08-01",
      "seasonEnd": "2025-11-30"
    }
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All", "value": "All"},
    {"label": "Field Operations", "value": "Field Operations"},
    {"label": "Machinery", "value": "Machinery"},
    {"label": "Quality Assurance", "value": "Quality Assurance"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Administration", "value": "Administration"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "On Leave", "value": "On Leave"},
    {"label": "Seasonal", "value": "Seasonal"},
    {"label": "Inactive", "value": "Inactive"}
  ];

  List<Map<String, dynamic>> get filteredWorkers {
    return workers.where((worker) {
      bool matchesSearch = worker["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                        worker["position"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesDepartment = selectedDepartment == "All" || worker["department"] == selectedDepartment;
      bool matchesStatus = selectedStatus == "All" || worker["status"] == selectedStatus;
      return matchesSearch && matchesDepartment && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Labor Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Workers", icon: Icon(Icons.people)),
        Tab(text: "Performance", icon: Icon(Icons.trending_up)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildWorkersTab(),
        _buildPerformanceTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildWorkersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildWorkerStats(),
          _buildWorkersList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search workers...",
                value: searchQuery,
                hint: "Search by name or position",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: showFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
              size: bs.sm,
              onPressed: () {
                showFilters = !showFilters;
                setState(() {});
              },
            ),
          ],
        ),
        if (showFilters) ...[
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
      ],
    );
  }

  Widget _buildWorkerStats() {
    int totalWorkers = workers.length;
    int activeWorkers = workers.where((w) => w["status"] == "Active").length;
    int onLeaveWorkers = workers.where((w) => w["status"] == "On Leave").length;
    double avgPerformance = workers.fold(0.0, (sum, w) => sum + (w["performance"] as double)) / totalWorkers;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Total Workers", totalWorkers.toString(), Icons.people, primaryColor),
        _buildStatCard("Active", activeWorkers.toString(), Icons.check_circle, successColor),
        _buildStatCard("On Leave", onLeaveWorkers.toString(), Icons.event_busy, warningColor),
        _buildStatCard("Avg Performance", "${avgPerformance.toStringAsFixed(1)}/5", Icons.star, infoColor),
      ],
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
              Icon(icon, color: color, size: 24),
              Spacer(),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
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

  Widget _buildWorkersList() {
    return Column(
      spacing: spSm,
      children: filteredWorkers.map((worker) => _buildWorkerCard(worker)).toList(),
    );
  }

  Widget _buildWorkerCard(Map<String, dynamic> worker) {
    Color statusColor = _getStatusColor(worker["status"]);
    Color performanceColor = _getPerformanceColor(worker["performance"] as double);

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
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Image.network(
                  "${worker["photo"]}",
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
                      "${worker["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${worker["position"]} • ${worker["department"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "ID: ${worker["id"]} • Hired: ${DateTime.parse("${worker["hireDate"]}").dMMMy}",
                      style: TextStyle(
                        fontSize: 11,
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
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${worker["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (worker["status"] == "On Leave") ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: warningColor, size: 16),
                  SizedBox(width: spSm),
                  Text(
                    "${worker["leaveType"]} • Expected return: ${DateTime.parse("${worker["expectedReturn"]}").dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (worker["status"] == "Seasonal") ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.schedule, color: infoColor, size: 16),
                  SizedBox(width: spSm),
                  Text(
                    "Season: ${DateTime.parse("${worker["seasonStart"]}").dMMMy} - ${DateTime.parse("${worker["seasonEnd"]}").dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildInfoItem("Hourly Rate", "\$${(worker["hourlyRate"] as double).toStringAsFixed(2)}", Icons.monetization_on),
              _buildInfoItem("Hours This Month", "${worker["hoursWorked"]}h", Icons.access_time),
              _buildInfoItem("Overtime", "${worker["overtime"]}h", Icons.schedule),
              _buildInfoItem("Attendance", "${worker["attendance"]}%", Icons.event_available),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Performance",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${worker["performance"]}/5",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: performanceColor,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: (worker["performance"] as double) / 5,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(performanceColor),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Attendance",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${worker["attendance"]}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getAttendanceColor(worker["attendance"] as int),
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: (worker["attendance"] as int) / 100,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(_getAttendanceColor(worker["attendance"] as int)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Skills:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (worker["skills"] as List).map((skill) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Text(
                      "$skill",
                      style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.verified, color: successColor, size: 16),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${(worker["certifications"] as List).join(" • ")}",
                  style: TextStyle(
                    fontSize: 11,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (worker["notes"] != null && (worker["notes"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.note, color: infoColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${worker["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
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
                  onPressed: () {
                    si("Viewing profile for ${worker["name"]}");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {
                  si("Calling ${worker["name"]}");
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  si("More options for ${worker["name"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: disabledBoldColor, size: 16),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
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
        ),
      ],
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPerformanceStats(),
          _buildTopPerformers(),
          _buildPerformanceChart(),
        ],
      ),
    );
  }

  Widget _buildPerformanceStats() {
    double avgPerformance = workers.fold(0.0, (sum, w) => sum + (w["performance"] as double)) / workers.length;
    int topPerformers = workers.where((w) => (w["performance"] as double) >= 4.5).length;
    double avgAttendance = workers.fold(0.0, (sum, w) => sum + (w["attendance"] as int)) / workers.length;
    int totalHours = workers.fold(0, (sum, w) => sum + (w["hoursWorked"] as int));

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildPerformanceStatCard("Avg Performance", "${avgPerformance.toStringAsFixed(1)}/5", Icons.trending_up, primaryColor),
        _buildPerformanceStatCard("Top Performers", topPerformers.toString(), Icons.star, successColor),
        _buildPerformanceStatCard("Avg Attendance", "${avgAttendance.toStringAsFixed(1)}%", Icons.event_available, infoColor),
        _buildPerformanceStatCard("Total Hours", "${(totalHours / 1000).toStringAsFixed(1)}K", Icons.timer, warningColor),
      ],
    );
  }

  Widget _buildPerformanceStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  title,
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
    );
  }

  Widget _buildTopPerformers() {
    final topPerformers = workers
        .where((w) => w["status"] == "Active")
        .toList()
        ..sort((a, b) => (b["performance"] as double).compareTo(a["performance"] as double));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.emoji_events, color: warningColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Top Performers",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...topPerformers.take(5).map((worker) => _buildTopPerformerItem(worker)).toList(),
        ],
      ),
    );
  }

  Widget _buildTopPerformerItem(Map<String, dynamic> worker) {
    Color performanceColor = _getPerformanceColor(worker["performance"] as double);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: performanceColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${worker["photo"]}",
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${worker["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${worker["position"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: performanceColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${worker["performance"]}/5",
              style: TextStyle(
                fontSize: 12,
                color: performanceColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Performance Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...workers.map((worker) => _buildPerformanceBar(worker)).toList(),
        ],
      ),
    );
  }

  Widget _buildPerformanceBar(Map<String, dynamic> worker) {
    double performance = worker["performance"] as double;
    Color performanceColor = _getPerformanceColor(performance);

    return Column(
      spacing: spXs,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${worker["name"]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              "${performance}/5",
              style: TextStyle(
                fontSize: 12,
                color: performanceColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        LinearProgressIndicator(
          value: performance / 5,
          backgroundColor: disabledColor,
          valueColor: AlwaysStoppedAnimation<Color>(performanceColor),
        ),
      ],
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildReportSummary(),
          _buildDepartmentBreakdown(),
          _buildPayrollSummary(),
        ],
      ),
    );
  }

  Widget _buildReportSummary() {
    int totalWorkers = workers.length;
    double totalPayroll = workers.fold(0.0, (sum, w) => sum + ((w["hoursWorked"] as int) * (w["hourlyRate"] as double)));
    double totalOvertime = workers.fold(0.0, (sum, w) => sum + ((w["overtime"] as int) * (w["hourlyRate"] as double) * 1.5));
    int totalHours = workers.fold(0, (sum, w) => sum + (w["hoursWorked"] as int));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Monthly Labor Report",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildReportItem("Total Workers", totalWorkers.toString(), Icons.people),
              _buildReportItem("Total Hours", "${totalHours}h", Icons.timer),
              _buildReportItem("Regular Pay", "\$${(totalPayroll / 1000).toStringAsFixed(1)}K", Icons.monetization_on),
              _buildReportItem("Overtime Pay", "\$${(totalOvertime / 1000).toStringAsFixed(1)}K", Icons.schedule),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 20),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
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
        ),
      ],
    );
  }

  Widget _buildDepartmentBreakdown() {
    Map<String, List<Map<String, dynamic>>> departmentGroups = {};
    for (var worker in workers) {
      String dept = worker["department"];
      if (!departmentGroups.containsKey(dept)) {
        departmentGroups[dept] = [];
      }
      departmentGroups[dept]!.add(worker);
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Department Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...departmentGroups.entries.map((entry) => _buildDepartmentItem(entry.key, entry.value)).toList(),
        ],
      ),
    );
  }

  Widget _buildDepartmentItem(String department, List<Map<String, dynamic>> deptWorkers) {
    int workerCount = deptWorkers.length;
    double avgPerformance = deptWorkers.fold(0.0, (sum, w) => sum + (w["performance"] as double)) / workerCount;
    double totalCost = deptWorkers.fold(0.0, (sum, w) => sum + ((w["hoursWorked"] as int) * (w["hourlyRate"] as double)));

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 3,
            color: primaryColor,
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
                  department,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "$workerCount workers • Avg Performance: ${avgPerformance.toStringAsFixed(1)}/5",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${(totalCost / 1000).toStringAsFixed(1)}K",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayrollSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Payroll Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...workers.map((worker) => _buildPayrollItem(worker)).toList(),
        ],
      ),
    );
  }

  Widget _buildPayrollItem(Map<String, dynamic> worker) {
    double regularPay = (worker["hoursWorked"] as int) * (worker["hourlyRate"] as double);
    double overtimePay = (worker["overtime"] as int) * (worker["hourlyRate"] as double) * 1.5;
    double totalPay = regularPay + overtimePay;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusXs),
            child: Image.network(
              "${worker["photo"]}",
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${worker["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${worker["hoursWorked"]}h regular + ${worker["overtime"]}h overtime",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${totalPay.currency}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "On Leave":
        return warningColor;
      case "Seasonal":
        return infoColor;
      case "Inactive":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPerformanceColor(double performance) {
    if (performance >= 4.5) return successColor;
    if (performance >= 4.0) return infoColor;
    if (performance >= 3.5) return warningColor;
    return dangerColor;
  }

  Color _getAttendanceColor(int attendance) {
    if (attendance >= 95) return successColor;
    if (attendance >= 90) return infoColor;
    if (attendance >= 85) return warningColor;
    return dangerColor;
  }
}
