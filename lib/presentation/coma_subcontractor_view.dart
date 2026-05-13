import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaSubcontractorView extends StatefulWidget {
  const ComaSubcontractorView({super.key});

  @override
  State<ComaSubcontractorView> createState() => _ComaSubcontractorViewState();
}

class _ComaSubcontractorViewState extends State<ComaSubcontractorView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedSpecialty = "All";
  String selectedRating = "All";

  List<Map<String, dynamic>> subcontractors = [
    {
      "id": "SUB001",
      "name": "BuildCorp Solutions",
      "contact_person": "Michael Rodriguez",
      "phone": "+1 555-0123",
      "email": "contact@buildcorp.com",
      "specialty": "Electrical",
      "status": "Active",
      "rating": 4.8,
      "license_number": "ELC-2024-001",
      "insurance_expiry": "2024-12-31",
      "current_projects": [
        {"name": "Downtown Office Complex", "progress": 75},
        {"name": "Medical Center Phase 2", "progress": 45}
      ],
      "total_projects": 45,
      "completed_projects": 38,
      "payment_terms": "Net 30",
      "hourly_rate": 85.0,
      "performance_score": 92,
      "safety_record": "Excellent",
      "certifications": ["OSHA 30", "NECA Certified", "Licensed Electrician"],
      "address": "1234 Industrial Blvd, City, State 12345",
      "years_experience": 12,
      "last_project_date": "2024-01-15"
    },
    {
      "id": "SUB002", 
      "name": "ProPlumbing & HVAC",
      "contact_person": "Sarah Johnson",
      "phone": "+1 555-0456",
      "email": "info@proplumbing.com",
      "specialty": "Plumbing",
      "status": "Active",
      "rating": 4.6,
      "license_number": "PLB-2024-002",
      "insurance_expiry": "2024-11-30",
      "current_projects": [
        {"name": "Residential Complex A", "progress": 60},
        {"name": "Shopping Mall Renovation", "progress": 30}
      ],
      "total_projects": 32,
      "completed_projects": 29,
      "payment_terms": "Net 15",
      "hourly_rate": 75.0,
      "performance_score": 88,
      "safety_record": "Good",
      "certifications": ["Master Plumber", "HVAC Certified", "Green Building"],
      "address": "5678 Commerce Dr, City, State 12345",
      "years_experience": 8,
      "last_project_date": "2024-01-10"
    },
    {
      "id": "SUB003",
      "name": "SteelFrame Contractors",
      "contact_person": "David Chen",
      "phone": "+1 555-0789",
      "email": "contracts@steelframe.com",
      "specialty": "Structural",
      "status": "On Hold",
      "rating": 4.9,
      "license_number": "STR-2024-003",
      "insurance_expiry": "2025-03-15",
      "current_projects": [
        {"name": "High-rise Tower Project", "progress": 85}
      ],
      "total_projects": 28,
      "completed_projects": 26,
      "payment_terms": "Net 45",
      "hourly_rate": 95.0,
      "performance_score": 95,
      "safety_record": "Outstanding",
      "certifications": ["Structural Welding", "AISC Certified", "Crane Operator"],
      "address": "9012 Heavy Industry Rd, City, State 12345",
      "years_experience": 15,
      "last_project_date": "2024-01-20"
    },
    {
      "id": "SUB004",
      "name": "Quality Concrete Works",
      "contact_person": "Maria Gonzalez",
      "phone": "+1 555-0234",
      "email": "maria@qualityconcrete.com",
      "specialty": "Concrete",
      "status": "Active",
      "rating": 4.4,
      "license_number": "CON-2024-004",
      "insurance_expiry": "2024-09-30",
      "current_projects": [
        {"name": "Highway Bridge Project", "progress": 40},
        {"name": "Stadium Foundation", "progress": 20}
      ],
      "total_projects": 51,
      "completed_projects": 47,
      "payment_terms": "Net 30",
      "hourly_rate": 70.0,
      "performance_score": 85,
      "safety_record": "Good",
      "certifications": ["ACI Certified", "Concrete Testing", "Heavy Equipment"],
      "address": "3456 Concrete Way, City, State 12345",
      "years_experience": 20,
      "last_project_date": "2024-01-12"
    },
    {
      "id": "SUB005",
      "name": "Precision Roofing Systems",
      "contact_person": "James Wilson",
      "phone": "+1 555-0567",
      "email": "james@precisionroofing.com",
      "specialty": "Roofing",
      "status": "Inactive",
      "rating": 4.2,
      "license_number": "ROF-2024-005",
      "insurance_expiry": "2024-06-30",
      "current_projects": [],
      "total_projects": 23,
      "completed_projects": 21,
      "payment_terms": "Net 30",
      "hourly_rate": 65.0,
      "performance_score": 82,
      "safety_record": "Average",
      "certifications": ["Roofing Contractor", "Fall Protection", "Weather Sealed"],
      "address": "7890 Rooftop Ln, City, State 12345",
      "years_experience": 10,
      "last_project_date": "2023-11-15"
    }
  ];

  List<Map<String, dynamic>> get filteredSubcontractors {
    return subcontractors.where((subcontractor) {
      final matchesSearch = searchQuery.isEmpty ||
          subcontractor["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          subcontractor["contact_person"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          subcontractor["specialty"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = selectedStatus == "All" || subcontractor["status"] == selectedStatus;
      final matchesSpecialty = selectedSpecialty == "All" || subcontractor["specialty"] == selectedSpecialty;
      final matchesRating = selectedRating == "All" || _getRatingCategory(subcontractor["rating"] as double) == selectedRating;
      
      return matchesSearch && matchesStatus && matchesSpecialty && matchesRating;
    }).toList();
  }

  String _getRatingCategory(double rating) {
    if (rating >= 4.5) return "Excellent";
    if (rating >= 4.0) return "Good";
    if (rating >= 3.5) return "Average";
    return "Below Average";
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "On Hold":
        return warningColor;
      case "Inactive":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPerformanceColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 80) return infoColor;
    if (score >= 70) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    final stats = _calculateStats();

    return Scaffold(
      appBar: AppBar(
        title: Text("Subcontractor Management"),
        actions: [
          IconButton(
            onPressed: () {
              // Add new subcontractor
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Overview Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Total Subcontractors",
                    "${subcontractors.length}",
                    Icons.business,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Active",
                    "${stats['active']}",
                    Icons.check_circle,
                    successColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Average Rating",
                    "${stats['avgRating'].toStringAsFixed(1)}⭐",
                    Icons.star,
                    warningColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Active Projects",
                    "${stats['activeProjects']}",
                    Icons.construction,
                    infoColor,
                  ),
                ),
              ],
            ),

            // Search and Filters
            QTextField(
              label: "Search subcontractors...",
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
                    label: "Status",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Active", "value": "Active"},
                      {"label": "On Hold", "value": "On Hold"},
                      {"label": "Inactive", "value": "Inactive"},
                    ],
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
                    label: "Specialty",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Electrical", "value": "Electrical"},
                      {"label": "Plumbing", "value": "Plumbing"},
                      {"label": "Structural", "value": "Structural"},
                      {"label": "Concrete", "value": "Concrete"},
                      {"label": "Roofing", "value": "Roofing"},
                    ],
                    value: selectedSpecialty,
                    onChanged: (value, label) {
                      selectedSpecialty = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
              label: "Rating Category",
              items: [
                {"label": "All", "value": "All"},
                {"label": "Excellent (4.5+)", "value": "Excellent"},
                {"label": "Good (4.0+)", "value": "Good"},
                {"label": "Average (3.5+)", "value": "Average"},
                {"label": "Below Average", "value": "Below Average"},
              ],
              value: selectedRating,
              onChanged: (value, label) {
                selectedRating = value;
                setState(() {});
              },
            ),

            // Subcontractors List
            Text(
              "Subcontractors (${filteredSubcontractors.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredSubcontractors.map((subcontractor) => _buildSubcontractorCard(subcontractor)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(width: 4, color: color),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubcontractorCard(Map<String, dynamic> subcontractor) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor(subcontractor["status"]),
          ),
        ),
      ),
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
                      "${subcontractor["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXxs),
                    Text(
                      "${subcontractor["contact_person"]} • ${subcontractor["specialty"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(subcontractor["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${subcontractor["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(subcontractor["status"]),
                  ),
                ),
              ),
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
                      "Rating: ${(subcontractor["rating"] as double).toStringAsFixed(1)}⭐",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXxs),
                    Text(
                      "Performance: ${subcontractor["performance_score"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: _getPerformanceColor(subcontractor["performance_score"]),
                        fontWeight: FontWeight.w500,
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
                      "Rate: \$${(subcontractor["hourly_rate"] as double).toStringAsFixed(0)}/hr",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXxs),
                    Text(
                      "Projects: ${subcontractor["completed_projects"]}/${subcontractor["total_projects"]}",
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

          if ((subcontractor["current_projects"] as List).isNotEmpty) ...[
            SizedBox(height: spSm),
            Text(
              "Current Projects:",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            ...(subcontractor["current_projects"] as List).map((project) => Container(
              margin: EdgeInsets.only(bottom: spXxs),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${project["name"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                  Text(
                    "${project["progress"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            )),
          ],

          SizedBox(height: spSm),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // View subcontractor details
                  },
                ),
              ),
              SizedBox(width: spXs),
              Expanded(
                child: QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () {
                    // Edit subcontractor
                  },
                ),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  // More options
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _calculateStats() {
    final activeCount = subcontractors.where((s) => s["status"] == "Active").length;
    final totalRating = subcontractors.fold(0.0, (sum, s) => sum + (s["rating"] as double));
    final avgRating = totalRating / subcontractors.length;
    final activeProjects = subcontractors.fold(0, (sum, s) => sum + (s["current_projects"] as List).length);

    return {
      "active": activeCount,
      "avgRating": avgRating,
      "activeProjects": activeProjects,
    };
  }
}
