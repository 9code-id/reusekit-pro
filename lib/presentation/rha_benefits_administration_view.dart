import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaBenefitsAdministrationView extends StatefulWidget {
  const RhaBenefitsAdministrationView({super.key});

  @override
  State<RhaBenefitsAdministrationView> createState() => _RhaBenefitsAdministrationViewState();
}

class _RhaBenefitsAdministrationViewState extends State<RhaBenefitsAdministrationView> {
  int currentTab = 0;
  String selectedDepartment = "all";
  String selectedBenefitType = "all";
  String selectedStatus = "all";
  String searchQuery = "";
  bool showActiveOnly = true;

  List<Map<String, dynamic>> benefitsData = [
    {
      "id": "BEN001",
      "employee": "Sarah Johnson",
      "employeeId": "EMP001",
      "department": "Engineering",
      "position": "Senior Developer",
      "enrollmentDate": "2024-01-01",
      "benefits": [
        {"type": "Health Insurance", "plan": "Premium PPO", "cost": 450, "employerCost": 360, "status": "active"},
        {"type": "Dental Insurance", "plan": "Basic Plan", "cost": 75, "employerCost": 60, "status": "active"},
        {"type": "Vision Insurance", "plan": "Standard", "cost": 25, "employerCost": 20, "status": "active"},
        {"type": "401(k)", "plan": "Company Match 6%", "cost": 570, "employerCost": 342, "status": "active"},
        {"type": "Life Insurance", "plan": "2x Salary", "cost": 45, "employerCost": 45, "status": "active"},
      ],
      "totalMonthlyCost": 1165,
      "employerContribution": 827,
      "employeeContribution": 338,
      "avatar": "https://picsum.photos/80/80?random=1&keyword=woman",
      "dependents": 2,
      "tier": "Employee + Family",
    },
    {
      "id": "BEN002",
      "employee": "Michael Chen",
      "employeeId": "EMP002",
      "department": "Marketing",
      "position": "Marketing Manager",
      "enrollmentDate": "2024-03-01",
      "benefits": [
        {"type": "Health Insurance", "plan": "Standard HMO", "cost": 320, "employerCost": 256, "status": "active"},
        {"type": "Dental Insurance", "plan": "Basic Plan", "cost": 50, "employerCost": 40, "status": "active"},
        {"type": "401(k)", "plan": "Company Match 4%", "cost": 312, "employerCost": 187, "status": "active"},
        {"type": "Life Insurance", "plan": "1x Salary", "cost": 28, "employerCost": 28, "status": "active"},
      ],
      "totalMonthlyCost": 710,
      "employerContribution": 511,
      "employeeContribution": 199,
      "avatar": "https://picsum.photos/80/80?random=2&keyword=man",
      "dependents": 1,
      "tier": "Employee + Spouse",
    },
    {
      "id": "BEN003",
      "employee": "Emily Rodriguez",
      "employeeId": "EMP003",
      "department": "Design",
      "position": "UI/UX Designer",
      "enrollmentDate": "2024-02-15",
      "benefits": [
        {"type": "Health Insurance", "plan": "Basic HMO", "cost": 280, "employerCost": 224, "status": "active"},
        {"type": "Dental Insurance", "plan": "Basic Plan", "cost": 35, "employerCost": 28, "status": "active"},
        {"type": "Vision Insurance", "plan": "Standard", "cost": 15, "employerCost": 12, "status": "active"},
        {"type": "401(k)", "plan": "Company Match 3%", "cost": 216, "employerCost": 130, "status": "active"},
      ],
      "totalMonthlyCost": 546,
      "employerContribution": 394,
      "employeeContribution": 152,
      "avatar": "https://picsum.photos/80/80?random=3&keyword=woman",
      "dependents": 0,
      "tier": "Employee Only",
    }
  ];

