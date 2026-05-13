import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaSkillManagementView extends StatefulWidget {
  const ComaSkillManagementView({Key? key}) : super(key: key);

  @override
  State<ComaSkillManagementView> createState() => _ComaSkillManagementViewState();
}

class _ComaSkillManagementViewState extends State<ComaSkillManagementView> {
  String selectedTrade = "all";
  String selectedLevel = "all";
  String selectedStatus = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> tradeFilters = [
    {"label": "All Trades", "value": "all"},
    {"label": "Electrical", "value": "electrical"},
    {"label": "Plumbing", "value": "plumbing"},
    {"label": "HVAC", "value": "hvac"},
    {"label": "Carpentry", "value": "carpentry"},
    {"label": "Masonry", "value": "masonry"},
    {"label": "Roofing", "value": "roofing"},
  ];

  List<Map<String, dynamic>> levelFilters = [
    {"label": "All Levels", "value": "all"},
    {"label": "Apprentice", "value": "apprentice"},
    {"label": "Journeyman", "value": "journeyman"},
    {"label": "Senior", "value": "senior"},
    {"label": "Lead", "value": "lead"},
    {"label": "Specialist", "value": "specialist"},
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Training", "value": "training"},
    {"label": "Assessment", "value": "assessment"},
    {"label": "Certified", "value": "certified"},
    {"label": "Inactive", "value": "inactive"},
  ];

