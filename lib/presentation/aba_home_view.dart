import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaHomeView extends StatefulWidget {
  const AbaHomeView({super.key});

  @override
  State<AbaHomeView> createState() => _AbaHomeViewState();
}

class _AbaHomeViewState extends State<AbaHomeView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "ABA Business",
      selectedIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: "Transactions",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          label: "Reports",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
      children: [
        _buildDashboardTab(),
        _buildTransactionsTab(),
        _buildReportsTab(),
        _buildSettingsTab(),
      ],
      onTap: (index) {
        currentIndex = index;
        setState(() {});
      },
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back!",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Here's your business overview for today",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(220),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Quick Actions
          Text(
            "Quick Actions",
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
              _buildQuickActionCard(
                "Record Sale",
                Icons.point_of_sale,
                successColor,
                () {
                  //navigateTo('AddSaleView')
                },
              ),
              _buildQuickActionCard(
                "Add Expense",
                Icons.receipt,
                dangerColor,
                () {
                  //navigateTo('AddExpenseView')
                },
              ),
              _buildQuickActionCard(
                "Create Invoice",
                Icons.description,
                warningColor,
                () {
                  //navigateTo('CreateInvoiceView')
                },
              ),
              _buildQuickActionCard(
                "Bank Reconcile",
                Icons.account_balance,
                infoColor,
                () {
                  //navigateTo('BankReconciliationView')
                },
              ),
            ],
          ),
          
          SizedBox(height: spLg),
          
          // Financial Overview
          Text(
            "Financial Overview",
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
              _buildFinancialCard("Total Revenue", "\$45,280", successColor, "+12%"),
              _buildFinancialCard("Total Expenses", "\$23,560", dangerColor, "+8%"),
              _buildFinancialCard("Net Profit", "\$21,720", primaryColor, "+15%"),
              _buildFinancialCard("Cash Balance", "\$18,940", infoColor, "+5%"),
            ],
          ),
          
          SizedBox(height: spLg),
          
          // Recent Transactions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Transactions",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  currentIndex = 1;
                  setState(() {});
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
          SizedBox(height: spSm),
          
          ..._buildRecentTransactions(),
        ],
      ),
    );
  }

  Widget _buildTransactionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Transactions",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          // Filter Options
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: disabledBoldColor, size: 20),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Search transactions...",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.filter_list, color: disabledBoldColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Filter",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Transaction List
          ..._buildAllTransactions(),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Financial Reports",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildReportCard(
                "Profit & Loss",
                "View your income and expenses",
                Icons.trending_up,
                successColor,
                () {
                  //navigateTo('AbaProfitLossView')
                },
              ),
              _buildReportCard(
                "Balance Sheet",
                "Assets, liabilities & equity",
                Icons.account_balance_wallet,
                infoColor,
                () {
                  //navigateTo('AbaBalanceSheetView')
                },
              ),
              _buildReportCard(
                "Cash Flow",
                "Track cash in and out",
                Icons.water_drop,
                primaryColor,
                () {
                  //navigateTo('AbaCashFlowSummaryView')
                },
              ),
              _buildReportCard(
                "Tax Summary",
                "Prepare for tax season",
                Icons.receipt_long,
                warningColor,
                () {
                  //navigateTo('AbaTaxSummaryView')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Settings",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          _buildSettingsSection("Business", [
            _buildSettingsItem("Business Information", Icons.business, () {}),
            _buildSettingsItem("Chart of Accounts", Icons.account_tree, () {}),
            _buildSettingsItem("Tax Settings", Icons.receipt_long, () {}),
          ]),
          
          _buildSettingsSection("Preferences", [
            _buildSettingsItem("Notifications", Icons.notifications, () {}),
            _buildSettingsItem("Currency & Format", Icons.monetization_on, () {}),
            _buildSettingsItem("Backup & Sync", Icons.backup, () {}),
          ]),
          
          _buildSettingsSection("Account", [
            _buildSettingsItem("Profile", Icons.person, () {}),
            _buildSettingsItem("Security", Icons.security, () {}),
            _buildSettingsItem("Subscription", Icons.star, () {}),
          ]),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(100)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialCard(String title, String amount, Color color, String change) {
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
          SizedBox(height: spXs),
          Text(
            amount,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRecentTransactions() {
    List<Map<String, dynamic>> transactions = [
      {"type": "Income", "description": "Client Payment - ABC Corp", "amount": 2500.00, "date": "Today"},
      {"type": "Expense", "description": "Office Supplies", "amount": -125.50, "date": "Yesterday"},
      {"type": "Income", "description": "Service Revenue", "amount": 850.00, "date": "2 days ago"},
    ];

    return transactions.map((transaction) => Container(
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
              color: (transaction["amount"] as double) > 0 ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              (transaction["amount"] as double) > 0 ? Icons.trending_up : Icons.trending_down,
              color: (transaction["amount"] as double) > 0 ? successColor : dangerColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${transaction["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${transaction["date"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${((transaction["amount"] as double).abs()).toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: (transaction["amount"] as double) > 0 ? successColor : dangerColor,
            ),
          ),
        ],
      ),
    )).toList();
  }

  List<Widget> _buildAllTransactions() {
    // Same as recent transactions but with more entries
    return _buildRecentTransactions();
  }

  Widget _buildReportCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              subtitle,
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

  Widget _buildSettingsSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...items,
        SizedBox(height: spMd),
      ],
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: spXs),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusXs),
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            Icon(icon, color: primaryColor, size: 20),
            SizedBox(width: spSm),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: disabledBoldColor, size: 20),
          ],
        ),
      ),
    );
  }
}
