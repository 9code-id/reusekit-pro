import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaPolicyManagementView extends StatefulWidget {
  const RhaPolicyManagementView({super.key});

  @override
  State<RhaPolicyManagementView> createState() => _RhaPolicyManagementViewState();
}

class _RhaPolicyManagementViewState extends State<RhaPolicyManagementView> {
  int currentTab = 0;
  String selectedCategory = "All";
  String selectedStatus = "All";
  String selectedDepartment = "All";
  String searchQuery = "";
  bool showExpiringSoon = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "All"},
    {"label": "HR Policies", "value": "HR"},
    {"label": "IT Security", "value": "Security"},
    {"label": "Finance", "value": "Finance"},
    {"label": "Operations", "value": "Operations"},
    {"label": "Legal", "value": "Legal"},
    {"label": "Health & Safety", "value": "Safety"},
  ];

  List<Map<String, dynamic>> statusTypes = [
    {"label": "All Status", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Under Review", "value": "Under Review"},
    {"label": "Pending Approval", "value": "Pending"},
    {"label": "Archived", "value": "Archived"},
  ];

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "All"},
    {"label": "Human Resources", "value": "HR"},
    {"label": "Information Technology", "value": "IT"},
    {"label": "Finance", "value": "Finance"},
    {"label": "Legal", "value": "Legal"},
    {"label": "Operations", "value": "Operations"},
    {"label": "Marketing", "value": "Marketing"},
  ];

  List<Map<String, dynamic>> policies = [
    {
      "id": "POL001",
      "title": "Employee Code of Conduct",
      "category": "HR",
      "department": "HR",
      "version": "3.2",
      "status": "Active",
      "createdDate": "2023-01-15",
      "lastUpdated": "2024-11-20",
      "effectiveDate": "2024-12-01",
      "reviewDate": "2025-12-01",
      "expiryDate": "2026-12-01",
      "owner": "Sarah Johnson",
      "approver": "Emma Davis",
      "description": "Guidelines for professional conduct, ethics, and workplace behavior for all employees",
      "acknowledgmentRequired": true,
      "acknowledgmentRate": 94.5,
      "totalEmployees": 131,
      "acknowledgedBy": 124,
      "tags": ["Ethics", "Conduct", "Workplace"],
      "relatedPolicies": ["POL002", "POL015"],
      "attachments": ["Code_of_Conduct_v3.2.pdf", "Ethics_Guidelines.pdf"],
    },
    {
      "id": "POL002",
      "title": "Anti-Harassment and Discrimination Policy",
      "category": "HR",
      "department": "HR",
      "version": "2.1",
      "status": "Active",
      "createdDate": "2023-02-01",
      "lastUpdated": "2024-10-15",
      "effectiveDate": "2024-11-01",
      "reviewDate": "2025-11-01",
      "expiryDate": "2026-11-01",
      "owner": "Sarah Johnson",
      "approver": "Emma Davis",
      "description": "Comprehensive policy addressing harassment, discrimination, and creating inclusive workplace environment",
      "acknowledgmentRequired": true,
      "acknowledgmentRate": 97.8,
      "totalEmployees": 131,
      "acknowledgedBy": 128,
      "tags": ["Harassment", "Discrimination", "Inclusion"],
      "relatedPolicies": ["POL001", "POL003"],
      "attachments": ["Anti_Harassment_Policy_v2.1.pdf", "Reporting_Procedures.pdf"],
    },
    {
      "id": "POL003",
      "title": "Information Security Policy",
      "category": "Security",
      "department": "IT",
      "version": "4.0",
      "status": "Under Review",
      "createdDate": "2023-03-01",
      "lastUpdated": "2024-12-15",
      "effectiveDate": "2025-01-15",
      "reviewDate": "2025-07-15",
      "expiryDate": "2026-01-15",
      "owner": "David Chen",
      "approver": "Michael Brown",
      "description": "Security standards, data protection measures, and cybersecurity protocols for all systems and data",
      "acknowledgmentRequired": true,
      "acknowledgmentRate": 89.3,
      "totalEmployees": 131,
      "acknowledgedBy": 117,
      "tags": ["Security", "Data Protection", "Cybersecurity"],
      "relatedPolicies": ["POL004", "POL012"],
      "attachments": ["Security_Policy_v4.0.pdf", "Security_Guidelines.pdf", "Incident_Response.pdf"],
    },
    {
      "id": "POL004",
      "title": "Remote Work Policy",
      "category": "HR",
      "department": "HR",
      "version": "1.5",
      "status": "Active",
      "createdDate": "2023-04-01",
      "lastUpdated": "2024-09-10",
      "effectiveDate": "2024-10-01",
      "reviewDate": "2025-04-01",
      "expiryDate": "2026-04-01",
      "owner": "Lisa Rodriguez",
      "approver": "Sarah Johnson",
      "description": "Guidelines for remote work arrangements, equipment, productivity standards, and communication protocols",
      "acknowledgmentRequired": true,
      "acknowledgmentRate": 91.6,
      "totalEmployees": 131,
      "acknowledgedBy": 120,
      "tags": ["Remote Work", "Productivity", "Communication"],
      "relatedPolicies": ["POL001", "POL003"],
      "attachments": ["Remote_Work_Policy_v1.5.pdf", "Home_Office_Setup.pdf"],
    },
    {
      "id": "POL005",
      "title": "Financial Expense Policy",
      "category": "Finance",
      "department": "Finance",
      "version": "2.3",
      "status": "Draft",
      "createdDate": "2023-05-01",
      "lastUpdated": "2024-12-20",
      "effectiveDate": "2025-02-01",
      "reviewDate": "2025-08-01",
      "expiryDate": "2026-02-01",
      "owner": "Michael Brown",
      "approver": "Emma Davis",
      "description": "Expense reimbursement procedures, approval limits, and financial accountability measures",
      "acknowledgmentRequired": false,
      "acknowledgmentRate": 0.0,
      "totalEmployees": 131,
      "acknowledgedBy": 0,
      "tags": ["Expenses", "Reimbursement", "Financial"],
      "relatedPolicies": ["POL006", "POL010"],
      "attachments": ["Expense_Policy_v2.3_Draft.pdf", "Expense_Forms.pdf"],
    },
  ];

  List<Map<String, dynamic>> policyTemplates = [
    {
      "id": "TPL001",
      "name": "Standard HR Policy Template",
      "category": "HR",
      "description": "Template for creating standardized HR policies with consistent formatting and required sections",
      "sections": ["Purpose", "Scope", "Policy Statement", "Procedures", "Responsibilities", "Compliance"],
      "lastUpdated": "2024-11-15",
      "usageCount": 12,
    },
    {
      "id": "TPL002",
      "name": "Security Policy Template",
      "category": "Security",
      "description": "Template for information security and cybersecurity policy documentation",
      "sections": ["Objective", "Scope", "Security Controls", "Risk Assessment", "Incident Response", "Monitoring"],
      "lastUpdated": "2024-12-01",
      "usageCount": 8,
    },
    {
      "id": "TPL003",
      "name": "Financial Policy Template",
      "category": "Finance",
      "description": "Template for financial and accounting policy documentation with approval workflows",
      "sections": ["Purpose", "Authority", "Procedures", "Approval Limits", "Documentation", "Review Process"],
      "lastUpdated": "2024-10-20",
      "usageCount": 6,
    },
  ];

  List<Map<String, dynamic>> approvalWorkflow = [
    {
      "policyId": "POL003",
      "policyTitle": "Information Security Policy",
      "currentStep": 2,
      "totalSteps": 4,
      "status": "Pending Review",
      "submittedBy": "David Chen",
      "submittedDate": "2024-12-15",
      "currentApprover": "Michael Brown",
      "daysInReview": 15,
      "steps": [
        {"step": 1, "role": "Policy Owner", "approver": "David Chen", "status": "Completed", "date": "2024-12-15"},
        {"step": 2, "role": "Department Head", "approver": "Michael Brown", "status": "Pending", "date": ""},
        {"step": 3, "role": "Legal Review", "approver": "Emma Davis", "status": "Waiting", "date": ""},
        {"step": 4, "role": "Executive Approval", "approver": "CEO", "status": "Waiting", "date": ""},
      ],
    },
    {
      "policyId": "POL005",
      "policyTitle": "Financial Expense Policy",
      "currentStep": 1,
      "totalSteps": 3,
      "status": "Draft",
      "submittedBy": "Michael Brown",
      "submittedDate": "2024-12-20",
      "currentApprover": "Michael Brown",
      "daysInReview": 10,
      "steps": [
        {"step": 1, "role": "Policy Owner", "approver": "Michael Brown", "status": "In Progress", "date": ""},
        {"step": 2, "role": "Legal Review", "approver": "Emma Davis", "status": "Waiting", "date": ""},
        {"step": 3, "role": "Executive Approval", "approver": "CEO", "status": "Waiting", "date": ""},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Policy Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Policies", icon: Icon(Icons.description)),
        Tab(text: "Approval Workflow", icon: Icon(Icons.approval)),
        Tab(text: "Templates", icon: Icon(Icons.library_books)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildPoliciesTab(),
        _buildApprovalWorkflowTab(),
        _buildTemplatesTab(),
      ],
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPolicyMetrics(),
          _buildAcknowledgmentStatus(),
          _buildQuickActions(),
          _buildRecentUpdates(),
        ],
      ),
    );
  }

  Widget _buildPolicyMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Policy Overview",
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
            _buildMetricCard(
              "Total Policies",
              "${policies.length}",
              "Across all departments",
              Icons.description,
              primaryColor,
              "3 added this month",
            ),
            _buildMetricCard(
              "Active Policies",
              "${policies.where((p) => p["status"] == "Active").length}",
              "Currently in effect",
              Icons.check_circle,
              successColor,
              "85.7% of total",
            ),
            _buildMetricCard(
              "Pending Review",
              "${policies.where((p) => p["status"] == "Under Review" || p["status"] == "Pending").length}",
              "Awaiting approval",
              Icons.pending,
              warningColor,
              "2 due this week",
            ),
            _buildMetricCard(
              "Acknowledgment Rate",
              "93.2%",
              "Average across all policies",
              Icons.how_to_reg,
              infoColor,
              "+2.1% from last month",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
    String trend,
  ) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 10,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAcknowledgmentStatus() {
    List<Map<String, dynamic>> acknowledgmentData = policies
        .where((p) => p["acknowledgmentRequired"] == true && p["status"] == "Active")
        .map((p) => {
              "title": p["title"],
              "rate": p["acknowledgmentRate"],
              "acknowledged": p["acknowledgedBy"],
              "total": p["totalEmployees"],
            })
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Policy Acknowledgment Status",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: acknowledgmentData.map((data) {
              Color statusColor = (data["rate"] as double) >= 95
                  ? successColor
                  : (data["rate"] as double) >= 85
                      ? warningColor
                      : dangerColor;

              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: disabledOutlineBorderColor.withAlpha(50),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${data["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${(data["rate"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: (data["rate"] as double) / 100,
                      backgroundColor: disabledOutlineBorderColor,
                      valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                    ),
                    Row(
                      children: [
                        Text(
                          "${data["acknowledged"]} of ${data["total"]} employees",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            //navigateTo('PolicyAcknowledgmentDetailsView')
                          },
                          child: Text(
                            "View Details",
                            style: TextStyle(
                              fontSize: 11,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Quick Actions",
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
            _buildActionCard(
              "Create Policy",
              "Draft new policy document",
              Icons.add_box,
              primaryColor,
              () {
                //navigateTo('CreatePolicyView')
              },
            ),
            _buildActionCard(
              "Review Pending",
              "Review policies awaiting approval",
              Icons.rate_review,
              warningColor,
              () {
                //navigateTo('PendingPoliciesView')
              },
            ),
            _buildActionCard(
              "Send Reminders",
              "Notify unacknowledged employees",
              Icons.notifications,
              infoColor,
              () {
                //navigateTo('SendRemindersView')
              },
            ),
            _buildActionCard(
              "Generate Report",
              "Policy compliance reports",
              Icons.assessment,
              successColor,
              () {
                //navigateTo('PolicyReportsView')
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentUpdates() {
    List<Map<String, dynamic>> recentUpdates = [
      {
        "policy": "Information Security Policy",
        "action": "Version 4.0 submitted for review",
        "user": "David Chen",
        "date": "2024-12-15",
        "type": "Update",
        "icon": Icons.security,
        "color": infoColor,
      },
      {
        "policy": "Financial Expense Policy",
        "action": "Draft version 2.3 created",
        "user": "Michael Brown",
        "date": "2024-12-20",
        "type": "Draft",
        "icon": Icons.edit,
        "color": warningColor,
      },
      {
        "policy": "Employee Code of Conduct",
        "action": "94.5% acknowledgment rate achieved",
        "user": "System",
        "date": "2024-12-22",
        "type": "Acknowledgment",
        "icon": Icons.check_circle,
        "color": successColor,
      },
      {
        "policy": "Remote Work Policy",
        "action": "Scheduled for annual review",
        "user": "Sarah Johnson",
        "date": "2024-12-18",
        "type": "Review",
        "icon": Icons.schedule,
        "color": primaryColor,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Recent Policy Updates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                //navigateTo('PolicyActivityLogView')
              },
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: recentUpdates.map((update) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: disabledOutlineBorderColor.withAlpha(50),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: (update["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        update["icon"] as IconData,
                        color: update["color"] as Color,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${update["policy"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${update["action"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "${update["user"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                " • ${update["date"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledColor,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: (update["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${update["type"]}",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: update["color"] as Color,
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
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPoliciesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPoliciesFilters(),
          _buildPoliciesList(),
        ],
      ),
    );
  }

  Widget _buildPoliciesFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Policies",
                  value: searchQuery,
                  hint: "Search by title, category, or owner",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('CreatePolicyView')
                },
              ),
            ],
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
                  items: statusTypes,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
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
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Expiring Soon",
                      "value": true,
                      "checked": showExpiringSoon,
                    }
                  ],
                  value: [
                    if (showExpiringSoon)
                      {"label": "Show Expiring Soon", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    showExpiringSoon = values.isNotEmpty;
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

  Widget _buildPoliciesList() {
    List<Map<String, dynamic>> filteredPolicies = policies.where((policy) {
      bool matchesSearch = searchQuery.isEmpty ||
          (policy["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (policy["category"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (policy["owner"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesCategory = selectedCategory == "All" ||
          policy["category"] == selectedCategory;

      bool matchesStatus = selectedStatus == "All" ||
          policy["status"] == selectedStatus;

      bool matchesDepartment = selectedDepartment == "All" ||
          policy["department"] == selectedDepartment;

      bool matchesExpiring = !showExpiringSoon || _isPolicyExpiringSoon(policy);

      return matchesSearch && matchesCategory && matchesStatus && 
             matchesDepartment && matchesExpiring;
    }).toList();

    return Column(
      children: filteredPolicies.map((policy) {
        Color statusColor = policy["status"] == "Active"
            ? successColor
            : policy["status"] == "Draft"
                ? infoColor
                : policy["status"] == "Under Review"
                    ? warningColor
                    : policy["status"] == "Pending"
                        ? warningColor
                        : disabledBoldColor;

        bool isExpiringSoon = _isPolicyExpiringSoon(policy);
        DateTime reviewDate = DateTime.parse(policy["reviewDate"]);
        int daysUntilReview = reviewDate.difference(DateTime.now()).inDays;

        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
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
                        Row(
                          children: [
                            Text(
                              "${policy["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${policy["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (isExpiringSoon) ...[
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Expiring Soon",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        Text(
                          "${policy["category"]} • ${policy["department"]} • v${policy["version"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('PolicyDetailsView')
                    },
                  ),
                ],
              ),
              Text(
                "${policy["description"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              if (policy["acknowledgmentRequired"] == true && policy["status"] == "Active")
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Acknowledgment Progress",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${(policy["acknowledgmentRate"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      LinearProgressIndicator(
                        value: (policy["acknowledgmentRate"] as double) / 100,
                        backgroundColor: disabledOutlineBorderColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          (policy["acknowledgmentRate"] as double) >= 95 ? successColor :
                          (policy["acknowledgmentRate"] as double) >= 85 ? warningColor : dangerColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${policy["acknowledgedBy"]} of ${policy["totalEmployees"]} employees",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 150,
                children: [
                  _buildPolicyInfoItem(
                    "Owner",
                    "${policy["owner"]}",
                    Icons.person,
                    primaryColor,
                  ),
                  _buildPolicyInfoItem(
                    "Effective Date",
                    "${policy["effectiveDate"]}",
                    Icons.calendar_today,
                    successColor,
                  ),
                  _buildPolicyInfoItem(
                    "Review Date",
                    "${policy["reviewDate"]}",
                    Icons.schedule,
                    daysUntilReview <= 90 ? warningColor : infoColor,
                  ),
                  _buildPolicyInfoItem(
                    "Last Updated",
                    "${policy["lastUpdated"]}",
                    Icons.update,
                    disabledBoldColor,
                  ),
                ],
              ),
              if ((policy["tags"] as List).isNotEmpty)
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (policy["tags"] as List).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$tag",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Policy",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('PolicyDetailsView')
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('EditPolicyView')
                    },
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    icon: Icons.file_download,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('DownloadPolicyView')
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPolicyInfoItem(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: color,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _isPolicyExpiringSoon(Map<String, dynamic> policy) {
    DateTime reviewDate = DateTime.parse(policy["reviewDate"]);
    int daysUntilReview = reviewDate.difference(DateTime.now()).inDays;
    return daysUntilReview <= 90;
  }

  Widget _buildApprovalWorkflowTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildWorkflowOverview(),
          _buildApprovalWorkflowList(),
        ],
      ),
    );
  }

  Widget _buildWorkflowOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Approval Workflow Overview",
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
            _buildMetricCard(
              "Pending Approvals",
              "${approvalWorkflow.where((w) => w["status"] == "Pending Review").length}",
              "Awaiting review",
              Icons.pending_actions,
              warningColor,
              "2 require attention",
            ),
            _buildMetricCard(
              "Draft Policies",
              "${approvalWorkflow.where((w) => w["status"] == "Draft").length}",
              "In development",
              Icons.edit,
              infoColor,
              "1 ready for submission",
            ),
            _buildMetricCard(
              "Average Review Time",
              "12.5 days",
              "Time to approval",
              Icons.schedule,
              primaryColor,
              "2 days faster than target",
            ),
            _buildMetricCard(
              "Approval Rate",
              "89.3%",
              "First-time approvals",
              Icons.check_circle,
              successColor,
              "+5.2% improvement",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildApprovalWorkflowList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Active Workflows",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              "${approvalWorkflow.length} workflows",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        Column(
          children: approvalWorkflow.map((workflow) {
            Color statusColor = workflow["status"] == "Pending Review"
                ? warningColor
                : workflow["status"] == "Draft"
                    ? infoColor
                    : successColor;

            double progress = (workflow["currentStep"] as int) / (workflow["totalSteps"] as int);

            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
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
                            Row(
                              children: [
                                Text(
                                  "${workflow["policyTitle"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${workflow["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: statusColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Submitted by ${workflow["submittedBy"]} • ${workflow["daysInReview"]} days in review",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.visibility,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('WorkflowDetailsView')
                        },
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Approval Progress",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Step ${workflow["currentStep"]} of ${workflow["totalSteps"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: progress,
                          backgroundColor: disabledOutlineBorderColor,
                          valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                        ),
                        Row(
                          children: [
                            Text(
                              "Current Approver: ${workflow["currentApprover"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: (workflow["steps"] as List).map<Widget>((step) {
                      Color stepColor = step["status"] == "Completed"
                          ? successColor
                          : step["status"] == "Pending"
                              ? warningColor
                              : step["status"] == "In Progress"
                                  ? infoColor
                                  : disabledBoldColor;

                      IconData stepIcon = step["status"] == "Completed"
                          ? Icons.check_circle
                          : step["status"] == "Pending"
                              ? Icons.pending
                              : step["status"] == "In Progress"
                                  ? Icons.hourglass_top
                                  : Icons.radio_button_unchecked;

                      return Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(2),
                              child: Icon(
                                stepIcon,
                                size: 16,
                                color: stepColor,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Step ${step["step"]}:",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${step["role"]} (${step["approver"]})",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: stepColor,
                                ),
                              ),
                            ),
                            if (step["date"] != "")
                              Text(
                                "${step["date"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledColor,
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  if (workflow["status"] == "Pending Review")
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Approve",
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('ApproveWorkflowView')
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Request Changes",
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('RequestChangesView')
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTemplatesOverview(),
          _buildTemplatesList(),
        ],
      ),
    );
  }

  Widget _buildTemplatesOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Policy Templates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {
                //navigateTo('CreateTemplateView')
              },
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: infoColor.withAlpha(30)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Policy templates help ensure consistency and completeness when creating new policies. Each template includes required sections and formatting guidelines.",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTemplatesList() {
    return Column(
      children: policyTemplates.map((template) {
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
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
                          "${template["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Category: ${template["category"]} • Used ${template["usageCount"]} times",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('TemplateDetailsView')
                    },
                  ),
                ],
              ),
              Text(
                "${template["description"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Template Sections:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (template["sections"] as List).map((section) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$section",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "Last Updated: ${template["lastUpdated"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    label: "Use Template",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('CreatePolicyFromTemplateView')
                    },
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('EditTemplateView')
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
