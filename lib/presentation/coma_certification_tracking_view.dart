import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaCertificationTrackingView extends StatefulWidget {
  const ComaCertificationTrackingView({Key? key}) : super(key: key);

  @override
  State<ComaCertificationTrackingView> createState() => _ComaCertificationTrackingViewState();
}

class _ComaCertificationTrackingViewState extends State<ComaCertificationTrackingView> {
  String selectedStatus = "all";
  String selectedType = "all";
  String selectedUrgency = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Expiring Soon", "value": "expiring"},
    {"label": "Expired", "value": "expired"},
    {"label": "Pending", "value": "pending"},
    {"label": "Suspended", "value": "suspended"},
  ];

  List<Map<String, dynamic>> typeFilters = [
    {"label": "All Types", "value": "all"},
    {"label": "Safety", "value": "safety"},
    {"label": "Professional", "value": "professional"},
    {"label": "Training", "value": "training"},
    {"label": "Compliance", "value": "compliance"},
    {"label": "Equipment", "value": "equipment"},
  ];

  List<Map<String, dynamic>> urgencyFilters = [
    {"label": "All Urgency", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> certifications = [
    {
      "id": "CERT-001",
      "certification_name": "OSHA 30-Hour Construction",
      "type": "safety",
      "holder_name": "Michael Rodriguez",
      "employee_id": "EMP-001",
      "holder_photo": "https://picsum.photos/100/100?random=1&keyword=person",
      "issuing_authority": "Occupational Safety and Health Administration",
      "certification_number": "OSH-30-2024-001234",
      "issue_date": "2024-01-15",
      "expiry_date": "2027-01-15",
      "status": "active",
      "urgency": "low",
      "days_until_expiry": 1095,
      "renewal_required": true,
      "cost": 450.00,
      "currency": "USD",
      "verification_method": "online",
      "verification_url": "https://osha.gov/verify/001234",
      "document_url": "cert_osha_30_001234.pdf",
      "training_hours": 30,
      "ceu_credits": 3.0,
      "renewal_process": {
        "advance_notice_days": 90,
        "renewal_course_required": true,
        "renewal_exam_required": true,
        "renewal_cost": 350.00,
        "provider_contact": "safety@oshacenter.com"
      },
      "compliance_requirements": [
        {
          "requirement": "Annual Refresher",
          "due_date": "2025-01-15",
          "status": "pending",
          "description": "8-hour annual safety refresher course"
        }
      ],
      "project_assignments": [
        {
          "project_name": "Metro Downtown Complex",
          "role": "Safety Officer",
          "start_date": "2024-04-01",
          "certification_required": true
        }
      ],
      "notes": "Required for all supervisory roles on federal projects",
      "priority": "high",
      "tags": ["federal", "supervision", "safety"]
    },
    {
      "id": "CERT-002",
      "certification_name": "Licensed Master Plumber",
      "type": "professional",
      "holder_name": "Sarah Thompson",
      "employee_id": "EMP-002",
      "holder_photo": "https://picsum.photos/100/100?random=2&keyword=person",
      "issuing_authority": "State Plumbing Board",
      "certification_number": "MPL-2019-8847",
      "issue_date": "2019-08-20",
      "expiry_date": "2024-08-20",
      "status": "expiring",
      "urgency": "critical",
      "days_until_expiry": 45,
      "renewal_required": true,
      "cost": 1200.00,
      "currency": "USD",
      "verification_method": "state_database",
      "verification_url": "https://stateboard.gov/verify/MPL-2019-8847",
      "document_url": "cert_master_plumber_8847.pdf",
      "training_hours": 240,
      "ceu_credits": 24.0,
      "renewal_process": {
        "advance_notice_days": 60,
        "renewal_course_required": true,
        "renewal_exam_required": true,
        "renewal_cost": 800.00,
        "provider_contact": "renewals@stateboard.gov"
      },
      "compliance_requirements": [
        {
          "requirement": "Continuing Education",
          "due_date": "2024-07-20",
          "status": "in_progress",
          "description": "24 CEU hours in plumbing systems"
        },
        {
          "requirement": "Code Update Training",
          "due_date": "2024-08-01",
          "status": "pending",
          "description": "New plumbing code requirements training"
        }
      ],
      "project_assignments": [
        {
          "project_name": "Healthcare Facility Expansion",
          "role": "Lead Plumber",
          "start_date": "2024-03-01",
          "certification_required": true
        }
      ],
      "notes": "Critical for commercial plumbing projects. Renewal process initiated.",
      "priority": "critical",
      "tags": ["license", "plumbing", "commercial"]
    },
    {
      "id": "CERT-003",
      "certification_name": "EPA Section 608 Certification",
      "type": "compliance",
      "holder_name": "James Wilson",
      "employee_id": "EMP-003",
      "holder_photo": "https://picsum.photos/100/100?random=3&keyword=person",
      "issuing_authority": "Environmental Protection Agency",
      "certification_number": "EPA-608-2018-5674",
      "issue_date": "2018-03-15",
      "expiry_date": "2025-03-15",
      "status": "active",
      "urgency": "medium",
      "days_until_expiry": 285,
      "renewal_required": false,
      "cost": 125.00,
      "currency": "USD",
      "verification_method": "epa_database",
      "verification_url": "https://epa.gov/section608/verify/5674",
      "document_url": "cert_epa_608_5674.pdf",
      "training_hours": 16,
      "ceu_credits": 1.6,
      "renewal_process": {
        "advance_notice_days": 0,
        "renewal_course_required": false,
        "renewal_exam_required": false,
        "renewal_cost": 0.00,
        "provider_contact": "info@epa.gov"
      },
      "compliance_requirements": [
        {
          "requirement": "Refrigerant Handling Record",
          "due_date": "ongoing",
          "status": "active",
          "description": "Maintain logs of refrigerant recovery and disposal"
        }
      ],
      "project_assignments": [
        {
          "project_name": "Residential Tower A",
          "role": "HVAC Technician",
          "start_date": "2024-02-15",
          "certification_required": true
        }
      ],
      "notes": "Lifetime certification. Required for refrigerant handling.",
      "priority": "medium",
      "tags": ["epa", "refrigerant", "hvac"]
    },
    {
      "id": "CERT-004",
      "certification_name": "Forklift Operator Certification",
      "type": "equipment",
      "holder_name": "Maria Garcia",
      "employee_id": "EMP-004",
      "holder_photo": "https://picsum.photos/100/100?random=4&keyword=person",
      "issuing_authority": "National Safety Training Institute",
      "certification_number": "FLO-2024-3321",
      "issue_date": "2024-01-10",
      "expiry_date": "2027-01-10",
      "status": "active",
      "urgency": "low",
      "days_until_expiry": 1095,
      "renewal_required": true,
      "cost": 275.00,
      "currency": "USD",
      "verification_method": "training_provider",
      "verification_url": "https://nsti.com/verify/FLO-2024-3321",
      "document_url": "cert_forklift_3321.pdf",
      "training_hours": 8,
      "ceu_credits": 0.8,
      "renewal_process": {
        "advance_notice_days": 30,
        "renewal_course_required": true,
        "renewal_exam_required": true,
        "renewal_cost": 225.00,
        "provider_contact": "training@nsti.com"
      },
      "compliance_requirements": [
        {
          "requirement": "Annual Equipment Inspection",
          "due_date": "2024-12-31",
          "status": "pending",
          "description": "Annual safety inspection and documentation"
        },
        {
          "requirement": "Workplace Evaluation",
          "due_date": "2024-07-10",
          "status": "completed",
          "description": "Site-specific workplace evaluation completed"
        }
      ],
      "project_assignments": [
        {
          "project_name": "Riverside Office Park",
          "role": "Material Handler",
          "start_date": "2024-05-01",
          "certification_required": true
        }
      ],
      "notes": "Required for all material handling operations",
      "priority": "medium",
      "tags": ["equipment", "safety", "material_handling"]
    },
    {
      "id": "CERT-005",
      "certification_name": "Certified Welding Inspector",
      "type": "professional",
      "holder_name": "David Chen",
      "employee_id": "EMP-005",
      "holder_photo": "https://picsum.photos/100/100?random=5&keyword=person",
      "issuing_authority": "American Welding Society",
      "certification_number": "CWI-2022-9985",
      "issue_date": "2022-06-15",
      "expiry_date": "2025-06-15",
      "status": "active",
      "urgency": "medium",
      "days_until_expiry": 365,
      "renewal_required": true,
      "cost": 1850.00,
      "currency": "USD",
      "verification_method": "aws_database",
      "verification_url": "https://aws.org/verify/CWI-2022-9985",
      "document_url": "cert_cwi_9985.pdf",
      "training_hours": 80,
      "ceu_credits": 8.0,
      "renewal_process": {
        "advance_notice_days": 120,
        "renewal_course_required": true,
        "renewal_exam_required": true,
        "renewal_cost": 1200.00,
        "provider_contact": "certification@aws.org"
      },
      "compliance_requirements": [
        {
          "requirement": "Continuing Education Units",
          "due_date": "2025-04-15",
          "status": "in_progress",
          "description": "9 CEU points required for renewal"
        },
        {
          "requirement": "Vision Exam",
          "due_date": "2025-05-15",
          "status": "pending",
          "description": "Annual vision examination required"
        }
      ],
      "project_assignments": [
        {
          "project_name": "Industrial Facility Upgrade",
          "role": "Quality Inspector",
          "start_date": "2024-01-15",
          "certification_required": true
        }
      ],
      "notes": "Premium certification for structural welding inspection",
      "priority": "high",
      "tags": ["welding", "inspection", "quality"]
    },
    {
      "id": "CERT-006",
      "certification_name": "First Aid/CPR Certification",
      "type": "safety",
      "holder_name": "Lisa Anderson",
      "employee_id": "EMP-006",
      "holder_photo": "https://picsum.photos/100/100?random=6&keyword=person",
      "issuing_authority": "American Red Cross",
      "certification_number": "ARC-FA-2023-7788",
      "issue_date": "2023-09-20",
      "expiry_date": "2024-09-20",
      "status": "expired",
      "urgency": "critical",
      "days_until_expiry": -30,
      "renewal_required": true,
      "cost": 95.00,
      "currency": "USD",
      "verification_method": "red_cross_database",
      "verification_url": "https://redcross.org/verify/ARC-FA-2023-7788",
      "document_url": "cert_first_aid_7788.pdf",
      "training_hours": 8,
      "ceu_credits": 0.8,
      "renewal_process": {
        "advance_notice_days": 30,
        "renewal_course_required": true,
        "renewal_exam_required": true,
        "renewal_cost": 85.00,
        "provider_contact": "training@redcross.org"
      },
      "compliance_requirements": [
        {
          "requirement": "Immediate Renewal",
          "due_date": "2024-06-20",
          "status": "overdue",
          "description": "Must renew before returning to work"
        }
      ],
      "project_assignments": [
        {
          "project_name": "School Renovation Project",
          "role": "Site Safety Coordinator",
          "start_date": "suspended",
          "certification_required": true
        }
      ],
      "notes": "EXPIRED - Employee suspended from safety roles until renewal",
      "priority": "critical",
      "tags": ["expired", "safety", "first_aid"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Certification Tracking"),
        actions: [
          QButton(
            icon: Icons.add_circle,
            size: bs.sm,
            onPressed: () => _addCertification(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.notifications,
            size: bs.sm,
            onPressed: () => _showExpiryNotifications(),
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
                  _buildCertificationOverview(),
                  _buildFilters(),
                  _buildExpiryAlerts(),
                  _buildCertificationsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildCertificationOverview() {
    int totalCerts = certifications.length;
    int activeCerts = certifications.where((c) => c["status"] == "active").length;
    int expiringCerts = certifications.where((c) => c["status"] == "expiring").length;
    int expiredCerts = certifications.where((c) => c["status"] == "expired").length;
    double totalCost = certifications.fold(0.0, (sum, c) => sum + (c["cost"] as double));

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
                child: Icon(Icons.verified_user, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Certification Tracking Overview",
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
              _buildOverviewCard("Total Certs", "$totalCerts", Icons.assignment, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Active", "$activeCerts", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Expiring", "$expiringCerts", Icons.warning, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Expired", "$expiredCerts", Icons.error, dangerColor),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: successColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.attach_money, color: successColor, size: 18),
                SizedBox(width: spXs),
                Text(
                  "Total Investment: \$${totalCost.currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Spacer(),
                Icon(Icons.trending_up, color: successColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "ROI Tracking Available",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ),
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
                  label: "Search certifications...",
                  value: searchQuery,
                  hint: "Search by name, holder, or certification number",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.calendar_today,
                size: bs.sm,
                onPressed: () => _showCalendarView(),
              ),
            ],
          ),
          Row(
            children: [
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
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeFilters,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Urgency",
                  items: urgencyFilters,
                  value: selectedUrgency,
                  onChanged: (value, label) {
                    selectedUrgency = value;
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

  Widget _buildExpiryAlerts() {
    List<Map<String, dynamic>> criticalCerts = certifications
        .where((c) => c["urgency"] == "critical" || c["status"] == "expired")
        .toList();

    if (criticalCerts.isEmpty) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: dangerColor.withAlpha(50)),
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
                  color: dangerColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.warning, color: dangerColor, size: 20),
              ),
              SizedBox(width: spMd),
              Text(
                "Critical Alerts (${criticalCerts.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () => _viewAllAlerts(),
              ),
            ],
          ),
          ...criticalCerts.take(3).map((cert) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border(
                left: BorderSide(
                  color: _getStatusColor(cert["status"]),
                  width: 4,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("${cert["holder_photo"]}"),
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
                        "${cert["certification_name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${cert["holder_name"]} | ${cert["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          color: _getStatusColor(cert["status"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (cert["status"] == "expired")
                        Text(
                          "Expired ${((cert["days_until_expiry"] as int) * -1)} days ago",
                          style: TextStyle(
                            fontSize: 11,
                            color: dangerColor,
                          ),
                        )
                      else
                        Text(
                          "Expires in ${cert["days_until_expiry"]} days",
                          style: TextStyle(
                            fontSize: 11,
                            color: warningColor,
                          ),
                        ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.refresh,
                  size: bs.sm,
                  onPressed: () => _renewCertification(cert["id"]),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildCertificationsList() {
    List<Map<String, dynamic>> filteredCerts = _getFilteredCertifications();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Certifications (${filteredCerts.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.file_download,
              size: bs.sm,
              onPressed: () => _exportReport(),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.sort,
              size: bs.sm,
              onPressed: () => _showSortOptions(),
            ),
          ],
        ),
        ...filteredCerts.map((cert) => _buildCertificationCard(cert)),
      ],
    );
  }

  Widget _buildCertificationCard(Map<String, dynamic> cert) {
    Color statusColor = _getStatusColor(cert["status"]);
    Color typeColor = _getTypeColor(cert["type"]);

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
                    image: NetworkImage("${cert["holder_photo"]}"),
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
                      "${cert["certification_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${cert["holder_name"]} (${cert["employee_id"]})",
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
                            "${cert["status"]}".toUpperCase(),
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
                            color: typeColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${cert["type"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: typeColor,
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
                    Icon(Icons.business, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Issuing Authority: ${cert["issuing_authority"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.confirmation_number, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Cert #: ${cert["certification_number"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.date_range, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Issued: ${cert["issue_date"]} | Expires: ${cert["expiry_date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                if (cert["days_until_expiry"] != null)
                  Row(
                    children: [
                      Icon(
                        cert["days_until_expiry"] < 0 ? Icons.error : Icons.schedule,
                        color: cert["days_until_expiry"] < 0 ? dangerColor : 
                               cert["days_until_expiry"] < 90 ? warningColor : successColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        cert["days_until_expiry"] < 0
                            ? "Expired ${(cert["days_until_expiry"] as int) * -1} days ago"
                            : "Expires in ${cert["days_until_expiry"]} days",
                        style: TextStyle(
                          fontSize: 12,
                          color: cert["days_until_expiry"] < 0 ? dangerColor : 
                                 cert["days_until_expiry"] < 90 ? warningColor : successColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if ((cert["compliance_requirements"] as List).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.rule, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Compliance Requirements",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  ...(cert["compliance_requirements"] as List).map((req) => Padding(
                    padding: EdgeInsets.only(left: spMd),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _getComplianceStatusColor(req["status"]),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${req["requirement"]} - ${req["status"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        if (req["due_date"] != "ongoing")
                          Text(
                            "Due: ${req["due_date"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: warningColor,
                            ),
                          ),
                      ],
                    ),
                  )),
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
                    Icon(Icons.school, color: infoColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Training: ${cert["training_hours"]}h | CEU: ${cert["ceu_credits"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.attach_money, color: successColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Cost: \$${(cert["cost"] as double).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (cert["renewal_required"] == true)
                  Row(
                    children: [
                      Icon(Icons.refresh, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Renewal Cost: \$${(cert["renewal_process"]["renewal_cost"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Notice: ${cert["renewal_process"]["advance_notice_days"]} days",
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
          if ((cert["project_assignments"] as List).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.work, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Current Project: ${(cert["project_assignments"] as List)[0]["project_name"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
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
                  "${cert["notes"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              QButton(
                icon: Icons.link,
                size: bs.sm,
                onPressed: () => _verifyCertification(cert["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.file_download,
                size: bs.sm,
                onPressed: () => _downloadDocument(cert["document_url"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editCertification(cert["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showCertificationOptions(cert),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCertifications() {
    List<Map<String, dynamic>> filtered = certifications;

    if (selectedStatus != "all") {
      filtered = filtered.where((cert) => cert["status"] == selectedStatus).toList();
    }

    if (selectedType != "all") {
      filtered = filtered.where((cert) => cert["type"] == selectedType).toList();
    }

    if (selectedUrgency != "all") {
      filtered = filtered.where((cert) => cert["urgency"] == selectedUrgency).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((cert) =>
          cert["certification_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          cert["holder_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          cert["certification_number"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'expiring':
        return warningColor;
      case 'expired':
        return dangerColor;
      case 'pending':
        return infoColor;
      case 'suspended':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'safety':
        return dangerColor;
      case 'professional':
        return primaryColor;
      case 'training':
        return warningColor;
      case 'compliance':
        return infoColor;
      case 'equipment':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getComplianceStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in_progress':
        return warningColor;
      case 'pending':
        return infoColor;
      case 'overdue':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _addCertification() {
    ss("Add new certification");
  }

  void _showExpiryNotifications() {
    ss("Expiry notifications");
  }

  void _showCalendarView() {
    ss("Calendar view");
  }

  void _viewAllAlerts() {
    ss("View all alerts");
  }

  void _renewCertification(String certId) {
    ss("Renew certification $certId");
  }

  void _exportReport() {
    ss("Export certification report");
  }

  void _showSortOptions() {
    ss("Certification sort options");
  }

  void _verifyCertification(String certId) {
    ss("Verify certification $certId");
  }

  void _downloadDocument(String documentUrl) {
    ss("Download document $documentUrl");
  }

  void _editCertification(String certId) {
    ss("Edit certification $certId");
  }

  void _showCertificationOptions(Map<String, dynamic> cert) {
    ss("Options for ${cert["certification_name"]}");
  }
}
