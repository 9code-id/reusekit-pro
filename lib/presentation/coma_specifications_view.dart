import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaSpecificationsView extends StatefulWidget {
  const ComaSpecificationsView({super.key});

  @override
  State<ComaSpecificationsView> createState() => _ComaSpecificationsViewState();
}

class _ComaSpecificationsViewState extends State<ComaSpecificationsView> {
  String searchQuery = "";
  String selectedCategory = "";
  String selectedStatus = "";
  String selectedType = "";

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": ""},
    {"label": "Materials", "value": "materials"},
    {"label": "Equipment", "value": "equipment"},
    {"label": "Systems", "value": "systems"},
    {"label": "Safety", "value": "safety"},
    {"label": "Quality", "value": "quality"},
    {"label": "Environmental", "value": "environmental"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "active"},
    {"label": "Under Review", "value": "under_review"},
    {"label": "Approved", "value": "approved"},
    {"label": "Outdated", "value": "outdated"},
    {"label": "Draft", "value": "draft"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": ""},
    {"label": "Technical", "value": "technical"},
    {"label": "Performance", "value": "performance"},
    {"label": "Safety", "value": "safety"},
    {"label": "Quality", "value": "quality"},
    {"label": "Installation", "value": "installation"},
  ];

  List<Map<String, dynamic>> specifications = [
    {
      "id": "SPEC-001",
      "title": "Concrete Mix Design - Grade 40",
      "category": "materials",
      "type": "technical",
      "status": "approved",
      "version": "v3.2",
      "created_date": "2024-01-10",
      "last_updated": "2024-01-25",
      "project": "Hospital Foundation",
      "author": "Michael Zhang",
      "reviewer": "Sarah Johnson",
      "compliance_standard": "AS 3600-2018",
      "description": "Detailed specifications for high-strength concrete mix design with 40 MPa compressive strength",
      "requirements": {
        "cement_content": "350-400 kg/m³",
        "water_cement_ratio": "0.45 max",
        "aggregate_size": "20mm max",
        "slump": "80-120mm",
        "compressive_strength": "40 MPa @ 28 days"
      },
      "testing_frequency": "Every 50m³",
      "acceptance_criteria": "≥95% of design strength",
      "quality_control": "Continuous monitoring",
      "environmental_impact": "Low",
      "cost_impact": "Medium",
      "implementation_complexity": "Standard",
      "priority": "high",
      "documents_count": 8,
      "revisions_count": 5
    },
    {
      "id": "SPEC-002",
      "title": "HVAC System Performance Standards",
      "category": "systems",
      "type": "performance",
      "status": "active",
      "version": "v2.1",
      "created_date": "2024-01-15",
      "last_updated": "2024-01-28",
      "project": "Office Complex",
      "author": "Lisa Chen",
      "reviewer": "Robert Brown",
      "compliance_standard": "ASHRAE 90.1",
      "description": "Performance specifications for HVAC systems including energy efficiency and indoor air quality requirements",
      "requirements": {
        "cooling_capacity": "500 tons",
        "heating_capacity": "400 kW",
        "energy_efficiency": "COP 3.5 min",
        "air_changes": "6-8 per hour",
        "temperature_control": "±2°C"
      },
      "testing_frequency": "Quarterly",
      "acceptance_criteria": "All parameters within range",
      "quality_control": "BMS monitoring",
      "environmental_impact": "Medium",
      "cost_impact": "High",
      "implementation_complexity": "Complex",
      "priority": "critical",
      "documents_count": 12,
      "revisions_count": 3
    },
    {
      "id": "SPEC-003",
      "title": "Electrical Safety Standards",
      "category": "safety",
      "type": "safety",
      "status": "approved",
      "version": "v4.0",
      "created_date": "2024-01-05",
      "last_updated": "2024-01-30",
      "project": "Industrial Facility",
      "author": "David Wilson",
      "reviewer": "Emma Thompson",
      "compliance_standard": "AS/NZS 3000",
      "description": "Comprehensive electrical safety specifications covering installation, testing, and maintenance requirements",
      "requirements": {
        "insulation_resistance": "≥1 MΩ",
        "earth_fault_protection": "30mA RCD",
        "cable_rating": "110% of load",
        "protection_class": "IP65 minimum",
        "grounding_resistance": "≤1 Ω"
      },
      "testing_frequency": "Annual",
      "acceptance_criteria": "Zero safety violations",
      "quality_control": "Licensed electrician",
      "environmental_impact": "Low",
      "cost_impact": "Medium",
      "implementation_complexity": "Standard",
      "priority": "critical",
      "documents_count": 15,
      "revisions_count": 8
    },
    {
      "id": "SPEC-004",
      "title": "Steel Fabrication Quality Control",
      "category": "quality",
      "type": "quality",
      "status": "under_review",
      "version": "v1.8",
      "created_date": "2024-01-20",
      "last_updated": "2024-02-01",
      "project": "Bridge Construction",
      "author": "Jennifer Kim",
      "reviewer": "Alex Rodriguez",
      "compliance_standard": "AS 4100",
      "description": "Quality control specifications for structural steel fabrication including welding and inspection procedures",
      "requirements": {
        "steel_grade": "Grade 350",
        "weld_quality": "SP category",
        "surface_preparation": "Sa 2.5 standard",
        "coating_thickness": "200-300 μm",
        "dimensional_tolerance": "±2mm"
      },
      "testing_frequency": "100% inspection",
      "acceptance_criteria": "Zero defects",
      "quality_control": "Third-party inspection",
      "environmental_impact": "Medium",
      "cost_impact": "High",
      "implementation_complexity": "Complex",
      "priority": "high",
      "documents_count": 10,
      "revisions_count": 2
    },
    {
      "id": "SPEC-005",
      "title": "Plumbing Installation Standards",
      "category": "equipment",
      "type": "installation",
      "status": "draft",
      "version": "v0.9",
      "created_date": "2024-01-25",
      "last_updated": "2024-02-02",
      "project": "Residential Complex",
      "author": "Carlos Martinez",
      "reviewer": "Linda Davis",
      "compliance_standard": "AS/NZS 3500",
      "description": "Installation specifications for plumbing systems including pipes, fixtures, and drainage requirements",
      "requirements": {
        "pipe_material": "PVC Schedule 40",
        "pressure_rating": "1.6 MPa",
        "joint_type": "Solvent welded",
        "slope_drainage": "1:100 minimum",
        "fixture_spacing": "Per code requirements"
      },
      "testing_frequency": "Before commissioning",
      "acceptance_criteria": "Pressure test passed",
      "quality_control": "Licensed plumber",
      "environmental_impact": "Low",
      "cost_impact": "Low",
      "implementation_complexity": "Standard",
      "priority": "medium",
      "documents_count": 6,
      "revisions_count": 1
    },
    {
      "id": "SPEC-006",
      "title": "Environmental Impact Assessment",
      "category": "environmental",
      "type": "performance",
      "status": "approved",
      "version": "v2.5",
      "created_date": "2024-01-08",
      "last_updated": "2024-01-29",
      "project": "Green Building Initiative",
      "author": "Sophie Wilson",
      "reviewer": "James Taylor",
      "compliance_standard": "Green Star",
      "description": "Environmental performance specifications for sustainable construction practices and materials",
      "requirements": {
        "energy_rating": "6 Star minimum",
        "water_efficiency": "40% reduction",
        "waste_diversion": "80% target",
        "indoor_air_quality": "Green certification",
        "carbon_footprint": "50% reduction"
      },
      "testing_frequency": "Monthly",
      "acceptance_criteria": "All targets met",
      "quality_control": "Environmental consultant",
      "environmental_impact": "Positive",
      "cost_impact": "Medium",
      "implementation_complexity": "Complex",
      "priority": "medium",
      "documents_count": 20,
      "revisions_count": 6
    }
  ];

