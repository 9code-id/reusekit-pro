import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaComplianceManagementView extends StatefulWidget {
  const FmaComplianceManagementView({super.key});

  @override
  State<FmaComplianceManagementView> createState() => _FmaComplianceManagementViewState();
}

class _FmaComplianceManagementViewState extends State<FmaComplianceManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedFilter = "All";
  String complianceType = "";
  String status = "";
  String priority = "Medium";
  String description = "";
  String corrective_action = "";
  String responsible_person = "";
  String deadline = "";
  String notes = "";

  List<Map<String, dynamic>> complianceItems = [
    {
      "id": "CMP001",
      "type": "Food Safety",
      "title": "HACCP Implementation",
      "description": "Implement Hazard Analysis Critical Control Points system",
      "status": "Compliant",
      "priority": "High",
      "last_review": "2024-12-15",
      "next_review": "2025-03-15",
      "responsible": "Food Safety Manager",
      "score": 95,
      "violations": 0,
      "corrective_actions": 2,
      "documents": ["HACCP Plan", "Training Records"],
    },
    {
      "id": "CMP002", 
      "type": "Health Department",
      "title": "Restaurant Permit Renewal",
      "description": "Annual health department permit renewal and inspection",
      "status": "Non-Compliant",
      "priority": "Critical",
      "last_review": "2024-11-20",
      "next_review": "2025-01-20",
      "responsible": "Operations Manager",
      "score": 72,
      "violations": 3,
      "corrective_actions": 5,
      "documents": ["Permit Application", "Inspection Report"],
    },
    {
      "id": "CMP003",
      "type": "Fire Safety",
      "title": "Fire Suppression System",
      "description": "Monthly fire suppression system inspection and maintenance",
      "status": "Compliant",
      "priority": "High",
      "last_review": "2024-12-10",
      "next_review": "2025-01-10",
      "responsible": "Facilities Manager",
      "score": 88,
      "violations": 1,
      "corrective_actions": 1,
      "documents": ["Inspection Certificate", "Maintenance Log"],
    },
    {
      "id": "CMP004",
      "type": "Environmental",
      "title": "Waste Management",
      "description": "Proper waste disposal and recycling compliance",
      "status": "Under Review",
      "priority": "Medium",
      "last_review": "2024-12-05",
      "next_review": "2025-02-05",
      "responsible": "Kitchen Manager",
      "score": 80,
      "violations": 2,
      "corrective_actions": 3,
      "documents": ["Waste Audit", "Disposal Contracts"],
    },
    {
      "id": "CMP005",
      "type": "Labor Law",
      "title": "Employee Training",
      "description": "Mandatory food safety and hygiene training for all staff",
      "status": "Compliant",
      "priority": "High",
      "last_review": "2024-12-01",
      "next_review": "2025-06-01",
      "responsible": "HR Manager",
      "score": 92,
      "violations": 0,
      "corrective_actions": 1,
      "documents": ["Training Certificates", "Attendance Records"],
    },
    {
      "id": "CMP006",
      "type": "Building Code",
      "title": "Kitchen Ventilation",
      "description": "Commercial kitchen ventilation system compliance",
      "status": "Non-Compliant",
      "priority": "High",
      "last_review": "2024-11-15",
      "next_review": "2024-12-30",
      "responsible": "Facilities Manager",
      "score": 65,
      "violations": 4,
      "corrective_actions": 6,
      "documents": ["Ventilation Report", "Engineering Plans"],
    },
  ];

  List<Map<String, dynamic>> auditHistory = [
    {
      "date": "2024-12-15",
      "type": "Internal Audit",
      "auditor": "Quality Assurance Team",
      "score": 88,
      "findings": 12,
      "critical": 2,
      "major": 4,
      "minor": 6,
      "status": "Completed",
    },
    {
      "date": "2024-11-20",
      "type": "Health Department",
      "auditor": "State Health Inspector",
      "score": 76,
      "findings": 18,
      "critical": 3,
      "major": 7,
      "minor": 8,
      "status": "Completed",
    },
    {
      "date": "2024-10-30",
      "type": "Fire Safety",
      "auditor": "Fire Marshal",
      "score": 92,
      "findings": 5,
      "critical": 0,
      "major": 2,
      "minor": 3,
      "status": "Completed",
    },
    {
      "date": "2024-10-15",
      "type": "Corporate Audit",
      "auditor": "Corporate Quality Team",
      "score": 85,
      "findings": 15,
      "critical": 1,
      "major": 6,
      "minor": 8,
      "status": "Completed",
    },
  ];

  List<Map<String, dynamic>> complianceMetrics = [
    {
      "category": "Food Safety",
      "compliance_rate": 95,
      "total_items": 25,
      "compliant": 24,
      "non_compliant": 1,
      "trend": "up",
    },
    {
      "category": "Health Department",
      "compliance_rate": 82,
      "total_items": 18,
      "compliant": 15,
      "non_compliant": 3,
      "trend": "down",
    },
    {
      "category": "Fire Safety",
      "compliance_rate": 90,
      "total_items": 12,
      "compliant": 11,
      "non_compliant": 1,
      "trend": "stable",
    },
    {
      "category": "Environmental",
      "compliance_rate": 78,
      "total_items": 15,
      "compliant": 12,
      "non_compliant": 3,
      "trend": "up",
    },
  ];

  List<Map<String, dynamic>> get filteredCompliance {
    return complianceItems.where((item) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${item["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${item["type"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "All" || item["status"] == selectedFilter;
      
      return matchesSearch && matchesFilter;
    }).toList();
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Compliance Score Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.verified_user, color: Colors.white, size: 32),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Overall Compliance Score",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "86%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "+2% from last month",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.all(0),
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Items", "${complianceItems.length}", Icons.assignment, primaryColor),
              _buildStatCard("Compliant", "${complianceItems.where((item) => item["status"] == "Compliant").length}", Icons.check_circle, successColor),
              _buildStatCard("Non-Compliant", "${complianceItems.where((item) => item["status"] == "Non-Compliant").length}", Icons.error, dangerColor),
              _buildStatCard("Under Review", "${complianceItems.where((item) => item["status"] == "Under Review").length}", Icons.schedule, warningColor),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Compliance by Category
          Text(
            "Compliance by Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: complianceMetrics.map((metric) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                        Expanded(
                          child: Text(
                            "${metric["category"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${metric["compliance_rate"]}%",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: (metric["compliance_rate"] as int) >= 90 ? successColor : 
                                   (metric["compliance_rate"] as int) >= 75 ? warningColor : dangerColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Icon(
                          (metric["trend"] as String) == "up" ? Icons.trending_up :
                          (metric["trend"] as String) == "down" ? Icons.trending_down : Icons.trending_flat,
                          color: (metric["trend"] as String) == "up" ? successColor :
                                 (metric["trend"] as String) == "down" ? dangerColor : disabledBoldColor,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: (metric["compliance_rate"] as int) / 100,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        (metric["compliance_rate"] as int) >= 90 ? successColor : 
                        (metric["compliance_rate"] as int) >= 75 ? warningColor : dangerColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${metric["compliant"]} of ${metric["total_items"]} items compliant",
                      style: TextStyle(
                        fontSize: 12,
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

  Widget _buildComplianceTab() {
    return Column(
      children: [
        // Search and Filter
        Container(
          padding: EdgeInsets.all(spMd),
          color: Colors.white,
          child: Column(
            children: [
              QTextField(
                label: "Search compliance items...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QCategoryPicker(
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Compliant", "value": "Compliant"},
                  {"label": "Non-Compliant", "value": "Non-Compliant"},
                  {"label": "Under Review", "value": "Under Review"},
                ],
                value: selectedFilter,
                onChanged: (index, label, value, item) {
                  selectedFilter = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
        // Compliance List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(spMd),
            itemCount: filteredCompliance.length,
            itemBuilder: (context, index) {
              final item = filteredCompliance[index];
              Color statusColor = item["status"] == "Compliant" ? successColor :
                                 item["status"] == "Non-Compliant" ? dangerColor : warningColor;
              
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
                child: ExpansionTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      item["status"] == "Compliant" ? Icons.check_circle :
                      item["status"] == "Non-Compliant" ? Icons.error : Icons.schedule,
                      color: statusColor,
                    ),
                  ),
                  title: Text(
                    "${item["title"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item["type"]} • ${item["responsible"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${item["status"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: item["priority"] == "Critical" ? dangerColor :
                                     item["priority"] == "High" ? warningColor : primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${item["priority"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoItem("Score", "${item["score"]}%", Icons.score),
                              ),
                              Expanded(
                                child: _buildInfoItem("Violations", "${item["violations"]}", Icons.warning),
                              ),
                              Expanded(
                                child: _buildInfoItem("Actions", "${item["corrective_actions"]}", Icons.build),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoItem("Last Review", "${item["last_review"]}", Icons.calendar_today),
                              ),
                              Expanded(
                                child: _buildInfoItem("Next Review", "${item["next_review"]}", Icons.event),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Text(
                            "Documents:",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Wrap(
                            spacing: spXs,
                            children: (item["documents"] as List).map((doc) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "$doc",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAuditTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Audit History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: auditHistory.map((audit) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.assessment,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${audit["type"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${audit["auditor"]} • ${audit["date"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: (audit["score"] as int) >= 90 ? successColor :
                                   (audit["score"] as int) >= 75 ? warningColor : dangerColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${audit["score"]}%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildAuditStat("Total Findings", "${audit["findings"]}", Icons.search),
                        ),
                        Expanded(
                          child: _buildAuditStat("Critical", "${audit["critical"]}", Icons.priority_high),
                        ),
                        Expanded(
                          child: _buildAuditStat("Major", "${audit["major"]}", Icons.warning),
                        ),
                        Expanded(
                          child: _buildAuditStat("Minor", "${audit["minor"]}", Icons.info),
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

  Widget _buildNewComplianceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add New Compliance Item",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          QDropdownField(
            label: "Compliance Type",
            items: [
              {"label": "Food Safety", "value": "Food Safety"},
              {"label": "Health Department", "value": "Health Department"},
              {"label": "Fire Safety", "value": "Fire Safety"},
              {"label": "Environmental", "value": "Environmental"},
              {"label": "Labor Law", "value": "Labor Law"},
              {"label": "Building Code", "value": "Building Code"},
            ],
            value: complianceType,
            onChanged: (value, label) {
              complianceType = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Status",
            value: status,
            onChanged: (value) {
              status = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QDropdownField(
            label: "Priority",
            items: [
              {"label": "Low", "value": "Low"},
              {"label": "Medium", "value": "Medium"},
              {"label": "High", "value": "High"},
              {"label": "Critical", "value": "Critical"},
            ],
            value: priority,
            onChanged: (value, label) {
              priority = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QMemoField(
            label: "Description",
            value: description,
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QMemoField(
            label: "Corrective Action",
            value: corrective_action,
            onChanged: (value) {
              corrective_action = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Responsible Person",
            value: responsible_person,
            onChanged: (value) {
              responsible_person = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Deadline",
            value: deadline,
            onChanged: (value) {
              deadline = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QMemoField(
            label: "Notes",
            value: notes,
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create Compliance Item",
              size: bs.md,
              onPressed: () {
                ss("Compliance item created successfully");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: disabledBoldColor),
            SizedBox(width: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAuditStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: disabledBoldColor, size: 20),
        SizedBox(height: spXs),
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
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Compliance Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Compliance", icon: Icon(Icons.verified_user)),
        Tab(text: "Audits", icon: Icon(Icons.assessment)),
        Tab(text: "Add Item", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildComplianceTab(),
        _buildAuditTab(),
        _buildNewComplianceTab(),
      ],
    );
  }
}
