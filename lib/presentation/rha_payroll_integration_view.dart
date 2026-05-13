import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaPayrollIntegrationView extends StatefulWidget {
  const RhaPayrollIntegrationView({super.key});

  @override
  State<RhaPayrollIntegrationView> createState() => _RhaPayrollIntegrationViewState();
}

class _RhaPayrollIntegrationViewState extends State<RhaPayrollIntegrationView> {
  int currentTab = 0;
  String selectedPeriod = "current";
  String selectedDepartment = "all";
  String selectedStatus = "all";
  bool autoSync = true;
  bool emailNotifications = true;

  List<Map<String, dynamic>> payrollData = [
    {
      "id": "PR001",
      "employee": "Sarah Johnson",
      "employeeId": "EMP001",
      "department": "Engineering",
      "position": "Senior Developer",
      "period": "Dec 1-15, 2024",
      "regularHours": 80.0,
      "overtimeHours": 8.5,
      "totalHours": 88.5,
      "hourlyRate": 45.00,
      "overtimeRate": 67.50,
      "grossPay": 4173.75,
      "deductions": 834.75,
      "netPay": 3339.00,
      "status": "processed",
      "processedDate": "2024-12-15",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=woman",
      "benefits": 625.00,
      "taxes": 209.75,
    },
    {
      "id": "PR002",
      "employee": "Michael Chen",
      "employeeId": "EMP002",
      "department": "Marketing",
      "position": "Marketing Manager",
      "period": "Dec 1-15, 2024",
      "regularHours": 80.0,
      "overtimeHours": 4.0,
      "totalHours": 84.0,
      "hourlyRate": 42.00,
      "overtimeRate": 63.00,
      "grossPay": 3612.00,
      "deductions": 722.40,
      "netPay": 2889.60,
      "status": "pending",
      "submittedDate": "2024-12-14",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=man",
      "benefits": 540.00,
      "taxes": 182.40,
    },
    {
      "id": "PR003",
      "employee": "Emily Rodriguez",
      "employeeId": "EMP003",
      "department": "Design",
      "position": "UI/UX Designer",
      "period": "Dec 1-15, 2024",
      "regularHours": 77.0,
      "overtimeHours": 2.0,
      "totalHours": 79.0,
      "hourlyRate": 38.50,
      "overtimeRate": 57.75,
      "grossPay": 3080.00,
      "deductions": 616.00,
      "netPay": 2464.00,
      "status": "approved",
      "approvedDate": "2024-12-15",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=woman",
      "benefits": 462.00,
      "taxes": 154.00,
    }
  ];