  List<Map<String, dynamic>> get filteredSpecifications {
    return specifications.where((spec) {
      bool matchesSearch = searchQuery.isEmpty ||
          (spec["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (spec["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (spec["author"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (spec["compliance_standard"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory.isEmpty || spec["category"] == selectedCategory;
      bool matchesStatus = selectedStatus.isEmpty || spec["status"] == selectedStatus;
      bool matchesType = selectedType.isEmpty || spec["type"] == selectedType;
      
      return matchesSearch && matchesCategory && matchesStatus && matchesType;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "approved":
      case "active":
        return successColor;
      case "under_review":
        return infoColor;
      case "draft":
        return warningColor;
      case "outdated":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      default:
        return successColor;
    }
  }

  Color getCategoryColor(String category) {
    switch (category) {
      case "materials":
        return Colors.brown;
      case "equipment":
        return Colors.blue;
      case "systems":
        return Colors.purple;
      case "safety":
        return dangerColor;
      case "quality":
        return successColor;
      case "environmental":
        return Colors.green;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Specifications"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Statistics
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.description, color: primaryColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Total Specs",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${specifications.length}",
                        style: TextStyle(
                          fontSize: 28,
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
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Approved",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${specifications.where((s) => s["status"] == "approved" || s["status"] == "active").length}",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.pending, color: warningColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Under Review",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${specifications.where((s) => s["status"] == "under_review" || s["status"] == "draft").length}",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.priority_high, color: dangerColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Critical",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${specifications.where((s) => s["priority"] == "critical").length}",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search specifications...",
                    value: searchQuery,
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
                          items: categories,
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
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: typeOptions,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Specifications Grid
            ResponsiveGridView(
              minItemWidth: 200,
              children: filteredSpecifications.map((spec) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: getCategoryColor(spec["category"]),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.description,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${spec["id"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${spec["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: getStatusColor(spec["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(
                            color: getStatusColor(spec["status"]),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "${spec["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: getStatusColor(spec["status"]),
                          ),
                        ),
                      ),

                      Text(
                        "${spec["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.engineering, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${spec["compliance_standard"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.person, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${spec["author"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.folder, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${spec["project"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Priority",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: getPriorityColor(spec["priority"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${spec["priority"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: getPriorityColor(spec["priority"]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Complexity",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${spec["implementation_complexity"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Version",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${spec["version"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
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
                                  "Documents",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${spec["documents_count"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
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
                                  "Revisions",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${spec["revisions_count"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
