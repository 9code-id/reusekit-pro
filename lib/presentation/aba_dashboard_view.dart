import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaDashboardView extends StatefulWidget {
  const AbaDashboardView({super.key});

  @override
  State<AbaDashboardView> createState() => _AbaDashboardViewState();
}

class _AbaDashboardViewState extends State<AbaDashboardView> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Business Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Sales", icon: Icon(Icons.trending_up)),
        Tab(text: "Expenses", icon: Icon(Icons.trending_down)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildSalesTab(),
        _buildExpensesTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period Selector
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              border: Border.all(color: disabledOutlineBorderColor),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: primaryColor, size: 18),
                SizedBox(width: spXs),
                Text(
                  "This Month",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Icon(Icons.keyboard_arrow_down, color: primaryColor, size: 18),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Key Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Total Revenue", "\$68,420", "+15.2%", successColor, Icons.attach_money),
              _buildMetricCard("Net Profit", "\$32,180", "+12.8%", primaryColor, Icons.trending_up),
              _buildMetricCard("Total Expenses", "\$36,240", "+8.4%", dangerColor, Icons.trending_down),
              _buildMetricCard("Cash Flow", "\$45,890", "+18.7%", infoColor, Icons.account_balance_wallet),
            ],
          ),
          
          SizedBox(height: spLg),
          
          // Revenue Chart Section
          Text(
            "Revenue Trend",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Container(
            width: double.infinity,
            height: 200,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Monthly Revenue",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$68,420",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(12, (index) {
                      double height = 20 + (index * 10.0) + (index % 3 * 15);
                      return Container(
                        width: 15,
                        height: height,
                        decoration: BoxDecoration(
                          color: index == 11 ? primaryColor : primaryColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spLg),
          
          // Quick Stats
          Text(
            "Quick Statistics",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Outstanding Invoices", "12", "\$18,460", warningColor),
              _buildStatCard("Paid Invoices", "28", "\$45,920", successColor),
              _buildStatCard("Overdue Payments", "3", "\$2,180", dangerColor),
              _buildStatCard("New Customers", "8", "This Month", infoColor),
            ],
          ),
          
          SizedBox(height: spLg),
          
          // Recent Activity
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ..._buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildSalesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sales Summary
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildSalesCard("Today's Sales", "\$3,240", "+8.5%", successColor),
              _buildSalesCard("This Week", "\$18,960", "+12.3%", primaryColor),
              _buildSalesCard("This Month", "\$68,420", "+15.2%", infoColor),
              _buildSalesCard("Average Order", "\$145", "+3.8%", warningColor),
            ],
          ),
          
          SizedBox(height: spLg),
          
          // Top Products/Services
          Text(
            "Top Performing Items",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ..._buildTopProducts(),
        ],
      ),
    );
  }

  Widget _buildExpensesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expense Summary
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildExpenseCard("This Month", "\$36,240", "+8.4%", dangerColor),
              _buildExpenseCard("Last Month", "\$33,450", "+5.2%", warningColor),
              _buildExpenseCard("Average Daily", "\$1,208", "+6.1%", infoColor),
              _buildExpenseCard("Largest Expense", "\$4,500", "Office Rent", primaryColor),
            ],
          ),
          
          SizedBox(height: spLg),
          
          // Expense Categories
          Text(
            "Expense Categories",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ..._buildExpenseCategories(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Performance Indicators
          Text(
            "Key Performance Indicators",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildKPICard("Profit Margin", "47%", "+2.1%", successColor),
              _buildKPICard("Customer Growth", "15%", "+5.3%", primaryColor),
              _buildKPICard("Expense Ratio", "53%", "-1.8%", warningColor),
              _buildKPICard("ROI", "32%", "+4.2%", infoColor),
            ],
          ),
          
          SizedBox(height: spLg),
          
          // Growth Analysis
          Text(
            "Growth Analysis",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Year-over-Year Growth",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildGrowthItem("Revenue Growth", "24.5%", successColor),
                _buildGrowthItem("Customer Base", "18.2%", primaryColor),
                _buildGrowthItem("Average Order Value", "12.8%", infoColor),
                _buildGrowthItem("Market Share", "6.4%", warningColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String change, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(
                change,
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
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
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String count, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            count,
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesCard(String title, String amount, String change, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
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
          SizedBox(height: spSm),
          Text(
            amount,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              color: successColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseCard(String title, String amount, String change, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
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
          SizedBox(height: spSm),
          Text(
            amount,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              color: change.startsWith('+') ? dangerColor : successColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKPICard(String title, String value, String change, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              color: change.startsWith('+') ? successColor : dangerColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRecentActivity() {
    List<Map<String, dynamic>> activities = [
      {"type": "sale", "description": "New sale - Invoice #1234", "amount": "\$2,450", "time": "2 hours ago"},
      {"type": "expense", "description": "Office supplies purchase", "amount": "\$125", "time": "5 hours ago"},
      {"type": "payment", "description": "Payment received from ABC Corp", "amount": "\$3,200", "time": "1 day ago"},
    ];

    return activities.map((activity) => Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusXs),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getActivityColor(activity["type"]).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              _getActivityIcon(activity["type"]),
              color: _getActivityColor(activity["type"]),
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${activity["time"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${activity["amount"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _getActivityColor(activity["type"]),
            ),
          ),
        ],
      ),
    )).toList();
  }

  List<Widget> _buildTopProducts() {
    List<Map<String, dynamic>> products = [
      {"name": "Business Consulting", "sales": 24, "revenue": 12000.0},
      {"name": "Web Development", "sales": 18, "revenue": 9500.0},
      {"name": "Marketing Services", "sales": 15, "revenue": 8200.0},
    ];

    return products.map((product) => Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusXs),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${product["sales"]} sales",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${(product["revenue"] as double).toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
        ],
      ),
    )).toList();
  }

  List<Widget> _buildExpenseCategories() {
    List<Map<String, dynamic>> categories = [
      {"name": "Office Rent", "amount": 4500.0, "percentage": 32},
      {"name": "Utilities", "amount": 1200.0, "percentage": 18},
      {"name": "Marketing", "amount": 2800.0, "percentage": 25},
      {"name": "Supplies", "amount": 950.0, "percentage": 15},
    ];

    return categories.map((category) => Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusXs),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${category["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${category["percentage"]}% of total expenses",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${(category["amount"] as double).toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: dangerColor,
            ),
          ),
        ],
      ),
    )).toList();
  }

  Widget _buildGrowthItem(String title, String percentage, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
          Text(
            percentage,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case "sale":
        return successColor;
      case "expense":
        return dangerColor;
      case "payment":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case "sale":
        return Icons.trending_up;
      case "expense":
        return Icons.trending_down;
      case "payment":
        return Icons.payment;
      default:
        return Icons.info;
    }
  }
}
