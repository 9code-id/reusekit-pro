import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsTipManagementView extends StatefulWidget {
  const RfsTipManagementView({super.key});

  @override
  State<RfsTipManagementView> createState() => _RfsTipManagementViewState();
}

class _RfsTipManagementViewState extends State<RfsTipManagementView> {
  int currentTab = 0;
  String selectedPeriod = "today";
  String distributionMethod = "equal";
  bool autoDistribution = true;

  List<Map<String, dynamic>> tipData = [
    {
      "employee": "Alice Johnson",
      "role": "Server",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=person",
      "tipsReceived": 145.75,
      "cashTips": 85.25,
      "cardTips": 60.50,
      "poolShare": 25.50,
      "directTips": 120.25,
      "shift": "Morning",
      "hoursWorked": 8.0,
      "tables": 12,
      "performance": 95,
    },
    {
      "employee": "Bob Wilson",
      "role": "Bartender",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=person",
      "tipsReceived": 98.50,
      "cashTips": 45.00,
      "cardTips": 53.50,
      "poolShare": 18.75,
      "directTips": 79.75,
      "shift": "Evening",
      "hoursWorked": 6.5,
      "tables": 0,
      "performance": 89,
    },
    {
      "employee": "Carol Smith",
      "role": "Server",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=person",
      "tipsReceived": 132.25,
      "cashTips": 70.75,
      "cardTips": 61.50,
      "poolShare": 22.00,
      "directTips": 110.25,
      "shift": "Evening",
      "hoursWorked": 8.0,
      "tables": 15,
      "performance": 92,
    },
    {
      "employee": "David Brown",
      "role": "Kitchen Staff",
      "avatar": "https://picsum.photos/80/80?random=4&keyword=person",
      "tipsReceived": 45.00,
      "cashTips": 15.00,
      "cardTips": 0.0,
      "poolShare": 45.00,
      "directTips": 0.0,
      "shift": "Full Day",
      "hoursWorked": 9.0,
      "tables": 0,
      "performance": 88,
    },
    {
      "employee": "Emma Davis",
      "role": "Host",
      "avatar": "https://picsum.photos/80/80?random=5&keyword=person",
      "tipsReceived": 35.75,
      "cashTips": 10.25,
      "cardTips": 0.0,
      "poolShare": 35.75,
      "directTips": 0.0,
      "shift": "Morning",
      "hoursWorked": 6.0,
      "tables": 0,
      "performance": 91,
    },
  ];

  List<Map<String, dynamic>> poolData = [
    {
      "date": "2024-12-15",
      "totalAmount": 285.50,
      "cashAmount": 125.75,
      "cardAmount": 159.75,
      "participants": 8,
      "distributed": true,
      "distributionMethod": "performance",
    },
    {
      "date": "2024-12-14", 
      "totalAmount": 312.25,
      "cashAmount": 140.50,
      "cardAmount": 171.75,
      "participants": 9,
      "distributed": true,
      "distributionMethod": "hours",
    },
    {
      "date": "2024-12-13",
      "totalAmount": 267.80,
      "cashAmount": 98.30,
      "cardAmount": 169.50,
      "participants": 7,
      "distributed": false,
      "distributionMethod": "equal",
    },
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Custom Range", "value": "custom"},
  ];

