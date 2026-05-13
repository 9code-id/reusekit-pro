import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaTrainingRecordsView extends StatefulWidget {
  const RmaTrainingRecordsView({super.key});

  @override
  State<RmaTrainingRecordsView> createState() => _RmaTrainingRecordsViewState();
}

class _RmaTrainingRecordsViewState extends State<RmaTrainingRecordsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedDepartment = "";
  String selectedStatus = "";
  String selectedCertification = "";

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": ""},
    {"label": "Customer Service", "value": "customer_service"},
    {"label": "Technical Support", "value": "technical_support"},
    {"label": "Quality Assurance", "value": "quality_assurance"},
    {"label": "Warehouse", "value": "warehouse"},
    {"label": "Management", "value": "management"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "Expired", "value": "expired"},
    {"label": "Pending", "value": "pending"},
  ];

  List<Map<String, dynamic>> certificationTypes = [
    {"label": "All Certifications", "value": ""},
    {"label": "RMA Basic", "value": "rma_basic"},
    {"label": "RMA Advanced", "value": "rma_advanced"},
    {"label": "Quality Control", "value": "quality_control"},
    {"label": "Customer Relations", "value": "customer_relations"},
    {"label": "Technical Procedures", "value": "technical_procedures"},
  ];

  List<Map<String, dynamic>> trainingRecords = [
    {
      "id": "TR001",
      "employee_name": "John Smith",
      "employee_id": "EMP001",
      "department": "customer_service",
      "certification_type": "rma_basic",
      "training_title": "RMA Process Fundamentals",
      "instructor": "Sarah Johnson",
      "start_date": "2024-01-15",
      "completion_date": "2024-01-20",
      "expiry_date": "2025-01-20",
      "status": "completed",
      "score": 95,
      "duration_hours": 40,
      "certificate_url": "https://certificates.example.com/TR001.pdf",
      "materials": [
        "RMA Policy Manual",
        "Customer Service Guidelines",
        "Return Process Flowchart"
      ],
      "competencies": [
        "Return Authorization",
        "Customer Communication",
        "Documentation"
      ]
    },
    {
      "id": "TR002",
      "employee_name": "Emily Davis",
      "employee_id": "EMP002",
      "department": "technical_support",
      "certification_type": "rma_advanced",
      "training_title": "Advanced RMA Technical Analysis",
      "instructor": "Mike Chen",
      "start_date": "2024-02-01",
      "completion_date": null,
      "expiry_date": "2025-02-01",
      "status": "in_progress",
      "score": null,
      "duration_hours": 60,
      "certificate_url": null,
      "materials": [
        "Technical Diagnostic Manual",
        "Advanced Testing Procedures",
        "Repair Authorization Guidelines"
      ],
      "competencies": [
        "Technical Diagnosis",
        "Component Testing",
        "Repair Assessment"
      ]
    },
    {
      "id": "TR003",
      "employee_name": "Robert Wilson",
      "employee_id": "EMP003",
      "department": "quality_assurance",
      "certification_type": "quality_control",
      "training_title": "Quality Control in RMA Process",
      "instructor": "Lisa Park",
      "start_date": "2023-11-10",
      "completion_date": "2023-11-18",
      "expiry_date": "2024-11-18",
      "status": "expired",
      "score": 88,
      "duration_hours": 32,
      "certificate_url": "https://certificates.example.com/TR003.pdf",
      "materials": [
        "QA Standards Manual",
        "Inspection Checklists",
        "Quality Metrics Guide"
      ],
      "competencies": [
        "Quality Inspection",
        "Standards Compliance",
        "Documentation Review"
      ]
    },
    {
      "id": "TR004",
      "employee_name": "Maria Garcia",
      "employee_id": "EMP004",
      "department": "warehouse",
      "certification_type": "rma_basic",
      "training_title": "Warehouse RMA Operations",
      "instructor": "David Lee",
      "start_date": "2024-03-01",
      "completion_date": null,
      "expiry_date": "2025-03-01",
      "status": "pending",
      "score": null,
      "duration_hours": 24,
      "certificate_url": null,
      "materials": [
        "Warehouse Procedures",
        "Inventory Management",
        "Safety Protocols"
      ],
      "competencies": [
        "Inventory Handling",
        "Safety Compliance",
        "Process Documentation"
      ]
    },
    {
      "id": "TR005",
      "employee_name": "James Anderson",
      "employee_id": "EMP005",
      "department": "customer_service",
      "certification_type": "customer_relations",
      "training_title": "Customer Relations in RMA",
      "instructor": "Jennifer Brown",
      "start_date": "2024-01-25",
      "completion_date": "2024-02-05",
      "expiry_date": "2025-02-05",
      "status": "completed",
      "score": 92,
      "duration_hours": 28,
      "certificate_url": "https://certificates.example.com/TR005.pdf",
      "materials": [
        "Customer Communication Guide",
        "Conflict Resolution Manual",
        "Service Recovery Procedures"
      ],
      "competencies": [
        "Customer Communication",
        "Conflict Resolution",
        "Service Recovery"
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredRecords {
    return trainingRecords.where((record) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${record["employee_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${record["training_title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${record["employee_id"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesDepartment = selectedDepartment.isEmpty ||
          record["department"] == selectedDepartment;

      bool matchesStatus = selectedStatus.isEmpty ||
          record["status"] == selectedStatus;

      bool matchesCertification = selectedCertification.isEmpty ||
          record["certification_type"] == selectedCertification;

      return matchesSearch && matchesDepartment && matchesStatus && matchesCertification;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return infoColor;
      case "expired":
        return dangerColor;
      case "pending":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "in_progress":
        return "In Progress";
      case "expired":
        return "Expired";
      case "pending":
        return "Pending";
      default:
        return "Unknown";
    }
  }

  String _getDepartmentLabel(String department) {
    switch (department) {
      case "customer_service":
        return "Customer Service";
      case "technical_support":
        return "Technical Support";
      case "quality_assurance":
        return "Quality Assurance";
      case "warehouse":
        return "Warehouse";
      case "management":
        return "Management";
      default:
        return "Unknown";
    }
  }

  String _getCertificationLabel(String certification) {
    switch (certification) {
      case "rma_basic":
        return "RMA Basic";
      case "rma_advanced":
        return "RMA Advanced";
      case "quality_control":
        return "Quality Control";
      case "customer_relations":
        return "Customer Relations";
      case "technical_procedures":
        return "Technical Procedures";
      default:
        return "Unknown";
    }
  }

  void _viewRecordDetails(Map<String, dynamic> record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Training Record Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow("Employee", "${record["employee_name"]} (${record["employee_id"]})"),
              _buildDetailRow("Department", _getDepartmentLabel("${record["department"]}")),
              _buildDetailRow("Training Title", "${record["training_title"]}"),
              _buildDetailRow("Certification", _getCertificationLabel("${record["certification_type"]}")),
              _buildDetailRow("Instructor", "${record["instructor"]}"),
              _buildDetailRow("Start Date", "${record["start_date"]}"),
              if (record["completion_date"] != null)
                _buildDetailRow("Completion Date", "${record["completion_date"]}"),
              _buildDetailRow("Expiry Date", "${record["expiry_date"]}"),
              _buildDetailRow("Duration", "${record["duration_hours"]} hours"),
              if (record["score"] != null)
                _buildDetailRow("Score", "${record["score"]}%"),
              _buildDetailRow("Status", _getStatusLabel("${record["status"]}")),
              
              SizedBox(height: spMd),
              Text(
                "Training Materials:",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              ...(record["materials"] as List).map((material) => Padding(
                padding: EdgeInsets.only(bottom: spXs),
                child: Row(
                  children: [
                    Icon(Icons.book, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${material}",
                        style: TextStyle(color: disabledBoldColor),
                      ),
                    ),
                  ],
                ),
              )),
              
              SizedBox(height: spMd),
              Text(
                "Competencies:",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: (record["competencies"] as List).map((competency) => 
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(40)),
                    ),
                    child: Text(
                      "${competency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          if (record["certificate_url"] != null)
            QButton(
              label: "View Certificate",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Certificate opened successfully");
              },
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "${label}:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordCard(Map<String, dynamic> record) {
    Color statusColor = _getStatusColor("${record["status"]}");
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${record["employee_name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXxs),
                      Text(
                        "${record["employee_id"]} • ${_getDepartmentLabel("${record["department"]}")}",
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
                    color: statusColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: statusColor.withAlpha(40)),
                  ),
                  child: Text(
                    _getStatusLabel("${record["status"]}"),
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            Text(
              "${record["training_title"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spXs),
            Text(
              "Certification: ${_getCertificationLabel("${record["certification_type"]}")}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.person, size: 16, color: disabledBoldColor),
                SizedBox(width: spXxs),
                Text(
                  "${record["instructor"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spSm),
                Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                SizedBox(width: spXxs),
                Text(
                  "${record["duration_hours"]}h",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                if (record["score"] != null) ...[
                  SizedBox(width: spSm),
                  Icon(Icons.grade, size: 16, color: successColor),
                  SizedBox(width: spXxs),
                  Text(
                    "${record["score"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
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
                        "Start: ${record["start_date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (record["completion_date"] != null)
                        Text(
                          "Completed: ${record["completion_date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      Text(
                        "Expires: ${record["expiry_date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewRecordDetails(record),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllRecordsTab() {
    return Column(
      children: [
        // Search and Filters
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search employees or training...",
                      value: searchQuery,
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.search,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
              
              SizedBox(height: spSm),
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
              
              SizedBox(height: spSm),
              QDropdownField(
                label: "Certification Type",
                items: certificationTypes,
                value: selectedCertification,
                onChanged: (value, label) {
                  selectedCertification = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Results Summary
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor.withAlpha(40)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Showing ${filteredRecords.length} of ${trainingRecords.length} training records",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Records List
        if (filteredRecords.isEmpty)
          Container(
            padding: EdgeInsets.all(spLg),
            child: Column(
              children: [
                Icon(
                  Icons.school_outlined,
                  size: 64,
                  color: disabledColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "No training records found",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Try adjusting your search criteria or filters",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )
        else
          ...filteredRecords.map((record) => _buildRecordCard(record)),
      ],
    );
  }

  Widget _buildStatisticsTab() {
    Map<String, int> statusCounts = {
      "completed": 0,
      "in_progress": 0,
      "expired": 0,
      "pending": 0,
    };

    Map<String, int> departmentCounts = {};
    Map<String, int> certificationCounts = {};

    for (var record in trainingRecords) {
      String status = "${record["status"]}";
      String department = "${record["department"]}";
      String certification = "${record["certification_type"]}";

      statusCounts[status] = (statusCounts[status] ?? 0) + 1;
      departmentCounts[department] = (departmentCounts[department] ?? 0) + 1;
      certificationCounts[certification] = (certificationCounts[certification] ?? 0) + 1;
    }

    return Column(
      children: [
        // Status Overview
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Training Status Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: [
                  _buildStatCard("Completed", statusCounts["completed"] ?? 0, successColor, Icons.check_circle),
                  _buildStatCard("In Progress", statusCounts["in_progress"] ?? 0, infoColor, Icons.schedule),
                  _buildStatCard("Expired", statusCounts["expired"] ?? 0, dangerColor, Icons.error),
                  _buildStatCard("Pending", statusCounts["pending"] ?? 0, warningColor, Icons.pending),
                ],
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Department Distribution
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Training by Department",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...departmentCounts.entries.map((entry) => Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(20)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _getDepartmentLabel(entry.key),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${entry.value}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Certification Types
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Certification Types",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...certificationCounts.entries.map((entry) => Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: secondaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: secondaryColor.withAlpha(20)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.workspace_premium, color: secondaryColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        _getCertificationLabel(entry.key),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${entry.value}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, int value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                "$value",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "RMA Training Records",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Records", icon: Icon(Icons.list)),
        Tab(text: "Statistics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildAllRecordsTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildStatisticsTab(),
        ),
      ],
    );
  }
}