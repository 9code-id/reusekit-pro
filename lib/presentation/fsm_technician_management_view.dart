import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmTechnicianManagementView extends StatefulWidget {
  const FsmTechnicianManagementView({super.key});

  @override
  State<FsmTechnicianManagementView> createState() => _FsmTechnicianManagementViewState();
}

class _FsmTechnicianManagementViewState extends State<FsmTechnicianManagementView> {
  bool loading = false;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedDepartment = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> technicians = [
    {
      "id": "TECH-001",
      "name": "John Smith",
      "email": "john.smith@company.com",
      "phone": "+1-555-0101",
      "department": "IT Support",
      "status": "Active",
      "employeeId": "EMP-001",
      "hireDate": "2023-01-15",
      "location": "New York Office",
      "supervisor": "Mike Johnson",
      "skills": ["Network Administration", "Windows Server", "Cisco Equipment", "Troubleshooting"],
      "certifications": ["CompTIA Network+", "Microsoft MCSA", "Cisco CCNA"],
      "availability": "Full-time",
      "currentAssignments": 5,
      "completedJobs": 142,
      "averageRating": 4.8,
      "hourlyRate": 75.0,
      "overtimeRate": 112.50,
      "performanceScore": 95,
      "lastActiveDate": "2024-06-19",
      "profileImage": "https://picsum.photos/100/100?random=1",
      "emergencyContact": "+1-555-9101",
      "address": "123 Tech Street, New York, NY 10001"
    },
    {
      "id": "TECH-002",
      "name": "Sarah Wilson",
      "email": "sarah.wilson@company.com",
      "phone": "+1-555-0102",
      "department": "Field Service",
      "status": "Active",
      "employeeId": "EMP-002",
      "hireDate": "2023-03-20",
      "location": "Chicago Office",
      "supervisor": "Lisa Chen",
      "skills": ["Equipment Maintenance", "Electrical Systems", "HVAC", "Safety Protocols"],
      "certifications": ["OSHA Safety", "Electrical License", "HVAC Certification"],
      "availability": "Full-time",
      "currentAssignments": 3,
      "completedJobs": 98,
      "averageRating": 4.9,
      "hourlyRate": 68.0,
      "overtimeRate": 102.0,
      "performanceScore": 98,
      "lastActiveDate": "2024-06-19",
      "profileImage": "https://picsum.photos/100/100?random=2",
      "emergencyContact": "+1-555-9102",
      "address": "456 Service Ave, Chicago, IL 60601"
    },
    {
      "id": "TECH-003",
      "name": "Mike Davis",
      "email": "mike.davis@company.com",
      "phone": "+1-555-0103",
      "department": "Medical Equipment",
      "status": "Active",
      "employeeId": "EMP-003",
      "hireDate": "2022-11-10",
      "location": "Boston Office",
      "supervisor": "Dr. James Wilson",
      "skills": ["Biomedical Equipment", "Calibration", "Compliance Testing", "Medical Devices"],
      "certifications": ["Biomedical Equipment Technician", "FDA Compliance", "ISO 13485"],
      "availability": "On-call",
      "currentAssignments": 7,
      "completedJobs": 189,
      "averageRating": 4.7,
      "hourlyRate": 85.0,
      "overtimeRate": 127.50,
      "performanceScore": 92,
      "lastActiveDate": "2024-06-18",
      "profileImage": "https://picsum.photos/100/100?random=3",
      "emergencyContact": "+1-555-9103",
      "address": "789 Medical Blvd, Boston, MA 02101"
    },
    {
      "id": "TECH-004",
      "name": "Emily Rodriguez",
      "email": "emily.rodriguez@company.com",
      "phone": "+1-555-0104",
      "department": "Field Service",
      "status": "On Leave",
      "employeeId": "EMP-004",
      "hireDate": "2023-05-05",
      "location": "Miami Office",
      "supervisor": "Robert Lee",
      "skills": ["POS Systems", "Network Setup", "Retail Equipment", "Customer Service"],
      "certifications": ["Retail Technology", "Point of Sale Systems", "Customer Service"],
      "availability": "Part-time",
      "currentAssignments": 0,
      "completedJobs": 76,
      "averageRating": 4.5,
      "hourlyRate": 62.0,
      "overtimeRate": 93.0,
      "performanceScore": 87,
      "lastActiveDate": "2024-06-10",
      "profileImage": "https://picsum.photos/100/100?random=4",
      "emergencyContact": "+1-555-9104",
      "address": "321 Retail Plaza, Miami, FL 33101"
    },
    {
      "id": "TECH-005",
      "name": "Alex Johnson",
      "email": "alex.johnson@company.com",
      "phone": "+1-555-0105",
      "department": "IT Support",
      "status": "Active",
      "employeeId": "EMP-005",
      "hireDate": "2024-01-08",
      "location": "Houston Office",
      "supervisor": "Susan Davis",
      "skills": ["System Monitoring", "Database Management", "Cloud Services", "Security"],
      "certifications": ["AWS Certified", "Microsoft Azure", "CompTIA Security+"],
      "availability": "Full-time",
      "currentAssignments": 4,
      "completedJobs": 34,
      "averageRating": 4.6,
      "hourlyRate": 72.0,
      "overtimeRate": 108.0,
      "performanceScore": 89,
      "lastActiveDate": "2024-06-19",
      "profileImage": "https://picsum.photos/100/100?random=5",
      "emergencyContact": "+1-555-9105",
      "address": "654 Cloud Drive, Houston, TX 77001"
    }
  ];

