import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaBonusManagementView extends StatefulWidget {
  const RhaBonusManagementView({super.key});

  @override
  State<RhaBonusManagementView> createState() => _RhaBonusManagementViewState();
}

class _RhaBonusManagementViewState extends State<RhaBonusManagementView> {
  int currentTab = 0;
  String selectedDepartment = "All";
  String selectedBonusType = "All";
  String selectedPeriod = "Q4 2024";
  String searchQuery = "";
  bool showActiveOnly = true;

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "All"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Operations", "value": "Operations"},
    {"label": "Finance", "value": "Finance"},
  ];

  List<Map<String, dynamic>> bonusTypes = [
    {"label": "All Types", "value": "All"},
    {"label": "Performance Bonus", "value": "Performance"},
    {"label": "Sales Commission", "value": "Commission"},
    {"label": "Annual Bonus", "value": "Annual"},
    {"label": "Retention Bonus", "value": "Retention"},
    {"label": "Project Bonus", "value": "Project"},
  ];

  List<Map<String, dynamic>> periods = [
    {"label": "Q4 2024", "value": "Q4 2024"},
    {"label": "Q3 2024", "value": "Q3 2024"},
    {"label": "Q2 2024", "value": "Q2 2024"},
    {"label": "Q1 2024", "value": "Q1 2024"},
    {"label": "FY 2024", "value": "FY 2024"},
  ];

  List<Map<String, dynamic>> bonusPrograms = [
    {
      "id": "BP001",
      "name": "Q4 Performance Bonus",
      "type": "Performance",
      "department": "All",
      "budget": 250000.0,
      "allocated": 187500.0,
      "remaining": 62500.0,
      "participants": 156,
      "status": "Active",
      "startDate": "2024-10-01",
      "endDate": "2024-12-31",
      "payoutDate": "2025-01-15",
      "criteria": "Individual & Team KPIs",
      "minPayout": 500.0,
      "maxPayout": 5000.0,
      "eligibility": "Full-time employees with 6+ months tenure"
    },
    {
      "id": "BP002",
      "name": "Sales Commission Program",
      "type": "Commission",
      "department": "Sales",
      "budget": 180000.0,
      "allocated": 165000.0,
      "remaining": 15000.0,
      "participants": 24,
      "status": "Active",
      "startDate": "2024-01-01",
      "endDate": "2024-12-31",
      "payoutDate": "Monthly",
      "criteria": "Revenue targets achieved",
      "minPayout": 1000.0,
      "maxPayout": 15000.0,
      "eligibility": "Sales representatives and managers"
    },
    {
      "id": "BP003",
      "name": "Annual Excellence Bonus",
      "type": "Annual",
      "department": "All",
      "budget": 320000.0,
      "allocated": 0.0,
      "remaining": 320000.0,
      "participants": 0,
      "status": "Planned",
      "startDate": "2024-01-01",
      "endDate": "2024-12-31",
      "payoutDate": "2025-03-01",
      "criteria": "Annual performance rating 4.5+",
      "minPayout": 2000.0,
      "maxPayout": 12000.0,
      "eligibility": "All employees with annual reviews"
    },
    {
      "id": "BP004",
      "name": "Engineering Innovation Bonus",
      "type": "Project",
      "department": "Engineering",
      "budget": 75000.0,
      "allocated": 45000.0,
      "remaining": 30000.0,
      "participants": 18,
      "status": "Active",
      "startDate": "2024-07-01",
      "endDate": "2024-12-31",
      "payoutDate": "2025-01-31",
      "criteria": "Innovation project completion",
      "minPayout": 1500.0,
      "maxPayout": 8000.0,
      "eligibility": "Engineering team members on innovation projects"
    },
  ];

  List<Map<String, dynamic>> bonusPayouts = [
    {
      "id": "PY001",
      "employeeId": "EMP001",
      "employeeName": "Sarah Johnson",
      "department": "Sales",
      "programId": "BP002",
      "programName": "Sales Commission Program",
      "bonusType": "Commission",
      "period": "December 2024",
      "amount": 4500.0,
      "baseAmount": 4000.0,
      "multiplier": 1.125,
      "status": "Approved",
      "approvedBy": "Mike Wilson",
      "approvedDate": "2024-12-28",
      "payDate": "2025-01-05",
      "performance": 112.5,
      "criteria": "Revenue: \$180K (target: \$160K)"
    },
    {
      "id": "PY002",
      "employeeId": "EMP002",
      "employeeName": "David Chen",
      "department": "Engineering",
      "programId": "BP004",
      "programName": "Engineering Innovation Bonus",
      "bonusType": "Project",
      "period": "Q4 2024",
      "amount": 3200.0,
      "baseAmount": 3200.0,
      "multiplier": 1.0,
      "status": "Pending",
      "approvedBy": "",
      "approvedDate": "",
      "payDate": "2025-01-31",
      "performance": 100.0,
      "criteria": "Project completion with quality metrics"
    },
    {
      "id": "PY003",
      "employeeId": "EMP003",
      "employeeName": "Lisa Rodriguez",
      "department": "Marketing",
      "programId": "BP001",
      "programName": "Q4 Performance Bonus",
      "bonusType": "Performance",
      "period": "Q4 2024",
      "amount": 2800.0,
      "baseAmount": 2500.0,
      "multiplier": 1.12,
      "status": "Processing",
      "approvedBy": "Emma Davis",
      "approvedDate": "2024-12-30",
      "payDate": "2025-01-15",
      "performance": 112.0,
      "criteria": "Individual KPIs exceeded, Team goals met"
    },
    {
      "id": "PY004",
      "employeeId": "EMP004",
      "employeeName": "Michael Brown",
      "department": "Operations",
      "programId": "BP001",
      "programName": "Q4 Performance Bonus",
      "bonusType": "Performance",
      "period": "Q4 2024",
      "amount": 1800.0,
      "baseAmount": 1800.0,
      "multiplier": 1.0,
      "status": "Paid",
      "approvedBy": "Emma Davis",
      "approvedDate": "2024-12-15",
      "payDate": "2024-12-20",
      "performance": 100.0,
      "criteria": "All performance targets achieved"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Bonus Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Programs", icon: Icon(Icons.card_giftcard)),
        Tab(text: "Payouts", icon: Icon(Icons.payments)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildProgramsTab(),
        _buildPayoutsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildOverviewMetrics(),
          _buildQuickActions(),
          _buildRecentActivity(),
          _buildUpcomingPayouts(),
        ],
      ),
    );
  }

  Widget _buildOverviewMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Bonus Overview",
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
              "Total Budget",
              "\$825K",
              "FY 2024",
              Icons.account_balance,
              primaryColor,
              "+8.5% vs last year",
            ),
            _buildMetricCard(
              "Allocated",
              "\$397.5K",
              "48.2% of budget",
              Icons.pie_chart,
              successColor,
              "12 active programs",
            ),
            _buildMetricCard(
              "Paid Out",
              "\$285K",
              "This year",
              Icons.payment,
              infoColor,
              "892 payments",
            ),
            _buildMetricCard(
              "Participants",
              "198",
              "Eligible employees",
              Icons.people,
              warningColor,
              "85% participation",
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
              "Create Program",
              "Set up new bonus program",
              Icons.add_card,
              primaryColor,
              () {
                //navigateTo('CreateBonusProgramView')
              },
            ),
            _buildActionCard(
              "Process Payouts",
              "Calculate and approve bonuses",
              Icons.calculate,
              successColor,
              () {
                //navigateTo('ProcessPayoutsView')
              },
            ),
            _buildActionCard(
              "Bulk Upload",
              "Import bonus data from file",
              Icons.upload_file,
              infoColor,
              () {
                //navigateTo('BulkUploadView')
              },
            ),
            _buildActionCard(
              "Reports",
              "Generate bonus reports",
              Icons.assessment,
              warningColor,
              () {
                //navigateTo('BonusReportsView')
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

  Widget _buildRecentActivity() {
    List<Map<String, dynamic>> activities = [
      {
        "action": "Bonus Approved",
        "details": "Sarah Johnson - Sales Commission: \$4,500",
        "user": "Mike Wilson",
        "time": "2 hours ago",
        "icon": Icons.check_circle,
        "color": successColor,
      },
      {
        "action": "Program Created",
        "details": "Q1 2025 Performance Bonus Program",
        "user": "Emma Davis",
        "time": "1 day ago",
        "icon": Icons.add_circle,
        "color": primaryColor,
      },
      {
        "action": "Payout Processed",
        "details": "Q4 Performance Bonus - 45 employees",
        "user": "System",
        "time": "2 days ago",
        "icon": Icons.payment,
        "color": infoColor,
      },
      {
        "action": "Budget Updated",
        "details": "Engineering Innovation Bonus +\$25K",
        "user": "Finance Team",
        "time": "3 days ago",
        "icon": Icons.account_balance,
        "color": warningColor,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                //navigateTo('ActivityLogView')
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
            children: activities.map((activity) {
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
                        color: (activity["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        activity["icon"] as IconData,
                        color: activity["color"] as Color,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${activity["action"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${activity["details"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "${activity["user"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                " • ${activity["time"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledColor,
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

  Widget _buildUpcomingPayouts() {
    List<Map<String, dynamic>> upcomingPayouts = [
      {
        "program": "Q4 Performance Bonus",
        "amount": 187500.0,
        "employees": 156,
        "payDate": "2025-01-15",
        "status": "Pending Approval",
        "department": "All",
      },
      {
        "program": "Engineering Innovation",
        "amount": 45000.0,
        "employees": 18,
        "payDate": "2025-01-31",
        "status": "Under Review",
        "department": "Engineering",
      },
      {
        "program": "Sales Commission",
        "amount": 28500.0,
        "employees": 12,
        "payDate": "2025-02-05",
        "status": "Scheduled",
        "department": "Sales",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Upcoming Payouts",
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
            children: upcomingPayouts.map((payout) {
              Color statusColor = payout["status"] == "Scheduled"
                  ? successColor
                  : payout["status"] == "Pending Approval"
                      ? warningColor
                      : infoColor;

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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${payout["program"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
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
                                  "${payout["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: statusColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "\$${((payout["amount"] as double) / 1000).toStringAsFixed(0)}K",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                " • ${payout["employees"]} employees",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Pay Date: ${payout["payDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                " • ${payout["department"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.arrow_forward,
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('PayoutDetailsView')
                      },
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

  Widget _buildProgramsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildProgramsFilters(),
          _buildProgramsList(),
        ],
      ),
    );
  }

  Widget _buildProgramsFilters() {
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
                  label: "Search Programs",
                  value: searchQuery,
                  hint: "Search by name, type, or department",
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
                  //navigateTo('CreateBonusProgramView')
                },
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
                child: QDropdownField(
                  label: "Bonus Type",
                  items: bonusTypes,
                  value: selectedBonusType,
                  onChanged: (value, label) {
                    selectedBonusType = value;
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
                      "label": "Show Active Only",
                      "value": true,
                      "checked": showActiveOnly,
                    }
                  ],
                  value: [
                    if (showActiveOnly)
                      {"label": "Show Active Only", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    showActiveOnly = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              Spacer(),
              Text(
                "${bonusPrograms.length} programs found",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgramsList() {
    List<Map<String, dynamic>> filteredPrograms = bonusPrograms.where((program) {
      bool matchesSearch = searchQuery.isEmpty ||
          (program["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (program["type"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (program["department"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesDepartment = selectedDepartment == "All" ||
          program["department"] == selectedDepartment;

      bool matchesType = selectedBonusType == "All" ||
          program["type"] == selectedBonusType;

      bool matchesStatus = !showActiveOnly ||
          program["status"] == "Active";

      return matchesSearch && matchesDepartment && matchesType && matchesStatus;
    }).toList();

    return Column(
      children: filteredPrograms.map((program) {
        Color statusColor = program["status"] == "Active"
            ? successColor
            : program["status"] == "Planned"
                ? warningColor
                : disabledBoldColor;

        double utilizationRate = ((program["allocated"] as double) / (program["budget"] as double)) * 100;

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
                              "${program["name"]}",
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
                                "${program["status"]}",
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
                          "${program["type"]} • ${program["department"]}",
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
                      //navigateTo('ProgramDetailsView')
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
                          "Budget Utilization",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${utilizationRate.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: utilizationRate / 100,
                      backgroundColor: disabledOutlineBorderColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        utilizationRate > 90 ? dangerColor : 
                        utilizationRate > 75 ? warningColor : successColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Allocated: \$${((program["allocated"] as double) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Budget: \$${((program["budget"] as double) / 1000).toStringAsFixed(0)}K",
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
              Row(
                children: [
                  Expanded(
                    child: _buildProgramInfoItem(
                      "Participants",
                      "${program["participants"]}",
                      Icons.people,
                    ),
                  ),
                  Expanded(
                    child: _buildProgramInfoItem(
                      "Min Payout",
                      "\$${(program["minPayout"] as double).toStringAsFixed(0)}",
                      Icons.trending_down,
                    ),
                  ),
                  Expanded(
                    child: _buildProgramInfoItem(
                      "Max Payout",
                      "\$${(program["maxPayout"] as double).toStringAsFixed(0)}",
                      Icons.trending_up,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Criteria: ${program["criteria"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Period: ${program["startDate"]} to ${program["endDate"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Payout Date: ${program["payoutDate"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProgramInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
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
      ],
    );
  }

  Widget _buildPayoutsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPayoutsFilters(),
          _buildPayoutsList(),
        ],
      ),
    );
  }

  Widget _buildPayoutsFilters() {
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
                  label: "Search Employees",
                  value: searchQuery,
                  hint: "Search by name or employee ID",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.file_download,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('ExportPayoutsView')
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periods,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPayoutsList() {
    return Column(
      children: bonusPayouts.map((payout) {
        Color statusColor = payout["status"] == "Paid"
            ? successColor
            : payout["status"] == "Approved"
                ? infoColor
                : payout["status"] == "Processing"
                    ? warningColor
                    : disabledBoldColor;

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
                              "${payout["employeeName"]}",
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
                                "${payout["status"]}",
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
                          "${payout["employeeId"]} • ${payout["department"]}",
                          style: TextStyle(
                            fontSize: 12,
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
                        "\$${(payout["amount"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${payout["bonusType"]} Bonus",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
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
                          "Program: ${payout["programName"]}",
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
                        Text(
                          "Period: ${payout["period"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Performance: ${(payout["performance"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    if (payout["criteria"] != null)
                      Text(
                        "Criteria: ${payout["criteria"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
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
                          "Base: \$${(payout["baseAmount"] as double).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Multiplier: ${(payout["multiplier"] as double).toStringAsFixed(3)}x",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (payout["approvedBy"] != null && (payout["approvedBy"] as String).isNotEmpty)
                          Text(
                            "Approved by: ${payout["approvedBy"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        Text(
                          "Pay Date: ${payout["payDate"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.receipt,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('PayoutDetailsView')
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

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildBonusAnalytics(),
          _buildDepartmentBreakdown(),
          _buildTrendAnalysis(),
        ],
      ),
    );
  }

  Widget _buildBonusAnalytics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Bonus Analytics",
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
            _buildAnalyticsCard(
              "Average Bonus",
              "\$2,850",
              "Per employee this year",
              Icons.attach_money,
              successColor,
              "+12.5% vs last year",
            ),
            _buildAnalyticsCard(
              "Participation Rate",
              "85.2%",
              "Eligible employees",
              Icons.people_alt,
              infoColor,
              "198 of 232 employees",
            ),
            _buildAnalyticsCard(
              "Budget Efficiency",
              "73.8%",
              "Budget utilization",
              Icons.pie_chart,
              warningColor,
              "\$609K of \$825K used",
            ),
            _buildAnalyticsCard(
              "ROI Impact",
              "3.2x",
              "Performance improvement",
              Icons.trending_up,
              primaryColor,
              "Based on productivity metrics",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnalyticsCard(
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

  Widget _buildDepartmentBreakdown() {
    List<Map<String, dynamic>> departmentData = [
      {
        "department": "Sales",
        "employees": 24,
        "totalBonus": 125000.0,
        "avgBonus": 5208.33,
        "participation": 95.8,
        "color": primaryColor,
      },
      {
        "department": "Engineering",
        "employees": 45,
        "totalBonus": 180000.0,
        "avgBonus": 4000.0,
        "participation": 88.9,
        "color": successColor,
      },
      {
        "department": "Marketing",
        "employees": 18,
        "totalBonus": 65000.0,
        "avgBonus": 3611.11,
        "participation": 83.3,
        "color": infoColor,
      },
      {
        "department": "Operations",
        "employees": 32,
        "totalBonus": 95000.0,
        "avgBonus": 2968.75,
        "participation": 81.3,
        "color": warningColor,
      },
      {
        "department": "Finance",
        "employees": 12,
        "totalBonus": 48000.0,
        "avgBonus": 4000.0,
        "participation": 75.0,
        "color": dangerColor,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Department Breakdown",
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
            children: departmentData.map((dept) {
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
                      width: 4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: dept["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${dept["department"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${((dept["totalBonus"] as double) / 1000).toStringAsFixed(0)}K",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${dept["employees"]} employees",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Avg: \$${(dept["avgBonus"] as double).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Participation: ${(dept["participation"] as double).toStringAsFixed(1)}%",
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
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendAnalysis() {
    List<Map<String, dynamic>> trendData = [
      {"period": "Q1 2024", "amount": 95000.0, "employees": 142},
      {"period": "Q2 2024", "amount": 118000.0, "employees": 167},
      {"period": "Q3 2024", "amount": 156000.0, "employees": 189},
      {"period": "Q4 2024", "amount": 240000.0, "employees": 198},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Quarterly Trends",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: trendData.map((trend) {
              double maxAmount = trendData.map((t) => t["amount"] as double).reduce((a, b) => a > b ? a : b);
              double progress = (trend["amount"] as double) / maxAmount;

              return Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                child: Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${trend["period"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${((trend["amount"] as double) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: disabledOutlineBorderColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                    Row(
                      children: [
                        Text(
                          "${trend["employees"]} employees",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Avg: \$${((trend["amount"] as double) / (trend["employees"] as int)).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
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
}
