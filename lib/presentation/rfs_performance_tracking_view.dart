import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsPerformanceTrackingView extends StatefulWidget {
  const RfsPerformanceTrackingView({super.key});

  @override
  State<RfsPerformanceTrackingView> createState() => _RfsPerformanceTrackingViewState();
}

class _RfsPerformanceTrackingViewState extends State<RfsPerformanceTrackingView> {
  int currentTab = 0;
  String selectedPeriod = "today";
  String selectedEmployee = "all";

  List<Map<String, dynamic>> performanceData = [
    {
      "employee": "Alice Johnson",
      "role": "Server",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=person",
      "ordersServed": 45,
      "averageServiceTime": 12,
      "customerRating": 4.8,
      "tipsEarned": 120.50,
      "efficiency": 92,
      "punctuality": 98,
      "shift": "Morning",
      "hoursWorked": 8.0,
    },
    {
      "employee": "Bob Wilson",
      "role": "Chef",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=person",
      "ordersServed": 78,
      "averageServiceTime": 8,
      "customerRating": 4.6,
      "tipsEarned": 85.25,
      "efficiency": 88,
      "punctuality": 95,
      "shift": "Evening",
      "hoursWorked": 9.0,
    },
    {
      "employee": "Carol Smith",
      "role": "Manager",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=person",
      "ordersServed": 0,
      "averageServiceTime": 0,
      "customerRating": 4.9,
      "tipsEarned": 0.0,
      "efficiency": 95,
      "punctuality": 100,
      "shift": "Full Day",
      "hoursWorked": 10.0,
    },
    {
      "employee": "David Brown",
      "role": "Bartender",
      "avatar": "https://picsum.photos/80/80?random=4&keyword=person",
      "ordersServed": 32,
      "averageServiceTime": 5,
      "customerRating": 4.7,
      "tipsEarned": 95.75,
      "efficiency": 90,
      "punctuality": 92,
      "shift": "Evening",
      "hoursWorked": 8.0,
    },
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "quarter"},
  ];

  List<Map<String, dynamic>> employeeOptions = [
    {"label": "All Employees", "value": "all"},
    {"label": "Alice Johnson", "value": "alice"},
    {"label": "Bob Wilson", "value": "bob"},
    {"label": "Carol Smith", "value": "carol"},
    {"label": "David Brown", "value": "david"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Performance Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Individual", icon: Icon(Icons.person)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildIndividualTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFilters(),
          _buildKPICards(),
          _buildTopPerformers(),
          _buildPerformanceTrends(),
        ],
      ),
    );
  }

  Widget _buildIndividualTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildEmployeeFilter(),
          _buildEmployeeList(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsCards(),
          _buildPerformanceComparison(),
          _buildShiftAnalysis(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.filter_list, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Filters",
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
                    label: "Time Period",
                    items: periodOptions,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.refresh,
                  size: bs.sm,
                  onPressed: () {
                    ss("Performance data refreshed");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKPICards() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildKPICard("Total Orders", "156", Icons.receipt, successColor),
        _buildKPICard("Avg Service Time", "9.2 min", Icons.timer, infoColor),
        _buildKPICard("Customer Rating", "4.7/5", Icons.star, warningColor),
        _buildKPICard("Total Tips", "\$${((120.50 + 85.25 + 95.75) as double).currency}", Icons.payments, primaryColor),
      ],
    );
  }

  Widget _buildKPICard(String title, String value, IconData icon, Color color) {
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
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopPerformers() {
    var sortedPerformers = List<Map<String, dynamic>>.from(performanceData);
    sortedPerformers.sort((a, b) => (b["efficiency"] as int).compareTo(a["efficiency"] as int));

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
                  "Top Performers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            ...sortedPerformers.take(3).map((performer) => _buildPerformerItem(performer)),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformerItem(Map<String, dynamic> performer) {
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
            backgroundImage: NetworkImage("${performer["avatar"]}"),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${performer["employee"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${performer["role"]}",
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
              "${performer["efficiency"]}%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: successColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTrends() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.trending_up, color: successColor),
                SizedBox(width: spSm),
                Text(
                  "Performance Trends",
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
                      "Performance Chart",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Efficiency trends over time",
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

  Widget _buildEmployeeFilter() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: QDropdownField(
          label: "Select Employee",
          items: employeeOptions,
          value: selectedEmployee,
          onChanged: (value, label) {
            selectedEmployee = value;
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _buildEmployeeList() {
    return Column(
      spacing: spSm,
      children: performanceData.map((employee) => _buildEmployeeCard(employee)).toList(),
    );
  }

  Widget _buildEmployeeCard(Map<String, dynamic> employee) {
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
                    color: _getEfficiencyColor(employee["efficiency"] as int).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${employee["efficiency"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getEfficiencyColor(employee["efficiency"] as int),
                    ),
                  ),
                ),
              ],
            ),
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildMetricCard("Orders Served", "${employee["ordersServed"]}", Icons.receipt_long),
                _buildMetricCard("Service Time", "${employee["averageServiceTime"]} min", Icons.timer),
                _buildMetricCard("Rating", "${employee["customerRating"]}/5", Icons.star),
                _buildMetricCard("Tips Earned", "\$${(employee["tipsEarned"] as double).currency}", Icons.payments),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      ss("Viewing ${employee["employee"]} details");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.message,
                  size: bs.sm,
                  onPressed: () {
                    ss("Message sent to ${employee["employee"]}");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
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

  Widget _buildAnalyticsCards() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildAnalyticsCard("Team Efficiency", "90.2%", Icons.speed, successColor, "+5.2%"),
        _buildAnalyticsCard("Punctuality Rate", "96.8%", Icons.schedule, infoColor, "+2.1%"),
        _buildAnalyticsCard("Customer Satisfaction", "4.7/5", Icons.sentiment_satisfied, warningColor, "+0.3"),
        _buildAnalyticsCard("Revenue per Hour", "\$${(285.75).currency}", Icons.attach_money, primaryColor, "+12%"),
      ],
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color, String change) {
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: successColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    change,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: successColor,
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

  Widget _buildPerformanceComparison() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.compare_arrows, color: infoColor),
                SizedBox(width: spSm),
                Text(
                  "Performance Comparison",
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
                    Icon(Icons.bar_chart, size: 48, color: disabledColor),
                    SizedBox(height: spSm),
                    Text(
                      "Performance Comparison Chart",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Compare team member performance",
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

  Widget _buildShiftAnalysis() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.access_time, color: warningColor),
                SizedBox(width: spSm),
                Text(
                  "Shift Performance Analysis",
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
                _buildShiftItem("Morning Shift", "85%", "6 AM - 2 PM", successColor),
                _buildShiftItem("Evening Shift", "92%", "2 PM - 10 PM", infoColor),
                _buildShiftItem("Night Shift", "78%", "10 PM - 6 AM", warningColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftItem(String shift, String performance, String time, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
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
                  shift,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  time,
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
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              performance,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getEfficiencyColor(int efficiency) {
    if (efficiency >= 90) return successColor;
    if (efficiency >= 80) return warningColor;
    return dangerColor;
  }
}