  List<Map<String, dynamic>> distributionOptions = [
    {"label": "Equal Distribution", "value": "equal"},
    {"label": "Based on Hours", "value": "hours"},
    {"label": "Based on Performance", "value": "performance"},
    {"label": "Based on Tables Served", "value": "tables"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Tip Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Distribution", icon: Icon(Icons.share)),
        Tab(text: "Pool", icon: Icon(Icons.account_balance)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildDistributionTab(),
        _buildPoolTab(),
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
          _buildTipSummary(),
          _buildQuickActions(),
          _buildTopEarners(),
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildDistributionTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildDistributionSettings(),
          _buildEmployeeTips(),
        ],
      ),
    );
  }

  Widget _buildPoolTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPoolSummary(),
          _buildPoolHistory(),
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
          _buildReportFilters(),
          _buildTipAnalytics(),
          _buildTrendAnalysis(),
          _buildPerformanceCorrelation(),
        ],
      ),
    );
  }

  Widget _buildTipSummary() {
    double totalTips = tipData.fold(0.0, (sum, emp) => sum + (emp["tipsReceived"] as double));
    double cashTips = tipData.fold(0.0, (sum, emp) => sum + (emp["cashTips"] as double));
    double cardTips = tipData.fold(0.0, (sum, emp) => sum + (emp["cardTips"] as double));
    double avgTips = totalTips / tipData.length;

    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildSummaryCard("Total Tips", "\$${totalTips.currency}", Icons.payments, primaryColor),
        _buildSummaryCard("Cash Tips", "\$${cashTips.currency}", Icons.monetization_on, successColor),
        _buildSummaryCard("Card Tips", "\$${cardTips.currency}", Icons.credit_card, infoColor),
        _buildSummaryCard("Average Tips", "\$${avgTips.currency}", Icons.trending_up, warningColor),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String amount, IconData icon, Color color) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                Spacer(),
                Icon(Icons.trending_up, color: successColor, size: 20),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  title,
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
    );
  }

  Widget _buildQuickActions() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.flash_on, color: warningColor),
                SizedBox(width: spSm),
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildActionButton("Add Tips", Icons.add_circle, () {
                  ss("Adding new tips entry");
                }),
                _buildActionButton("Distribute Pool", Icons.share, () {
                  ss("Distributing tip pool");
                }),
                _buildActionButton("Generate Report", Icons.description, () {
                  ss("Generating tip report");
                }),
                _buildActionButton("Export Data", Icons.download, () {
                  ss("Exporting tip data");
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      child: QButton(
        label: title,
        size: bs.sm,
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildTopEarners() {
    var sortedEarners = List<Map<String, dynamic>>.from(tipData);
    sortedEarners.sort((a, b) => (b["tipsReceived"] as double).compareTo(a["tipsReceived"] as double));

    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.emoji_events, color: warningColor),
                SizedBox(width: spSm),
                Text(
                  "Top Tip Earners",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            ...sortedEarners.take(3).map((earner) => _buildEarnerItem(earner)),
          ],
        ),
      ),
    );
  }

  Widget _buildEarnerItem(Map<String, dynamic> earner) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage("${earner["avatar"]}"),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${earner["employee"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${earner["role"]} • ${earner["shift"]} Shift",
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
                "\$${(earner["tipsReceived"] as double).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Text(
                "${((earner["tipsReceived"] as double) / (earner["hoursWorked"] as double)).toStringAsFixed(2)}/hr",
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
  }

  Widget _buildRecentActivity() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.history, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Recent Tip Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Column(
              spacing: spSm,
              children: [
                _buildActivityItem("Pool distributed to 8 employees", "2 hours ago", Icons.share, successColor),
                _buildActivityItem("Cash tips added: \$125.75", "4 hours ago", Icons.monetization_on, infoColor),
                _buildActivityItem("Card tips auto-recorded", "6 hours ago", Icons.credit_card, warningColor),
                _buildActivityItem("Performance bonus applied", "1 day ago", Icons.star, primaryColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String activity, String time, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                Text(
                  time,
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
  }

  Widget _buildDistributionSettings() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.settings, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Distribution Settings",
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
                Expanded(
                  child: QDropdownField(
                    label: "Distribution Method",
                    items: distributionOptions,
                    value: distributionMethod,
                    onChanged: (value, label) {
                      distributionMethod = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Apply",
                  size: bs.sm,
                  onPressed: () {
                    ss("Distribution method updated");
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Auto Distribution",
                        "value": true,
                        "checked": autoDistribution,
                      }
                    ],
                    value: [if (autoDistribution) {"label": "Auto Distribution", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      autoDistribution = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeTips() {
    return Column(
      spacing: spSm,
      children: [
        Card(
          child: Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Icon(Icons.people, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Employee Tip Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QDropdownField(
                  label: "Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
        ...tipData.map((employee) => _buildEmployeeTipCard(employee)),
      ],
    );
  }

  Widget _buildEmployeeTipCard(Map<String, dynamic> employee) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage("${employee["avatar"]}"),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${employee["employee"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${employee["role"]} • ${employee["shift"]} Shift",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "\$${(employee["tipsReceived"] as double).currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ),
              ],
            ),
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildTipDetailCard("Cash Tips", "\$${(employee["cashTips"] as double).currency}", Icons.monetization_on),
                _buildTipDetailCard("Card Tips", "\$${(employee["cardTips"] as double).currency}", Icons.credit_card),
                _buildTipDetailCard("Pool Share", "\$${(employee["poolShare"] as double).currency}", Icons.share),
                _buildTipDetailCard("Direct Tips", "\$${(employee["directTips"] as double).currency}", Icons.person),
              ],
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                spacing: spMd,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${(employee["hoursWorked"] as double).toStringAsFixed(1)}h",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Hours Worked",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (employee["tables"] > 0) ...[
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${employee["tables"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Tables Served",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${employee["performance"]}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Performance",
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
            ),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Add Tips",
                    size: bs.sm,
                    onPressed: () {
                      ss("Adding tips for ${employee["employee"]}");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () {
                    ss("Editing tips for ${employee["employee"]}");
                  },
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.receipt,
                  size: bs.sm,
                  onPressed: () {
                    ss("Tip statement generated for ${employee["employee"]}");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipDetailCard(String title, String amount, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 18),
          SizedBox(height: spXs),
          Text(
            amount,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
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
    );
  }

  Widget _buildPoolSummary() {
    Map<String, dynamic> currentPool = poolData.first;
    
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Current Tip Pool",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: currentPool["distributed"] ? successColor.withValues(alpha: 0.1) : warningColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    currentPool["distributed"] ? "DISTRIBUTED" : "PENDING",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: currentPool["distributed"] ? successColor : warningColor,
                    ),
                  ),
                ),
              ],
            ),
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildPoolCard("Total Amount", "\$${(currentPool["totalAmount"] as double).currency}", Icons.account_balance_wallet),
                _buildPoolCard("Cash Tips", "\$${(currentPool["cashAmount"] as double).currency}", Icons.monetization_on),
                _buildPoolCard("Card Tips", "\$${(currentPool["cardAmount"] as double).currency}", Icons.credit_card),
                _buildPoolCard("Participants", "${currentPool["participants"]}", Icons.people),
              ],
            ),
            if (!currentPool["distributed"]) ...[
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Distribute Pool",
                  size: bs.sm,
                  onPressed: () {
                    ss("Distributing tip pool to ${currentPool["participants"]} employees");
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPoolCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPoolHistory() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.history, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Pool History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            ...poolData.map((pool) => _buildPoolHistoryItem(pool)),
          ],
        ),
      ),
    );
  }

  Widget _buildPoolHistoryItem(Map<String, dynamic> pool) {
    Color statusColor = pool["distributed"] ? successColor : warningColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateTime.parse(pool["date"]).dMMMy,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${pool["participants"]} participants • ${pool["distributionMethod"]}",
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
                "\$${(pool["totalAmount"] as double).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  pool["distributed"] ? "DONE" : "PENDING",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportFilters() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.filter_alt, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Report Filters",
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
                Expanded(
                  child: QDropdownField(
                    label: "Report Type",
                    items: [
                      {"label": "Tip Summary", "value": "summary"},
                      {"label": "Employee Performance", "value": "performance"},
                      {"label": "Pool Analysis", "value": "pool"},
                    ],
                    value: "summary",
                    onChanged: (value, label) {
                      ss("Report type updated");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Generate",
                  size: bs.sm,
                  onPressed: () {
                    ss("Report generated successfully");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipAnalytics() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildAnalyticsCard("Avg Tips/Hour", "\$${(18.75).currency}", Icons.schedule, primaryColor, "+12.5%"),
        _buildAnalyticsCard("Pool Efficiency", "94.2%", Icons.speed, successColor, "+3.1%"),
        _buildAnalyticsCard("Cash vs Card", "45:55", Icons.pie_chart, infoColor, "+2.8%"),
        _buildAnalyticsCard("Employee Satisfaction", "8.7/10", Icons.sentiment_satisfied, warningColor, "+0.5"),
      ],
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color, String change) {
    bool isPositive = change.startsWith('+');
    Color changeColor = isPositive ? successColor : dangerColor;
    
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: changeColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    change,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: changeColor,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  title,
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
    );
  }

  Widget _buildTrendAnalysis() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.trending_up, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Tip Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.show_chart, size: 48, color: disabledColor),
                    SizedBox(height: spSm),
                    Text(
                      "Tip Trend Analysis",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Weekly tip patterns and trends",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceCorrelation() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.scatter_plot, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Performance vs Tips Correlation",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.analytics, size: 48, color: disabledColor),
                    SizedBox(height: spSm),
                    Text(
                      "Performance Correlation Chart",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Employee performance vs tip earnings",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
