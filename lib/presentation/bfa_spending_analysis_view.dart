import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaSpendingAnalysisView extends StatefulWidget {
  const BfaSpendingAnalysisView({super.key});

  @override
  State<BfaSpendingAnalysisView> createState() => _BfaSpendingAnalysisViewState();
}

class _BfaSpendingAnalysisViewState extends State<BfaSpendingAnalysisView> {
  String selectedPeriod = "This Month";
  String selectedCategory = "All Categories";
  
  List<Map<String, dynamic>> timeframes = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> categoryFilters = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Food & Dining", "value": "Food & Dining"},
    {"label": "Transportation", "value": "Transportation"},
    {"label": "Shopping", "value": "Shopping"},
    {"label": "Entertainment", "value": "Entertainment"},
    {"label": "Bills & Utilities", "value": "Bills & Utilities"},
  ];

  List<Map<String, dynamic>> spendingData = [
    {
      "category": "Food & Dining",
      "amount": 1250.75,
      "percentage": 32.5,
      "change": 15.2,
      "transactions": 45,
      "avgTransaction": 27.79,
      "icon": Icons.restaurant,
      "color": warningColor,
      "budget": 1000.0,
      "isOverBudget": true,
    },
    {
      "category": "Transportation",
      "amount": 850.50,
      "percentage": 22.1,
      "change": -5.8,
      "transactions": 28,
      "avgTransaction": 30.38,
      "icon": Icons.directions_car,
      "color": primaryColor,
      "budget": 900.0,
      "isOverBudget": false,
    },
    {
      "category": "Shopping",
      "amount": 675.25,
      "percentage": 17.6,
      "change": 8.3,
      "transactions": 22,
      "avgTransaction": 30.69,
      "icon": Icons.shopping_bag,
      "color": successColor,
      "budget": 800.0,
      "isOverBudget": false,
    },
    {
      "category": "Entertainment",
      "amount": 425.00,
      "percentage": 11.1,
      "change": 22.1,
      "transactions": 15,
      "avgTransaction": 28.33,
      "icon": Icons.movie,
      "color": infoColor,
      "budget": 400.0,
      "isOverBudget": true,
    },
    {
      "category": "Bills & Utilities",
      "amount": 385.75,
      "percentage": 10.0,
      "change": -2.1,
      "transactions": 8,
      "avgTransaction": 48.22,
      "icon": Icons.receipt,
      "color": dangerColor,
      "budget": 400.0,
      "isOverBudget": false,
    },
    {
      "category": "Health & Fitness",
      "amount": 265.50,
      "percentage": 6.9,
      "change": 5.7,
      "transactions": 12,
      "avgTransaction": 22.13,
      "icon": Icons.fitness_center,
      "color": successColor,
      "budget": 300.0,
      "isOverBudget": false,
    },
  ];

  List<Map<String, dynamic>> recentTransactions = [
    {
      "id": 1,
      "merchant": "Starbucks Coffee",
      "category": "Food & Dining",
      "amount": 8.75,
      "date": "2025-06-15",
      "time": "08:30",
      "type": "Card",
      "icon": Icons.local_cafe,
    },
    {
      "id": 2,
      "merchant": "Shell Gas Station",
      "category": "Transportation",
      "amount": 65.20,
      "date": "2025-06-14",
      "time": "18:45",
      "type": "Card",
      "icon": Icons.local_gas_station,
    },
    {
      "id": 3,
      "merchant": "Amazon Prime",
      "category": "Shopping",
      "amount": 129.99,
      "date": "2025-06-14",
      "time": "14:20",
      "type": "Online",
      "icon": Icons.shopping_cart,
    },
    {
      "id": 4,
      "merchant": "Netflix",
      "category": "Entertainment",
      "amount": 15.99,
      "date": "2025-06-13",
      "time": "12:00",
      "type": "Subscription",
      "icon": Icons.tv,
    },
    {
      "id": 5,
      "merchant": "Electric Company",
      "category": "Bills & Utilities",
      "amount": 125.50,
      "date": "2025-06-13",
      "time": "09:15",
      "type": "Auto Pay",
      "icon": Icons.flash_on,
    },
  ];

  double getTotalSpending() {
    return spendingData.fold(0.0, (sum, item) => sum + (item["amount"] as double));
  }

  int getTotalTransactions() {
    return spendingData.fold(0, (sum, item) => sum + (item["transactions"] as int));
  }

  double getAverageTransaction() {
    double total = getTotalSpending();
    int transactions = getTotalTransactions();
    return transactions > 0 ? total / transactions : 0.0;
  }

  List<Map<String, dynamic>> getFilteredData() {
    if (selectedCategory == "All Categories") {
      return spendingData;
    }
    return spendingData.where((item) => item["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredData = getFilteredData();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Spending Analysis"),
        actions: [
          IconButton(
            onPressed: () {
              // Export data
            },
            icon: Icon(Icons.file_download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: timeframes,
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
                    label: "Category",
                    items: categoryFilters,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Overview Cards
            Container(
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
                  Text(
                    "Spending Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildOverviewCard(
                          "Total Spent",
                          "\$${getTotalSpending().currency}",
                          Icons.account_balance_wallet,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildOverviewCard(
                          "Transactions",
                          "${getTotalTransactions()}",
                          Icons.receipt_long,
                          successColor,
                        ),
                      ),
                    ],
                  ),
                  _buildOverviewCard(
                    "Average per Transaction",
                    "\$${getAverageTransaction().toStringAsFixed(2)}",
                    Icons.trending_up,
                    infoColor,
                  ),
                ],
              ),
            ),

            // Category Breakdown
            Text(
              "Category Breakdown",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              spacing: spSm,
              children: filteredData.map((category) {
                bool isOverBudget = category["isOverBudget"] as bool;
                double budgetUsage = ((category["amount"] as double) / (category["budget"] as double)) * 100;
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: isOverBudget ? Border.all(
                      color: dangerColor.withAlpha(50),
                      width: 1,
                    ) : null,
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (category["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              category["icon"] as IconData,
                              color: category["color"] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${category["category"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${category["transactions"]} transactions • Avg \$${(category["avgTransaction"] as double).toStringAsFixed(2)}",
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
                                "\$${(category["amount"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isOverBudget ? dangerColor : primaryColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    (category["change"] as double) >= 0 ? Icons.trending_up : Icons.trending_down,
                                    size: 12,
                                    color: (category["change"] as double) >= 0 ? dangerColor : successColor,
                                  ),
                                  SizedBox(width: spXxs),
                                  Text(
                                    "${(category["change"] as double) >= 0 ? '+' : ''}${(category["change"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: (category["change"] as double) >= 0 ? dangerColor : successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Budget Progress
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Budget: \$${(category["budget"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${budgetUsage.toStringAsFixed(0)}% used",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isOverBudget ? dangerColor : successColor,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (budgetUsage / 100).clamp(0.0, 1.2),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isOverBudget ? dangerColor : successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      if (isOverBudget) ...[
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.warning,
                                size: 16,
                                color: dangerColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Over budget by \$${((category["amount"] as double) - (category["budget"] as double)).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),

            // Recent Transactions
            Text(
              "Recent Transactions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: recentTransactions.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> transaction = entry.value;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: index < recentTransactions.length - 1 ? Border(
                        bottom: BorderSide(
                          color: disabledColor,
                          width: 1,
                        ),
                      ) : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            transaction["icon"] as IconData,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${transaction["merchant"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${transaction["category"]} • ${transaction["type"]}",
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
                              "-\$${(transaction["amount"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "${transaction["date"]} ${transaction["time"]}",
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
                }).toList(),
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Set Budget",
                    icon: Icons.account_balance,
                    size: bs.sm,
                    onPressed: () {
                      // Set category budgets
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "View All Transactions",
                    icon: Icons.list,
                    size: bs.sm,
                    onPressed: () {
                      // View all transactions
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

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
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
      ),
    );
  }
}