  List<Map<String, dynamic>> integrationLogs = [
    {
      "id": "LOG001",
      "timestamp": "2024-12-15 14:30:00",
      "action": "Payroll Data Sync",
      "status": "success",
      "recordsProcessed": 24,
      "system": "ADP Workforce",
      "details": "Successfully synchronized 24 employee payroll records"
    },
    {
      "id": "LOG002",
      "timestamp": "2024-12-15 10:15:00",
      "action": "Timesheet Import",
      "status": "warning",
      "recordsProcessed": 22,
      "system": "Time Clock System",
      "details": "2 timesheets require manual review"
    },
    {
      "id": "LOG003",
      "timestamp": "2024-12-14 16:45:00",
      "action": "Benefits Calculation",
      "status": "success",
      "recordsProcessed": 24,
      "system": "Benefits Portal",
      "details": "All benefit calculations completed successfully"
    },
    {
      "id": "LOG004",
      "timestamp": "2024-12-14 09:20:00",
      "action": "Tax Calculation",
      "status": "error",
      "recordsProcessed": 0,
      "system": "Tax Service API",
      "details": "Connection timeout - tax calculations failed"
    }
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Current Period (Dec 1-15)", "value": "current"},
    {"label": "Previous Period (Nov 16-30)", "value": "previous"},
    {"label": "December 2024", "value": "dec2024"},
    {"label": "November 2024", "value": "nov2024"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "all"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Design", "value": "design"},
    {"label": "Sales", "value": "sales"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "Processed", "value": "processed"},
    {"label": "Error", "value": "error"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Payroll Integration",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Payroll Data", icon: Icon(Icons.payment)),
        Tab(text: "Integration", icon: Icon(Icons.sync)),
        Tab(text: "Reports", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildPayrollDataTab(),
        _buildIntegrationTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildDashboardTab() {
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
              _buildStatCard("Total Employees", "24", Icons.people, primaryColor),
              _buildStatCard("Processed Payroll", "22", Icons.check_circle, successColor),
              _buildStatCard("Pending Review", "2", Icons.pending, warningColor),
              _buildStatCard("Total Gross Pay", "\$86,420", Icons.attach_money, infoColor),
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
                        label: "Sync Timesheets",
                        icon: Icons.sync,
                        size: bs.sm,
                        onPressed: () => _syncTimesheets(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Process Payroll",
                        icon: Icons.play_arrow,
                        size: bs.sm,
                        onPressed: () => _processPayroll(),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Generate Report",
                        icon: Icons.description,
                        size: bs.sm,
                        onPressed: () => _generatePayrollReport(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Export Data",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () => _exportPayrollData(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // System Status
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
                  "Integration Status",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(4, (index) {
                  final systems = [
                    {"name": "ADP Workforce", "status": "connected", "lastSync": "2 min ago"},
                    {"name": "Time Clock System", "status": "connected", "lastSync": "5 min ago"},
                    {"name": "Benefits Portal", "status": "connected", "lastSync": "1 hour ago"},
                    {"name": "Tax Service API", "status": "error", "lastSync": "2 hours ago"},
                  ];
                  final system = systems[index];
                  Color statusColor = system["status"] == "connected" ? successColor : dangerColor;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${system["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Last sync: ${system["lastSync"]}",
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
                            "${system["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // Recent Activity
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
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...integrationLogs.take(3).map((log) => _buildActivityItem(log)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayrollDataTab() {
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
                      child: QDropdownField(
                        label: "Period",
                        items: periodOptions,
                        value: selectedPeriod,
                        onChanged: (value, label) {
                          selectedPeriod = value;
                          setState(() {});
                        },
                      ),
                    ),
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
              ],
            ),
          ),

          // Payroll Summary
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
                  "Payroll Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryItem("Gross Pay", "\$86,420.75", successColor),
                    ),
                    Expanded(
                      child: _buildSummaryItem("Total Deductions", "\$17,284.15", warningColor),
                    ),
                    Expanded(
                      child: _buildSummaryItem("Net Pay", "\$69,136.60", primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Payroll Records
          ...payrollData.map((payroll) => _buildPayrollCard(payroll)),
        ],
      ),
    );
  }

  Widget _buildIntegrationTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Integration Settings
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
                  "Integration Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Auto Sync Timesheets",
                            "value": true,
                            "checked": autoSync,
                          }
                        ],
                        value: [
                          if (autoSync)
                            {
                              "label": "Auto Sync Timesheets",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          autoSync = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Email Notifications",
                            "value": true,
                            "checked": emailNotifications,
                          }
                        ],
                        value: [
                          if (emailNotifications)
                            {
                              "label": "Email Notifications",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          emailNotifications = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Test Connection",
                        icon: Icons.wifi_protected_setup,
                        size: bs.sm,
                        onPressed: () => _testConnection(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Manual Sync",
                        icon: Icons.sync,
                        size: bs.sm,
                        onPressed: () => _manualSync(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Integration Logs
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
                      "Integration Logs",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Clear Logs",
                      size: bs.sm,
                      onPressed: () => _clearLogs(),
                    ),
                  ],
                ),
                ...integrationLogs.map((log) => _buildLogCard(log)),
              ],
            ),
          ),

          // API Configuration
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
                  "Connected Systems",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(4, (index) {
                  final systems = [
                    {"name": "ADP Workforce", "type": "Payroll System", "status": "Active", "version": "v2.1"},
                    {"name": "Time Clock Pro", "type": "Time Tracking", "status": "Active", "version": "v1.8"},
                    {"name": "Benefits Hub", "type": "Benefits Management", "status": "Active", "version": "v3.2"},
                    {"name": "TaxAPI", "type": "Tax Calculation", "status": "Error", "version": "v1.5"},
                  ];
                  final system = systems[index];
                  Color statusColor = system["status"] == "Active" ? successColor : dangerColor;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.api,
                            color: statusColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${system["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${system["type"]} • ${system["version"]}",
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
                            "${system["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.settings,
                          size: bs.sm,
                          onPressed: () => _configureSystem(system),
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
                        label: "Payroll Summary",
                        icon: Icons.summarize,
                        size: bs.sm,
                        onPressed: () => _generatePayrollSummary(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Tax Report",
                        icon: Icons.receipt,
                        size: bs.sm,
                        onPressed: () => _generateTaxReport(),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Benefits Report",
                        icon: Icons.health_and_safety,
                        size: bs.sm,
                        onPressed: () => _generateBenefitsReport(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Department Analysis",
                        icon: Icons.business,
                        size: bs.sm,
                        onPressed: () => _generateDepartmentAnalysis(),
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
              _buildAnalyticsCard("Avg Processing Time", "2.3 hrs", "-15% vs last month", successColor),
              _buildAnalyticsCard("Error Rate", "0.8%", "-0.2% vs last month", successColor),
              _buildAnalyticsCard("Auto Sync Success", "97%", "+2% vs last month", successColor),
              _buildAnalyticsCard("Manual Interventions", "3", "-5 vs last month", successColor),
            ],
          ),

          // Recent Reports
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
                  "Recent Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(5, (index) {
                  final reports = [
                    {"name": "Payroll Summary - Dec 2024", "date": "2024-12-15", "type": "Summary", "size": "1.2 MB"},
                    {"name": "Tax Report - Q4 2024", "date": "2024-12-14", "type": "Tax", "size": "2.8 MB"},
                    {"name": "Benefits Analysis - November", "date": "2024-12-01", "type": "Benefits", "size": "1.5 MB"},
                    {"name": "Department Payroll - November", "date": "2024-11-30", "type": "Department", "size": "3.1 MB"},
                    {"name": "Integration Audit - Q4 2024", "date": "2024-11-25", "type": "Audit", "size": "4.2 MB"},
                  ];
                  final report = reports[index];
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.description,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${report["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${report["type"]} • ${report["date"]} • ${report["size"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () => _downloadReport(report),
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

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildPayrollCard(Map<String, dynamic> payroll) {
    Color statusColor = payroll["status"] == "processed" 
        ? successColor 
        : payroll["status"] == "approved" 
            ? primaryColor 
            : warningColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
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
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${payroll["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${payroll["employee"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${payroll["department"]} • ${payroll["position"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${payroll["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Period",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${payroll["period"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                      "Total Hours",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${payroll["totalHours"]}h",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
                      "Net Pay",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((payroll["netPay"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Breakdown
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
                    Text("Gross Pay:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${((payroll["grossPay"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  children: [
                    Text("Deductions:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("-\$${((payroll["deductions"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: dangerColor)),
                  ],
                ),
                Row(
                  children: [
                    Text("Net Pay:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    Spacer(),
                    Text("\$${((payroll["netPay"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: successColor)),
                  ],
                ),
              ],
            ),
          ),

          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewPayrollDetails(payroll),
                ),
              ),
              if (payroll["status"] == "pending") ...[
                QButton(
                  icon: Icons.check,
                  size: bs.sm,
                  onPressed: () => _approvePayroll(payroll),
                ),
                QButton(
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () => _editPayroll(payroll),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> log) {
    Color statusColor = log["status"] == "success" 
        ? successColor 
        : log["status"] == "warning" 
            ? warningColor 
            : dangerColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            log["status"] == "success" ? Icons.check_circle :
            log["status"] == "warning" ? Icons.warning :
            Icons.error,
            color: statusColor,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${log["action"]} - ${log["system"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${log["timestamp"]} • ${log["recordsProcessed"]} records",
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
    );
  }

  Widget _buildLogCard(Map<String, dynamic> log) {
    Color statusColor = log["status"] == "success" 
        ? successColor 
        : log["status"] == "warning" 
            ? warningColor 
            : dangerColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              log["status"] == "success" ? Icons.check_circle :
              log["status"] == "warning" ? Icons.warning :
              Icons.error,
              color: statusColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${log["action"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${log["system"]} • ${log["timestamp"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${log["details"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${log["recordsProcessed"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _syncTimesheets() {
    // Navigate to sync timesheets functionality
  }

  void _processPayroll() {
    // Navigate to process payroll functionality
  }

  void _generatePayrollReport() {
    // Navigate to generate payroll report
  }

  void _exportPayrollData() {
    // Navigate to export payroll data
  }

  void _testConnection() {
    // Navigate to test connection functionality
  }

  void _manualSync() {
    // Navigate to manual sync functionality
  }

  void _clearLogs() {
    // Navigate to clear logs functionality
  }

  void _configureSystem(Map<String, dynamic> system) {
    // Navigate to configure system settings
  }

  void _generatePayrollSummary() {
    // Navigate to generate payroll summary
  }

  void _generateTaxReport() {
    // Navigate to generate tax report
  }

  void _generateBenefitsReport() {
    // Navigate to generate benefits report
  }

  void _generateDepartmentAnalysis() {
    // Navigate to generate department analysis
  }

  void _downloadReport(Map<String, dynamic> report) {
    // Navigate to download report functionality
  }

  void _viewPayrollDetails(Map<String, dynamic> payroll) {
    // Navigate to payroll details view
  }

  void _approvePayroll(Map<String, dynamic> payroll) {
    payroll["status"] = "approved";
    payroll["approvedDate"] = DateTime.now().toIso8601String();
    setState(() {});
    ss("Payroll approved successfully");
  }

  void _editPayroll(Map<String, dynamic> payroll) {
    // Navigate to edit payroll form
  }
}
