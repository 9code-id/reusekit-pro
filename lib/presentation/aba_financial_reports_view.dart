import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaFinancialReportsView extends StatefulWidget {
  const AbaFinancialReportsView({super.key});

  @override
  State<AbaFinancialReportsView> createState() => _AbaFinancialReportsViewState();
}

class _AbaFinancialReportsViewState extends State<AbaFinancialReportsView> {
  int currentTab = 0;
  String selectedPeriod = "monthly";
  String selectedYear = "2024";
  bool loading = false;

  List<Map<String, dynamic>> periods = [
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  List<Map<String, dynamic>> years = [
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
  ];

  List<Map<String, dynamic>> financialMetrics = [
    {
      "title": "Total Revenue",
      "current": 2450000.00,
      "previous": 2180000.00,
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "title": "Total Expenses",
      "current": 1850000.00,
      "previous": 1720000.00,
      "icon": Icons.trending_down,
      "color": dangerColor,
    },
    {
      "title": "Net Profit",
      "current": 600000.00,
      "previous": 460000.00,
      "icon": Icons.account_balance_wallet,
      "color": primaryColor,
    },
    {
      "title": "Gross Margin",
      "current": 24.5,
      "previous": 21.1,
      "icon": Icons.percent,
      "color": infoColor,
      "isPercentage": true,
    },
  ];

  List<Map<String, dynamic>> revenueBreakdown = [
    {
      "category": "Product Sales",
      "amount": 1250000.00,
      "percentage": 51.0,
      "color": Colors.blue,
    },
    {
      "category": "Service Revenue",
      "amount": 850000.00,
      "percentage": 34.7,
      "color": Colors.green,
    },
    {
      "category": "Subscription Revenue",
      "amount": 250000.00,
      "percentage": 10.2,
      "color": Colors.orange,
    },
    {
      "category": "Other Income",
      "amount": 100000.00,
      "percentage": 4.1,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> expenseBreakdown = [
    {
      "category": "Cost of Goods Sold",
      "amount": 750000.00,
      "percentage": 40.5,
      "color": Colors.red,
    },
    {
      "category": "Salaries & Benefits",
      "amount": 550000.00,
      "percentage": 29.7,
      "color": Colors.blue,
    },
    {
      "category": "Operating Expenses",
      "amount": 350000.00,
      "percentage": 18.9,
      "color": Colors.orange,
    },
    {
      "category": "Marketing & Advertising",
      "amount": 120000.00,
      "percentage": 6.5,
      "color": Colors.green,
    },
    {
      "category": "Other Expenses",
      "amount": 80000.00,
      "percentage": 4.3,
      "color": Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Financial Reports",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Revenue", icon: Icon(Icons.trending_up)),
        Tab(text: "Expenses", icon: Icon(Icons.trending_down)),
        Tab(text: "Analysis", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildRevenueTab(),
        _buildExpensesTab(),
        _buildAnalysisTab(),
      ],
      onInit: (tabController) {
        // Tab controller initialization if needed
      },
    );
  }

  Widget _buildOverviewTab() {
    return loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPeriodFilters(),
                _buildFinancialMetrics(),
                _buildQuickActions(),
              ],
            ),
          );
  }

  Widget _buildPeriodFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Report Period",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
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
                    _loadFinancialData();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Year",
                  items: years,
                  value: selectedYear,
                  onChanged: (value, label) {
                    selectedYear = value;
                    _loadFinancialData();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialMetrics() {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 200,
      children: financialMetrics.map((metric) => _buildMetricCard(metric)).toList(),
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    double current = metric["current"] as double;
    double previous = metric["previous"] as double;
    bool isPercentage = metric["isPercentage"] ?? false;
    double change = ((current - previous) / previous) * 100;
    bool isPositive = change > 0;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: metric["color"] as Color,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                metric["icon"] as IconData,
                color: metric["color"] as Color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${metric["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            isPercentage 
                ? "${current.toStringAsFixed(1)}%"
                : "\$${current.currency}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive ? successColor : dangerColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${change.abs().toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 14,
                  color: isPositive ? successColor : dangerColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "vs previous period",
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

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
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
            minItemWidth: 180,
            children: [
              _buildActionButton("Generate P&L", Icons.summarize, () => _generateProfitLoss()),
              _buildActionButton("Balance Sheet", Icons.account_balance, () => _generateBalanceSheet()),
              _buildActionButton("Cash Flow", Icons.waves, () => _generateCashFlow()),
              _buildActionButton("Export All", Icons.file_download, () => _exportAllReports()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      child: QButton(
        label: title,
        icon: icon,
        size: bs.sm,
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildRevenueTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Revenue Breakdown", Icons.trending_up),
          _buildRevenueChart(),
          _buildRevenueDetails(),
        ],
      ),
    );
  }

  Widget _buildExpensesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Expense Breakdown", Icons.trending_down),
          _buildExpenseChart(),
          _buildExpenseDetails(),
        ],
      ),
    );
  }

  Widget _buildAnalysisTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Financial Analysis", Icons.analytics),
          _buildRatioAnalysis(),
          _buildTrendAnalysis(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 24),
        SizedBox(width: spSm),
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRevenueChart() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: revenueBreakdown.map((item) => _buildChartItem(item)).toList(),
      ),
    );
  }

  Widget _buildExpenseChart() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: expenseBreakdown.map((item) => _buildChartItem(item)).toList(),
      ),
    );
  }

  Widget _buildChartItem(Map<String, dynamic> item) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: item["color"] as Color,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Text(
                "${item["category"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
            ),
            Text(
              "${(item["percentage"] as double).toStringAsFixed(1)}%",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(width: spSm),
            Text(
              "\$${(item["amount"] as double).currency}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: (item["percentage"] as double) / 100,
            child: Container(
              decoration: BoxDecoration(
                color: item["color"] as Color,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRevenueDetails() {
    double totalRevenue = revenueBreakdown.fold(0.0, (sum, item) => 
        sum + (item["amount"] as double));
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Revenue",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$${totalRevenue.currency}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseDetails() {
    double totalExpenses = expenseBreakdown.fold(0.0, (sum, item) => 
        sum + (item["amount"] as double));
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: dangerColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Expenses",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$${totalExpenses.currency}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatioAnalysis() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Financial Ratios",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildRatioItem("Gross Profit Margin", "24.5%", successColor),
          _buildRatioItem("Operating Margin", "18.3%", infoColor),
          _buildRatioItem("Net Profit Margin", "12.2%", primaryColor),
          _buildRatioItem("Return on Assets", "8.7%", warningColor),
        ],
      ),
    );
  }

  Widget _buildRatioItem(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTrendAnalysis() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: infoColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.insights, color: infoColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Key Insights",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "• Revenue growth of 12.4% compared to previous period",
            style: TextStyle(fontSize: 14, color: primaryColor),
          ),
          Text(
            "• Operating expenses increased by 7.6%, still within budget",
            style: TextStyle(fontSize: 14, color: primaryColor),
          ),
          Text(
            "• Net profit margin improved by 3.3 percentage points",
            style: TextStyle(fontSize: 14, color: primaryColor),
          ),
          Text(
            "• Strong performance in product sales and service revenue",
            style: TextStyle(fontSize: 14, color: primaryColor),
          ),
        ],
      ),
    );
  }

  void _loadFinancialData() {
    loading = true;
    setState(() {});

    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Financial data updated");
    });
  }

  void _generateProfitLoss() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Profit & Loss statement generated");
  }

  void _generateBalanceSheet() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Balance sheet generated");
  }

  void _generateCashFlow() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Cash flow statement generated");
  }

  void _exportAllReports() async {
    showLoading();
    await Future.delayed(Duration(seconds: 3));
    hideLoading();
    ss("All financial reports exported");
  }
}
