import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmTechnicianSkillsView extends StatefulWidget {
  const FsmTechnicianSkillsView({super.key});

  @override
  State<FsmTechnicianSkillsView> createState() => _FsmTechnicianSkillsViewState();
}

class _FsmTechnicianSkillsViewState extends State<FsmTechnicianSkillsView> {
  bool loading = false;
  String searchQuery = "";
  String selectedSkillCategory = "All";
  String selectedProficiencyLevel = "All";
  String selectedTechnician = "All";

  List<Map<String, dynamic>> skills = [
    {
      "id": "SKILL-001",
      "name": "Network Administration",
      "category": "IT Infrastructure",
      "description": "Configure, maintain, and troubleshoot network systems including routers, switches, and firewalls",
      "requiredForJobs": ["Network Engineer", "IT Support Specialist", "System Administrator"],
      "certificationRequired": false,
      "technicians": [
        {"technicianId": "TECH-001", "name": "John Smith", "proficiency": "Expert", "experience": 8, "lastAssessed": "2024-06-01"},
        {"technicianId": "TECH-005", "name": "Alex Johnson", "proficiency": "Advanced", "experience": 3, "lastAssessed": "2024-05-15"},
        {"technicianId": "TECH-008", "name": "Lisa Chang", "proficiency": "Intermediate", "experience": 2, "lastAssessed": "2024-04-20"}
      ],
      "averageProficiency": 4.2,
      "demandLevel": "High",
      "marketRate": 75.0,
      "trainingAvailable": true
    },
    {
      "id": "SKILL-002",
      "name": "Biomedical Equipment Maintenance",
      "category": "Medical Equipment",
      "description": "Service, calibrate, and repair medical devices and diagnostic equipment",
      "requiredForJobs": ["Biomedical Technician", "Medical Equipment Specialist"],
      "certificationRequired": true,
      "technicians": [
        {"technicianId": "TECH-003", "name": "Mike Davis", "proficiency": "Expert", "experience": 12, "lastAssessed": "2024-05-30"},
        {"technicianId": "TECH-006", "name": "Jessica Taylor", "proficiency": "Expert", "experience": 9, "lastAssessed": "2024-06-10"}
      ],
      "averageProficiency": 4.8,
      "demandLevel": "High",
      "marketRate": 85.0,
      "trainingAvailable": true
    },
    {
      "id": "SKILL-003",
      "name": "HVAC Systems",
      "category": "Mechanical",
      "description": "Install, maintain, and repair heating, ventilation, and air conditioning systems",
      "requiredForJobs": ["HVAC Technician", "Building Maintenance Specialist"],
      "certificationRequired": true,
      "technicians": [
        {"technicianId": "TECH-002", "name": "Sarah Wilson", "proficiency": "Expert", "experience": 6, "lastAssessed": "2024-06-05"},
        {"technicianId": "TECH-007", "name": "David Brown", "proficiency": "Advanced", "experience": 4, "lastAssessed": "2024-05-20"}
      ],
      "averageProficiency": 4.5,
      "demandLevel": "Medium",
      "marketRate": 68.0,
      "trainingAvailable": true
    },
    {
      "id": "SKILL-004",
      "name": "Cybersecurity",
      "category": "IT Security",
      "description": "Implement security measures, conduct vulnerability assessments, and respond to security incidents",
      "requiredForJobs": ["Security Analyst", "IT Security Specialist", "Cybersecurity Consultant"],
      "certificationRequired": true,
      "technicians": [
        {"technicianId": "TECH-008", "name": "Lisa Chang", "proficiency": "Expert", "experience": 5, "lastAssessed": "2024-06-01"},
        {"technicianId": "TECH-005", "name": "Alex Johnson", "proficiency": "Advanced", "experience": 3, "lastAssessed": "2024-05-25"}
      ],
      "averageProficiency": 4.3,
      "demandLevel": "Very High",
      "marketRate": 88.0,
      "trainingAvailable": true
    },
    {
      "id": "SKILL-005",
      "name": "POS Systems",
      "category": "Retail Technology",
      "description": "Install, configure, and maintain point-of-sale systems and retail technology",
      "requiredForJobs": ["Retail Tech Support", "POS Specialist"],
      "certificationRequired": false,
      "technicians": [
        {"technicianId": "TECH-004", "name": "Emily Rodriguez", "proficiency": "Advanced", "experience": 4, "lastAssessed": "2024-05-10"}
      ],
      "averageProficiency": 4.0,
      "demandLevel": "Medium",
      "marketRate": 62.0,
      "trainingAvailable": true
    },
    {
      "id": "SKILL-006",
      "name": "Solar Systems Installation",
      "category": "Renewable Energy",
      "description": "Design, install, and maintain solar panel systems and energy storage solutions",
      "requiredForJobs": ["Solar Installer", "Renewable Energy Technician"],
      "certificationRequired": true,
      "technicians": [
        {"technicianId": "TECH-007", "name": "David Brown", "proficiency": "Expert", "experience": 11, "lastAssessed": "2024-06-08"}
      ],
      "averageProficiency": 4.9,
      "demandLevel": "High",
      "marketRate": 80.0,
      "trainingAvailable": true
    },
    {
      "id": "SKILL-007",
      "name": "Cloud Services Management",
      "category": "IT Infrastructure",
      "description": "Deploy, manage, and optimize cloud-based services and infrastructure",
      "requiredForJobs": ["Cloud Engineer", "DevOps Specialist", "System Administrator"],
      "certificationRequired": true,
      "technicians": [
        {"technicianId": "TECH-005", "name": "Alex Johnson", "proficiency": "Advanced", "experience": 3, "lastAssessed": "2024-05-28"},
        {"technicianId": "TECH-001", "name": "John Smith", "proficiency": "Intermediate", "experience": 2, "lastAssessed": "2024-04-15"}
      ],
      "averageProficiency": 3.8,
      "demandLevel": "Very High",
      "marketRate": 95.0,
      "trainingAvailable": true
    },
    {
      "id": "SKILL-008",
      "name": "Electrical Systems",
      "category": "Electrical",
      "description": "Install, maintain, and repair electrical systems and components",
      "requiredForJobs": ["Electrician", "Electrical Technician", "Maintenance Specialist"],
      "certificationRequired": true,
      "technicians": [
        {"technicianId": "TECH-002", "name": "Sarah Wilson", "proficiency": "Advanced", "experience": 5, "lastAssessed": "2024-05-22"},
        {"technicianId": "TECH-007", "name": "David Brown", "proficiency": "Expert", "experience": 11, "lastAssessed": "2024-06-12"}
      ],
      "averageProficiency": 4.4,
      "demandLevel": "High",
      "marketRate": 72.0,
      "trainingAvailable": true
    }
  ];