  List<Map<String, dynamic>> skillProfiles = [
    {
      "id": "SKILL-001",
      "worker_id": "EMP-001",
      "employee_name": "Michael Rodriguez",
      "employee_code": "EMP-001",
      "primary_trade": "electrical",
      "skill_level": "journeyman",
      "years_experience": 8,
      "status": "certified",
      "profile_image": "https://picsum.photos/100/100?random=1&keyword=person",
      "contact_info": {
        "phone": "+1 (555) 123-4567",
        "email": "michael.rodriguez@construction.com",
        "emergency_contact": "+1 (555) 987-6543"
      },
      "skills": [
        {
          "skill_name": "Electrical Installation",
          "proficiency": "advanced",
          "rating": 4.5,
          "certified": true,
          "certification_date": "2023-08-15",
          "expiry_date": "2026-08-15",
          "certifying_body": "NECA"
        },
        {
          "skill_name": "Motor Control Systems",
          "proficiency": "intermediate",
          "rating": 3.8,
          "certified": true,
          "certification_date": "2024-02-10",
          "expiry_date": "2027-02-10",
          "certifying_body": "IEEE"
        },
        {
          "skill_name": "Safety Protocols",
          "proficiency": "advanced",
          "rating": 4.8,
          "certified": true,
          "certification_date": "2024-01-20",
          "expiry_date": "2025-01-20",
          "certifying_body": "OSHA"
        }
      ],
      "certifications": [
        {
          "name": "Licensed Electrician",
          "issuer": "State Board",
          "issue_date": "2020-06-15",
          "expiry_date": "2025-06-15",
          "status": "active",
          "document_url": "cert_doc_1.pdf"
        },
        {
          "name": "OSHA 30-Hour",
          "issuer": "OSHA",
          "issue_date": "2024-01-20",
          "expiry_date": "2027-01-20",
          "status": "active",
          "document_url": "cert_doc_2.pdf"
        }
      ],
      "training_history": [
        {
          "course_name": "Advanced PLC Programming",
          "provider": "Technical Institute",
          "completion_date": "2024-03-15",
          "score": 92,
          "status": "completed"
        },
        {
          "course_name": "Safety Leadership",
          "provider": "Safety Training Corp",
          "completion_date": "2024-01-10",
          "score": 88,
          "status": "completed"
        }
      ],
      "project_assignments": [
        {
          "project_name": "Metro Downtown Complex",
          "role": "Lead Electrician",
          "start_date": "2024-04-01",
          "end_date": "2024-07-30",
          "performance_rating": 4.6
        }
      ],
      "performance_metrics": {
        "overall_rating": 4.4,
        "productivity_score": 92,
        "quality_score": 88,
        "safety_score": 95,
        "teamwork_score": 90
      },
      "availability": {
        "status": "available",
        "next_available": "2024-06-20",
        "current_project": "Metro Downtown Complex",
        "utilization_rate": 85
      },
      "wage_info": {
        "hourly_rate": 32.50,
        "overtime_rate": 48.75,
        "classification": "Journeyman Electrician"
      }
    },
    {
      "id": "SKILL-002",
      "worker_id": "EMP-002",
      "employee_name": "Sarah Thompson",
      "employee_code": "EMP-002",
      "primary_trade": "plumbing",
      "skill_level": "senior",
      "years_experience": 12,
      "status": "active",
      "profile_image": "https://picsum.photos/100/100?random=2&keyword=person",
      "contact_info": {
        "phone": "+1 (555) 234-5678",
        "email": "sarah.thompson@construction.com",
        "emergency_contact": "+1 (555) 876-5432"
      },
      "skills": [
        {
          "skill_name": "Commercial Plumbing",
          "proficiency": "expert",
          "rating": 4.9,
          "certified": true,
          "certification_date": "2022-05-20",
          "expiry_date": "2025-05-20",
          "certifying_body": "PHCC"
        },
        {
          "skill_name": "Pipe Welding",
          "proficiency": "advanced",
          "rating": 4.6,
          "certified": true,
          "certification_date": "2021-09-15",
          "expiry_date": "2024-09-15",
          "certifying_body": "AWS"
        },
        {
          "skill_name": "Blueprint Reading",
          "proficiency": "expert",
          "rating": 4.8,
          "certified": true,
          "certification_date": "2020-03-10",
          "expiry_date": "2025-03-10",
          "certifying_body": "ICC"
        }
      ],
      "certifications": [
        {
          "name": "Master Plumber License",
          "issuer": "State Board",
          "issue_date": "2019-08-20",
          "expiry_date": "2024-08-20",
          "status": "active",
          "document_url": "cert_doc_3.pdf"
        },
        {
          "name": "Backflow Prevention",
          "issuer": "Water Authority",
          "issue_date": "2023-11-05",
          "expiry_date": "2025-11-05",
          "status": "active",
          "document_url": "cert_doc_4.pdf"
        }
      ],
      "training_history": [
        {
          "course_name": "Green Plumbing Systems",
          "provider": "Eco Training Center",
          "completion_date": "2024-02-28",
          "score": 95,
          "status": "completed"
        },
        {
          "course_name": "Code Updates 2024",
          "provider": "Plumbing Institute",
          "completion_date": "2024-01-15",
          "score": 91,
          "status": "completed"
        }
      ],
      "project_assignments": [
        {
          "project_name": "Healthcare Facility Expansion",
          "role": "Plumbing Supervisor",
          "start_date": "2024-03-01",
          "end_date": "2024-08-15",
          "performance_rating": 4.8
        }
      ],
      "performance_metrics": {
        "overall_rating": 4.7,
        "productivity_score": 94,
        "quality_score": 96,
        "safety_score": 92,
        "teamwork_score": 89
      },
      "availability": {
        "status": "assigned",
        "next_available": "2024-08-16",
        "current_project": "Healthcare Facility Expansion",
        "utilization_rate": 90
      },
      "wage_info": {
        "hourly_rate": 38.75,
        "overtime_rate": 58.13,
        "classification": "Senior Plumber"
      }
    },
    {
      "id": "SKILL-003",
      "worker_id": "EMP-003",
      "employee_name": "James Wilson",
      "employee_code": "EMP-003",
      "primary_trade": "hvac",
      "skill_level": "lead",
      "years_experience": 15,
      "status": "training",
      "profile_image": "https://picsum.photos/100/100?random=3&keyword=person",
      "contact_info": {
        "phone": "+1 (555) 345-6789",
        "email": "james.wilson@construction.com",
        "emergency_contact": "+1 (555) 765-4321"
      },
      "skills": [
        {
          "skill_name": "HVAC Installation",
          "proficiency": "expert",
          "rating": 4.8,
          "certified": true,
          "certification_date": "2020-07-12",
          "expiry_date": "2025-07-12",
          "certifying_body": "NATE"
        },
        {
          "skill_name": "Refrigeration Systems",
          "proficiency": "expert",
          "rating": 4.7,
          "certified": true,
          "certification_date": "2019-11-30",
          "expiry_date": "2024-11-30",
          "certifying_body": "RSES"
        },
        {
          "skill_name": "Energy Efficiency",
          "proficiency": "advanced",
          "rating": 4.5,
          "certified": false,
          "certification_date": null,
          "expiry_date": null,
          "certifying_body": null
        }
      ],
      "certifications": [
        {
          "name": "EPA Section 608",
          "issuer": "EPA",
          "issue_date": "2018-03-15",
          "expiry_date": "2025-03-15",
          "status": "active",
          "document_url": "cert_doc_5.pdf"
        },
        {
          "name": "HVAC Excellence",
          "issuer": "HVAC Excellence",
          "issue_date": "2022-09-20",
          "expiry_date": "2025-09-20",
          "status": "active",
          "document_url": "cert_doc_6.pdf"
        }
      ],
      "training_history": [
        {
          "course_name": "Smart HVAC Controls",
          "provider": "Tech Training Solutions",
          "completion_date": null,
          "score": null,
          "status": "in_progress"
        },
        {
          "course_name": "Leadership in Construction",
          "provider": "Management Institute",
          "completion_date": "2024-04-05",
          "score": 87,
          "status": "completed"
        }
      ],
      "project_assignments": [
        {
          "project_name": "Residential Tower A",
          "role": "HVAC Lead",
          "start_date": "2024-02-15",
          "end_date": "2024-09-30",
          "performance_rating": 4.5
        }
      ],
      "performance_metrics": {
        "overall_rating": 4.6,
        "productivity_score": 89,
        "quality_score": 93,
        "safety_score": 96,
        "teamwork_score": 94
      },
      "availability": {
        "status": "assigned",
        "next_available": "2024-10-01",
        "current_project": "Residential Tower A",
        "utilization_rate": 88
      },
      "wage_info": {
        "hourly_rate": 42.00,
        "overtime_rate": 63.00,
        "classification": "HVAC Lead Technician"
      }
    },
    {
      "id": "SKILL-004",
      "worker_id": "EMP-004",
      "employee_name": "Maria Garcia",
      "employee_code": "EMP-004",
      "primary_trade": "carpentry",
      "skill_level": "apprentice",
      "years_experience": 3,
      "status": "assessment",
      "profile_image": "https://picsum.photos/100/100?random=4&keyword=person",
      "contact_info": {
        "phone": "+1 (555) 456-7890",
        "email": "maria.garcia@construction.com",
        "emergency_contact": "+1 (555) 654-3210"
      },
      "skills": [
        {
          "skill_name": "Framing",
          "proficiency": "intermediate",
          "rating": 3.8,
          "certified": false,
          "certification_date": null,
          "expiry_date": null,
          "certifying_body": null
        },
        {
          "skill_name": "Finish Carpentry",
          "proficiency": "beginner",
          "rating": 3.2,
          "certified": false,
          "certification_date": null,
          "expiry_date": null,
          "certifying_body": null
        },
        {
          "skill_name": "Tool Safety",
          "proficiency": "intermediate",
          "rating": 4.1,
          "certified": true,
          "certification_date": "2024-01-15",
          "expiry_date": "2025-01-15",
          "certifying_body": "OSHA"
        }
      ],
      "certifications": [
        {
          "name": "OSHA 10-Hour",
          "issuer": "OSHA",
          "issue_date": "2024-01-15",
          "expiry_date": "2027-01-15",
          "status": "active",
          "document_url": "cert_doc_7.pdf"
        }
      ],
      "training_history": [
        {
          "course_name": "Apprentice Carpentry Level 2",
          "provider": "Trade School",
          "completion_date": null,
          "score": null,
          "status": "in_progress"
        },
        {
          "course_name": "Basic Construction Math",
          "provider": "Community College",
          "completion_date": "2023-12-10",
          "score": 85,
          "status": "completed"
        }
      ],
      "project_assignments": [
        {
          "project_name": "Riverside Office Park",
          "role": "Carpentry Apprentice",
          "start_date": "2024-05-01",
          "end_date": "2024-08-30",
          "performance_rating": 3.9
        }
      ],
      "performance_metrics": {
        "overall_rating": 3.7,
        "productivity_score": 78,
        "quality_score": 75,
        "safety_score": 89,
        "teamwork_score": 86
      },
      "availability": {
        "status": "assigned",
        "next_available": "2024-09-01",
        "current_project": "Riverside Office Park",
        "utilization_rate": 75
      },
      "wage_info": {
        "hourly_rate": 18.50,
        "overtime_rate": 27.75,
        "classification": "Carpentry Apprentice"
      }
    },
    {
      "id": "SKILL-005",
      "worker_id": "EMP-005",
      "employee_name": "David Chen",
      "employee_code": "EMP-005",
      "primary_trade": "masonry",
      "skill_level": "specialist",
      "years_experience": 20,
      "status": "certified",
      "profile_image": "https://picsum.photos/100/100?random=5&keyword=person",
      "contact_info": {
        "phone": "+1 (555) 567-8901",
        "email": "david.chen@construction.com",
        "emergency_contact": "+1 (555) 543-2109"
      },
      "skills": [
        {
          "skill_name": "Structural Masonry",
          "proficiency": "expert",
          "rating": 4.9,
          "certified": true,
          "certification_date": "2018-06-20",
          "expiry_date": "2025-06-20",
          "certifying_body": "MCAA"
        },
        {
          "skill_name": "Stone Cutting",
          "proficiency": "expert",
          "rating": 4.8,
          "certified": true,
          "certification_date": "2017-04-15",
          "expiry_date": "2024-04-15",
          "certifying_body": "Natural Stone Institute"
        },
        {
          "skill_name": "Historic Restoration",
          "proficiency": "expert",
          "rating": 4.7,
          "certified": true,
          "certification_date": "2019-09-10",
          "expiry_date": "2026-09-10",
          "certifying_body": "Preservation Society"
        }
      ],
      "certifications": [
        {
          "name": "Certified Mason Specialist",
          "issuer": "MCAA",
          "issue_date": "2018-06-20",
          "expiry_date": "2025-06-20",
          "status": "active",
          "document_url": "cert_doc_8.pdf"
        },
        {
          "name": "Historic Preservation",
          "issuer": "National Trust",
          "issue_date": "2019-09-10",
          "expiry_date": "2026-09-10",
          "status": "active",
          "document_url": "cert_doc_9.pdf"
        }
      ],
      "training_history": [
        {
          "course_name": "Advanced Stone Restoration",
          "provider": "Heritage Institute",
          "completion_date": "2024-01-25",
          "score": 97,
          "status": "completed"
        },
        {
          "course_name": "Modern Masonry Techniques",
          "provider": "Mason Guild",
          "completion_date": "2023-10-15",
          "score": 93,
          "status": "completed"
        }
      ],
      "project_assignments": [
        {
          "project_name": "Historic Building Renovation",
          "role": "Master Mason",
          "start_date": "2024-01-15",
          "end_date": "2024-12-20",
          "performance_rating": 4.9
        }
      ],
      "performance_metrics": {
        "overall_rating": 4.8,
        "productivity_score": 96,
        "quality_score": 98,
        "safety_score": 94,
        "teamwork_score": 91
      },
      "availability": {
        "status": "assigned",
        "next_available": "2024-12-21",
        "current_project": "Historic Building Renovation",
        "utilization_rate": 95
      },
      "wage_info": {
        "hourly_rate": 48.00,
        "overtime_rate": 72.00,
        "classification": "Master Mason Specialist"
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skill Management"),
        actions: [
          QButton(
            icon: Icons.person_add,
            size: bs.sm,
            onPressed: () => _addWorkerProfile(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _showSkillAnalytics(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildSkillOverview(),
                  _buildFilters(),
                  _buildSkillMetrics(),
                  _buildWorkersList(),
                ],
              ),
            ),
    );
  }

  Widget _buildSkillOverview() {
    int totalWorkers = skillProfiles.length;
    int certifiedWorkers = skillProfiles.where((w) => w["status"] == "certified").length;
    int trainingWorkers = skillProfiles.where((w) => w["status"] == "training").length;
    double avgRating = skillProfiles.fold(0.0, (sum, w) => sum + (w["performance_metrics"]["overall_rating"] as double)) / skillProfiles.length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.engineering, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Skill Management Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildOverviewCard("Total Workers", "$totalWorkers", Icons.group, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Certified", "$certifiedWorkers", Icons.verified, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("In Training", "$trainingWorkers", Icons.school, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Avg Rating", "${avgRating.toStringAsFixed(1)}", Icons.star, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
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
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: disabledBoldColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Search workers...",
                  value: searchQuery,
                  hint: "Search by name, trade, or skills",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () => _showAdvancedFilters(),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Trade",
                  items: tradeFilters,
                  value: selectedTrade,
                  onChanged: (value, label) {
                    selectedTrade = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Skill Level",
                  items: levelFilters,
                  value: selectedLevel,
                  onChanged: (value, label) {
                    selectedLevel = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusFilters,
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
      ),
    );
  }

  Widget _buildSkillMetrics() {
    Map<String, int> tradeDistribution = {};
    Map<String, int> levelDistribution = {};
    
    for (var worker in skillProfiles) {
      String trade = worker["primary_trade"];
      String level = worker["skill_level"];
      tradeDistribution[trade] = (tradeDistribution[trade] ?? 0) + 1;
      levelDistribution[level] = (levelDistribution[level] ?? 0) + 1;
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Skill Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "By Trade",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...tradeDistribution.entries.map((entry) => Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _getTradeColor(entry.key),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${entry.key}: ${entry.value}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "By Level",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...levelDistribution.entries.map((entry) => Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _getLevelColor(entry.key),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${entry.key}: ${entry.value}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkersList() {
    List<Map<String, dynamic>> filteredWorkers = _getFilteredWorkers();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Workers (${filteredWorkers.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.sort,
              size: bs.sm,
              onPressed: () => _showSortOptions(),
            ),
          ],
        ),
        ...filteredWorkers.map((worker) => _buildWorkerCard(worker)),
      ],
    );
  }

  Widget _buildWorkerCard(Map<String, dynamic> worker) {
    Color statusColor = _getStatusColor(worker["status"]);
    Color levelColor = _getLevelColor(worker["skill_level"]);

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: statusColor,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  image: DecorationImage(
                    image: NetworkImage("${worker["profile_image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${worker["employee_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${worker["employee_code"]} | ${worker["years_experience"]} years exp",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${worker["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: levelColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${worker["skill_level"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: levelColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.build, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Primary Trade: ${worker["primary_trade"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Skills: ${(worker["skills"] as List).length} | Certifications: ${(worker["certifications"] as List).length}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
                if ((worker["skills"] as List).isNotEmpty)
                  Container(
                    height: 100,
                    child: QHorizontalScroll(
                      children: (worker["skills"] as List).map((skill) => Container(
                        width: 180,
                        margin: EdgeInsets.only(right: spSm),
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
                                    "${skill["skill_name"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                if (skill["certified"] == true)
                                  Icon(Icons.verified, color: successColor, size: 14),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Level: ${skill["proficiency"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 12),
                                SizedBox(width: spXs),
                                Text(
                                  "${skill["rating"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: warningColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.star_rate, color: successColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Overall Rating: ${worker["performance_metrics"]["overall_rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.trending_up, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Utilization: ${worker["availability"]["utilization_rate"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Productivity: ${worker["performance_metrics"]["productivity_score"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Safety Score: ${worker["performance_metrics"]["safety_score"]}%",
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
          Row(
            children: [
              Icon(Icons.phone, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${worker["contact_info"]["phone"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Rate: \$${((worker["wage_info"]["hourly_rate"] as double)).currency}/hr",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (worker["availability"]["current_project"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.work, color: infoColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Currently assigned to: ${worker["availability"]["current_project"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Available: ${worker["availability"]["next_available"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewWorkerProfile(worker["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editWorkerProfile(worker["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showWorkerOptions(worker),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredWorkers() {
    List<Map<String, dynamic>> filtered = skillProfiles;

    if (selectedTrade != "all") {
      filtered = filtered.where((worker) => worker["primary_trade"] == selectedTrade).toList();
    }

    if (selectedLevel != "all") {
      filtered = filtered.where((worker) => worker["skill_level"] == selectedLevel).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((worker) => worker["status"] == selectedStatus).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((worker) =>
          worker["employee_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          worker["primary_trade"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (worker["skills"] as List).any((skill) => 
              skill["skill_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()))).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'certified':
        return successColor;
      case 'active':
        return infoColor;
      case 'training':
        return warningColor;
      case 'assessment':
        return primaryColor;
      case 'inactive':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getLevelColor(String level) {
    switch (level.toLowerCase()) {
      case 'specialist':
        return dangerColor;
      case 'lead':
        return warningColor;
      case 'senior':
        return successColor;
      case 'journeyman':
        return infoColor;
      case 'apprentice':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTradeColor(String trade) {
    switch (trade.toLowerCase()) {
      case 'electrical':
        return dangerColor;
      case 'plumbing':
        return infoColor;
      case 'hvac':
        return warningColor;
      case 'carpentry':
        return successColor;
      case 'masonry':
        return primaryColor;
      case 'roofing':
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _addWorkerProfile() {
    ss("Add new worker profile");
  }

  void _showSkillAnalytics() {
    ss("Skill management analytics");
  }

  void _showAdvancedFilters() {
    ss("Advanced skill filters");
  }

  void _showSortOptions() {
    ss("Worker sort options");
  }

  void _viewWorkerProfile(String workerId) {
    ss("Viewing worker profile $workerId");
  }

  void _editWorkerProfile(String workerId) {
    ss("Editing worker profile $workerId");
  }

  void _showWorkerOptions(Map<String, dynamic> worker) {
    ss("Worker options for ${worker["employee_name"]}");
  }
}
