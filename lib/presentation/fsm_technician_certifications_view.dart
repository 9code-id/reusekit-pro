import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmTechnicianCertificationsView extends StatefulWidget {
  const FsmTechnicianCertificationsView({super.key});

  @override
  State<FsmTechnicianCertificationsView> createState() => _FsmTechnicianCertificationsViewState();
}

class _FsmTechnicianCertificationsViewState extends State<FsmTechnicianCertificationsView> {
  bool loading = false;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedCategory = "All";
  String selectedTechnician = "All";

  List<Map<String, dynamic>> certifications = [
    {
      "id": "CERT-001",
      "name": "CompTIA Network+",
      "category": "IT Infrastructure",
      "issuer": "CompTIA",
      "description": "Validates networking skills and knowledge required to troubleshoot, configure, and manage common network wireless and wired devices",
      "validityPeriod": "3 years",
      "renewalRequired": true,
      "cost": 370.0,
      "difficulty": "Intermediate",
      "prerequisite": "CompTIA A+ recommended",
      "technicians": [
        {
          "technicianId": "TECH-001",
          "name": "John Smith",
          "issueDate": "2020-03-15",
          "expiryDate": "2024-03-15",
          "status": "Expiring Soon",
          "score": 820,
          "renewalDue": "2024-03-15"
        },
        {
          "technicianId": "TECH-005",
          "name": "Alex Johnson",
          "issueDate": "2022-01-20",
          "expiryDate": "2025-01-20",
          "status": "Valid",
          "score": 795,
          "renewalDue": "2025-01-20"
        }
      ],
      "marketDemand": "High",
      "salaryImpact": "+15%",
      "requiredForJobs": ["Network Administrator", "IT Support Specialist", "System Administrator"],
      "trainingProviders": ["CompTIA Official", "Udemy", "Coursera"],
      "examDetails": {
        "duration": "90 minutes",
        "questions": "90 questions",
        "passingScore": "720/900",
        "format": "Multiple choice"
      }
    },
    {
      "id": "CERT-002",
      "name": "Biomedical Equipment Technician",
      "category": "Medical Equipment",
      "issuer": "ACI (Association for the Advancement of Medical Instrumentation)",
      "description": "Certification for technicians who maintain, repair, and operate medical equipment in healthcare facilities",
      "validityPeriod": "Lifetime with continuing education",
      "renewalRequired": true,
      "cost": 450.0,
      "difficulty": "Advanced",
      "prerequisite": "Associate degree in biomedical technology",
      "technicians": [
        {
          "technicianId": "TECH-003",
          "name": "Mike Davis",
          "issueDate": "2018-06-10",
          "expiryDate": "2024-06-10",
          "status": "Valid",
          "score": 885,
          "renewalDue": "2024-06-10"
        },
        {
          "technicianId": "TECH-006",
          "name": "Jessica Taylor",
          "issueDate": "2019-09-15",
          "expiryDate": "2025-09-15",
          "status": "Valid",
          "score": 912,
          "renewalDue": "2025-09-15"
        }
      ],
      "marketDemand": "Very High",
      "salaryImpact": "+25%",
      "requiredForJobs": ["Biomedical Technician", "Medical Equipment Specialist", "Clinical Engineer"],
      "trainingProviders": ["AAMI", "Penn Foster", "Community Colleges"],
      "examDetails": {
        "duration": "4 hours",
        "questions": "165 questions",
        "passingScore": "70%",
        "format": "Multiple choice and practical"
      }
    },
    {
      "id": "CERT-003",
      "name": "HVAC Excellence Certification",
      "category": "Mechanical",
      "issuer": "HVAC Excellence",
      "description": "Industry-recognized certification demonstrating competency in HVAC installation, maintenance, and repair",
      "validityPeriod": "2 years",
      "renewalRequired": true,
      "cost": 285.0,
      "difficulty": "Intermediate",
      "prerequisite": "6 months HVAC experience",
      "technicians": [
        {
          "technicianId": "TECH-002",
          "name": "Sarah Wilson",
          "issueDate": "2023-04-20",
          "expiryDate": "2025-04-20",
          "status": "Valid",
          "score": 840,
          "renewalDue": "2025-04-20"
        },
        {
          "technicianId": "TECH-007",
          "name": "David Brown",
          "issueDate": "2022-11-15",
          "expiryDate": "2024-11-15",
          "status": "Valid",
          "score": 865,
          "renewalDue": "2024-11-15"
        }
      ],
      "marketDemand": "High",
      "salaryImpact": "+18%",
      "requiredForJobs": ["HVAC Technician", "Building Maintenance Specialist", "Facility Manager"],
      "trainingProviders": ["HVAC Excellence", "Technical Schools", "Trade Programs"],
      "examDetails": {
        "duration": "2 hours",
        "questions": "100 questions",
        "passingScore": "70%",
        "format": "Multiple choice"
      }
    },
    {
      "id": "CERT-004",
      "name": "CISSP (Certified Information Systems Security Professional)",
      "category": "Cybersecurity",
      "issuer": "(ISC)² International Information System Security Certification Consortium",
      "description": "Advanced cybersecurity certification for experienced security practitioners, managers and executives",
      "validityPeriod": "3 years",
      "renewalRequired": true,
      "cost": 749.0,
      "difficulty": "Expert",
      "prerequisite": "5 years paid work experience in cybersecurity",
      "technicians": [
        {
          "technicianId": "TECH-008",
          "name": "Lisa Chang",
          "issueDate": "2023-02-28",
          "expiryDate": "2026-02-28",
          "status": "Valid",
          "score": 750,
          "renewalDue": "2026-02-28"
        }
      ],
      "marketDemand": "Very High",
      "salaryImpact": "+35%",
      "requiredForJobs": ["Security Manager", "CISO", "Security Consultant", "Risk Analyst"],
      "trainingProviders": ["(ISC)²", "SANS", "InfoSec Institute"],
      "examDetails": {
        "duration": "6 hours",
        "questions": "100-150 questions",
        "passingScore": "700/1000",
        "format": "CAT (Computer Adaptive Testing)"
      }
    },
    {
      "id": "CERT-005",
      "name": "AWS Certified Solutions Architect",
      "category": "Cloud Computing",
      "issuer": "Amazon Web Services",
      "description": "Validates expertise in designing distributed systems and applications on the AWS platform",
      "validityPeriod": "3 years",
      "renewalRequired": true,
      "cost": 150.0,
      "difficulty": "Advanced",
      "prerequisite": "1+ years hands-on experience with AWS",
      "technicians": [
        {
          "technicianId": "TECH-005",
          "name": "Alex Johnson",
          "issueDate": "2023-08-10",
          "expiryDate": "2026-08-10",
          "status": "Valid",
          "score": 810,
          "renewalDue": "2026-08-10"
        }
      ],
      "marketDemand": "Very High",
      "salaryImpact": "+28%",
      "requiredForJobs": ["Cloud Architect", "DevOps Engineer", "Cloud Engineer"],
      "trainingProviders": ["AWS Training", "A Cloud Guru", "Linux Academy"],
      "examDetails": {
        "duration": "130 minutes",
        "questions": "65 questions",
        "passingScore": "720/1000",
        "format": "Multiple choice and multiple response"
      }
    },
    {
      "id": "CERT-006",
      "name": "Solar Installation Professional Certification",
      "category": "Renewable Energy",
      "issuer": "North American Board of Certified Energy Practitioners (NABCEP)",
      "description": "Industry-standard certification for solar photovoltaic installation professionals",
      "validityPeriod": "3 years",
      "renewalRequired": true,
      "cost": 395.0,
      "difficulty": "Intermediate",
      "prerequisite": "Documentation of solar installation experience",
      "technicians": [
        {
          "technicianId": "TECH-007",
          "name": "David Brown",
          "issueDate": "2021-05-15",
          "expiryDate": "2024-05-15",
          "status": "Expiring Soon",
          "score": 825,
          "renewalDue": "2024-05-15"
        }
      ],
      "marketDemand": "High",
      "salaryImpact": "+22%",
      "requiredForJobs": ["Solar Installer", "Renewable Energy Technician", "Solar Sales Engineer"],
      "trainingProviders": ["NABCEP", "Solar Energy International", "Community Colleges"],
      "examDetails": {
        "duration": "4 hours",
        "questions": "80 questions",
        "passingScore": "70%",
        "format": "Multiple choice"
      }
    }
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Valid", "value": "Valid"},
    {"label": "Expiring Soon", "value": "Expiring Soon"},
    {"label": "Expired", "value": "Expired"},
    {"label": "In Progress", "value": "In Progress"}
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "IT Infrastructure", "value": "IT Infrastructure"},
    {"label": "Medical Equipment", "value": "Medical Equipment"},
    {"label": "Mechanical", "value": "Mechanical"},
    {"label": "Cybersecurity", "value": "Cybersecurity"},
    {"label": "Cloud Computing", "value": "Cloud Computing"},
    {"label": "Renewable Energy", "value": "Renewable Energy"}
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