  List<Map<String, dynamic>> skillCategories = [
    {"label": "All", "value": "All"},
    {"label": "IT Infrastructure", "value": "IT Infrastructure"},
    {"label": "Medical Equipment", "value": "Medical Equipment"},
    {"label": "Mechanical", "value": "Mechanical"},
    {"label": "IT Security", "value": "IT Security"},
    {"label": "Retail Technology", "value": "Retail Technology"},
    {"label": "Renewable Energy", "value": "Renewable Energy"},
    {"label": "Electrical", "value": "Electrical"}
  ];

  List<Map<String, dynamic>> proficiencyLevels = [
    {"label": "All", "value": "All"},
    {"label": "Expert", "value": "Expert"},
    {"label": "Advanced", "value": "Advanced"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Beginner", "value": "Beginner"}
  ];

  List<Map<String, dynamic>> technicianOptions = [
    {"label": "All Technicians", "value": "All"},
    {"label": "John Smith", "value": "TECH-001"},
    {"label": "Sarah Wilson", "value": "TECH-002"},
    {"label": "Mike Davis", "value": "TECH-003"},
    {"label": "Emily Rodriguez", "value": "TECH-004"},
    {"label": "Alex Johnson", "value": "TECH-005"},
    {"label": "Jessica Taylor", "value": "TECH-006"},
    {"label": "David Brown", "value": "TECH-007"},
    {"label": "Lisa Chang", "value": "TECH-008"}
  ];

  List<Map<String, dynamic>> get filteredSkills {
    return skills.where((skill) {
      bool matchesSearch = skill["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          skill["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          skill["category"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedSkillCategory == "All" || skill["category"] == selectedSkillCategory;
      
      bool matchesTechnician = selectedTechnician == "All" || 
                              (skill["technicians"] as List).any((tech) => tech["technicianId"] == selectedTechnician);
      
      bool matchesProficiency = selectedProficiencyLevel == "All" ||
                               (skill["technicians"] as List).any((tech) => tech["proficiency"] == selectedProficiencyLevel);
      
      return matchesSearch && matchesCategory && matchesTechnician && matchesProficiency;
    }).toList();
  }

  Color _getDemandLevelColor(String demandLevel) {
    switch (demandLevel) {
      case "Very High":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getProficiencyColor(String proficiency) {
    switch (proficiency) {
      case "Expert":
        return successColor;
      case "Advanced":
        return infoColor;
      case "Intermediate":
        return warningColor;
      case "Beginner":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _viewSkillDetails(Map<String, dynamic> skill) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Skill Details"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text("${skill["name"]}", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Category: ${skill["category"]}"),
                Text("ID: ${skill["id"]}"),
                
                SizedBox(height: spSm),
                Text("Description", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("${skill["description"]}"),
                
                SizedBox(height: spSm),
                Text("Market Information", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Market Rate: \$${(skill["marketRate"] as double).toStringAsFixed(2)}/hour"),
                Text("Demand Level: ${skill["demandLevel"]}"),
                Text("Average Proficiency: ${skill["averageProficiency"]}/5.0"),
                Text("Certification Required: ${skill["certificationRequired"] ? "Yes" : "No"}"),
                Text("Training Available: ${skill["trainingAvailable"] ? "Yes" : "No"}"),
                
                SizedBox(height: spSm),
                Text("Required For Jobs", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                ...(skill["requiredForJobs"] as List).map((job) => Text("• $job")),
                
                SizedBox(height: spSm),
                Text("Technicians with this Skill", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                ...(skill["technicians"] as List).map((tech) => Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${tech["name"]}", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Proficiency: ${tech["proficiency"]} (${tech["experience"]} years)"),
                      Text("Last Assessed: ${tech["lastAssessed"]}"),
                    ],
                  ),
                )),
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

  void _addNewSkill() {
    ss("Add new skill functionality");
  }

  void _assessTechnician(Map<String, dynamic> skill) {
    ss("Skill assessment functionality for ${skill["name"]}");
  }

  void _scheduleTraining(Map<String, dynamic> skill) {
    ss("Schedule training for ${skill["name"]}");
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Technician Skills"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Technician Skills"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNewSkill,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildSummaryCard("Total Skills", "${skills.length}", primaryColor, Icons.build),
                _buildSummaryCard("High Demand", "${skills.where((s) => s["demandLevel"] == "High" || s["demandLevel"] == "Very High").length}", dangerColor, Icons.trending_up),
                _buildSummaryCard("Certification Required", "${skills.where((s) => s["certificationRequired"] == true).length}", warningColor, Icons.verified),
                _buildSummaryCard("Training Available", "${skills.where((s) => s["trainingAvailable"] == true).length}", successColor, Icons.school),
              ],
            ),

            // Search and Filters
            QTextField(
              label: "Search skills",
              value: searchQuery,
              hint: "Search by skill name, description, or category",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: skillCategories,
                    value: selectedSkillCategory,
                    onChanged: (value, label) {
                      selectedSkillCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Proficiency Level",
                    items: proficiencyLevels,
                    value: selectedProficiencyLevel,
                    onChanged: (value, label) {
                      selectedProficiencyLevel = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
              label: "Filter by Technician",
              items: technicianOptions,
              value: selectedTechnician,
              onChanged: (value, label) {
                selectedTechnician = value;
                setState(() {});
              },
            ),

            // Skills List
            Text(
              "Skills (${filteredSkills.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...filteredSkills.map((skill) => Container(
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${skill["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${skill["category"]} • ${skill["id"]}",
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
                          color: _getDemandLevelColor(skill["demandLevel"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${skill["demandLevel"]} Demand",
                          style: TextStyle(
                            color: _getDemandLevelColor(skill["demandLevel"]),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Text(
                    "${skill["description"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Market Rate",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(skill["marketRate"] as double).toStringAsFixed(0)}/hr",
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
                              "Avg Proficiency",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${skill["averageProficiency"]}/5.0",
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
                              "Technicians",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${(skill["technicians"] as List).length}",
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
                      Icon(Icons.verified, size: 16, color: skill["certificationRequired"] ? warningColor : disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        skill["certificationRequired"] ? "Certification Required" : "No Certification",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                      Spacer(),
                      Icon(Icons.school, size: 16, color: skill["trainingAvailable"] ? successColor : disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        skill["trainingAvailable"] ? "Training Available" : "No Training",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                    ],
                  ),

                  // Technicians with this skill (preview)
                  if ((skill["technicians"] as List).isNotEmpty) ...[
                    Text(
                      "Technicians:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    QHorizontalScroll(
                      children: (skill["technicians"] as List).map((tech) => Container(
                        margin: EdgeInsets.only(right: spXs),
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getProficiencyColor(tech["proficiency"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${tech["name"]} (${tech["proficiency"]})",
                          style: TextStyle(
                            color: _getProficiencyColor(tech["proficiency"]),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],

                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () => _viewSkillDetails(skill),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Assess",
                          size: bs.sm,
                          onPressed: () => _assessTechnician(skill),
                        ),
                      ),
                      if (skill["trainingAvailable"]) ...[
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Training",
                            size: bs.sm,
                            onPressed: () => _scheduleTraining(skill),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
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
}