  List<Map<String, dynamic>> benefitPlans = [
    {
      "id": "PLAN001",
      "name": "Premium PPO Health Plan",
      "type": "Health Insurance",
      "provider": "BlueCross BlueShield",
      "description": "Comprehensive PPO plan with nationwide coverage",
      "tiers": [
        {"name": "Employee Only", "monthlyCost": 280, "employerShare": 80},
        {"name": "Employee + Spouse", "monthlyCost": 380, "employerShare": 75},
        {"name": "Employee + Family", "monthlyCost": 450, "employerShare": 80},
      ],
      "features": ["\$500 Deductible", "20% Coinsurance", "Out-of-Network Coverage", "Prescription Drug Coverage"],
      "enrolledEmployees": 15,
      "status": "active",
    },
    {
      "id": "PLAN002",
      "name": "Standard HMO Health Plan",
      "type": "Health Insurance",
      "provider": "Kaiser Permanente",
      "description": "Cost-effective HMO plan with local network",
      "tiers": [
        {"name": "Employee Only", "monthlyCost": 220, "employerShare": 80},
        {"name": "Employee + Spouse", "monthlyCost": 320, "employerShare": 80},
        {"name": "Employee + Family", "monthlyCost": 420, "employerShare": 75},
      ],
      "features": ["\$250 Deductible", "15% Copay", "Local Network", "Preventive Care Covered"],
      "enrolledEmployees": 8,
      "status": "active",
    },
    {
      "id": "PLAN003",
      "name": "Company 401(k) Plan",
      "type": "Retirement",
      "provider": "Fidelity Investments",
      "description": "401(k) retirement plan with company matching",
      "tiers": [
        {"name": "Standard Match", "monthlyCost": 0, "employerShare": 100},
      ],
      "features": ["Up to 6% Company Match", "Immediate Vesting", "Loan Options", "Investment Advisory"],
      "enrolledEmployees": 22,
      "status": "active",
    }
  ];

  List<Map<String, dynamic>> enrollmentRequests = [
    {
      "id": "REQ001",
      "employee": "David Wilson",
      "employeeId": "EMP004",
      "requestType": "New Enrollment",
      "benefitType": "Health Insurance",
      "planName": "Premium PPO Health Plan",
      "tier": "Employee + Spouse",
      "effectiveDate": "2025-01-01",
      "requestDate": "2024-12-10",
      "status": "pending",
      "reason": "New hire enrollment",
      "monthlyCost": 380,
    },
    {
      "id": "REQ002",
      "employee": "Lisa Brown",
      "employeeId": "EMP005",
      "requestType": "Plan Change",
      "benefitType": "Health Insurance",
      "currentPlan": "Standard HMO",
      "newPlan": "Premium PPO",
      "tier": "Employee + Family",
      "effectiveDate": "2025-01-01",
      "requestDate": "2024-12-12",
      "status": "approved",
      "reason": "Life event - new baby",
      "monthlyCost": 450,
    },
    {
      "id": "REQ003",
      "employee": "James Davis",
      "employeeId": "EMP006",
      "requestType": "Cancellation",
      "benefitType": "Dental Insurance",
      "planName": "Basic Dental Plan",
      "effectiveDate": "2024-12-31",
      "requestDate": "2024-12-08",
      "status": "pending",
      "reason": "Spouse coverage through other employer",
      "monthlyCost": -50,
    }
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "all"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Design", "value": "design"},
    {"label": "Sales", "value": "sales"},
  ];