  List<Map<String, dynamic>> get filteredCertifications {
    return certifications.where((cert) {
      bool matchesSearch = cert["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          cert["issuer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          cert["category"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || cert["category"] == selectedCategory;
      
      bool matchesTechnician = selectedTechnician == "All" || 
                              (cert["technicians"] as List).any((tech) => tech["technicianId"] == selectedTechnician);
      
      bool matchesStatus = selectedStatus == "All" ||
                          (cert["technicians"] as List).any((tech) => tech["status"] == selectedStatus);
      
      return matchesSearch && matchesCategory && matchesTechnician && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Valid":
        return successColor;
      case "Expiring Soon":
        return warningColor;
      case "Expired":
        return dangerColor;
      case "In Progress":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Expert":
        return dangerColor;
      case "Advanced":
        return warningColor;
      case "Intermediate":
        return infoColor;
      case "Beginner":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getDemandColor(String demand) {
    switch (demand) {
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

  void _viewCertificationDetails(Map<String, dynamic> cert) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Certification Details"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text("${cert["name"]}", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Issued by: ${cert["issuer"]}"),
                Text("Category: ${cert["category"]}"),
                
                SizedBox(height: spSm),
                Text("Description", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("${cert["description"]}"),
                
                SizedBox(height: spSm),
                Text("Certification Details", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Validity Period: ${cert["validityPeriod"]}"),
                Text("Cost: \$${(cert["cost"] as double).toStringAsFixed(2)}"),
                Text("Difficulty: ${cert["difficulty"]}"),
                Text("Market Demand: ${cert["marketDemand"]}"),
                Text("Salary Impact: ${cert["salaryImpact"]}"),
                Text("Prerequisite: ${cert["prerequisite"]}"),
                
                SizedBox(height: spSm),
                Text("Exam Information", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Duration: ${cert["examDetails"]["duration"]}"),
                Text("Questions: ${cert["examDetails"]["questions"]}"),
                Text("Passing Score: ${cert["examDetails"]["passingScore"]}"),
                Text("Format: ${cert["examDetails"]["format"]}"),
                
                SizedBox(height: spSm),
                Text("Required For Jobs", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                ...(cert["requiredForJobs"] as List).map((job) => Text("• $job")),
                
                SizedBox(height: spSm),
                Text("Training Providers", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                ...(cert["trainingProviders"] as List).map((provider) => Text("• $provider")),
                
                SizedBox(height: spSm),
                Text("Certified Technicians", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                ...(cert["technicians"] as List).map((tech) => Container(
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
                      Text("Issue Date: ${tech["issueDate"]}"),
                      Text("Expiry Date: ${tech["expiryDate"]}"),
                      Text("Status: ${tech["status"]}"),
                      Text("Score: ${tech["score"]}"),
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

  void _renewCertification(Map<String, dynamic> cert, Map<String, dynamic> technician) async {
    bool isConfirmed = await confirm("Renew ${cert["name"]} for ${technician["name"]}?");
    if (isConfirmed) {
      ss("Certification renewal process initiated");
    }
  }

  void _scheduleCertification() {
    ss("Schedule new certification functionality");
  }

  void _viewTechnicianCertifications(Map<String, dynamic> technician) {
    ss("View all certifications for ${technician["name"]}");
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Technician Certifications"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Technician Certifications"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _scheduleCertification,
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
                _buildSummaryCard("Total Certifications", "${certifications.length}", primaryColor, Icons.verified),
                _buildSummaryCard("Expiring Soon", "${certifications.where((c) => (c["technicians"] as List).any((t) => t["status"] == "Expiring Soon")).length}", warningColor, Icons.warning),
                _buildSummaryCard("High Demand", "${certifications.where((c) => c["marketDemand"] == "Very High" || c["marketDemand"] == "High").length}", dangerColor, Icons.trending_up),
                _buildSummaryCard("Avg Cost", "\$${(certifications.fold(0.0, (sum, c) => sum + (c["cost"] as double)) / certifications.length).toStringAsFixed(0)}", infoColor, Icons.attach_money),
              ],
            ),

            // Search and Filters
            QTextField(
              label: "Search certifications",
              value: searchQuery,
              hint: "Search by name, issuer, or category",
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
                    items: categoryOptions,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
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

            QDropdownField(
              label: "Filter by Technician",
              items: technicianOptions,
              value: selectedTechnician,
              onChanged: (value, label) {
                selectedTechnician = value;
                setState(() {});
              },
            ),

            // Certifications List
            Text(
              "Certifications (${filteredCertifications.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...filteredCertifications.map((cert) => Container(
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
                              "${cert["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${cert["issuer"]} • ${cert["category"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getDifficultyColor(cert["difficulty"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${cert["difficulty"]}",
                              style: TextStyle(
                                color: _getDifficultyColor(cert["difficulty"]),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getDemandColor(cert["marketDemand"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${cert["marketDemand"]} Demand",
                              style: TextStyle(
                                color: _getDemandColor(cert["marketDemand"]),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Text(
                    "${cert["description"]}",
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
                              "Cost",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(cert["cost"] as double).toStringAsFixed(0)}",
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
                              "Validity",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${cert["validityPeriod"]}",
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
                              "Salary Impact",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${cert["salaryImpact"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Certified Technicians
                  if ((cert["technicians"] as List).isNotEmpty) ...[
                    Text(
                      "Certified Technicians:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    ...(cert["technicians"] as List).map((tech) => Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${tech["name"]}",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                Text(
                                  "Expires: ${tech["expiryDate"]}",
                                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(tech["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${tech["status"]}",
                                  style: TextStyle(
                                    color: _getStatusColor(tech["status"]),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                "Score: ${tech["score"]}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                            ],
                          ),
                          if (tech["status"] == "Expiring Soon") ...[
                            SizedBox(width: spSm),
                            QButton(
                              label: "Renew",
                              size: bs.sm,
                              onPressed: () => _renewCertification(cert, tech),
                            ),
                          ],
                        ],
                      ),
                    )),
                  ],

                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () => _viewCertificationDetails(cert),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Schedule Exam",
                          size: bs.sm,
                          onPressed: () => ss("Schedule exam for ${cert["name"]}"),
                        ),
                      ),
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
