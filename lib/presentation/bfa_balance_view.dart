import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaBalanceView extends StatefulWidget {
  const BfaBalanceView({Key? key}) : super(key: key);

  @override
  State<BfaBalanceView> createState() => _BfaBalanceViewState();
}

class _BfaBalanceViewState extends State<BfaBalanceView> {
  int currentTab = 0;
  String selectedPeriod = "1M";
  bool showBalance = true;
  bool loading = false;

  List<Map<String, dynamic>> accounts = [
    {
      "id": 1,
      "name": "Checking Account",
      "type": "checking",
      "accountNumber": "****1234",
      "balance": 15840.75,
      "currency": "USD",
      "color": primaryColor,
      "isHidden": false
    },
    {
      "id": 2,
      "name": "Savings Account",
      "type": "savings",
      "accountNumber": "****5678",
      "balance": 45230.20,
      "currency": "USD",
      "color": successColor,
      "isHidden": false
    },
    {
      "id": 3,
      "name": "Investment Account",
      "type": "investment",
      "accountNumber": "****9012",
      "balance": 128475.50,
      "currency": "USD",
      "color": infoColor,
      "isHidden": false
    },
    {
      "id": 4,
      "name": "Credit Card",
      "type": "credit",
      "accountNumber": "****3456",
      "balance": -2340.85,
      "currency": "USD",
      "color": warningColor,
      "isHidden": false
    }
  ];

  List<Map<String, dynamic>> balanceHistory = [
    {"date": "2024-01-01", "balance": 180000},
    {"date": "2024-01-05", "balance": 185000},
    {"date": "2024-01-10", "balance": 182000},
    {"date": "2024-01-15", "balance": 187205.60},
    {"date": "2024-01-20", "balance": 189000},
    {"date": "2024-01-25", "balance": 186500},
    {"date": "2024-01-30", "balance": 187205.60},
  ];

  List<Map<String, dynamic>> recentTransactions = [
    {
      "id": 1,
      "description": "Salary Deposit",
      "amount": 5200.00,
      "type": "credit",
      "date": "2024-01-30",
      "account": "Checking Account",
      "category": "Income"
    },
    {
      "id": 2,
      "description": "Grocery Shopping",
      "amount": -156.78,
      "type": "debit",
      "date": "2024-01-29",
      "account": "Checking Account",
      "category": "Food & Dining"
    },
    {
      "id": 3,
      "description": "Investment Purchase",
      "amount": -2000.00,
      "type": "debit",
      "date": "2024-01-28",
      "account": "Investment Account",
      "category": "Investment"
    }
  ];

  double get totalBalance {
    return accounts
        .where((account) => !account["isHidden"])
        .fold(0.0, (sum, account) => sum + (account["balance"] as double));
  }

  double get totalAssets {
    return accounts
        .where((account) => (account["balance"] as double) > 0)
        .fold(0.0, (sum, account) => sum + (account["balance"] as double));
  }

  double get totalLiabilities {
    return accounts
        .where((account) => (account["balance"] as double) < 0)
        .fold(0.0, (sum, account) => sum + ((account["balance"] as double).abs()));
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Balance Overview",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.account_balance_wallet)),
        Tab(text: "Accounts", icon: Icon(Icons.account_balance)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAccountsTab(),
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
          // Total Balance Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowLg],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Total Balance",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        showBalance = !showBalance;
                        setState(() {});
                      },
                      child: Icon(
                        showBalance ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  showBalance ? "\$${totalBalance.currency}" : "••••••",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "+2.5% from last month",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quick Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Assets",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        showBalance ? "\$${totalAssets.currency}" : "••••••",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.trending_down,
                        color: dangerColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Liabilities",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        showBalance ? "\$${totalLiabilities.currency}" : "••••••",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Recent Transactions
          Container(
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
                    Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...recentTransactions.take(3).map((transaction) => Container(
                  margin: EdgeInsets.only(bottom: spXs),
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
                          color: transaction["type"] == "credit"
                              ? successColor.withAlpha(20)
                              : dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          transaction["type"] == "credit"
                              ? Icons.add
                              : Icons.remove,
                          color: transaction["type"] == "credit"
                              ? successColor
                              : dangerColor,
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
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${transaction["account"]} • ${transaction["category"]}",
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
                            "${transaction["type"] == "credit" ? "+" : ""}\$${(transaction["amount"] as double).abs().currency}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: transaction["type"] == "credit"
                                  ? successColor
                                  : dangerColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(transaction["date"] as String).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Transfer",
                        icon: Icons.swap_horiz,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Pay Bills",
                        icon: Icons.receipt,
                        onPressed: () {},
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
  }

  Widget _buildAccountsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filter
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search accounts",
                  value: "",
                  hint: "Search by account name...",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          // Net Worth Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Column(
              children: [
                Text(
                  "Net Worth",
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  showBalance ? "\$${(totalAssets - totalLiabilities).currency}" : "••••••",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),

          // Accounts List
          ...accounts.map((account) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: account["color"] as Color,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: (account["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    account["type"] == "checking"
                        ? Icons.account_balance_wallet
                        : account["type"] == "savings"
                            ? Icons.savings
                            : account["type"] == "investment"
                                ? Icons.trending_up
                                : Icons.credit_card,
                    color: account["color"] as Color,
                    size: 24,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${account["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${account["accountNumber"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        account["type"].toString().toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: account["color"] as Color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      showBalance
                          ? "\$${(account["balance"] as double).currency}"
                          : "••••••",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: (account["balance"] as double) >= 0
                            ? successColor
                            : dangerColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    QButton(
                      label: "Details",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),

          // Add Account Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Account",
              icon: Icons.add,
              onPressed: () {},
            ),
          ),
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
          // Period Selector
          QCategoryPicker(
            label: "Select Period",
            items: [
              {"label": "1W", "value": "1W"},
              {"label": "1M", "value": "1M"},
              {"label": "3M", "value": "3M"},
              {"label": "6M", "value": "6M"},
              {"label": "1Y", "value": "1Y"},
            ],
            value: selectedPeriod,
            onChanged: (index, label, value, item) {
              selectedPeriod = value;
              setState(() {});
            },
          ),

          // Balance Trend Chart Placeholder
          Container(
            height: 200,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Balance Trend",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.trending_up,
                            size: 48,
                            color: primaryColor,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Balance Chart",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Account Distribution
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                ...accounts.where((acc) => (acc["balance"] as double) > 0).map((account) {
                  double percentage = ((account["balance"] as double) / totalAssets) * 100;
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: account["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${account["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              "${percentage.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: percentage / 100,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            account["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Financial Insights
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Financial Insights",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: successColor.withAlpha(50)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.lightbulb, color: successColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Your savings rate has improved by 15% this month. Keep up the great work!",
                          style: TextStyle(
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