  List<Map<String, dynamic>> benefitTypeOptions = [
    {"label": "All Benefits", "value": "all"},
    {"label": "Health Insurance", "value": "health"},
    {"label": "Dental Insurance", "value": "dental"},
    {"label": "Vision Insurance", "value": "vision"},
    {"label": "401(k)", "value": "retirement"},
    {"label": "Life Insurance", "value": "life"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Pending", "value": "pending"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Benefits Administration",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Enrollment", icon: Icon(Icons.person_add)),
        Tab(text: "Plans", icon: Icon(Icons.health_and_safety)),
        Tab(text: "Reports", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildEnrollmentTab(),
        _buildPlansTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Enrolled", "24", Icons.people, primaryColor),
              _buildStatCard("Monthly Cost", "\$18.2K", Icons.attach_money, successColor),
              _buildStatCard("Pending Requests", "3", Icons.pending, warningColor),
              _buildStatCard("Plan Utilization", "87%", Icons.pie_chart, infoColor),
            ],
          ),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
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
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Open Enrollment",
                        icon: Icons.assignment,
                        size: bs.sm,
                        onPressed: () => _startOpenEnrollment(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Add New Plan",
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () => _addNewPlan(),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Process Changes",
                        icon: Icons.update,
                        size: bs.sm,
                        onPressed: () => _processChanges(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Benefits Report",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () => _generateBenefitsReport(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Benefits Utilization
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Benefits Utilization",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(5, (index) {
                  final benefits = [
                    {"type": "Health Insurance", "enrolled": 23, "total": 24, "percentage": 96, "color": primaryColor},
                    {"type": "401(k)", "enrolled": 22, "total": 24, "percentage": 92, "color": successColor},
                    {"type": "Dental Insurance", "enrolled": 20, "total": 24, "percentage": 83, "color": infoColor},
                    {"type": "Life Insurance", "enrolled": 18, "total": 24, "percentage": 75, "color": warningColor},
                    {"type": "Vision Insurance", "enrolled": 15, "total": 24, "percentage": 63, "color": secondaryColor},
                  ];
                  final benefit = benefits[index];
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 40,
                          decoration: BoxDecoration(
                            color: benefit["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${benefit["type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${benefit["enrolled"]} of ${benefit["total"]} employees",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${benefit["percentage"]}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: benefit["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // Recent Enrollment Activity
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Recent Enrollment Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...enrollmentRequests.take(3).map((request) => 
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          request["requestType"] == "New Enrollment" ? Icons.person_add :
                          request["requestType"] == "Plan Change" ? Icons.swap_horiz :
                          Icons.cancel,
                          color: primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${request["employee"]} - ${request["requestType"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${request["benefitType"]} • ${request["requestDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                          decoration: BoxDecoration(
                            color: request["status"] == "approved" ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${request["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: request["status"] == "approved" ? successColor : warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnrollmentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search employees...",
                        value: searchQuery,
                        hint: "Name or ID",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    QButton(
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Department",
                        items: departmentOptions,
                        value: selectedDepartment,
                        onChanged: (value, label) {
                          selectedDepartment = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QDropdownField(
                        label: "Benefit Type",
                        items: benefitTypeOptions,
                        value: selectedBenefitType,
                        onChanged: (value, label) {
                          selectedBenefitType = value;
                          setState(() {});
                        },
                      ),
                    ),
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
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Show active enrollments only",
                            "value": true,
                            "checked": showActiveOnly,
                          }
                        ],
                        value: [
                          if (showActiveOnly)
                            {
                              "label": "Show active enrollments only",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          showActiveOnly = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                    QButton(
                      label: "New Enrollment",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () => _newEnrollment(),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Pending Requests
          if (enrollmentRequests.where((req) => req["status"] == "pending").isNotEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Pending Enrollment Requests",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...enrollmentRequests.where((req) => req["status"] == "pending").map((request) => _buildEnrollmentRequestCard(request)),
                ],
              ),
            ),

          // Employee Benefits
          ...benefitsData.map((benefits) => _buildEmployeeBenefitsCard(benefits)),
        ],
      ),
    );
  }

  Widget _buildPlansTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Plans Overview
          Container(
            padding: EdgeInsets.all(spMd),
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
                    Text(
                      "Available Benefit Plans",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Add Plan",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () => _addBenefitPlan(),
                    ),
                  ],
                ),
                Text(
                  "Manage benefit plans and coverage options for employees",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Benefit Plans
          ...benefitPlans.map((plan) => _buildBenefitPlanCard(plan)),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Report Generation
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Generate Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Enrollment Report",
                        icon: Icons.people,
                        size: bs.sm,
                        onPressed: () => _generateEnrollmentReport(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Cost Analysis",
                        icon: Icons.analytics,
                        size: bs.sm,
                        onPressed: () => _generateCostAnalysis(),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Utilization Report",
                        icon: Icons.pie_chart,
                        size: bs.sm,
                        onPressed: () => _generateUtilizationReport(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Compliance Report",
                        icon: Icons.verified_user,
                        size: bs.sm,
                        onPressed: () => _generateComplianceReport(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Analytics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAnalyticsCard("Avg Cost per Employee", "\$758", "+5.2% vs last month", warningColor),
              _buildAnalyticsCard("Plan Satisfaction", "4.2/5", "+0.3 vs last quarter", successColor),
              _buildAnalyticsCard("Claims Processing", "96%", "+1% vs last month", successColor),
              _buildAnalyticsCard("Cost Savings", "\$24K", "vs. previous provider", successColor),
            ],
          ),

          // Cost Breakdown
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Monthly Cost Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(5, (index) {
                  final costs = [
                    {"type": "Health Insurance", "cost": 8400, "percentage": 46, "color": primaryColor},
                    {"type": "401(k) Matching", "cost": 4200, "percentage": 23, "color": successColor},
                    {"type": "Life Insurance", "cost": 2800, "percentage": 15, "color": infoColor},
                    {"type": "Dental Insurance", "cost": 1800, "percentage": 10, "color": warningColor},
                    {"type": "Vision Insurance", "cost": 1200, "percentage": 6, "color": secondaryColor},
                  ];
                  final cost = costs[index];
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 40,
                          decoration: BoxDecoration(
                            color: cost["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${cost["type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${cost["percentage"]}% of total cost",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${((cost["cost"] as num) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: cost["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, String change, Color changeColor) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              color: changeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeBenefitsCard(Map<String, dynamic> benefits) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${benefits["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${benefits["employee"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${benefits["department"]} • ${benefits["position"]} • ${benefits["tier"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${((benefits["totalMonthlyCost"] as num).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Monthly Cost",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Cost Breakdown
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text("Employer Contribution:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${((benefits["employerContribution"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: successColor)),
                  ],
                ),
                Row(
                  children: [
                    Text("Employee Contribution:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${((benefits["employeeContribution"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  children: [
                    Text("Total Monthly Cost:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    Spacer(),
                    Text("\$${((benefits["totalMonthlyCost"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                  ],
                ),
              ],
            ),
          ),

          // Enrolled Benefits
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (benefits["benefits"] as List).map((benefit) => Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: primaryColor.withAlpha(40)),
              ),
              child: Text(
                "${benefit["type"]} - ${benefit["plan"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )).toList(),
          ),

          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewBenefitsDetails(benefits),
                ),
              ),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editBenefits(benefits),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () => _addBenefit(benefits),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnrollmentRequestCard(Map<String, dynamic> request) {
    Color statusColor = request["status"] == "approved" 
        ? successColor 
        : request["status"] == "pending" 
            ? warningColor 
            : dangerColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
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
                      "${request["employee"]} - ${request["requestType"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${request["benefitType"]} • Effective: ${request["effectiveDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${request["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          
          if (request["reason"] != null)
            Text(
              "Reason: ${request["reason"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontStyle: FontStyle.italic,
              ),
            ),

          if (request["status"] == "pending")
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Approve",
                    size: bs.sm,
                    onPressed: () => _approveRequest(request),
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Reject",
                    size: bs.sm,
                    onPressed: () => _rejectRequest(request),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildBenefitPlanCard(Map<String, dynamic> plan) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.health_and_safety,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${plan["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${plan["provider"]} • ${plan["enrolledEmployees"]} enrolled",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${plan["type"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          
          Text(
            "${plan["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          // Plan Tiers
          if (plan["tiers"] != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Coverage Tiers:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...(plan["tiers"] as List).map((tier) => Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${tier["name"]}:",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Text(
                        "\$${tier["monthlyCost"]} (${tier["employerShare"]}% employer)",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                    ],
                  ),
                )),
              ],
            ),

          // Features
          if (plan["features"] != null)
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (plan["features"] as List).map((feature) => Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: infoColor.withAlpha(40)),
                ),
                child: Text(
                  "$feature",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList(),
            ),

          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewPlanDetails(plan),
                ),
              ),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editPlan(plan),
              ),
              QButton(
                icon: Icons.people,
                size: bs.sm,
                onPressed: () => _viewPlanEnrollees(plan),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _startOpenEnrollment() {
    // Navigate to open enrollment setup
  }

  void _addNewPlan() {
    // Navigate to add new benefit plan
  }

  void _processChanges() {
    // Navigate to process enrollment changes
  }

  void _generateBenefitsReport() {
    // Navigate to generate benefits report
  }

  void _newEnrollment() {
    // Navigate to new enrollment form
  }

  void _addBenefitPlan() {
    // Navigate to add benefit plan form
  }

  void _generateEnrollmentReport() {
    // Navigate to generate enrollment report
  }

  void _generateCostAnalysis() {
    // Navigate to generate cost analysis
  }

  void _generateUtilizationReport() {
    // Navigate to generate utilization report
  }

  void _generateComplianceReport() {
    // Navigate to generate compliance report
  }

  void _viewBenefitsDetails(Map<String, dynamic> benefits) {
    // Navigate to detailed benefits view
  }

  void _editBenefits(Map<String, dynamic> benefits) {
    // Navigate to edit benefits form
  }

  void _addBenefit(Map<String, dynamic> benefits) {
    // Navigate to add benefit form
  }

  void _approveRequest(Map<String, dynamic> request) {
    request["status"] = "approved";
    setState(() {});
    ss("Enrollment request approved successfully");
  }

  void _rejectRequest(Map<String, dynamic> request) {
    request["status"] = "rejected";
    setState(() {});
    se("Enrollment request rejected");
  }

  void _viewPlanDetails(Map<String, dynamic> plan) {
    // Navigate to detailed plan view
  }

  void _editPlan(Map<String, dynamic> plan) {
    // Navigate to edit plan form
  }

  void _viewPlanEnrollees(Map<String, dynamic> plan) {
    // Navigate to view plan enrollees
  }
}