  List<Map<String, dynamic>> departments = [
    {"label": "All", "value": "All"},
    {"label": "IT Support", "value": "IT Support"},
    {"label": "Field Service", "value": "Field Service"},
    {"label": "Medical Equipment", "value": "Medical Equipment"},
    {"label": "Manufacturing", "value": "Manufacturing"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "On Leave", "value": "On Leave"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Training", "value": "Training"}
  ];

  List<Map<String, dynamic>> get filteredTechnicians {
    return technicians.where((tech) {
      bool matchesSearch = tech["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          tech["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          tech["department"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || tech["status"] == selectedStatus;
      bool matchesDepartment = selectedDepartment == "All" || tech["department"] == selectedDepartment;
      
      return matchesSearch && matchesStatus && matchesDepartment;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "On Leave":
        return warningColor;
      case "Inactive":
        return dangerColor;
      case "Training":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPerformanceColor(int score) {
    if (score >= 95) return successColor;
    if (score >= 85) return infoColor;
    if (score >= 75) return warningColor;
    return dangerColor;
  }

  void _viewTechnicianProfile(Map<String, dynamic> technician) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Technician Profile"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(technician["profileImage"]),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${technician["name"]}",
                            style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold),
                          ),
                          Text("${technician["department"]}"),
                          Text("${technician["employeeId"]}"),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                Text("Contact Information", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Email: ${technician["email"]}"),
                Text("Phone: ${technician["phone"]}"),
                Text("Emergency: ${technician["emergencyContact"]}"),
                Text("Address: ${technician["address"]}"),
                
                SizedBox(height: spSm),
                Text("Employment Details", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Hire Date: ${technician["hireDate"]}"),
                Text("Location: ${technician["location"]}"),
                Text("Supervisor: ${technician["supervisor"]}"),
                Text("Availability: ${technician["availability"]}"),
                
                SizedBox(height: spSm),
                Text("Performance Metrics", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Performance Score: ${technician["performanceScore"]}/100"),
                Text("Average Rating: ${technician["averageRating"]}/5.0"),
                Text("Completed Jobs: ${technician["completedJobs"]}"),
                Text("Current Assignments: ${technician["currentAssignments"]}"),
                
                SizedBox(height: spSm),
                Text("Skills", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                ...(technician["skills"] as List).map((skill) => Text("• $skill")),
                
                SizedBox(height: spSm),
                Text("Certifications", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                ...(technician["certifications"] as List).map((cert) => Text("• $cert")),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _editTechnician(Map<String, dynamic> technician) {
    ss("Edit technician functionality would open here");
  }

  void _assignJob(Map<String, dynamic> technician) {
    ss("Job assignment functionality would open here");
  }

  void _updateStatus(Map<String, dynamic> technician, String newStatus) async {
    bool isConfirmed = await confirm("Change status to $newStatus for ${technician["name"]}?");
    if (isConfirmed) {
      setState(() {
        technician["status"] = newStatus;
      });
      ss("Status updated successfully");
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        // Summary Cards
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildSummaryCard("Total Technicians", "${technicians.length}", primaryColor, Icons.people),
            _buildSummaryCard("Active", "${technicians.where((t) => t["status"] == "Active").length}", successColor, Icons.check_circle),
            _buildSummaryCard("On Leave", "${technicians.where((t) => t["status"] == "On Leave").length}", warningColor, Icons.schedule),
            _buildSummaryCard("Avg Performance", "${(technicians.fold(0, (sum, t) => sum + (t["performanceScore"] as int)) / technicians.length).toStringAsFixed(0)}%", infoColor, Icons.trending_up),
          ],
        ),

        // Quick Actions
        Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildActionCard("Add Technician", Icons.person_add, primaryColor, () {
              ss("Add technician functionality");
            }),
            _buildActionCard("Bulk Import", Icons.upload_file, infoColor, () {
              ss("Bulk import functionality");
            }),
            _buildActionCard("Schedule Training", Icons.school, warningColor, () {
              ss("Training schedule functionality");
            }),
            _buildActionCard("Performance Review", Icons.assessment, successColor, () {
              ss("Performance review functionality");
            }),
          ],
        ),

        // Recent Activities
        Text(
          "Recent Activities",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              _buildActivityItem("John Smith completed 5 service calls", "2 hours ago", Icons.check_circle, successColor),
              _buildActivityItem("Sarah Wilson started training program", "4 hours ago", Icons.school, infoColor),
              _buildActivityItem("Mike Davis updated certifications", "6 hours ago", Icons.verified, warningColor),
              _buildActivityItem("Emily Rodriguez went on leave", "1 day ago", Icons.schedule, dangerColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTechniciansTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        // Search and Filters
        QTextField(
          label: "Search technicians",
          value: searchQuery,
          hint: "Search by name, ID, or department",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),

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

        // Technicians List
        Text(
          "Technicians (${filteredTechnicians.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),

        ...filteredTechnicians.map((technician) => Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(technician["profileImage"]),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${technician["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${technician["department"]} • ${technician["employeeId"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(technician["status"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${technician["status"]}",
                      style: TextStyle(
                        color: _getStatusColor(technician["status"]),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

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
                        Text(
                          "${technician["performanceScore"]}%",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: _getPerformanceColor(technician["performanceScore"] as int),
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
                          "Rating",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${technician["averageRating"]}/5.0",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
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
                          "Active Jobs",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${technician["currentAssignments"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                  SizedBox(width: 4),
                  Text(
                    "${technician["location"]}",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                  Spacer(),
                  Icon(Icons.phone, size: 16, color: disabledBoldColor),
                  SizedBox(width: 4),
                  Text(
                    "${technician["phone"]}",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Profile",
                      size: bs.sm,
                      onPressed: () => _viewTechnicianProfile(technician),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Assign Job",
                      size: bs.sm,
                      onPressed: () => _assignJob(technician),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Technician Management"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return QTabBar(
      title: "Technician Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "All Technicians", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildOverviewTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildTechniciansTab(),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
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
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          boxShadow: [shadowSm],
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            SizedBox(height: spSm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String time, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  time,
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
}
